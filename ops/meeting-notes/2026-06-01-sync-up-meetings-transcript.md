---
date: 2026-06-01
meeting: Sync up - Meetings Transcript
type: sync
attendees: [Lalit Maharana, Sagar Bhat, Hemant Kumar]
source: zoom
meeting_uuid: C1120575-C345-4D92-871D-7DE8DA2D069B
backfilled: 2026-07-07
---

# Sync up - Meetings Transcript — 2026-06-01

## Summary
Working sync between Lalit, Sagar, and Hemant on the AI meeting-transcript pipeline, resolving the open AI-side questions Sriram had flagged the previous Friday. The group aligned on the data window and data-sourcing approach for the MVP, discussed transcript processing/chunking, latency expectations, RBAC scoping of goals, PII handling, model choice, and enumerated the initial story/task list for the AI board. Sriram had noted an August release target.

## Key decisions
- Data window: consider current fiscal year data only for the MVP (previous-year goals are typically closed after the review cycle; a meeting never spans across fiscal years).
- Data sourcing: for the MVP, fetch goals (and needed data) LIVE via API calls rather than relying on pre-processed DB data — ensures accurate, non-stale data. (Bhavesh's advice: don't make pre-processing a dependency for this feature.)
- Live-call approach is acceptable for the MVP (goals + action items) but is NOT scalable as scope expands to conversations, feedback, recognition, skills — will need a different data-prep approach later.
- Recap: one meeting → one transcript → one recap (immediate last meeting only), stored as the meeting summary (key points).
- Meeting prep (current meeting): synthesize the last ~4–5 meetings (keep configurable; can go further back), plus meeting metadata (previous agenda items, action items). Validate meaningfulness in the POC and expand scope if needed.
- Failure handling: follow the existing pattern used for other AI summaries — show an error message with a retry button to re-trigger the flow.
- Fallback source: manual transcript upload (text file / paste from Granola or other meeting-record services) when Zoom integration isn't available — needs the meetings/integration pod to upload to S3 and pass an S3 link.
- Model: no specific requirement — use whatever works; likely Gemma (a good use case to start experimenting with Gemma); decide based on latency.
- RBAC: pull the user's public AND private goals, but ensure private goals are NOT shown to managers when giving manager visibility into an employee's goals.
- PII: reuse existing guardrail guidance; work-related detail (e.g., "deliver laptop to Hyderabad") is fine, but personal identifiers (PAN/Aadhaar/SSN, flat number, PIN code) should not surface in action-item titles or recommendations. Treat as a "star item" / PII consideration — implement and observe rather than a hard guardrail block.
- Embeddings: not now — go with Postgres/type system (per JZ) for the MVP; embeddings are a future task once implemented in parallel.

## Discussion notes
- Latency: the 30s/60s numbers in the doc (Appendix A5) are unrealistic — current summaries (performance, feedback) already take a couple of minutes; a 30-min/1-hr transcript is a lot of text and won't process in a single pass. Landed around ~120s depending on data volume.
- One-on-ones are not saved in memory yet; skills data is P2 (must be triggered per user before it's saved in the LLM Engine DB).
- Transcript processing will need a chunking strategy (research industry standard / check with Claude) — a full transcript won't be processable in one go.
- Need a sample transcript from the integrations team (uploaded to S3) to play around with processing.
- Recommendation logic: identify renewable signals from the transcript; "create goal" is straightforward; check whether a new goal conflicts with existing (current-fiscal-year) goals — this requires live, accurate goal data.
- Feature is on priority given the August release target.

## Action items
- [ ] Sagar & Hemant — Set up a call with JZ to share the plan and get direction; aim for some implementation/direction by end of week.
- [ ] Hemant — First action: POC on processing a large Zoom transcript (chunking strategy, meaningful chunks) referencing existing implementations.
- [ ] Sagar/Hemant — Implement the endpoint(s): POST to trigger the flow and endpoint to fetch/poll the response; plus DB migration tasks for storing summaries.
- [ ] Sagar/Hemant — Implement insights + action-item building from prompts (recommendation + summary generation in the API endpoint).
- [ ] Lalit — Create an epic "Meeting transcripts / recommendations architecture" and add these stories (rephrase the crude drafts).
- [ ] Lalit — Assign the recommendations spike to Sagar (Sagar to add detail, then close/reassign to Hemant).
- [ ] Lalit — Discuss the manual-upload → S3 flow with the meetings/integrations pod (they must upload to S3 and pass the S3 link); can pitch it in the evening sync.
- [ ] Sagar/Hemant — Reach out to Tejas/Akansha for Gemma experience; connect with JZ on model choice and latency.

## Next steps
- Connect with JZ (Sagar/Hemant); by end of week aim to have a direction and initial implementation set up. Discuss the S3 upload flow with the integrations team in the evening sync.
