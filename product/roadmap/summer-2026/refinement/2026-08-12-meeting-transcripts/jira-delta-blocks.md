# Jira description delta blocks — 2026-08-12

Grounded in the **2026-08-11 "Meeting Transcripts – Jira Alignment"** session (Lalit / Sagar / Hemant) and `#meeting-transcript-integration` **8/10–8/11**. Complements `../2026-07-27-meeting-transcripts/RECONCILE-2026-08-12.md` (swept only through 8/6) — no overlap with it.

**How to use:** each block below is **appended under the existing description body** — do not replace anything. AC additions are `- [ ]` items to paste under the existing Acceptance Criteria list.

**Legend:** ✅ AGREED · ⚠️ OPEN — *do not paste as decided* · 🔴 BLOCKING/COMPLIANCE · 📄 doc reference

⚠️ **Verify before pasting.** Atlassian was unavailable when this was written; routing is based on the 7/27 story descriptions. Some of this may already be in the live ticket — check first.

---

## ENG-82387 — AI Signal Extraction *(epic)*

```
── Update 2026-08-11 · Jira Alignment sync (Lalit/Sagar/Hemant) ──

DB schema (shape agreed). The processing schema covers three areas:
  1. Pipeline setup — main processing task, trigger details (task ID, instance ID, user).
  2. Prep & recap data.
  3. Recommendations.
Detail lives in Confluence "AI Meeting Transcript: DB Schema" (page 4350935050, Sagar, ~8/11).
Sagar to attach schema + infrastructure sub-detail to the pipeline ticket.

Reconciliation scope — NOT YET CHANGED. Reconciliation runs at MEETING level today.
Agreed in-session that it needs to move to USER level: the same goal discussed across
different meeting instances (with different participants) currently yields duplicate,
inconsistent recommendations for one user. Sagar to assess whether goal extraction and
reconciliation split into separate tickets. No AC changed pending that call.

Speaker attribution. Confirmed working for SINGLE-PASS processing only. Multi-pass to be
tested to determine whether additional handling is required.

⚠️ OPEN — Turn IDs. Sagar reopened the earlier decision to drop turn IDs from the payload.
Unresolved; affects attribution and evidence-citation fidelity.
```

**AC to append:**

```
- [ ] Given a user with recommendations generated from more than one meeting instance, when reconciliation runs, then duplicate recommendations for the same goal are consolidated across all of that user's relevant meeting instances rather than per meeting. (⚠️ pending user-level reconciliation decision — do not implement from this line alone)
- [ ] Given a transcript processed in multi-pass mode, when speaker attribution runs, then speakers resolve with the same accuracy as single-pass, or the gap is documented. (⚠️ pending multi-pass test)
```

---

## ENG-84148 — API contract & I/O *(In Progress)*

```
── Update 2026-08-11 · Jira Alignment sync ──

Endpoint set (reviewed and agreed):
  • Trigger processing
  • Get status
  • Bulk accept recommendations
  • Bulk decline recommendations
  • Meeting recommendation
  • Recap

Bulk operations process 4 items per call.

Trigger endpoint — to add:
  • stages — restrict processing to named pipeline stages
  • force_regeneration — bypass cached output and regenerate

Manual transcript upload. No separate mode parameter. Manual uploads are triggered by
passing transcript_enabled = true together with the S3 URL of the uploaded transcript —
the same path as automated Zoom ingestion (Sagar, 8/11 14:57 IST).

⚠️ OPEN — persist transcript source? Sagar asked (8/11 15:04 IST) whether manual vs
automated should be stored for future use. If yes, the trigger API needs a source
parameter in addition to transcript_enabled, and the schema needs a corresponding field.
Unanswered as of 8/12.

Owner note: Hemant to circulate the endpoint contracts to the team.
```

**AC to append:**

```
- [ ] Given a bulk accept or bulk decline request, when the caller submits more than 4 recommendations, then the request is batched at 4 items per call.
- [ ] Given a trigger request with a stages parameter, when processing runs, then only the named stages execute.
- [ ] Given a trigger request with force_regeneration = true, when processing runs, then cached output is bypassed and content is regenerated.
- [ ] Given a manually uploaded transcript, when processing is triggered, then the payload carries transcript_enabled = true and the S3 URL of the uploaded file.
```

---

## ENG-82994 — Connect Zoom UX · consent, Integrations panel & status

```
── Update 2026-08-11 · #meeting-transcript-integration ──

🔴 Manual transcript upload proceeds regardless of Zoom consent status.
If a user has not granted Zoom consent but uploads or pastes a transcript manually,
AI insights ARE generated from that transcript (Lalit, 8/11 14:17 IST; requirement
restated by Hiten 14:56 IST). Implementation: transcript_enabled = true + S3 URL.

Sagar's framing, unrebutted in thread: "does that mean a manual transcript upload
overrides the user's personal consent?" — effectively yes for the manual path.

Sagar explicitly asked that this decision be recorded, flagging it as material for
QA security testing (8/11 14:58 IST). This block is that record.

🔴 Interaction to resolve: this sits alongside the three-level consent model (org /
series / instance) and the full-consent-required rule for Recap. A manual upload path
that bypasses per-user Zoom consent needs an explicit position in the InfoSec consent
doc — which is still unsent to Brian Jacobs (~34 days overdue) and does not yet cover
this case.
```

**AC to append:**

```
- [ ] Given a participant who has not granted Zoom consent, when a transcript is uploaded or pasted manually for that meeting, then AI insight generation proceeds from the uploaded transcript.
- [ ] Given the manual-upload consent-bypass path, when security testing runs, then the behaviour is covered by an explicit test case. (Sagar, QA/security ask)
```

---

## ENG-82996 — AI Meeting Prep Card · UI

```
── Update 2026-08-11 · Jira Alignment sync ──

Display caps (Hemant, confirmed in session):
  • Recommendations — maximum 3
  • Goal signals — maximum 2

⚠️ OPEN — Attention Flags cap. Sagar argued 2 is more appropriate than 3 for attention
flags and recap items. Hemant's confirmed figure was 3. No call was made before the
meeting ended. Do not implement the flag cap from this block until settled.
```

**AC to append:**

```
- [ ] Given a generated Prep card, when it renders, then at most 3 recommendations are shown.
- [ ] Given a generated Prep card, when it renders, then at most 2 goal signals are shown.
```

---

## ENG-82997 — AI Recap card · UI

```
── Update 2026-08-11 · Jira Alignment sync ──

⚠️ OPEN — item caps. Sagar proposed 2 rather than 3 for recap items and attention flags.
Existing AC specifies Blockers ≤3 / Follow-ups ≤5, duration-scaled. Unresolved.

⚠️ OPEN — sizing basis. Sagar: caps should scale off PROCESSED transcript length, not
raw transcript length or meeting duration. Current AC scales by duration. Changing this
alters the duration-scaled cap logic — needs a decision before AC is rewritten.

⚠️ OPEN — carry-forward criteria. The session raised, but did not define, the rule for
which recap items carry forward into a subsequent meeting's recap (persistent blockers,
unresolved follow-ups, recurring trends). Related to the user-level reconciliation
question on ENG-82387.
```

*No AC changes — all three items are open. Left as a note per direction.*

---

## ENG-82397 — AI suggestions and completions · UI

```
── Update 2026-08-11 · Jira Alignment sync ──

Bulk accept / decline are backed by dedicated endpoints processing 4 items per call
(see ENG-84148). Any bulk UI affordance should batch to that limit rather than issuing
per-item calls.

Note: AI completions were split out to ENG-86085 on 8/7 — confirm which of this ticket's
completion-related AC still belongs here before appending.
```

**AC to append:**

```
- [ ] Given multiple pending recommendations, when the user performs a bulk accept or bulk decline, then the client batches the request at 4 items per call.
```

---

## ENG-83002 — Zoom Admin Page · UI

```
── Update 2026-08-11 · #meeting-transcript-integration (Tanveer, Danish, Asa) ──

🔴 Zoom App Marketplace submission is now an active release dependency, not a
hypothetical. Raised by Tanveer 8/11 12:30 IST: the Zoom app likely needs publishing to
the Zoom App Marketplace for release, third-party approval is required, and the review
cycle is long enough that it must start immediately.

Status as of 8/11:
  • Danish is driving; shared Zoom's review-process/prerequisites doc (Google Doc, 8/11 17:04 IST)
  • Danish needs admin-level permission to create the production app in the Betterworks
    Zoom account and submit it for review
  • Asa Denton granted Danish the "Zoom for Developers" role (8/11 21:00 IST)

This converts Jira Q15 (Marketplace approval vs OAuth-suffices, 8–13 week review) from an
open question into a live gate, and reactivates ENG-82987 (Zoom Marketplace/API
feasibility spike) — the only 7/27 spike still In Progress, unchanged since 6/23.
```

*No AC change — this is a dependency and gate note. Consider whether it belongs on the parent epic's release-gates list instead.*

---

## ENG-79199 — Parent epic

```
── Update 2026-08-10 / 08-11 · #meeting-transcript-integration ──

Source handling (scope confirmation, Lalit 8/10 11:57 IST):
  • One source at a time. Multiple sources processed simultaneously (e.g. Zoom + MS Teams)
    is a P2 item, post-MVP. Architecture is being shaped to allow it later, but MS Teams
    is NOT in the month-end release.
  • One Zoom transcript per 1:1 meeting for now. Multiple files from a single Zoom meeting
    is a known later case — confirms the existing P2 deferral rather than changing it.

P3 — logged, below the P2 line (Lalit, 8/11 13:00 IST):
  • Skill recommendations
  • Slack / Jira / Teams connections

Release dependency added: Zoom App Marketplace approval (see ENG-83002).
```

---

## Not routed

Items from the 8/11 session with no clean ticket home, listed so they are not lost:

- **"Update the Bhakti documentation"** — action assigned to Lalit in the Zoom summary. Likely a transcription artifact; couldn't resolve what document this refers to. Please confirm the intended target.
- **Private notes** — Hemant raised briefly; no decision, no scope statement.
- **Agenda items in meeting data** — mentioned in passing during the data-processing discussion; no decision.
- **Low-confidence data handling** — discussed; appears to overlap the confidence-judge decision already captured at 8/6 in reconcile §1. No new position taken.
- **Coaching briefs for manager personas** — Lalit mentioned alongside summary and attention flags; consistent with the existing P1-lightweight/Phase-2-full split. No change.
