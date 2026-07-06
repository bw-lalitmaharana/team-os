---
date: 2026-06-03
meeting: Lalit / Harshini
type: design
attendees: [Lalit Maharana, Harshini Vijay, Varnika Garg]
source: zoom
meeting_uuid: D14A68A2-DC41-4809-96D6-FE0A1A5A89EE
backfilled: 2026-07-07
---

# Lalit / Harshini — 2026-06-03

## Summary
Design review of the AI meeting-transcript feature ahead of a later sync with Natalia. Harshini walked through the design states (upcoming, active, completed-with-Zoom, completed-without-Zoom / manual transcript, past meeting) and addressed Natalia's comments. Varnika joined partway to give context and product feedback. Lalit also walked through his own states/objects document (meeting states, per-object behavior, brief model and recap model tabs) for review. No summary asset was available; notes reconstructed from the meeting transcript.

## Key decisions
- For upcoming meetings (before the meeting starts), do NOT show "upload file" / "paste transcript" options; instead show a "no transcript yet" message. Manual upload/paste appears only once the meeting is completed (as a fallback if the Zoom transcript hasn't arrived).
- MVP transcript source is Zoom only (most Betterworks customers are on Zoom). Architecture should allow adding Teams / Google Meet later; the Zoom-specific labels ("Connected to Zoom") should eventually become generic ("connected to meetings"). The design-tab labels (completed-Zoom / completed-no-Zoom) are Claude prototype tabs, not product UI.
- Only text transcripts supported for now (both paste into a text area and file upload). Audio files deferred — will wait for customer requests.
- Uploaded transcript files are kept as-is and opened in a text/Word viewer; no post-processing into a standard format (too much effort). Pasted transcripts kept in an open text area; AI layer validates and processes if valid.
- Coaching section to be removed from the design per Natalia's comment (reduces scope). Coaching should surface within the meeting-prep flow as a nudge (e.g., action item delayed 4 times → coach the employee), not as a separate block.
- Goal creation from a recommendation redirects to the goals page in MVP (with intent to componentize/render the goal form inline in future so it can be reused on homepage/landing). Recognition, being smaller, can render in the sidebar.
- Agenda topics / action items are frozen and AI will not touch them, regardless of source (user-added, admin-pushed, rolled over, or accepted from AI suggestions). Admin-pushed items must persist and not be overridden by AI.
- Reprocessing model: allow processing twice (before and after the meeting). Do not override user's manual changes; keep manual additions alongside AI-generated ones. Provide a manual regenerate/reload option rather than auto-regenerating.

## Action items
- [ ] Harshini — Hide upload/paste transcript on upcoming state; show "no transcript yet" message; move upload/paste to completed state
- [ ] Harshini — Update copy to "based on previous meetings" (not "based on the last transcript") since AI prep uses several past meetings
- [ ] Harshini — Add guidance text on manual paste: transcript should include timestamp, speaker names, and message so format matches Zoom
- [ ] Harshini — Make state labels generic (remove "Zoom" from design labels)
- [ ] Harshini — Consider moving coaching insights into meeting prep; add Lalit + Varnika to the Natalia call
- [ ] Lalit — Add Varnika to the later Natalia design call (Natalia specifically asked to keep Varnika involved)
- [ ] Lalit — Review meeting-states / per-object states doc + brief-model and recap-model tabs with Harshini/Varnika
- [ ] Varnika — Review Lalit's states slide/doc

## Follow-ups / open questions
- Whether to auto-refresh/reprocess the whole meeting page after a manual transcript is added, and how to avoid overriding in-meeting manual edits. Leaning toward: reload button re-runs generation; suggestions/recommendations stay as-is.
- Whether AI suggestions (agenda/action items) should update when a new transcript arrives, for the user to add to the next meeting.
- Admin AI assistance (e.g., admins wanting AI for pushed agenda topics) — future follow-up enhancement.
- Plan a pod squad / usability check with users unfamiliar with the meetings page (Varnika asked to be added).

## Discussion notes
- Four flows / states presented; header made more personable per Natalia (show whom the meeting is with + date/time). Right-rail panel unchanged; primary CTA changed to secondary to reduce attention competition.
- Recommended actions (create goal, give recognition, give feedback) are AI-recommended system actions based on past transcripts.
- Lalit's framing: prep track (suggestions help plan agenda/action items) vs post-meeting track (transcript → recap). Once a meeting is done, the transcript is primarily useful for a recap; new suggestions surface for the next meeting instance.
- Agenda topics can arrive four ways: user-added, admin-added, rolled over from previous meeting, or added from the AI-suggested bucket.
- Varnika raised the admin push-out feature (super admins push agenda topics/action items to all one-on-ones; roll over until marked complete) — these must be retained and not AI-overridden.

## Next steps
- Connect with Natalia later today (Lalit to add Varnika); bring up moving coaching into meeting prep.
- Harshini to make the Natalia-comment changes for today's meeting.
