---
date: 2026-07-27
meeting: PDP Stand Up
type: standup
attendees: [Pankaj Lohmor, Sriram CS, Sanchit Kanwar, Nitish Devadiga, Rinku, Nataliia Savenko, Saurabh Pandey, Harikrishnan S, Lalit Maharana]
source: zoom
meeting_uuid: 103D24A1-3796-49F4-9893-74EDE376613E
---
# PDP Stand Up — 2026-07-27

## Summary
The team held a standup meeting to discuss progress on their PDP (Personal Development Plan) feature implementation. Nitish reported working on AI-agent vector-embedding implementation for text recommendations, which Sagar had approved, with an estimated 3–5 days to completion. Pankaj shared progress on the skill-detail page and course-selection features, planning to complete local testing and move to code review by the next day. Saurabh discussed implementing schema changes for differentiating PDP goals from other types of goals (ticket 84673), though he had questions about whether to implement filter-admin-view changes given the current scope. The team discussed focusing on must-have deliverables for the summer release, with aspirational features being lower priority. After the main standup, Nataliia and Saurabh had a follow-up discussion about goal-implementation details, where Saurabh explained his approach to database schema changes and asked for clarification on whether to use the existing filter-view flow or implement new UI changes, ultimately deciding to proceed with backend changes while waiting for specific UI tickets to be created.

## Key decisions
- Proceed with the simple text-recommendation approach as the working MVP for the summer release; leave AI-based course recommendations as an open item with unknown estimates.
- Aspirational features are not mandatory and will be implemented based on capacity and lowest priority — must-have deliverables come first.
- Saurabh proceeds with backend/schema changes for PDP goal differentiation now; filter-admin-view/UI changes wait for dedicated UI tickets and design input rather than being bundled in now.

## Action items
- **Nataliia:** Update the ticket description for goal creation based on the discussion with Saurabh.
- **Nataliia:** Create tickets for UI and backend changes related to the filter view for PDP goals, based on Saurabh's input.
- **Nataliia:** Share the spreadsheet on the permission model with the team for alignment and agreement.
- **Nitish:** Complete implementation of text recommendations in the LLM and move it to GoToView within 3–5 days.
- **Pankaj:** Finish testing edge cases for the skill-detail page and course selection, move to code review by tomorrow, then start on goal creation.
- **Pankaj:** Provide refined estimates for text-based AI recommendation, course selection, and goal creation, considering dependencies on Saurabh's work.
- **Saurabh:** Continue implementing schema changes for the new goal attribute (ticket 84673) and the long-term design for the goals table, including indexing changes.
- **Saurabh:** Provide details to Nataliia on backend changes needed for filter-view implementation.
- **Saurabh:** Discuss with Varnika whether the filter-view revamp should move to a future sprint if it doesn't fit the current timeline.

## Follow-ups / open questions
- Saurabh was unsure whether ticket 84673 is specifically tied to Nataliia's feature or if other tickets are incoming for the same work.
- Whether to implement filter-admin modifications previously discussed by Sriram remains open — leaning toward deferring to focus on major deliverables for the POC by the weekend.
- Blocking issue on AI-section estimates for vector embeddings needs resolution (Nitish).

## Discussion notes
- Nitish clarified with Rinku that his LLM work is the actual implementation, not a spike.
- Rinku noted that estimates/effort for must-have features are needed for the summer release, focusing on three Apex items, and asked for more time before locking timelines; Pankaj agreed to give rough estimates now with room to adjust later. Sriram suggested identifying factors that could affect the estimates.
- In the post-standup follow-up, Saurabh explained he's adding a new table and skill-ID storage to differentiate PDP goals from normal goals, and recommended waiting for design input before major UI changes; Nataliia agreed to create both UI and backend tickets, and Saurabh offered to provide specifics for the backend piece.

## Next steps
- Nitish to finish vector-embedding text recommendations (3–5 days).
- Pankaj to move skill-detail/course-selection to code review by tomorrow, then start goal creation.
- Nataliia and Saurabh to finalize goal-creation ticket scope (backend now, UI pending new tickets).
