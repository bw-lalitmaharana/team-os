---
date: 2026-05-21
meeting: Meetings Transcript - Platform / AI / Integrations sync
type: architecture
attendees: [Lalit Maharana, Pankaj Lohmor, Sagar, Anuj Pancholi, Danish, Tejas]
source: zoom
meeting_uuid: 4C721D01-9E62-4111-A418-214290B4479C
backfilled: 2026-07-07
---

# Meetings Transcript - Platform / AI / Integrations sync — 2026-05-21

## Summary
The meeting focused on the feature that extracts signals from meeting transcripts to automatically suggest action items, goal updates, and other recommendations to users after meetings finish. Lalit presented the UI design concept showing how meeting summaries, action items, and recommendations would appear on the meetings page, with plans to extend across the platform to other pages and sources beyond Zoom transcripts. The team discussed the technical architecture: transcripts from third parties like Zoom flow through integration layers, then to a new AI action system microservice that extracts relevant info and generates draft suggestions for action items, goals, and other modules. Key challenges identified: mapping transcript content to existing Betterworks data, handling meetings that don't cover all planned topics, and managing accumulation of suggestions over time. The team agreed to refine architecture, design, and story sizing over the next few days before starting development next sprint.

## Key decisions
- Phased rollout: P1 = Zoom integration + basic recommendations (action items, goals); feedback and recognition deferred to a later phase (P2).
- The AI action system will be a new microservice (Anuj leading), with the AI team handling inference and data correlation; it stores cross-board suggestions/actions.
- Integration layers will listen for webhooks or poll third parties for transcripts, triggering events into the AI action system.
- LLM module mapping to use the existing cosine-similarity approach plus context-based LLM suggestions (as used in Goals Assist) to correlate data points to source; false positives to be minimized through iteration.
- Team to refine architecture/design/story over the next 1–2 days, then size and split into tasks; implement next sprint.

## Action items
- [ ] Anuj — Work with Danish to obtain sample Zoom transcript schema/data for testing participant → Betterworks user-ID mapping.
- [ ] Anuj — Investigate (with Danish) feasibility/accuracy of mapping transcript participants to Betterworks user IDs using Zoom/iPass vendor data.
- [ ] Pankaj — Share a sample transcript and sample payload with Sagar and the AI team for testing and schema design.
- [ ] Sagar — Define the expected schema and draft a prompt for processing transcript data using the provided sample.
- [ ] Sagar — Share existing documentation / code walkthrough of current AI features (e.g., Goals Assist) handling source mapping and cosine similarity.
- [ ] Lalit — Share the UI design page shown in the meeting with Sagar and team for review.
- [ ] Lalit — Check with design on UI patterns for marking action items complete and refine UX for handling multiple weeks' suggestions.
- [ ] Lalit — Share a task list (e.g., spreadsheet) with descriptions for refinement and story-point sizing.
- [ ] Lalit — Check usage data for the action-item/agenda-item rollover feature to inform design.
- [ ] Lalit — Refine the rulebook/logic for showing, rolling over, and managing staleness of recommendations and action items across meetings.
- [ ] All (Lalit, Pankaj, Sagar, Anuj, Danish, Tejas) — Refine architecture, design, and story; prepare for sizing and task split.

## Follow-ups / open questions
- Whether to add a rail between the data-sending and inference steps (raised by Tejas).
- Vector embeddings for goal matching are not currently available; to be built later as a separate service.
- Handling cases where a meeting doesn't cover all planned topics.
- Managing UX when suggestions accumulate over time.

## Discussion notes
The feature auto-generates meeting summaries, identifies action items from conversation, and provides contextual goal/progress info, considering existing user-created action items to avoid duplication. Pankaj described the integration layers listening for webhooks / polling third parties. Tejas clarified the AI action system is a new microservice. Sagar explained the current cosine-similarity + context-LLM approach achieves near-zero errors and offered to walk Danish through the code. Data flow: transcripts processed through multiple services; the AI action system receives context (meeting IDs, action-item IDs, user data) to generate suggestions.

## Next steps
- Refine architecture and design over the coming days; implement in the next sprint.
- Reconvene to review refined architecture, design, and story breakdown.
