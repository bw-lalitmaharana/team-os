---
date: 2026-05-27
meeting: Meeting Transcript - Refinement
type: refinement
attendees: [Lalit Maharana, Sagar, Pankaj Lohmor, Anuj Pancholi, Prasanna Poojary]
source: zoom
meeting_uuid: 31BA0738-954B-4C9B-90C6-50290B4CF273
backfilled: 2026-07-07
---

# Meeting Transcript - Refinement — 2026-05-27

## Summary
Refinement working session to finalize the architecture and story for the meeting-transcript recommendation system, and to align on ownership and story split. Lalit presented the high-level design: multiple data sources (Zoom transcripts first) feeding a recommendation system that extracts summaries, action items, agenda topics, and goal/recognition recommendations into a prioritized queue, with UI changes to surface them. Primary goals: reduce manager meeting-prep time and help employees get credit for contributions. The team worked through ranking logic, data-retention policies, the regenerate flow, and integration with the existing LLM engine. Key decisions: ship V1 of summaries/recommendations before regenerate; use priority levels instead of complex re-ranking; data-source limits of one fiscal year for goals and three months for recognition. Architecture diagram/details to be frozen, with Sagar's team owning documentation.

## Key decisions
- Build the LLM-engine into this rather than a new service; the AI/LLM team accommodates storage + a simple API for draft actions/recommendations.
- Prioritize V1 of summaries and recommendations first; defer the "regenerate" button flow.
- Use priority levels (adaptable to new signals and module context) instead of fixed re-ranking; on dismiss, remove from queue and show the next item.
- Ranking approach based on recommendation type, due dates, and created dates, with module-page-specific ordering.
- Data-source limits: last one fiscal year of goals; three-month window for recognition checks; also consider open action items and goal config schema/visibility when classifying recommendations.
- Action items and module-specific recommendations share one queue but are visually differentiated in the UI.
- AI-generated recommendations are pre-placed for user review/decision; unaddressed action items roll forward to subsequent meetings.
- Freeze the architecture diagram/details; Sagar's team owns documenting the agreed architecture.

## Action items
- [ ] Lalit — Study and propose a retention policy for unreviewed action items (time-based or meeting-occurrence-based TTL).
- [ ] Lalit — Provide sample data points + expected transformations (transcript text → action items/goals/recognitions) to the AI/LLM team for alignment.
- [ ] Lalit — Freeze the list of goal attributes recommendations should target (create, update progress, description, timelines, etc.).
- [ ] Lalit — Share updated architecture/documentation and refine based on feedback.
- [ ] Sagar — Discuss internally and own freezing the architecture diagram and related details.
- [ ] Sagar (AI/LLM team) — Accommodate storage + API for draft actions/recommendations within the existing LLM engine; provide a simple API to serve draft actions.
- [ ] Sagar (AI/LLM team) + Lalit — Co-create the prompt/context for the LLM to classify and generate recommendations (action items, goals, recognition).
- [ ] All (as needed) — Bring Lalit into follow-up discussions as implementation questions arise.

## Follow-ups / open questions
- Time limits for retaining unreviewed action items (TTL policy).
- Exact architecture and implementation details (Sagar's team to own and refine).
- When the regenerate button is needed (when users change agenda topics/goals before meetings, so the AI brief reflects current data) — Sagar's team currently shows new data via toast messages.
- Whether re-ranking is necessary on delete (Pankaj suggested simply marking deleted and showing the next).

## Discussion notes
- System connects to Zoom to access transcripts; extracts meeting summary, action items, agenda topics; provides goal-related recommendations; includes a recommendation queue with prioritization and UI changes to display it.
- When generating from transcripts, the system considers open action items, current goals, goal config schema, and visibility settings to classify recommendations appropriately.
- Prasanna agreed with the plan for the working session (discuss missing pieces, PIDs, architecture docs to gain full clarity).

## Next steps
- Sagar's team to freeze and document architecture; Lalit to supply sample data/transformations and freeze goal attributes; co-create LLM prompt.
