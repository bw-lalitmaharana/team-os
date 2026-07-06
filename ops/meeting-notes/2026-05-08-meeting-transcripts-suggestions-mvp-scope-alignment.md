---
date: 2026-05-08
meeting: Meeting transcripts suggestions - MVP scope alignment
type: planning
attendees: [Lalit Maharana, Nellie LeMonier, Gauri]
source: zoom
meeting_uuid: F6113EF7-3757-491E-B45C-4B1E53D8D31F
backfilled: 2026-07-07
---

# Meeting transcripts suggestions - MVP scope alignment — 2026-05-08

## Summary
Scope- and architecture-alignment session for the AI-powered meeting transcription and suggestions system. Lalit presented the project structure: connectors for different input sources, an AI service to standardize transcripts, and a suggestions engine that generates action items, goals, and feedback from meeting content. The team discussed shipping this as an MVP starting with one integration (likely meetings) before expanding to goals and feedback. Nellie suggested involving Varnika (PM for meetings and goals) in planning and recommended starting with manual transcript uploads for testing. The group also discussed UI design considerations and the need to align with existing data structures across team databases.

## Key decisions
- Solidify MVP scope first rather than immediately holding a 2–3 hour workshop; Lalit and Gauri to lead workshop structuring.
- Phased MVP: start with the meetings pod integration (via Varnika) before expanding to other pods.
- Use manual transcript upload for the initial POC to test both the AI and the data-structure components in parallel with connector development.
- Build a centralized/master suggestion set per user that persists across pages (dismissing a goal suggestion on the meetings page should also remove it from the goals page).
- UI principle: augment user actions rather than acting on their behalf; make it clear when users accept AI-inferred content vs. mark items complete.

## Action items
- [ ] Lalit — Talk to Varnika (PM for meetings and goals) to align on scope and next steps for the MVP.
- [ ] Lalit — Lead coordination with relevant PMs (meetings, goals, AI, etc.) to structure the initiative and ensure alignment.
- [ ] Lalit — Focus initial integration/POC on meetings starting with manual transcript upload; coordinate with Varnika.
- [ ] Lalit — Finalize the suggestion schema (title, subtitle, evidences, CTA, type) at the database level so other pods can plug into it.
- [ ] Lalit — Refine wireframe designs with Gauri after the Varnika discussion, then plan the workshop once design is complete.
- [ ] Gauri — Update prototype/designs per feedback (button alignment, message styling); confirm pattern consistency with Sarah.
- [ ] Nellie — Reach out to DevOps to get Lalit a VPN account for accessing HTML prototypes.
- [ ] Gauri & Nellie — Plan a brainstorming session for the AI assistant design work.

## Follow-ups / open questions
- Team ownership: which teams (one-on-ones, AI, integrations) will build the new UI and own implementation — likely Varnika's (meetings) team for UI.
- Current limitation: system only supports one-on-one meetings today; architecture could extend to multi-person meetings.
- Users need a way to manage/authenticate connections to external tools (Jira, Salesforce) in a dedicated configuration space.

## Discussion notes
- Proposed architecture: input sources (Zoom API, Teams API, manual uploads, Slack, Notion) → AI service that standardizes transcripts and generates suggestions → reconciliation service that checks existing employee data (goals, meetings, action items) to prevent duplicates → priority-ordered suggestion queue per user.
- Suggestion card components: title, subtext, evidences (meeting timestamps), CTA (add/dismiss), and type classification.
- Implementation split proposed: connectors (Zoom, Teams as separate stories), suggestions engine core, and pod-specific integrations (meetings, feedback, goals, skills).
- Wireframes shown at two levels: across multiple meetings for consolidated signals, and within individual meetings for agenda/action items.
- Recommendation card feature approved by Nellie (may be trimmed to fit time constraints); would incorporate meeting titles, dates, and attributes like goals, skills, action items, and agendas. Potential Zoom webhook integration noted but not fully explored.
- Nellie stressed including action items and agenda topics as core meeting-structure elements, not just goals and skills.
- Sriram's input (relayed by Lalit): bring multiple AI initiatives (design automation, QA test-case generation, code writing) into a consolidated workshop to fast-track prototype development.
- Gauri recommended scheduling a 2–3 hour workshop only after proper research and a clear agenda, to make it worthwhile for engineers.

## Next steps
Start with the meetings pod via Varnika to align two workstreams (meetings + goals), build the centralized suggestion engine with a single master suggestion set displayed across pages, and use manual transcript upload as the initial POC while connector integrations are developed in parallel. Emphasis on deduplication via reconciliation and clear schema definition before expanding to other pods.
