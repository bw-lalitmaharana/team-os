---
date: 2026-06-16
meeting: Project Plan | Meeting Transcript
type: planning
attendees: [Lalit Maharana, Sagar Bhat, Anuj Pancholi, Danish Sharma, Harshini Vijay, Tanveer Farooq, Pankaj Lohmor, Prasanna Poojary, Hemant Kumar, Sriram CS]
source: zoom
meeting_uuid: 0501939E-0758-4A0C-9B8F-4D130A12F5CF, 1288F816-9A54-4FDF-BA75-A834BFD575CF, 1D484F6D-BF51-464C-B2E3-BAE67DABAC85, 7203B3C9-16C2-4095-A0AF-E6BAC617E006, A988E198-13C3-44D9-B238-6AD641615645, B9A88818-1ACB-49E5-A40F-C92BAD7D36EB, BFD4933A-B33E-410D-A097-4A2A4DEA013E, DC61E9C9-4A4F-4ED7-A17E-5AD54C29EA71, E914A1E5-3CAC-4DAB-B209-5ACCCDEEAA5A, E9DE876C-E98F-4E57-B24C-F40EF3018E76, F3ACDB68-A569-4E44-9F40-EB07DBE272D7
backfilled: 2026-07-07
---

# Project Plan | Meeting Transcript — 2026-06-16

> Note: This is a single note merged from 11 Zoom captures of the recurring "Project Plan | Meeting Transcript" planning call on the Meeting Transcript Integration feature. The primary body is drawn from the richest capture (0501939E — the alignment session); additional decisions surfaced in the other captures are folded in below.

## Summary
Alignment session covering the Meeting Transcript Integration feature: integration architecture, OAuth/webhook design, user consent flow, AI-driven meeting insights UI, and daily scrum cadence. The core integration architecture (admin OAuth, single webhook, consent-based processing) is largely aligned, with the webhook routing approach (single URL vs. per-org URL) remaining the key open technical question. UI flows are well-shaped, with minor adjustments needed around consent-only UX and Figma reference screens for developer handoff.

## Key decisions
**Integration architecture & OAuth**
- OAuth will be admin-level (one-time per org), not per-user; individual users only provide in-app consent (Anuj & Danish).
- Webhook distribution debated: Pankaj proposed a single Betterworks-wide webhook URL using Zoom's `account_id` to route events per org; Danish's original approach assigned unique URLs per org — resolution deferred offline.
- Two events will be published: card enable/disable state change, and OAuth completion with token storage.
- Inbound webhook must be built in-house — no viable third-party or open-source solution exists (from spike).

**User consent & data processing**
- If User A consents but User B does not, transcripts are processed on A's behalf only; B sees no data until consent is given (Lalit).
- Future meetings only — past transcripts are not retroactively processed after a user grants consent.
- Consent flag must be included in the payload passed from Meetings to AI.

**UI / designs**
- "Accept and Connect Zoom" CTA simplified to "Accept" only — no user-level Zoom OAuth redirect needed.
- Notes section gains a third tab: "AI Transcript" (name retained for AI branding per Sriram's input).
- Manual transcript input (paste or file upload) supported when Zoom is not connected; validated and uploaded to S3 by Meeting Service — no AI dependency at upload stage.
- Source citations and timestamps removed from action items and agenda item suggestions in designs — confirmed intentional, removed due to "too much noise" per Natalia's direction.
- Transcript format standard: accept VTT format only (VTT or TXT MIME type); educate users rather than parse arbitrary provider formats.
- AI recap placement: show above agenda topics and action items for past meeting instances only; upcoming meetings retain the left/right split layout.

**AI suggestions & goal recommendations**
- AI will produce two suggestion types: create (new action item/goal) and update/close (existing item); grouping by type handled on the Meetings UI side.
- Goal suggestion API response will include name, description, and owner ID — sufficient to pre-populate the Create Goal form; mandatory fields (type, category) completed manually by the user.
- Both private and public goals to be included in goal suggestions.
- For MVP, AI fetches goals data directly from the Goals microservice using participant Betterworks user IDs; a future data service (warehouse query layer) discussed for scale but not on the current timeline.
- Milestone updates and business-period extraction flagged as MVP-scope questions (Sagar, Anuj); explored only if schema allows, not hard blockers.

**Cadence & tracking**
- Async scrum not working; switching to a synchronous daily 15-min call at 12 PM IST (after Danish's 11 AM integration scrum).
- Implementation tracking to begin formally from July 1st; full timeline to be established by Wednesday.

## Action items
- [ ] Danish — Share integration technical/non-functional requirements doc internally, then with wider stakeholders with a defined timeline and audience.
- [ ] Danish — Provide Harshini details on Zoom webhook authentication flow (likely basic auth) and two-step admin setup screens (similar to LMS flow).
- [ ] Danish & Pankaj — Resolve offline: single Betterworks webhook URL vs. per-org URL architecture for Zoom event routing.
- [ ] Danish — Share gateway/inbound-webhook architecture document for internal review; begin project structure setup for the new inbound webhook service.
- [ ] Harshini — Update consent modal CTA to "Accept" only; add third-party integration page designs for the Zoom card; create error-state designs.
- [ ] Sagar / Hemant — Finalize spike + API contract; confirm milestone update scope for MVP with Lalit; assess business-period extraction feasibility.
- [ ] Sagar — Share high-level API contract (triggering API + GET API) with Anuj for gap review.
- [ ] Anuj — Confirm whether Zoom Marketplace app approval is required for prod GA; investigate action-item / agenda-topic rollover ID behavior; validate manual upload / copy-paste ingestion approach with Pankaj.
- [ ] Tanveer — Schedule recurring 12 PM IST daily scrum; gather ticket estimates from engineers; build project plan / end-date timeline by Wednesday.
- [ ] Lalit / Harshini — Share Claude design links in the Meeting Transcript Integration channel for engineering reference.

## Follow-ups / open questions
- Final webhook routing approach (single Betterworks URL vs. per-org URL) — key open technical question.
- Rollover ID handling: agenda topic IDs change on rollover (new instance = new ID); action item IDs may also change — deterministic mapping across a meeting series needed rather than relying on AI/string matching. A key edge case: an action item marked done after rollover may still surface as a suggestion to close because its ID differs from the one in the AI DB. Hiten to spike a solution on the meetings side.
- Same Zoom meeting ID can be linked to multiple meeting series (e.g. Sriram reuses one URL), risking mixed transcripts — mitigation via participant validation and a 1-hour start-time correlation threshold; if correlation fails, prompt manual upload.
- Multi-transcript handling (meeting drop/rejoin) deferred to post-MVP.
- Whether owner ID alone is sufficient to invoke the Create Goal form (Anuj to confirm).
- Refresh consolidation (3 separate refreshes → 1): no conclusion yet; awaiting Sagar's input.

## Scale / infra notes
- Scale estimate: ~1,600 concurrent participants, ~400 processing transcripts simultaneously in a peak week (Lalit).
- Current single inference server per environment is insufficient; horizontal scaling (HPA) needed going forward (Sagar).
- Decision to use the Zoom AI Companion transcript event over cloud recording.
