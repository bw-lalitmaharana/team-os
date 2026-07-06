---
date: 2026-05-21
meeting: Sync on Meetings Transcript
type: design
attendees: [Lalit Maharana, Sarah Brose, Harshini Vijay]
source: zoom
meeting_uuid: E46676A2-7194-4F72-8B11-248A8939EFCA
backfilled: 2026-07-07
---

# Sync on Meetings Transcript — 2026-05-21

## Summary
Onboarding/alignment design session with new designer Harshini, plus Sarah and Lalit. Lalit explained the meeting-transcripts feature: for one-on-ones between employees and managers, transcripts are fetched from each meeting instance, and from them the system derives (1) agenda topics discussed, (2) action items for employee/manager, and (3) a summary of previous transcripts to prep for the next one-on-one. Beyond that, the system extracts work signals (feedback, recognition, goal progress) into one unified signal list surfaced on the meetings page and, eventually, across other pages (goals, feedback, recognition) and other sources (Slack, Jira, Confluence). The team discussed layout philosophy (left = depth/contextual actions, right = breadth/peripheral context like goals, feedback received, recognition), the distinction between "action item" vs. AI "suggestion," rolling incomplete items forward, freezing past meetings, and design process using Claude.

Sarah relayed Natalia's direction: design 2–3 creative iterations at once, not constrained by the design system or technical requirements, while reducing cognitive load (don't spread actionable items all over the page).

## Key decisions
- Layout principle: left side = depth (contextualized actions/info); right side = breadth (peripheral systems touching the meeting — goals, feedback, recognition).
- Past meetings to be frozen (not editable); incomplete actions/agenda items from previous meetings roll forward to the latest meeting. (Engineering confirmed it's easier to iterate between the last two meetings than search across all.)
- MVP scope: meetings page only, covering summary, agenda topics, action items, and one module recommendation (goals, since goals are already shown on the meetings page). Phase 2: more sources (Slack, Jira, Confluence) and more modules (feedback, recognition) in respective pages.
- Goals recommendations cover both create and update (including progress); "goals" is treated to include milestones (same schema).
- Design flexibility: things can move around (e.g., anchor the "new meeting" button to a side, not center; notes section rework for private/shared/AI notes). The manual add-action-item/agenda-topic interaction likely stays as-is.
- Design tool: continue using Claude for design during this testing/experimental phase; no requirement for pixel-perfect Figma from engineering — "whatever works."

## Action items
- [ ] Harshini — Create a new Claude file, link Austin's existing file, and recreate it to iterate on top without disturbing Austin's file.
- [ ] Austin — Label/archive his design versions so they're easier to scan.
- [ ] Harshini — Explore design directions for the open problem area (AI-recommended actions + right panel).
- [ ] Lalit — Bring designs to Natalia (set up a call) once Harshini has something; Natalia wants visibility (she was miffed to be excluded from this call).

## Follow-ups / open questions
- Placement of AI-recommended actions: dedicated space (Austin/Lalit's earlier design) vs. inline per action item — Natalia felt a dedicated space competes for attention. Undecided.
- Whether to nudge users that rolled-over action items appear completed (dismiss if not relevant), since items keep piling onto the latest meeting.
- Milestones aren't currently shown in the right panel; updating goal progress vs. a contributing milestone needs engineering/Austin input on what to open.
- Whether to redirect to the goals page or open the goal form inline (engineering feasibility TBD).
- Whether to show the transcript inline in the app or redirect; how to render coaching tips.
- QA / dev-handoff expectations for Claude-based designs (no accurate design-system representation yet) — to be clarified with the team once near-final.

## Discussion notes
- Meetings are one-on-ones (two people); group meetings not currently supported.
- When a goal is saved or feedback given elsewhere, a callback to the recommendation engine pulls the now-irrelevant suggestion off the list.
- Goal/recognition/feedback forms will be pre-filled from transcript content (e.g., pre-filled recognition text/hashtags) with evidence links back to the source transcript, to reduce friction to a one-click action.
- Timeline pressure: front-end development targeted to start at the beginning of the next sprint (~end of May); backend already in refinement. Sarah noted the design has been "spinning its wheels" for a couple of iterations.
- Harshini added to the daily catch-ups; team currently in refinement.

## Next steps
- Harshini to produce 2–3 design directions and share with Sarah, Lalit, and Natalia.
