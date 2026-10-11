# Zoom integration — requirements study & open items (internal)

Working notes behind `zoom-integration-administrators.md` and `zoom-integration-users.md`.
Not for publication. Written 2026-09-09, **rewritten the same day after verifying against shipped
code** — the first version was sourced from PRDs and ADRs and was wrong in three places.

## 0. What changed in this rewrite, and why

The first draft of both articles was built from `connect-layer.prd.md` and the ADR set. Three of its
central claims do not survive contact with the code:

| First draft said | Code says | Evidence |
| --- | --- | --- |
| Each user installs the Betterworks app from the Zoom Marketplace and completes Zoom OAuth | Users install nothing and never see Zoom. One org-level OAuth, performed by the Betterworks admin | `haven .../views/admin/integrations/thirdparty/ZoomConfig.vue` · `haven .../components/meetings/ZoomTermsDialog.vue` |
| A transcript is only available to the meeting **host**, so a 1:1 is processed when its host has connected | Host identity is irrelevant. `host_id` arrives in the webhook and is **never read**. The gate is participant consent — at least one of the two | `meetings-api src/repo/models/zoom-webhook-inbound.js` |
| Transcript comes from Cloud Recording + Audio Transcription (`recording.transcript_completed`) | Transcript comes from the **AI Companion durable-transcript** path (`meeting.aic_transcript_completed`) | same file, webhook event handler |

Lalit flagged the first two and questioned the third (host access); all three were confirmed against
code. The third — the Cloud Recording vs AI Companion path — was **not** flagged by anyone and was
found while verifying the other two. Treat PRD/ADR text on this integration as stale until
reconciled (§6).

### 0.1 The host dependency that IS real (added later the same day)

Lalit then asked whether the webhook only fires when the host has AI Companion enabled. **Confirmed —
and it is a different dependency from the one refuted above.** Keep these two apart; conflating them
is what produced the original error.

| | Does a transcript EXIST? | Can Betterworks GET it once it exists? |
| --- | --- | --- |
| Decided by | The **host**, entirely | The org's OAuth + participant consent |
| Mechanism | Zoom: only host/co-host can start meeting summary; it runs under the host's settings | `GET /v2/meetings/{uuid}/transcript` with the org identifier token |
| Host identity used? | Yes — host's entitlement, settings, and in-meeting action | **No.** `host_id` appears once in `meetings-api/src`, in the Joi schema, and is never read |
| Status | **Real. Now documented in both articles** | **Refuted. ADR-D-019 stands corrected** |

Zoom's own wording, KB0058013: "Only the meeting host and co-host can start or stop the Meeting
summary through the in-meeting controls." Zoom Community, same question: a participant cannot enable
AI summary for themselves, only request it — the host decides even if the participant has the
feature enabled on their own account.

So for a manager-hosted 1:1 — the normal case — it is the **manager's** AI Companion setting that
governs, and enabling it for a group of reports achieves nothing. Both docs now say this in
Requirements, Troubleshooting, and the FAQ, because it is the highest-volume support scenario in the
whole integration: intermittent, invisible from the attendee's side, and not fixable by the person
reporting it.

**Corollary the code proves, not previously documented:** `payload.account_id` is the account that
owns the meeting, i.e. the host's. An unmatched account is `skip('no_conferencing_provider')` — a
logged 200-ack. So a 1:1 hosted from any Zoom account other than the authorized one (external
participant, contractor, or a second Zoom tenant inside the same company) silently produces nothing.
Added to Known Limitations and Troubleshooting; the multi-account case is also an open item in §7.

## 1. What is actually required from Zoom

Verified gates. All must pass or the integration silently produces nothing.

| # | Gate | Where it lives | Fails as |
| --- | --- | --- | --- |
| 1 | Paid Zoom Workplace plan with AI Companion (Pro / Pro Plus / Business / Business Plus / Enterprise / Enterprise Plus / Enterprise Bundle) | Zoom licensing | No AI Companion at all; Basic accounts can never work |
| 2 | AI Companion activated + **Meeting summary with AI Companion** enabled **for the host** (account, group or user level) | Admin Center → Settings → Zoom AI → Meeting (classic: Account Management → Account Settings → AI Companion) | No transcript produced, no webhook fires |
| 2b | Meeting summary actually **started** in the call — auto-start on, or the host/co-host starts it manually | Host's in-meeting AI Companion control; auto-start in the same settings page | No transcript for that meeting only — intermittent, per-meeting failure |
| 3 | **Allow users to retain transcripts generated with meeting summary** enabled for the host's account | Zoom AI settings → General | Summary generated, transcript discarded — *authenticated but empty* |
| 3b | The host is a user **in the Zoom account that was authorized** | Zoom account membership | `skip('no_conferencing_provider')` — logged 200-ack, nothing surfaced |
| 4 | An account owner / admin who can authorize account-level permissions | Zoom account role | OAuth consent screen cannot be completed |

Gates 2, 2b, 3 and 3b are all **host-scoped** (§0.1). An attendee's own settings are irrelevant to a
meeting they did not host, which makes these four the only gates that can fail differently for two
people sitting in the same meeting.

Cloud Recording is **not** a prerequisite. Nothing in the code path touches a cloud recording as a
source; AI Companion produces the transcript without one. (See §3 for the one scope that muddies
this.)

Plus two Betterworks-side gates:

5. Admin **enables** the Zoom integration *and* completes **Authenticate** at org level. Enabled-but-
   not-authenticated is a real and silent state — the toggle alone retrieves nothing.
   `ZoomConfig.vue`: `updateAccessLevel({ access_level: AccessLevel.ORG })` then
   `redirectIntegrationToOAuth(Zoom)` → `/services/authn-proxy/oauth2/authorize/zoom`.
6. Each user accepts the **Connect Zoom to Betterworks** consent dialog. Admins cannot consent on a
   user's behalf (ADR-CD-003 still holds). This is a Betterworks consent record, not a Zoom OAuth.
   `ZoomTermsDialog.vue`: `submitZoomConsent(ACCEPTED)` → `PATCH /services/meetings/meetings/
   conferencing-consent`, then `syncWithCalendar()`.

And two matching gates that are easy to miss because they belong to the calendar integration, not to
Zoom:

7. The 1:1 must exist as a calendar meeting whose invitation carries a Zoom join link — the webhook's
   `object.meeting_id` is matched against `meeting_series.conferencing_meeting_id`, which the calendar
   integration populates from that link. No link, no match, no processing.
8. The instance must have started within **±3h** of the calendar slot (`INSTANCE_MATCH_WINDOW_MS`).

**Gates 2, 3, 5 and 7 are the support-ticket generators.** Each is invisible from the Zoom side and
each produces exactly "we connected Zoom and nothing happens." All are called out in the admin doc.
Gate 2 is the worst of them because it fails *selectively* — the admin sees some 1:1s working — and
because the person who reports it (the attendee) cannot fix it.

## 2. Verified flow (what the code actually does)

```
BW admin: enable + Authenticate  →  authn-proxy OAuth (org-level, one shared Zoom app)
                                 →  conferencing_provider row (org_id, provider=zoom, access_level='org')
                                 →  getZoomUser() captures Zoom account_id as external_account_id

User: accepts consent dialog     →  user_conferencing_consent (zoom / transcript / accepted)
                                 →  calendar sync

HOST starts AI Companion (or     →  Zoom generates + retains the transcript
  auto-start is on)                 no host entitlement / not started ⇒ nothing exists, no webhook

Meeting ends, AI Companion ran   →  webhook meeting.aic_transcript_completed
                                    (attach_type: 'durable_transcript')
  payload.account_id             →  ext.conferencing_provider (zoom, enabled, access_level='org') → org_id
    ^ the account that OWNS the meeting = the host's account. Not ours ⇒ no_conferencing_provider
  org_id                         →  ext.organization → core_id, identifier
  object.meeting_id              →  meeting_series.conferencing_meeting_id (TEXT)
  object.meeting_start_time      →  meeting_instance within ±3h
                                 →  AUTHORIZATION GATE: checkParticipantConsent()
                                    "at least one participant of the series must have accepted"
                                 →  authnProxy.getMeetingTranscript({ identifierToken: org.identifier,
                                      meetingUuid: object.meeting_uuid })
                                    GET /v2/meetings/{meetingUuid}/transcript
                                 →  download via X-Override-Base-Url, S3 quarantine → validate → ingest
```

Notes that matter for the docs:

- The bearer token on every proxied Zoom call is the **org identifier**, not a user token
  (`authn-proxy.js` JSDoc: "org identifier used as bearer token"). This is why user-level install is
  structurally impossible in the shipped design, not merely unnecessary.
- `zoom-cloud-recording.js` is a **format sniffer**, not a fetch path. It recognises a
  `00:00:00 --> 00:00:05` timestamp shape in transcript text. The filename reads like a Cloud
  Recording dependency in isolation; it isn't one. `ALLOWED_SHAPES_BY_SOURCE[ZOOM] = [WEBVTT,
  ZOOM_CLOUD_RECORDING]` — two accepted text shapes, one fetch path.
- Zoom transcripts and manual uploads share the same S3 quarantine → validate → ingest lifecycle and
  the same size cap (`s3.maxBytes` → `OVERSIZE`).

## 3. OAuth scopes — six requested, three with no mapped call

Source of truth is `authn-proxy/internal/provider/providers.yml`, zoom block:

```yaml
default_scopes:
  - meeting:read:summary:admin
  - meeting:read:list_past_participants:admin
  - cloud_recording:read:recording:admin
  - cloud_recording:read:meeting_transcript:admin
  - user:read:user:admin
  - meeting:read:meeting:admin
```

All six carry `:admin`, deliberately not `:master` — the file's own comment: ":admin reaches every
user WITHIN the account that installs the app, which is exactly one install's scope." That single
line is the whole reason the integration is admin-managed and users install nothing.

Three of the six have **no call mapped to them anywhere in the code** as of this verification —
`providers.yml` itself flags `cloud_recording:read:recording:admin` as UNVERIFIED. Only
`user:read:user:admin` (getZoomUser), `cloud_recording:read:meeting_transcript:admin` (the transcript
GET), and the webhook subscription are exercised.

**This must be settled before Marketplace submission, not after.** Changing the scope list on a
published Zoom app triggers re-review *and* forces re-consent from every existing customer. Unused
scopes are also precisely the "invasive scopes" review friction already logged as a risk in the
Connect Layer PRD.

Two live questions for Rinku Ravi / Integrations:

- Is `meeting:read:summary:admin` needed? We do **not** consume Zoom's AI Companion summary — ADR-D-015
  / CAP-001 have Betterworks generating its recap from the raw transcript on the BW LLM stack. If it is
  only there "in case", drop it.
- Are `cloud_recording:read:recording:admin`, `meeting:read:list_past_participants:admin` and
  `meeting:read:meeting:admin` planned for near-term work, or leftovers from the abandoned
  cloud-recording design? Anything not shipping in the next release should come out of the submission.

## 4. Why AI Companion is required even though we don't use its summary

Counter-intuitive, and customers will ask. Both docs answer it in an FAQ.

- Betterworks generates its recap from the **raw transcript** via the Betterworks LLM stack
  (ADR-D-015 / CAP-001). Zoom's native summary is never read or shown.
- But AI Companion's meeting-summary feature is what *produces and retains* the transcript. It is a
  hard dependency purely as the transcript source.
- AI Companion meeting summary does **not** require cloud recording — it can produce a summary and a
  retained transcript without one.

## 5. No pre-flight validation, no user-facing error

Verified absence, and worth treating as a product gap rather than a doc problem:

- Nothing in the code validates a customer's Zoom-side settings at authenticate time. An admin can
  complete OAuth successfully with AI Companion off, or transcript retention off, and see a green
  "Betterworks can now automatically fetch meeting transcripts" state that is functionally false.
- When a transcript turns out not to be downloadable the handler returns `skip(
  'transcript_not_downloadable')` and acks the webhook 200. It is a log line. Nobody is told.
- Other skip/error codes on the same path: `NO_CONSENT`, `PARTICIPANTS_NOT_FOUND`, `OVERSIZE`,
  `INVALID_ZOOM_CLOUD_RECORDING`. None surface to an admin or a user.
- No handling of Zoom's `app_deauthorized` event was found. If a customer removes the app in Zoom,
  Betterworks appears to keep believing it is authenticated.

Consequence for support: the docs carry the burden that the product doesn't. The admin
Troubleshooting section is written as a settings checklist for exactly this reason. A pre-flight
check at authenticate time (call the settings API, warn on AI Companion / retention off) would remove
most of it — worth raising with Rinku Ravi as a small, high-leverage follow-up.

## 6. Stale ADRs needing supersession

Flagged for Rinku Ravi / Integrations rather than silently dropped. Each is contradicted by shipped
code:

- **ADR-D-019 (host-only access)** — built on `GET /v2/users/{userId}/recordings`, which returns only
  a user's own recordings. The shipped code calls `GET /v2/meetings/{meetingUuid}/transcript` with an
  org-level token, so the host-ownership constraint that ADR rests on does not apply. **Refuted as an
  access constraint.** When superseding it, don't overcorrect: the ADR was reaching for something
  real, just in the wrong layer — the host *does* determine whether a transcript exists (§0.1), and
  the host's account *does* determine whether the webhook resolves to us. Rewrite it as a
  generation-side dependency rather than deleting the host from the picture entirely.
  Also closes **ZOPEN-D1**: option (b) admin-managed tenant-wide is what shipped, with participant
  consent layered on top — closer to (c) than to (a) in customer-visible behaviour.
- **ADR-CD-010 / ADR-ZD-001 / ADR-D-017 (General App, user-managed install)** — the app is
  org-installed with `:admin` scopes and a single shared client_id/secret (`org_dependent: false`).
  **Contradicted.**
- **`connect-layer.prd.md` ~L191/196 (Cloud Recording + Audio Transcription,
  `recording.transcript_completed`)** — superseded by the AI Companion durable-transcript path.
  **Stale.** This one is worth correcting in the PRD itself: it sets a customer prerequisite (cloud
  recording of 1:1s) that many orgs prohibit by policy, and GTM may have picked it up.

## 7. Remaining items to confirm before publishing

Code-verified items are marked. Everything else is an assumption in the drafts.

- **Betterworks admin nav path** — `Admin → Integrations` and the toggle label are assumed. The
  component is `views/admin/integrations/thirdparty/ZoomConfig.vue`; confirm the surfaced nav labels
  with the Admin pod.
- **User connect entry point** — assumed to be the Meetings page banner/modal per CONN-CAP-001a.
  The dialog itself is verified (`ZoomTermsDialog.vue`); the surface that launches it is not.
- **Disconnect entry point** — `DisconnectZoomDialog.vue` exists; the settings surface it launches
  from was not verified.
- **"1:1" terminology** — both dialogs interpolate the org's configured term (`CW()`), so a customer
  who renames 1:1s sees their own label. Consider phrasing the published articles accordingly.
- **Transcript TTL** — docs say "a limited period" deliberately. If the 2–6 month figure is locked,
  state it. Needs Anuj / Sriram.
- **Marketplace listing status** — review runs 8–13 weeks (ADR-D-018 / ADR-ZD-004). Both docs are now
  written so that *no* customer-facing step depends on a public listing (the admin authenticates from
  inside Betterworks), which removes the interim-unlisted-link problem the first draft had. Still
  confirm the app is installable for the first customers at publish time.
- **Zoom UI paths** — Zoom is mid-migration to the new Admin Center and has renamed "AI Companion"
  settings to "Zoom AI". Both paths are given; verify against the tenant used for screenshots.
- **Region / BAA caveats** — noted in the admin doc as a general caution. Confirm whether any target
  customer is affected.
- **One Zoom account per organization** — implied by the upsert key `(org_id, provider, access_level)`
  and by `account_id`-based org resolution. Confirm the intended behaviour for a customer with
  multiple Zoom accounts or sub-accounts before a customer hits it. Sharper now that §0.1 is
  established: since the resolving `account_id` is the **host's**, any customer whose managers are
  spread across two Zoom accounts gets silent partial coverage, with no signal telling them which
  half is missing. Worth a decision before the first multi-account customer, not after.
- **Host-side enablement is unverifiable from our side** — we cannot tell an admin which of their
  hosts lack meeting summary, because nothing reads host identity and we never call a settings API.
  If a pre-flight check is built (§5), listing hosts without **Meeting summary with AI Companion**
  would be the single most useful thing it could report. Would need
  `meeting:read:summary:admin` — which is currently requested and unused (§3), so the scope
  decision and this one should be taken together.

## 8. Sources

Code (verified 2026-09-09, `~/Documents/GitHub/`):

- `haven/packages/app/src/views/admin/integrations/thirdparty/ZoomConfig.vue` — admin enable + Authenticate
- `haven/packages/app/src/components/meetings/ZoomTermsDialog.vue` — the entire user flow
- `haven/packages/app/src/composables/meetings/useZoomIntegration.ts` — connected == consent accepted
- `meetings-api/src/repo/models/zoom-webhook-inbound.js` — event, org resolution, consent gate, fetch
- `meetings-api/src/services/authn-proxy.js` — the three Zoom calls, org identifier as bearer token
- `meetings-api/src/repo/models/conferencing-provider.js` — org-level provider row, account_id capture
- `meetings-api/src/transcripts/consent.js` · `.../models/conferencing-consent.js` — consent gate
- `meetings-api/src/transcripts/shapes/zoom-cloud-recording.js` — format sniffer only
- `meetings-api/src/repo/models/constants.js` — ±3h match window, org access level
- `authn-proxy/internal/provider/providers.yml` — the six scopes, :admin-not-:master rationale

Zoom:

- [Enabling or disabling meeting summary with AI](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0057960)
- [Allow users to retain transcripts generated with meeting summary](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0076631)
- [Admin management of the Zoom App Marketplace](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0060122)
- [Approving apps and managing app requests](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0062300)

Betterworks (structure source):

- [Integrations: Microsoft Outlook (Administrators)](https://support.betterworks.com/hc/en-us/articles/6031216641933-Integrations-Outlook-Administrators)
- [Integrations: Microsoft Outlook (Users)](https://support.betterworks.com/hc/en-us/articles/6058655111565-Integrations-Microsoft-Outlook-Users)

Internal (treat as stale where §6 says so): ADR-CD-010 / ADR-ZD-001 / ADR-D-017 · ADR-D-019 ·
ADR-D-015 · ADR-CD-003 · ADR-CD-008 · ADR-D-018 / ADR-ZD-004 · `connect-layer.prd.md` §Capabilities
