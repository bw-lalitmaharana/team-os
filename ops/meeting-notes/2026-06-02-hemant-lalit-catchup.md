---
date: 2026-06-02
meeting: Hemant / Lalit - Catchup
type: catchup
attendees: [Hemant Kumar, Lalit Maharana]
source: zoom
meeting_uuid: FA7DFAEB-B7B7-4BD9-B9F0-3F6641C4BFEF
backfilled: 2026-07-07
---

# Hemant / Lalit - Catchup — 2026-06-02

## Summary
Catchup and work review between Hemant (~4 years at Betterworks, recently moved to the AI team after homepage development and product migration) and Lalit. They reviewed AI features — meeting transcripts, one-on-one summaries, talent services, performance-management tools — with Lalit updating on development phases and technical implementations. Discussion covered monolith architecture changes, auth-token management, and the meeting-transcript pipeline, plus Hemant's current challenges with latency and error handling in the LLM-engine integration. They also discussed India/other-location team coordination (most engineering decisions handled by the US team).

## Key decisions
- Hemant to start code development on moving the API, beginning with auth.
- Extend the framework for the meeting-transcripts pipeline; aim for an MVP release.
- Formalize/scale meeting-transcript processing per queue and add more touchpoints (Zoom integration, one-on-ones); divide the work to move forward.
- Cluster LM Engine Direct Service for call queries to address latency/error issues from the current monolith.

## Discussion notes
- Hemant now on the homepage development team and AI team; plans to create a test account and start API/auth code development.
- LM Engine clustering: ~80% of the dev task complete; local testing still needed to remove the Rainforest environment dependency; updates possibly by next morning.
- DevOps/dashboard access issues — tickets needed for access requirements.
- AI performance features: one-on-ones, meeting tracker, talent-services integration; performance-summary redesign and TechWolf integration completed.
- Lalit's AI initiatives overview: Agentic AI Foundation MCP layer (chat/POI), CI/CD framework, AI-powered skill-to-learning matching engine for learning recommendations; pre-processing Phase 3 complete; upscaled Skills API (Skill Master phase 1 + user skills phase 2).
- Fiscal-year date-picker logic: gaps in performance-cycle handling; explored a date picker for fiscal-year transitions and issues with manual updates.
- Meeting transcripts: Lalit has summaries for all of Hemant's meetings; embeddings/dataset architecture discussed; noted "Jayzik"/some resources not available in India.

## Action items
- [ ] Hemant — Create a test account for Engage and share it with Lalit.
- [ ] Hemant — Start code development for moving the API, starting with auth.
- [ ] Hemant — Share the dashboard for inference-server scale up/down with Lalit.
- [ ] Hemant — Update the status of the next-gen item.
- [ ] Lalit — Add the email to the system as discussed.
- [ ] Lalit — Check the meeting-transcript pipeline setup and its production status.
- [ ] Lalit — Research and provide feedback on the fiscal-year date-picker logic issue.
- [ ] Lalit — Coordinate with the India team on use of Teams and app-platform resources.
- [ ] Lalit — Extend the framework for the meeting-transcripts pipeline; aim for an MVP release.
