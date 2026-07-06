---
date: 2026-06-09
meeting: Meeting Transcript - AI sync
type: sync
attendees: [Lalit Maharana, Sagar Bhat, Hemant Kumar]
source: zoom
meeting_uuid: E4E45AEA-6193-48A4-A144-1C7FE3DAF9F4
backfilled: 2026-07-07
---

# Meeting Transcript - AI sync — 2026-06-09

## Summary
AI-pod sync on the meeting-transcript feature. Hemant reported the transcript-processing POC (happy flow) is done; the team is moving toward feature implementation. Discussion centered on setting up the API contract with the meetings team (via dummy/mocked endpoints so both sides can develop in parallel), the need for a real transcript on an S3 bucket to measure end-to-end latency, per-user insight generation for one-on-ones, and the reconciliation/post-processing framework to de-duplicate recommendations. No summary asset was available; notes reconstructed from the meeting transcript. (Parent Jira: 8079199 → three child epics: integration, AI, meetings.)

## Key decisions
- Provide the meetings team a set of dummy/mocked LLM-engine API endpoints (valid endpoints returning mock data, no real execution) so they can build/test their integration without depending on the AI pod; swap in real logic once the AI change is complete. Link this work to an existing story (API contract + I/O endpoints).
- Do NOT jump into implementation before contracts/schemas are signed off with both meetings and integrations teams. The architecture spike's end goal is the documented plan/contract, not code.
- Per-user insight generation: transcript processed once; matched/compared twice against each participant's data (user 1 and user 2 perspectives), producing separate recommendation sets per user. Ignore third/ad-hoc speakers not part of the one-on-one (they won't see this meeting or recommendations); primary users come from meeting metadata (user 1, user 2). Design is scalable to group meetings.
- Cleaning/guardrails (PII skimming) is the common pipeline step. PII handling deferred for now; when addressed, handle mixed-content lines (extract useful data, ignore personal parts) rather than dropping whole lines.
- Reconciliation/post-processing framework will de-duplicate and consolidate into one set of recommendations per user, checking existing recommendations and previous actions to tweak new ones (embeddings a separate later story).
- Action tracking (accepted/dismissed AI suggestions) will be a separate ticket; meetings team records and sends a flag when a suggestion is accepted/dismissed.
- Sync cadence: move to async Scrum updates in the channel; keep the evening call primarily for progress tracking (optional attendance); deeper cross-team flow discussions handled async/ad hoc with Lalit looped in.

## Action items
- [ ] Sagar / Hemant — Give meetings team dummy/mocked LLM-engine API endpoints for contract testing; finalize the response structure (with Hemant, loop in Bhavesh); link to existing story
- [ ] Sagar / Hemant — Continue building the processing pipeline; ~1 week to a basic end-to-end POC
- [ ] Lalit — Coordinate with meetings team (Tanveer) to put together the project plan (dependencies, timeline to closure); carry the message on the S3 bucket / file-name format
- [ ] Meetings team (via Lalit) — Create an S3 bucket, share credentials, and place a sample transcript so the AI pod can test fetch → process → measure latency (flagged as a blocker for end-to-end testing)
- [ ] Sagar / Hemant — Agree file-name format with meetings (e.g., meeting ID + date), not random names
- [ ] Lalit — Provide/obtain real one-on-one transcripts (or generate a dummy conversation) for POC beyond synthetic data
- [ ] Lalit — Document specific spike questions to be answered; keep acceptance criteria at the story level
- [ ] Lalit — Stop/share this meeting's transcript with Hemant (and any similar one-on-one transcripts) as test data

## Follow-ups / open questions
- Sample payload/input format and how it's pulled (from meetings pod or warehouse); credentials.
- Contract details: user ID format; distinguishing user vs manager.
- Whether the AI pod must go back in time to pull previously accepted action items (Sagar: probably not needed now since new meetings data reflects accepted items).
- No current mechanism to track prior user actions on suggestions — architecture must record accept/dismiss per action item (separate task).
- Latency: S3 pull time must be minimal (adds to overall feature latency); needs real numbers before claiming speed. Intermediate/waiting state exists in the UI.

## Discussion notes
- POC currently uses a locally-saved random TXT file (not S3); fetching from S3 is untested. Transcripts used are synthetic (1009ABC / 1008AB series) — "too much" happy-flow / clean data; real data needed to see speaker-detection edge cases, multiple languages, etc.
- Meeting states: upcoming (no transcript), active (transcript generating/processing state), completed (transcript arrived). On processing, store suggestions/summaries in respective places and send to UI to render.
- Recommendation pipeline may combine transcript + DMs + Jira per user; separate pipelines if recommendations are derived independently, together if interdependent; post-processing removes redundancy across sources.
- Sagar's concern about the evening call: not everyone joins and some calls feel redundant; hence the async-first proposal, keeping a time block for at least one connect.

## Next steps
- Reconnect on the evening call to finalize contract questions and discuss remaining items with Tanveer.
- Sagar to drop a note in the meeting channel; Lalit to be looped into any cross-team discussions.
