---
date: 2026-06-08
meeting: Lalit / Harshini
type: design
attendees: [Lalit Maharana, Harshini Vijay]
source: zoom
meeting_uuid: 70FB1560-C72B-46ED-B517-9433E1BD61DF
backfilled: 2026-07-07
---

# Lalit / Harshini — 2026-06-08

## Summary
Working session to align the meeting-transcript designs against Lalit's phase-1 story map and identify what is missing for the MVP (V1). Lalit walked through the story map covering work across three pods — Integration (Zoom connector backend), AI (structured summaries/action extraction, prompts, reconciliation, quality gates), and Meetings (most of the UI-heavy work). They went story by story through suggestion states, goal recommendation cards, action items, agenda topics, transcript handling, meeting-prep and recap cards, and consent flows. No summary asset was available; notes reconstructed from the meeting transcript.

## Key decisions
- Phase 1 scope: Zoom as the transcript source; goals as the only recommendation output type (no feedback/recognition deep flows yet, but the recommendation pattern/framework must be frozen so other sources/outputs can plug in later). Transcript inputs: automatic from Zoom, manual file upload, and copy-paste.
- Goal recommendation: use redirection to the goals page (agreed earlier); goal form should be pre-filled from AI suggestions (at least title/description from meeting insights).
- Zoom consent: needs a Betterworks-level consent banner (what transcript data is accessed and why) shown in the meeting space, plus active connection state, revoke, and re-authenticate options in settings. Add a settings/connections layer rather than dedicating the settings button entirely to Zoom (more connections coming).
- Suggestion state model: pending → confirmed (accepted) / dismissed / undismissed; actions are accept, dismiss, or edit-and-accept (edit-and-accept relevant for action items/agenda topics, not goals). No rollback/undo (not available today) — skip.
- Add a common reload button (per meeting prep and at overall level) that regenerates suggestions; show an indicator when updates are available. AI suggestions resurface when user edits agenda/action items; goal/recognition suggestions won't change much (transcript is fixed) but can resurface.
- Remove the AI source tag/subtitle once items are added to the list (both action items and agenda topics) — less clutter, per Natalia.
- Due date on action items: optional attribute (only action items, not agenda topics) — a due-date picker; editable; removable via chip; do not carry forward automatically; check effort for MVP. Add overdue handling.
- Roll-over: keep the roll-over count in the backend; show a "rolled over" chip + "open since <meeting date>" rather than "rolled 2/3 times." Remove which-transcript subtitle (low value).
- Goal card: show the actual goal title (shorthand) instead of "Create goal"; keep the create-goal CTA/redirection even after adding to action items; drop the redundant "create goal" intent text and remove the name shown at the bottom of AI suggestions. Goals added from card are not auto-checked (per Natalia) — user can check if they want.
- Transcript viewing: full transcript rendered for active/completed states; editing (remove & re-upload / re-paste) available for manual upload and copy-paste, not for Zoom-sourced transcripts. Copy + delete are standard actions. Add "Open in Zoom" for meetings with a Zoom recording once a transcript exists.
- AI briefs always exist even without a transcript (uses past meetings, notes, action items, agenda topics); empty state only on first-time use — nudge users to add transcripts/content. Two separate preps: manager-focused (coaching/feedback) and employee-focused (showcasing work), using last four meetings for both participants.
- AI-generated notes not in scope. Shared/private notes unchanged (rich text editor).

## Action items
- [ ] Harshini — Refine Zoom connect flow: add a consent/connections layer instead of a Zoom-only settings button; add consent banner content
- [ ] Harshini — Remove AI source tags/subtitles once items are added (action items + agenda topics)
- [ ] Harshini — Update goal card: show shorthand goal title, keep create-goal CTA after adding, remove redundant intent text and bottom name
- [ ] Harshini — Add due-date picker to action items (optional, editable, removable); design overdue/rolled-over chip + "open since" label
- [ ] Harshini — Add remove & re-upload / re-paste for manual transcripts; add copy + delete; add "Open in Zoom" option
- [ ] Harshini — Reduce button load (prefer icons where possible); re-check every component against the kitchen-sink library / existing product patterns
- [ ] Harshini — Note empty states (no suggestions = show nothing; first-time AI brief empty state)
- [ ] Lalit — Define the structure/content of the meeting-prep summary and recap card content (get back with card content)
- [ ] Lalit — Check with Varnika about rendering the goal form inline
- [ ] Both — Consider a consolidated/side-panel view of all open items rolling over across past meetings (parked as optional, with filter)

## Follow-ups / open questions
- Whether editing a manual action item/agenda topic affects the state of other AI suggestions (Harshini: once added, a manual edit just updates it).
- Whether to show a toast on dismiss (vs only on add/save) — Harshini to decide.
- How the AI layer parses/validates an arbitrarily pasted transcript before processing.
- Exact structure of the prep/recap summary (currently a bit random: blockers, follow-ups) — Lalit to think through; remove misleading category chips at the top for consistency with the right-side summary.

## Discussion notes
- Story map shows one spike per pod to figure out the contract; permitting/exclusion and data governance are technical; AI work is mostly prompts + backend (PII handling, summary/action/goal extraction, reconciliation, meeting prep, quality gates).
- Suggestions expire when the meeting transitions to completed; pending suggestion cards removed on that transition; past meetings don't show suggestions.
- Ignore the "24 hours before scheduled meeting" cron reference in the doc — not exactly current.
- Consolidated view for all open items likely belongs on the homepage rather than per one-on-one series.

## Next steps
- Harshini to make the minor changes noted and re-check components; Lalit to return with prep/recap card content and confirm the goal-form inline rendering with Varnika.
