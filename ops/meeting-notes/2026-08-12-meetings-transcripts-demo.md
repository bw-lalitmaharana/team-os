---
date: 2026-08-12
meeting: Meetings transcripts Demo
type: review
attendees: [Hiten Khuman, Riya Malik, Mary Makris, Nellie LeMonier, Harshini Vijay, Lalit Maharana, Tejas S, Sagar Bhat]
source: zoom
meeting_uuid: A4513217-6541-49B0-B050-E0641F4738FD
---
# Meetings transcripts Demo — 2026-08-12

## Summary
The team met to demo the new AI-powered meeting-intelligence feature, which uses Zoom transcripts to generate meeting recaps, prep suggestions, and recommendations for one-on-one meetings. Nellie set context on the feature's components (admin enablement, meeting-prep assistance, past-meeting recaps) and introduced Mary (marketing, documentation/enablement support) to the dev team (Hiten, Harshini). Hiten demonstrated the admin setup and Zoom integration, and the process for uploading transcripts manually or automatically via Zoom. Lalit then demoed a prototype showing how the AI processes transcript data into action items, agenda topics, and goal recommendations, including the various AI-processing states and empty states for insufficient data. Mary asked about the data sources behind the prep feature and how low-data scenarios are handled; Lalit confirmed prep is based on the last four calls and that empty-state handling is implemented. The team also discussed the insights-refresh feature (triggered by changes to notes, action items, agenda topics, or transcripts), currently live at the meeting level only. The session closed with next steps on enablement documentation and sharing materials.

## Key decisions
- AI meeting prep is based on the last four calls; empty-state handling covers insufficient-data scenarios.
- Refresh button is confirmed as meeting-level only for now, with a follow-up to discuss adding it elsewhere (see open questions).

## Action items
- **Lalit:** Update the Confluence enablement documentation with the latest Phase One information by tomorrow (2026-08-13) and notify Mary once done.
- **Lalit:** Share the recording of the demo with attendees once available.
- **Lalit:** Share the Sigma link with prototypes with attendees.
- **Team:** Discuss and potentially add the AI-processing state and refresh-button functionality at the prep level, per Tejas's suggestion.

## Follow-ups / open questions
- Whether the insights-refresh button should also appear at the prep level (currently meeting-level only) — raised by Tejas, not yet decided.

## Discussion notes
- Feature has three main components: meeting recaps, prep recommendations for upcoming meetings, and insights linked to user attributes like goals.
- Foundation established via Zoom integration for transcript processing; users can also upload manual transcripts or paste text, including for past meetings at any time.
- Goal-creation flow: when a goal is created from a recommendation, users are redirected to a goals page with pre-filled data; updates include suggested changes from the transcript with checkmarked action items. Some goal-related features are still in progress and currently redirect to separate screens.
- Plans exist to eventually expand recommendations to feedback, recognition, and skills, beyond the current action-item/agenda/goal scope.

## Next steps
- Lalit to update and share enablement documentation, demo recording, and Sigma prototype link.
- Team to revisit refresh-button placement (meeting-level vs. prep-level) per Tejas's suggestion.
