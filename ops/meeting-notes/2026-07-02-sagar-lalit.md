---
date: 2026-07-02
meeting: Sagar / Lalit
type: 1:1
attendees: [Lalit Maharana, Sagar]
source: zoom
meeting_uuid: AE7A9263-1EEE-4D1E-8CC3-93A5BD91DCB2
backfilled: 2026-07-07
---

# Sagar / Lalit — 2026-07-02

## Summary
General catch-up on the AI meeting transcript pipeline, completion of embedding work, and the roadmap through August. Embedding work is fully closed on the internal environment and transcript implementation has begun. Target: dev-complete for the transcript feature by July, with an August production release.

## Key decisions
- DB schema for transcript pipeline: series_id/instance_id as primary key; source stored as an enum (Zoom default, extensible to Slack/manual upload); S3 URL and a transcript hash included to prevent redundant pipeline runs on unchanged data.
- Embedding dimensions: 512 for OpenAI; ~768 retained for the other model; half-vector chosen over full-vector after spiking.
- Normalization service removed as middleware — LLM engine now calls the talent API directly; normalization code moved into the LLM engine (eventually to be relocated inside the talent service).
- Dummy APIs to be created so the meeting pod team is unblocked and can test flows without the real backend.
- Design document to be shared with the team today (by evening) on Slack; walkthrough call scheduled for Monday if needed.

## Action items
- Sagar: Finalize the DB schema and ensure Hemant is aligned; integrate Hemant's transcript processing pipeline into the codebase.
- Sagar: Share the meeting-transcript design doc on Slack today; schedule a walkthrough call (possibly Monday).
- Sagar: Run the script to generate embeddings for translated skills in the internal environment.
- Sagar + Jay-Z/Nelly: Verify the normalization service migration is complete and close the ticket.
- Hemant: Complete transcript processing pipeline, then create the dummy API set and share the branch with the meeting pod team.
- Team (infra/Lightcast): Confirm readiness to run translated-skills scripts on production; Sagar then triggers the ~5-6 hour embedding job.
- Lalit: Clarify scope/support needed for the learning recommendation engine with Nitesh; follow up on Arabic/Light customer topics.
- Team (Product/Harshini): Review the first transcript iteration in July and provide feedback.

## Follow-ups / open questions
- Translated-skills scripts need a green light from the Lightcast/infra side before running on production.
- Prompt management (LLM prompts in DB with version history, configurable selection, prompt guard, standardized output) partially implemented; Gemma/Llama prompts not yet fully added to DB; needs broader team involvement.
- Learning recommendation engine scope (courses matching, talent profile recommendations) — Nitesh leading courses; cross-team sync needed.

## Discussion notes
- Embedding pipeline fully closed: ChromaDB → PGVector migration, dimension selection, half-vector spike, embedding API, multilingual skill translations (Lightcast 9.22 → 9.32 delta), Rundeck job on internal.
- Transcript design ~90% finalized; implementation started with Hemant on the transcript processing pipeline.
- Risks: post-implementation prompt tweaking could delay release by days to a week; support work for the learning recommendation engine may pull time from transcript delivery; transcript work was previously delayed because priority between embedding and transcript wasn't escalated early enough.
- Date-picker feature would require real-time processing and may face testing challenges due to pre-processing requirements.

## Next steps
- Aim for transcript + learning-engine dev complete by July; share doc by evening; walkthrough next week.
