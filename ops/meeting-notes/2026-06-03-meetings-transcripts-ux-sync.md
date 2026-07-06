---
date: 2026-06-03
meeting: Meetings Transcripts - UX Sync
type: design
attendees: [Lalit Maharana, Harshini Vijay, Nataliya, Nellie, Sarah, Varnika Garg]
source: zoom
meeting_uuid: 14490D9B-F708-418B-8881-F7A5A81EEDE0
backfilled: 2026-07-07
---

# Meetings Transcripts - UX Sync — 2026-06-03

## Summary
The team reviewed updated designs for the AI-powered meeting-preparation feature. Harshini presented four user flows covering the meeting lifecycle from upcoming to past meetings. Nataliya gave feedback on making the header more personable (showing specific meeting context rather than generic text) and suggested combining AI-suggested actions with recommended actions into a single unified list with consistent add-and-complete functionality. The team discussed how recommended actions should remain visible in the action-items list even after being performed, allowing users to track and follow up. They reviewed transcript and notes functionality — including manual transcript add for past meetings and generating AI insights, with plans to support both copy-paste and file upload. The discussion concluded with agreement to prioritize must-have features for the summer release while keeping future team-meeting capabilities in mind for a potential winter add-on.

## Key decisions
- Header should explicitly state meeting context (e.g., "Your one-on-one with Darren Knight") rather than just avatars; make it more personable.
- Remove coaching insights (per Nataliya).
- "Create goal" redirects to the goals page for consistency in MVP; may change later as recommendations expand across modules.
- Combine AI-suggested and recommended actions under a single interface with appropriate add buttons; treat "give recognition" like an AI-suggested action item with an add button (rather than a separate block). Give recognition opens within the current page; goals opens in a separate tab.
- Recommended/suggested actions added to the action-item list only when the user clicks and performs the action (not on dismiss); completed items should stay visible/tracked.
- Goal suggestions remain visible until the user manually dismisses them or completes the goal creation, at which point a callback to the recommendations framework removes the suggestion.
- Prioritize one-on-one meetings for the summer release; team meetings targeted for a potential winter add-on. Current development must not block future team-level meeting capabilities.

## Action items
- [ ] Harshini — Update meeting header to state the meeting context explicitly; review need for avatars
- [ ] Harshini — Add option to delete and replace a manually added transcript; include a "copy" button for transcript text
- [ ] Harshini & Lalit — Define the exact set of actions (create goal, give recognition, add skill) available in AI-suggested actions and detail user flows for each
- [ ] Harshini & Lalit — Finalize UX for handling AI-suggested actions (combine AI-suggested + recommended, add/create button behavior, auto-add to action items with checked/unchecked states)
- [ ] Harshini & Varnika — Ensure the "add past meetings" feature (including adding past transcripts) is in production within the next two weeks
- [ ] Harshini & Lalit — Review and prioritize must-have vs nice-to-have features for the summer release and document them
- [ ] Harshini & Lalit — Ensure current design/architecture does not block future team-meeting support
- [ ] Harshini & Lalit — Investigate/design ability for users to modify AI-generated recaps/summaries; ensure a reload/regenerate button for recaps and suggestions when user data changes
- [ ] Harshini & Lalit — Ensure manual meeting creation offers upload/paste transcript during the creation flow
- [ ] Harshini & Lalit — For future releases, research extension to team meetings in parallel with the one-on-one implementation

## Follow-ups / open questions
- How the system handles modified goal titles when a suggestion is created (Sarah's question — to consider during implementation).
- Whether users should be able to modify AI-synthesized summaries (not fully resolved).
- File upload vs copy-paste behavior (Nataliya raised but not completed in transcript).
- New users without existing transcripts: feature not applicable; nudge to manually enter transcripts for past meetings.

## Discussion notes
- AI could use both transcripts and user-added notes to generate recaps and action items; Lalit confirmed this is being considered along with other datasets like goals and feedback.
- Nataliya proposed adding recommended/suggested topics to the action-item list with a checkbox for consistency, so users don't lose track of items they click through.
- Transcript processing demo: paste or upload → generate AI insights. Nataliya requested a copy button (to share transcripts with other agents) and a delete option.
- Debate on the "3 agenda / 2 actions" tags Claude added — questioned their value-add.
- Manual transcript addition can be integrated into the meeting-add flow (pick a date, optionally add a transcript).

## Next steps
- Focus on getting one version out first; research team-meeting possibilities in parallel; consider team meetings for a winter add-on release.
