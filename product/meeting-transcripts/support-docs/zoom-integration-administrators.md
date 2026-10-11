# Integrations: Zoom (Administrators)

<!--
INTERNAL — DELETE THIS BLOCK BEFORE PUBLISHING TO ZENDESK.
Structure mirrors "Integrations: Microsoft Outlook (Administrators)"
(support.betterworks.com/hc/en-us/articles/6031216641933).

Verified against code 2026-09-09. Evidence:
  - haven .../admin/integrations/thirdparty/ZoomConfig.vue — admin toggle + Authenticate,
    sets access_level: ORG, then redirects to authn-proxy/oauth2/authorize/zoom
  - authn-proxy internal/provider/providers.yml (zoom block) — the six :admin scopes
  - meetings-api src/repo/models/zoom-webhook-inbound.js — meeting.aic_transcript_completed,
    org resolution by account_id, participant-consent gate, can_download check
  - meetings-api src/services/authn-proxy.js — GET /meetings/{uuid}/transcript with the ORG token
  - meetings-api src/repo/models/conferencing-provider.js — GET /users/me captures account_id
Open items: see zoom-requirements-notes.md in this folder.
-->

## Contents

- [Overview](#overview)
- [Requirements](#requirements)
- [Permissions](#permissions)
- [Configuration](#configuration)
  - [Step 1: Enable Meeting summary with AI Companion in Zoom](#step-1-enable-meeting-summary-with-ai-companion-in-zoom)
  - [Step 2: Allow transcripts to be retained in Zoom](#step-2-allow-transcripts-to-be-retained-in-zoom)
  - [Step 3: Enable and authenticate Zoom in Betterworks](#step-3-enable-and-authenticate-zoom-in-betterworks)
  - [Step 4: Tell your users to give consent](#step-4-tell-your-users-to-give-consent)
- [Known Limitations](#known-limitations)
- [Additional Resources](#additional-resources)
- [Troubleshooting](#troubleshooting)

## Overview

**Note:** If you'd like to know how your team will use the integration, see [Integrations: Zoom (Users)](./zoom-integration-users.md).

Betterworks offers a Zoom integration that automatically brings the transcript of a 1:1 meeting into Betterworks, where it is turned into an AI recap, suggested action items, and goal recommendations for the meeting's participants. This removes the need for managers and their reports to take notes during a 1:1 or to copy and paste a transcript by hand.

Setting up the integration is an administrator's job from start to finish. You enable Zoom AI Companion so that Zoom produces a transcript, you allow transcripts to be retained, and you authenticate Zoom once from Betterworks on behalf of your whole organization. Your users never install anything and never sign in to Zoom through Betterworks — they only give their consent inside Betterworks before their own 1:1s are processed.

**Important:** Betterworks never joins your meetings. There is no recording bot and no additional participant in the call. Betterworks retrieves the transcript that Zoom itself has already produced.

**Note:** Betterworks generates its own AI recap from the raw transcript using the Betterworks AI stack. It does not use or display Zoom's native AI Companion summary. Zoom AI Companion is required because it is what produces the transcript — not because Betterworks reuses Zoom's summary.

## Requirements

Both the Zoom-side and Betterworks-side requirements below must be met before any 1:1 in your organization is processed.

### Zoom account requirements

| Requirement | Detail |
| --- | --- |
| Zoom plan | A paid Zoom Workplace plan: Pro, Pro Plus, Business, Business Plus, Enterprise, Enterprise Plus, or Enterprise Bundle. Zoom AI Companion is included at no additional cost on these plans. |
| Zoom Basic (free) | Not supported. Zoom AI Companion is not available on Basic accounts, so no transcript is produced. |
| Zoom AI Companion | Must be activated for your Zoom account by the account owner, and **Meeting summary with AI Companion** must be enabled for the users who **host** 1:1s — in most organizations, the managers. Only a meeting's host or co-host can start meeting summary, so an attendee's own AI Companion setting has no effect on a 1:1 they don't host. |
| Transcript retention | **Allow users to retain transcripts generated with meeting summary** must be enabled for the host's account. Without it, Zoom discards the transcript and there is nothing for Betterworks to retrieve. |
| Meeting host in the authorized account | The person who hosts the 1:1 must be a user in the same Zoom account you authorize. A 1:1 hosted from a different Zoom account — an external party, or a second Zoom account in your own company — is not processed. |
| Administrator access | The person who authenticates must be a Zoom account owner or admin able to authorize an app for the whole account. The Betterworks app requests account-level permissions, so an ordinary member cannot complete this step. |
| One Zoom account per organization | Betterworks maps a single Zoom account to your Betterworks organization. Authorizing across the sub-accounts of a master account is not supported. |

**Note:** Zoom AI Companion availability can be affected by your account's region and data-residency configuration, and accounts under a Business Associate Agreement (BAA) may have additional restrictions. If AI Companion settings are not visible in your Zoom portal, contact Zoom support to confirm your account's entitlement.

### Betterworks requirements

- A Betterworks Super Admin must enable and authenticate the Zoom integration under **Admin → Integrations**. Until that is done, no transcript is retrieved for anyone.
- The calendar integration must be connected, and your users' 1:1s must be scheduled as calendar meetings that carry a Zoom join link. Betterworks matches an incoming Zoom transcript to a 1:1 using the Zoom link on the calendar invitation.
- At least one of the two participants in a 1:1 must have given Zoom transcript consent in Betterworks. Administrators cannot give this consent on a user's behalf.

**Note:** You do not need to create, publish, or configure a Zoom Marketplace app, and you do not need to search the Zoom App Marketplace for Betterworks. Betterworks publishes and maintains the app, and the permissions it requests are fixed by Betterworks — they are not something you assemble or adjust in your own Zoom account. You authorize the app from within Betterworks, in Step 3 below.

<!-- INTERNAL: install model is General App, ADMIN-MANAGED (webhook-gateway
docs/zoom-marketplace-production-rollout.md), reached from Betterworks rather than by browsing
the Marketplace — the rollout doc leans toward distributing an unlisted install link.
This CONTRADICTS ADR-CD-010, which recorded "General App, User-managed" as the MVP decision.
The shipped code is admin/org-level throughout (all :admin scopes, ORG access level, org token),
so ADR-CD-010 and ADR-D-017 are stale and should be superseded rather than reconciled.
Raise with Rinku Ravi / Integrations. -->


## Permissions

When you authenticate, Zoom shows you a consent screen listing what the Betterworks app may do in your account. Every permission is read-only, and every one is account-level: a single authorization covers the users in your Zoom account, so each user does not have to authorize separately.

| Permission | Why Betterworks needs it |
| --- | --- |
| View meeting summary information | Subscribes Betterworks to the Zoom notification that says an AI Companion transcript is ready. |
| View meeting transcripts | Retrieve the transcript text that the AI pipeline processes. |
| View recordings | Authorize the download of the transcript file Zoom hands back. |
| View past meeting participants | Confirm who took part in the completed meeting. |
| View meeting information | Read the basic details of the completed meeting. |
| View user profile | Identify which Zoom account was authorized, so incoming transcripts can be mapped to your organization. |

**Note:** All permissions requested are read-only. Betterworks cannot start, join, modify, or delete Zoom meetings or recordings, and cannot change any Zoom setting.

<!-- INTERNAL: the six granular scopes actually requested (authn-proxy providers.yml zoom
default_scopes, lines 341-347) are, in order: meeting:read:summary:admin,
meeting:read:list_past_participants:admin, cloud_recording:read:recording:admin,
cloud_recording:read:meeting_transcript:admin, user:read:user:admin, meeting:read:meeting:admin.
The rows above are plain-language equivalents, reordered so the two that matter most read first.

THREE of the six have no mapped call in the shipped code (verified 2026-09-09):
  - meeting:read:list_past_participants:admin (GET /past_meetings/{id}/participants) — not called.
    Speaker attribution comes from the inline speaker labels in the transcript itself, not from
    Zoom's participant list, and the consent gate reads Betterworks' own participant tables.
  - meeting:read:meeting:admin (GET /meetings/{id}) — not called.
  - cloud_recording:read:recording:admin — flagged UNVERIFIED in providers.yml; may be required for
    the download_url fetch to authorize, or may be dead weight.
Adding or removing a scope on a published app costs Zoom re-review plus re-consent from every
existing customer, so this should be settled with Rinku Ravi / Integrations BEFORE the production
Marketplace submission — not after. Delete the corresponding rows here if the scopes are trimmed.
Confirm final consent-screen wording against the published listing; Zoom's labels differ from the
scope strings. -->

## Configuration

### Step 1: Enable Meeting summary with AI Companion in Zoom

Meeting summary with AI Companion is what generates the transcript Betterworks retrieves.

**Important:** Meeting summary is controlled by the meeting's host. Only the host or a co-host can start it, and it runs under the host's Zoom settings. Enable it for the users who host 1:1s — usually managers — otherwise their reports' 1:1s produce no transcript no matter what the reports have enabled themselves.

1. Sign in to the Zoom web portal as an account owner or administrator.

2. Click your profile picture, then select **Admin Center**.

3. In the side menu, select **Settings**.

4. Select **Zoom AI**.

5. Under **Meeting**, enable **Meeting summary with AI Companion**.

6. (Recommended) Enable the option to start meeting summary automatically, so hosts don't have to remember to turn it on for each 1:1.

7. (Optional) Select the lock icon to prevent users from turning the setting off.

**Note:** In Zoom accounts that have not yet moved to the new Admin Center, the equivalent path is **Account Management → Account Settings → AI Companion** tab.

To enable it for a pilot group rather than the whole account:

1. In the side menu, select **Users → Groups**.

2. Select the applicable group name.

3. Click **Edit product settings**.

4. Select the **Zoom AI** tab, then enable **Meeting summary with AI Companion** under **Meeting**.

**Important:** A pilot group must contain the **hosts** of the 1:1s you want processed. If you enable the setting for a group of reports but not for their managers, and the managers schedule and host the 1:1s, no transcripts are produced.

<!-- SCREENSHOT: Zoom Admin Center → Settings → Zoom AI, with "Meeting summary with AI Companion" toggled on -->

### Step 2: Allow transcripts to be retained in Zoom

By default Zoom may generate a summary and then discard the underlying transcript. Betterworks needs the transcript itself.

1. In the Zoom web portal, go to **Admin Center → Settings → Zoom AI**.

2. Under **General**, enable **Allow users to retain transcripts generated with meeting summary**.

3. (Optional) Select the lock icon to enforce this for all users.

**Important:** If this setting is off, the integration can be fully connected and still produce nothing, because Zoom never keeps a transcript to hand over. Betterworks is told the transcript cannot be downloaded and skips the meeting. This is the single most common cause of an integration that appears connected but produces no results.

<!-- SCREENSHOT: Zoom AI settings → General → "Allow users to retain transcripts generated with meeting summary" -->

### Step 3: Enable and authenticate Zoom in Betterworks

This is the step that authorizes Betterworks to retrieve transcripts. It is done once, by an administrator, for the whole organization.

1. Sign in to Betterworks as a Super Admin.

2. Navigate to **Admin → Integrations**.

3. Locate **Zoom** and turn on **Enable this integration**.

4. Select **Authenticate**.

5. Sign in to Zoom as an account owner or administrator when Zoom prompts you, review the permissions listed, and approve them.

You are returned to Betterworks, where the Zoom card confirms that Betterworks can now automatically fetch meeting transcripts from your Zoom account. A **Re-authenticate** option replaces the **Authenticate** button; use it if you ever need to renew the authorization or approve an updated set of permissions.

**Important:** Approve the Zoom consent screen while signed in to Zoom as an administrator of the account your organization actually meets in. The account you authorize is the account whose meetings Betterworks will receive.

**Note:** Authenticating does not process anyone's 1:1s on its own. Each user still gives their own consent in Betterworks first — see Step 4.

Turning the toggle off later disconnects Zoom and stops all further transcript retrieval for your organization. Items already generated remain reviewable, and existing evidence is preserved under your retention policy. Permanent deletion requires an explicit request.

<!-- SCREENSHOT: Betterworks Admin → Integrations → Zoom, showing "Enable this integration" and the Authenticate button -->
<!-- SCREENSHOT: the connected state with "Re-authenticate" -->
<!-- INTERNAL: confirm the final admin nav path and card labels with the Admin pod (CONN-CAP-006).
Current strings in ZoomConfig.vue: "Enable this integration", "Authenticate with Zoom to
authorize Betterworks to fetch meeting transcripts.", "Betterworks can now automatically fetch
meeting transcripts from your Zoom account.", "Re-authenticate". -->

### Step 4: Tell your users to give consent

Once you have authenticated, direct your users to [Integrations: Zoom (Users)](./zoom-integration-users.md). Each user reviews what Betterworks will access and accepts it in Betterworks. There is nothing for them to install, and they are never asked to sign in to Zoom.

A 1:1 is processed once at least one of its two participants has accepted. Encouraging both people to accept is still worthwhile, because each person's own AI recap, action items, and goal recommendations are generated only for them.

## Known Limitations

- **1:1 meetings only.** Group meetings are not processed.
- **Whether a transcript exists at all is decided by the host.** Meeting summary with AI Companion can only be started by a meeting's host or co-host, and it runs under the host's Zoom settings. If the host does not have it enabled, or it isn't set to start automatically and nobody starts it during the call, Zoom produces no transcript and Betterworks has nothing to retrieve. This applies per meeting, so the same pair of people can have some 1:1s processed and others not, depending on who hosted.
- **The host must be in the Zoom account you authorized.** A 1:1 hosted from another Zoom account is not processed, because Betterworks identifies your organization from the Zoom account that owns the meeting.
- **Once a transcript exists, either participant's consent is enough.** Retrieval is not restricted to the host: Betterworks uses account-level access, so a transcript can be processed for a 1:1 the user attended but did not host.
- **The 1:1 must be a scheduled calendar meeting with a Zoom link.** Betterworks matches an incoming transcript to a 1:1 by the Zoom meeting on the calendar invitation, and pairs it with the occurrence whose start time is closest to the meeting's actual start. An ad-hoc Zoom call that isn't on the calendar as a Betterworks 1:1 cannot be matched, and its transcript is not ingested.
- **Consent is required before anything is retrieved.** If neither participant has accepted, Betterworks does not request the transcript from Zoom at all.
- **Only the two participants of a 1:1 are processed.** References to people who were not in the meeting are excluded.
- **No AI output is written to a performance record without confirmation.** Every recap, action item, and goal recommendation must be explicitly confirmed by the user before it becomes part of their Betterworks data.
- **Very large transcripts are not processed.** A transcript above the supported size limit is rejected rather than truncated.
- **Transcripts are not stored permanently.** Transcripts are retained for a limited period and then removed.

<!-- INTERNAL: two DIFFERENT host questions — keep them separate, they were conflated before.
(1) ACCESS: host-only was REMOVED after code verification on 2026-09-09. The scopes are
account-level (:admin) and the transcript is fetched with the ORG token via
GET /meetings/{meetingUuid}/transcript — host_id arrives on the webhook and is never read
(it appears exactly once in meetings-api/src, in the Joi schema). ADR-D-019 / ZOPEN-D1 based
host-only on GET /users/{userId}/recordings, which the code does not call; that ADR needs
revisiting against the shipped implementation.
(2) GENERATION: a host dependency IS real and was added on 2026-09-09 — Zoom only lets the host
or co-host start meeting summary ("Only the meeting host and co-host can start or stop the Meeting
summary through the in-meeting controls", KB0058013), so the host's settings decide whether a
transcript exists. Separately, payload.account_id is the account that owns the meeting = the host's
account; a non-matching account is skip('no_conferencing_provider'), silently.
Also confirm the final transcript TTL figure (2–6 months proposed) with Anuj/Sriram and the
size limit with the meetings pod before stating either as a number. -->

## Additional Resources

- [Zoom: Enabling or disabling meeting summary with AI Companion](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0057960)
- [Zoom: Allow users to retain transcripts generated with meeting summary](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0076631)
- [Zoom: Using AI Companion meeting summary](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0058013)
- [Zoom: Managing apps on the Zoom App Marketplace](https://support.zoom.com/hc/en/article?id=zm_kb&sysparm_article=KB0060122)

## Troubleshooting

**Your users don't see an option to connect Zoom**

- Confirm the Zoom integration is enabled **and authenticated** in **Admin → Integrations**. A toggle that is on but not authenticated still shows an **Authenticate** button and does not enable the integration for users.
- Confirm the user has a Betterworks license and can access the Meetings page.

**You can't complete the Zoom consent screen**

- Confirm you are signed in to Zoom as an account owner or admin. The Betterworks app requests account-level permissions, which an ordinary member cannot approve.
- Confirm your Zoom account is on a supported paid plan.
- If your Zoom account is a sub-account of a master account, authorize the account your organization meets in rather than the master account.

**Zoom is authenticated, but no transcripts arrive**

- Confirm **Allow users to retain transcripts generated with meeting summary** is enabled. This is the most frequent cause: without it, Zoom keeps no transcript to hand over.
- Confirm **Meeting summary with AI Companion** is enabled for **the users who host those 1:1s**, either at account level or through their group. Checking the setting on the attendee's account is the most common mistake here — an attendee cannot start meeting summary for a meeting they don't host.
- Confirm AI Companion actually ran in the meeting. If it is not set to start automatically, the host must start it during the call.
- Confirm at least one participant of the 1:1 has accepted Zoom transcript consent in Betterworks.
- Confirm the meeting was a 1:1 scheduled in the calendar with a Zoom join link, not an ad-hoc call.
- Confirm the calendar integration is connected for those users.

**Some 1:1s work and others don't**

- Check who hosted the ones that didn't work. Meeting summary runs under the host's Zoom settings, so a 1:1 hosted by someone without **Meeting summary with AI Companion** enabled produces no transcript, while the same two people's other 1:1s work normally.
- Check group-level Zoom AI settings, which override account defaults.
- Check whether the host was a user in the Zoom account you authorized. 1:1s hosted from another Zoom account, including an external participant's, are not processed.
- Check whether the host started meeting summary. Without auto-start, it has to be started manually in each call.
- Confirm the affected users are on licensed Zoom accounts rather than Basic.
- Check whether the 1:1s that fail were scheduled with a Zoom link on the invitation, and whether the meeting started close to its scheduled time. An occurrence that ran hours away from its scheduled slot may not be matched.

**Note:** Zoom setting changes can take time to apply across an account, and a transcript only becomes available after a meeting ends and Zoom finishes processing it. Allow time before re-testing. If you don't see your issue listed above, please reach out to the Betterworks Support Team — support@betterworks.com.
