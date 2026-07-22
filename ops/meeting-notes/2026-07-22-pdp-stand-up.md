---
date: 2026-07-22
meeting: PDP Stand Up
type: standup
attendees: [Rinku, Nitish Devadiga, Sriram CS, Nataliia Savenko, Harikrishnan S, Lalit Maharana, Pankaj Lohmor, Saurabh Pandey]
source: zoom
meeting_uuid: 344FE22C-FD95-49CC-A938-CC58BE04CA6F
---
# PDP Stand Up — 2026-07-22

## Summary
The team held a project update meeting focused on PDP (Personal Development Plan) feature development, centered on project urgency and technical implementation details. Sriram emphasized the critical timeline — about a month and a week remaining until the August 31st deadline — stressing that the team must prioritize delivering one working end-to-end solution rather than continuing technical discussions. Pankaj reported on ongoing discussions with JV regarding vector search vs. AI query approaches, while Nitish mentioned completing research on API compatibility metrics and LLM engine work for text recommendations. Saurabh shared progress on goal-configuration differentiation between PDP and normal goals, completing a spike on the technical implementation. The team discussed UI requirements including goals-list displays, skill-details panels, and permission models for PDP goals, with Nataliia presenting refined user stories and clarifying implementation approaches for goal-creation workflows and milestone structures.

## Key decisions
- Ship a basic end-to-end goal-creation workflow first, without AI course recommendations; enhance later. No further technical discussions or spikes should delay development given the Aug 31 deadline.
- PDP goals permission model: private visibility by default, with explicit permissions for managers to view/edit goals created through specific flows.
- Goal structure for course-derived goals uses a sub-goals/milestones approach (Saurabh's technical design), pending Nataliia's visual-design recreation and confirmation.

## Action items
- **Nitish:** Format the API compatibility/capacity metrics research into a document and share it.
- **Nitish:** Research further into the LLM engine for text recommendations.
- **Nitish:** Connect with the AI team to get the UI text-recommendation engine sorted in the LLM engine.
- **Nitish:** Provide sign-off on Saurabh's spike (differentiating PDP goal vs. normal goal) via a ticket comment.
- **Pankaj:** Call JV tonight to discuss vector search vs. AI query and finalize the approach.
- **Pankaj:** Continue the UI work and prepare the PR for the new screen.
- **Pankaj:** Add story points to in-progress tickets and start working on them.
- **Rinku:** Schedule the sprint planning call for Monday.
- **Saurabh:** Stay on a call with Nataliia after this meeting to confirm details before posting the spike document on the ticket.
- **Saurabh:** Add the UI-changes point to the goals form for PDP goals after the call with Nataliia.
- **Saurabh:** Start building the goals-list UI with mock data.
- **Saurabh:** Share the co-creation structure document for milestones/sub-goals with Nataliia.

## Follow-ups / open questions
- Final vector-search vs. AI-query approach pending tonight's Pankaj/JV call.
- LMS integration details and text-recommendation process needed before Saurabh can finalize goal payloads.

## Discussion notes
- Saurabh and Nataliia discussed permission logic for PDP goals and reviewed UI design for displaying development goals on the talent profile, including list view, card formatting, and action menu.
- Saurabh confirmed he can start implementation with mock data but needs LMS-integration and text-recommendation-process details to build correct goal payloads.
- The team discussed a UI feature letting users select specific steps as developmental goals, with Saurabh explaining the sub-goals/milestones technical approach; Nataliia asked for structure clarification and will recreate the visual design.
- Team also reviewed progress on API filters for PDP goals, the skill-details-panel redesign, and UI text recommendations.

## Next steps
- Pankaj to finalize the vector-search/AI-query approach after tonight's JV call and continue the new-screen PR.
- Saurabh and Nataliia to align on goal-form UI changes and milestone/sub-goal co-creation structure.
- Rinku to schedule Monday's sprint planning call.
