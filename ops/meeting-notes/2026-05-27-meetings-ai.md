---
date: 2026-05-27
meeting: Meetings AI
type: design
attendees: [Lalit Maharana, Harshini Vijay, Sarah Brose]
source: zoom
meeting_uuid: 97A8731D-545F-4431-B6BE-6336ED87FAA3
backfilled: 2026-07-07
---

# Meetings AI — 2026-05-27

## Summary
Design review of the meetings module focusing on layout structure and the placement of AI-recommended actions, ahead of a stakeholder review with Natalia. Harshini presented four design versions; the team aligned on Version 1 (clear left/right separation — actions on the left, reference content on the right) as the strongest candidate. The placement and prominence of AI-recommended actions remained the key open question, with several patterns to take to Natalia and to validate via user testing before finalizing detailed flows.

## Key decisions
- Align on Version 1 (clear action/reference separation) as the strongest layout candidate.
- Move the "new meeting" button to the global header for consistency and to reduce competition with main screen content.
- Keep AI-recommended-actions placement as a distinct open question, presenting three potential patterns to Natalia for input.
- Hold detailed feature additions until Natalia approves the base layout (avoid unproductive rework).
- Plan a PodSquad session with CS/SE for early user-testing feedback.
- Rename "AI suggested actions" to "recommendations"/"suggestions" to reduce confusion with "action items."

## Action items
- [ ] Lalit — Schedule a review meeting with Natalia (next day) to present Version 1 and discuss open questions.
- [ ] Harshini — Review detailed feature requirements in the doc and compile questions before the Natalia review.
- [ ] Harshini — Contact Paul, Austin, or Varnika to set up a PodSquad session for meetings-design user feedback.
- [ ] Harshini — Change "AI suggested actions" terminology to "recommendations"/"suggestions."

## Follow-ups / open questions
- Placement/prominence of AI-recommended actions: within the meeting-prep tab, a separate tab, embedded in the About section, or on the right side panel — three potential patterns for Natalia's input.
- AI recommendations don't integrate cleanly with meeting prep (they're derived post-meeting from past transcripts, not pre-meeting) — Harshini suggested they're more relevant in specific modules (feedback, goals) than on the meetings page.
- Whether to show recommendations both in a dedicated section and inline within goal items (concern about overwhelming users).
- Revisiting an overview/landing section for the right panel as a future enhancement with AI additions (Sarah's proposal).

## Discussion notes
Four versions presented by Harshini:
- Version 1 (preferred): clear left/right distinction — actions on left (AI suggestions in a collapsed accordion, agenda topics, action items, notes with shared/private tabs); reference content on right (AI meeting prep, About section).
- Version 2: AI brief integrated within the upcoming-meeting section; agenda topics in the brief; AI-recommended actions in a carousel at top.
- Version 3: AI-recommended actions grouped on the right, collapsed by default to stay subtle.
- Version 4: inline tab structure (overview + AI recommendations tabs) for the upcoming meeting.
- Two archived versions deemed too distracting or too hidden.

Alignment: Lalit liked the clear left/right split and consolidating all actions in one place (esp. agenda-topic suggestions in the main panel). Sarah favored Version 1 as most geared to meeting prep, with similar interaction patterns for topics and action items. Harshini noted consistency with other modules (feedback) via AI summary + About tabs on the right.

Terminology/placement debate: Sarah flagged confusion between "AI suggested actions" and "action items," and questioned whether the meetings page (vs. homepage or in-app notifications) is the right home. Lalit clarified these are recommendations derived from transcripts (feedback, recognition, goal updates) filtered to meeting context — not transcript-only — and argued notifications are too passive; suggested the right side panel as a common platform pattern.

Takeaway: Version 1 (clear action/reference separation) is the strongest candidate, but AI-recommended-actions placement/prominence remains open pending Natalia's input and user testing before finalizing detailed flows.

## Next steps
- Present Version 1 and open questions to Natalia; set up a PodSquad user-testing session.
