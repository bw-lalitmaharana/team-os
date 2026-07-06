---
date: 2026-06-11
meeting: Meetings AI
type: design
attendees: [Lalit Maharana, Harshini Vijay, Varnika Garg, Anuj]
source: zoom
meeting_uuid: 63FE0187-3DBD-4164-80D1-1E00621BF377
backfilled: 2026-07-07
---

# Meetings AI — 2026-06-11

## Summary
Design review for the upcoming and past meeting pages with integrated AI features — Zoom transcription, AI-generated suggestions for goals/action items/agenda topics, and user consent flows — plus a technical-feasibility discussion around real-time updates, async processing, and cross-module integration (goals, recognition, feedback). Harshini presented the redesigned meeting interface; Varnika raised concerns around due dates, admin-locked items, and consent; Lalit clarified technical constraints and requirements. (Notes from Lalit's my_notes; no AI summary asset.)

## Key decisions
- Due date feature removed from MVP due to complexity integrating with admin config.
- Recognition and feedback kept in designs for visibility but marked out-of-scope for phase one; implementation focuses on the goals flow.
- AI-generated notes feature deferred to a later phase.
- "Create Goal" → redirect to goals page and pre-fill the form with AI-extracted attributes (name, description, hierarchy, etc.). "Update Goal" suggestions → open the goal form and show AI suggestions as hints without auto-populating; user updates manually.
- After goal creation, automatically add a goal reference to the action-items list (requires page reload). Same pattern for recognition/feedback (post-MVP).
- Real-time updates not feasible; page reload required after goal creation to refresh recommendations queue and action items. Show a prominent "Updates available, reload to view" indicator when AI processing completes.
- Transcript processing is async (can take 5–10 minutes): show status indicators ("Add transcript to get AI insights" → "Insight generation in progress" → "Updates available"), same pattern for file upload (similar to existing CSV upload in goals).
- Zoom integration requires two-layer consent: a Betterworks disclaimer (data usage) before the Zoom OAuth redirect, even with admin-level Zoom authentication.
- UI/UX: consistent checkbox styling (not circular tick marks) across agenda topics and action items; toast notifications for add/dismiss; global Zoom configuration via a settings icon on the homepage (individual meeting pages don't need separate settings). Expand/collapse retained for the upcoming-meetings panel.
- Event-based callbacks needed when goals are saved to update meeting-page data.

## Action items
- [ ] Harshini — Remove due-date feature from MVP designs; mark out-of-scope in tickets
- [ ] Harshini — Keep recognition/feedback in designs for visibility but focus detailed flows only on goals
- [ ] Harshini — Add "Updates available, reload" indicator design for when AI processing completes
- [ ] Harshini — Correct checkbox styling consistency in Figma (remove circular tick marks)
- [ ] Harshini — Design Betterworks consent UI showing data-usage info before Zoom OAuth redirect
- [ ] Harshini — Finalize designs and share with dev team after incorporating goals flow and status indicators
- [ ] Lalit — Verify whether dismiss action needs a confirmation modal or just a toast
- [ ] Lalit — Share the design file with the dev team once Harshini confirms updates are complete
- [ ] Varnika / Dev team — Create a POC ticket for event-based callback when goals are saved to update the meeting recommendations queue
- [ ] Varnika / Anuj — Determine feasibility of pre-filling goal-form attributes vs showing suggestions as hints within the MVP timeline

## Follow-ups / open questions
- Whether the dismiss action needs a confirmation modal or just a toast notification.
- Feasibility of pre-filling goal-form attributes vs hints within MVP timeline.
- Varnika: due-date feature conflicting with admin-pushed items (admin-controlled due dates); need consistency for how admin-locked items are handled.

## Discussion notes
- Harshini's redesign: header shows meeting details, date/time, connected Zoom status with duration; AI suggestions split into standard suggestions (add to list) and system actions (create goal, give recognition); hover interactions (pencil, delete) for agenda/action items; post-meeting AI can identify completed topics and suggest marking them done; manual transcript paste/upload with async processing.
- Varnika: consent requirements for AI/Zoom integration are more critical than existing integrations.
- Lalit: transcript user pastes/uploads → can immediately view it; processing runs in background with status indicators.

## Takeaway
The meeting page supports AI-driven workflows where transcript analysis generates suggestions that redirect users to appropriate forms (goals, recognition, feedback) with pre-filled or hinted data. Due to real-time-update constraints, the experience relies on page reloads after cross-module actions, with clear status indicators. MVP scope is goals integration only; due dates and other features deferred to align with admin config work. Zoom integration requires two-layer consent (Betterworks disclaimer + Zoom OAuth).

## Next steps
- Harshini to finalize goals flow + status indicators and share with dev; POC ticket for the goal-save callback; confirm pre-fill vs hints feasibility for MVP.
