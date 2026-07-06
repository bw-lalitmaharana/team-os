---
date: 2026-06-02
meeting: Hemant / Sagar
type: design
attendees: [Lalit Maharana, Sagar Bhat, Hemant Kumar]
source: zoom
meeting_uuid: 12DE437F-5750-4BBE-BD5A-3EA81CDC43C0
backfilled: 2026-07-07
---

# Hemant / Sagar — 2026-06-02

## Summary
Follow-up design / data-flow walkthrough (Lalit, Sagar, Hemant) clarifying the meeting-transcript feature's UI behavior and which data feeds which section over time. Sagar and Hemant worked through a concrete June-2 / June-9 / May-25 timeline to pin down: what the "AI brief / prep" shows before a transcript is processed, what the per-meeting "summary / key points" shows after processing, and how rolled-over and AI-suggested items behave. The bulk of the discussion separated what is transcript/AI-driven vs. pure front-end/UI behavior.

## Key decisions
- Two distinct constructs:
  - AI brief / prep (for the upcoming meeting): synthesized from the last ~4 meetings and their metadata (previous agenda items, action items, transcripts). Shown before the current meeting's transcript is processed. Does NOT include the just-finished meeting's data until that transcript is processed.
  - Per-meeting summary / key points (recap): generated after the transcript is processed; contains data for that single meeting only (key points, decisions, action/agenda data points).
- Flow: until a meeting's transcript is processed, the UI keeps showing the previous brief/data; once processed, the brief is replaced with the latest, and the meeting's own summary is stored as data points.
- Recommendation cards (goals, recognition, action items) have their own ordering; agenda topics ordered by timestamp (no ranking needed).
- Applying a suggestion (e.g., goal) opens a pre-filled form via the CTA; suggestion metadata carries name, user, achievement/description (key results and other details are added by the user, not part of the suggestion). This is UI-driven.
- Rolled-over items = open items from the previous meeting forwarded to the current one (UI behavior, not transcript-driven). "AI-edited" flag marks AI-suggested items the user has edited.
- MVP scope: only "goal" as the create construct (Development and other categories are future, not in MVP).
- Deferred for MVP: the "not yet in agenda" cross-reference of missing items from prior summaries — instead, missing agenda topics will surface via AI suggestions (suggested topics are equivalent to "not yet written to agenda"), avoiding a brittle keyword/taxonomy-matching approach.

## Discussion notes
- Agenda topics: AI derives them from the previous ~3 summaries, then compares against existing agenda topics (including rolled-over) and surfaces missing ones as suggestions — passing the AI the existing agenda topics and completion state as context.
- AI brief is similar to the existing AI one-on-one/pod summary but with a narrower scope and more point reductions.
- Sagar's clarifying questions were largely to separate transcript/AI-engine responsibilities from front-end responsibilities; agreed the front-end/meetings side owns the form pre-fill and item rendering.

## Action items
- [ ] Sagar/Hemant — Implement per-meeting summary generation (key-point/data-point format) triggered on transcript processing, scoped to the single meeting.
- [ ] Sagar/Hemant — Generate the AI brief/prep from the last ~4 meetings and their metadata; keep showing prior data until the new transcript is processed.
- [ ] Lalit (product/UI) — Own suggestion metadata schema (name, user, achievement/description) and the pre-filled form behavior; roll-over and AI-edited flagging are UI-driven.
- [ ] Team — Keep the "not yet in agenda" missing-item cross-reference out of the MVP; surface missing topics via AI suggestions instead.
