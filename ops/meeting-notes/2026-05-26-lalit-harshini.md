---
date: 2026-05-26
meeting: Lalit / Harshini
type: 1:1
attendees: [Lalit Maharana, Harshini Vijay]
source: zoom
meeting_uuid: 421FD026-8322-418A-9DD2-2ABF718EDEFB
backfilled: 2026-07-07
---

# Lalit / Harshini — 2026-05-26

## Summary
Follow-up working session where Lalit walked Harshini through a ranked, clubbed version of the meetings requirements (grouped into areas and ranked by ticket count + priority for MVP), and they aligned on how to reflect it in the design explorations. Lalit organized the work into: (1) action-item/agenda-item enhancements (metadata: priority, due date, labels, notes, attachments, change log, plus AI coaching, full-page item view, min character limits, rollover consolidation); (2) meeting-panel UX (clear left/right differentiation, manual transcript upload, redirect to transcript, recommendations from signals, attachments, lock/unlock privileges, adding past meetings); (3) Zoom integration (auth + consent flow, fetch transcripts with speaker details); (4) AI story (past-meeting summaries, current-meeting prep summary, coaching, transcript → action items/agenda/recommendations); (5) cross-module reference — goals for MVP (P2: feedback, skills, recognition); plus notes enhancements, notifications, list-page UX (search, delete series, edge cases), and change trail.

## Key decisions
- MVP priority: Zoom integration and the AI story must come first and tie back to user actions; other items (metadata, notes enhancements, list-page UX) can proceed in parallel.
- Cross-module reference for MVP = goals only (feedback/skills/recognition are P2).
- Rollover: roll everything unactioned forward, piling onto the top/latest meeting, and let the user decide relevance — this also satisfies the "one consolidated view" request.
- Two design versions to share: one without action-item enhancements (closer to existing) and one with the new enhancements, to test integrating them without clutter. Narrow the 5 explorations to ~3.
- Goal editing can come from recommendations (pre-filled text + evidence), e.g., "we noticed an updated timeline / progress on this goal → update achievement %."
- Notes enhancements (rich text, full-canvas view, private/public toggle, character-limit fixes, Google Docs) deprioritized — not MVP-blocking / not transcript-related.
- Design split so that even the Zoom integration alone can ship; complete design will contain everything but be splittable.

## Action items
- [ ] Lalit — Share the ranked sheet on Slack (missed sharing it in the prior meeting).
- [ ] Lalit — Connect with Natalia to run through the ranked list; report back to Harshini.
- [ ] Lalit — Recheck current rollover behavior (what happens today when items are added to a past meeting).
- [ ] Lalit — Drill down further on the agenda/action-item metadata (how priorities are configured; due date from transcript vs. manual; how configurable labels should be), referencing standard task/to-do UI patterns.
- [ ] Harshini — Recreate existing designs and add the enhancements on top, producing both versions to share.

## Follow-ups / open questions
- Lock/unlock privileges: who can lock (likely manager/owner) or configurable via settings; if past meetings are locked, edits are blocked; if unlocked, add completed items + notes (not open items).
- Adding past meetings: allow adding another instance in the series and making instances editable (today restricted to the series; no rollover on ad-hoc additions).
- List-page edge cases (unhandled today): manager change stops one-on-ones; role change alters goals; deleting a meeting from calendar doesn't sync back to meetings.
- Whether the full action-item/agenda metadata set should be vetted by Natalia before incorporating into explorations.

## Discussion notes
- Two summary types: per-past-meeting summary (already shown under each meeting in new designs) and current-meeting prep summary (shown at top). Coaching is the not-yet-covered piece.
- Natalia's standing expectation: redesign the meetings UI; her key point is too many primary actions on screen — reduce cognitive load and prioritize the number-one action.
- Notifications: a couple of requests flagged wrong content; add missing notifications (low UX effort).
- Change trail across action items, agenda, notes is a new construct to introduce at some point.
- Group meetings and sharing with others are low priority (kept last).

## Next steps
- Lalit to sync with Natalia; Harshini to produce the two design versions once the ranked list is confirmed.
