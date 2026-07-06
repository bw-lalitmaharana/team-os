---
date: 2026-06-02
meeting: Bhavesh / Lalit - Catchup
type: catchup
attendees: [Bhavesh Vaviya, Lalit Maharana]
source: zoom
meeting_uuid: 7F14EE6A-8B9F-47F6-9920-8626D5621CFF
backfilled: 2026-07-07
---

# Bhavesh / Lalit - Catchup — 2026-06-02

## Summary
Getting-to-know-you catchup plus a work review between Bhavesh and Lalit. They covered several technical initiatives: AI skills, MWA (Managed Workflows for Apache Airflow) upgrade service, and integration with TechWolf and Lightcast. Bhavesh described his team's focus on Phase 2 and Phase 3 (skills and one-on-one meeting features), the complexity of implementing meeting-transcript capabilities, and the need for stable data processing. They also discussed pre-processing stability, the importance of a proper design phase before development, a browser window-resizing issue, linting requirements, and the need for better visibility via dashboards for LLM-engine tracking.

## Key decisions
- Split the meeting-transcript work: Lalit/product to handle UI and front-end design aspects while technical foundations are being built.
- A design phase is needed before development (technical designs are more complex than initially anticipated).
- Migrate generative AI models from Llama to Gemma; integrate OpenAI embeddings.
- Lightcast → TechWolf migration in two phases: Phase 1 read-only (ensure sync), Phase 2 two-way integration (user profile updates).
- Delegate Phase 3 pre-processing tasks to other team members.
- LLM proxy guardrails metrics to be tracked via New Relic dashboard (can be deprioritized if needed).
- Browser window-resizing issue for Writing Assistant is low priority (next sprint).

## Discussion notes
- Bhavesh: ~long tenure with the AI team; MWA backing service being developed on "Marakamta" (MWAA); today upgraded all environments to Airflow 2.11.0 (from outdated 2.5.1, no longer AWS-supported).
- AI projects discussed: AI Skills Annual, Agentic AI Foundation, CI/CD framework for AI benchmark testing.
- Phase 2 complete; Phase 3 focuses on skills and one-on-one meetings with individual teams; needs DB data cleanup from module data pre-processing.
- Transcription challenge: summarizing large volumes of one-on-one meetings, handling context, extracting action items; system upgrade/stability/pre-processing-run issues (DevOps resolution suggested).
- Touchpoints for the pipeline: transcription, Jira, Slack, Confluence, meeting transcripts.
- Design discussion on meeting transcript processing pipeline planned for Friday (led by Bhavesh with Sagar and Hemant).

## Action items
- [ ] Bhavesh — Lead Friday design discussions with Sagar and Hemant on the meeting-transcript processing pipeline.
- [ ] Bhavesh — Monitor and resolve stability issues from pre-processing runs.
- [ ] Bhavesh — Delegate Phase 3 pre-processing tasks to other team members.
- [ ] Bhavesh — Track LLM-proxy guardrails metrics via New Relic dashboard.
- [ ] Bhavesh — Collaborate on linter issues and codebase restructuring.
- [ ] Bhavesh — Work on DB data cleanup from module data pre-processing in Phase 3.
- [ ] Bhavesh — Add skills and one-on-ones processing to the pipeline.
- [ ] Lalit — Continue TechWolf skills integration (Phase 1 read-only, Phase 2 two-way sync) and explore migration from Lightcast.
- [ ] Lalit — Plan meeting-transcription development after the design phase is complete.
- [ ] Lalit — Address the browser window-resizing issue for Writing Assistant (low priority, next sprint).
