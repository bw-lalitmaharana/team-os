---
date: 2026-05-28
meeting: Meetings Transcripts UX alignment
type: design
attendees: [Lalit Maharana, Harshini Vijay, Nataliya Kolb, Nellie LeMonier, Paul Agustin, Sarah Brose]
source: zoom
meeting_uuid: 6243FA9E-1A87-4335-868D-610C2D417E27
backfilled: 2026-07-07
---

# Meetings Transcripts UX alignment — 2026-05-28

## Summary
Design review of AI-powered meeting recommendations and transcripts within the Betterworks platform. Lalit presented the framework for generating recommendations from meeting transcripts (action items, agenda topics, goal-related suggestions), planning to show the top 3–5 recommendations while keeping separate lists for managers and employees. Harshini demonstrated four design versions showing different layouts for combining AI meeting prep with action items and recommendations. The team discussed whether to integrate AI recommendations into the right panel or keep them as a separate section. Key feedback: combine AI-suggested action items with regular action items into a single unified list; add a prominent AI meeting recap section; ensure consistent patterns across the platform. They also discussed manual transcript-addition capability and user-visibility of AI-recommended items — deciding suggested items are user-specific, with shared visibility only after items are explicitly added to action lists.

## Key decisions
- Show top 3–5 relevant recommendations to users.
- Combine AI-suggested action items and manually-added action items into a single unified list (no separation from the user's perspective); use visual icons to distinguish AI-recommended vs. manually-added.
- Add a meeting recap section under the AI header (context on what was discussed previously), shown alongside agenda topics and action items.
- Maintain separate recommendation lists for managers and employees.
- AI-suggested items are user-specific until converted to shared action items (shared visibility applies only after explicit adoption).
- Support manual transcript addition from various tools (not just Zoom), including past meetings.
- Two summary types: individual per-meeting summaries (stored in meeting history) and prep summaries (synthesizing prior meetings + action items to prepare for the current meeting).

## Discussion notes
- Harshini's four versions explored sidebars, carousels, and separate tabs for AI suggestions — balancing visibility vs. not competing with primary actions.
- Nellie suggested considering alternative placements (homepage, individual pods) and examining UX / implementation complexity before finalizing.
- Sarah suggested embedding meeting briefs in the right panel; Harshini proposed a tabbed structure showing both AI content and standard right-side panels consistently across modules.
- Nataliya requested ability to add manual transcripts from various tools and emphasized consistent design patterns; asked about accessing previous meeting summaries (found by navigating to individual past meetings in history).
- Integration with Zoom for transcript processing; goals as the initial cross-module interaction.

## Action items
- [ ] Harshini — Integrate feedback into updated design: combine AI recap, meeting prep, and action items (user + AI-suggested) into a single consistent right-panel layout; share updated links with Nataliya.
- [ ] Harshini — Ensure manual transcript addition (past meetings, multiple sources/tools) is in the next design iteration.
- [ ] Harshini — Prepare user flows and detailed interactions for key actions (give recognition, create goal) for Pod Squad validation.
- [ ] Harshini — Share all design versions/links for async feedback ahead of the next review.
- [ ] Lalit — Document and communicate PM decisions on visibility/sharing of AI-suggested and user-added action items (manager vs. employee, shared vs. private).
- [ ] Nataliya — Review updated design links and provide feedback, especially on combined action items and AI-summary visibility.
- [ ] Nataliya — Invite relevant team members to the upcoming IPP meeting on conversational intelligence for direct user feedback.
- [ ] Paul Agustin — Organize/schedule a Pod Squad (user validation) session for the updated meetings UI/UX (include Veronica and other stakeholders).
- [ ] Lalit, Paul Agustin, Nellie — Define and document the MVP approach for AI-suggested action visibility and the transition to shared visibility on adoption.
- [ ] Harshini & Nataliya — Schedule a follow-up to review finalized design before broader validation and sales-team prototype prep.
