---
date: 2026-05-25
meeting: Lalit / Harshini
type: 1:1
attendees: [Lalit Maharana, Harshini Vijay]
source: zoom
meeting_uuid: 7045E254-C4E4-4338-B58E-4F3D8C9E5D5E
backfilled: 2026-07-07
---

# Lalit / Harshini — 2026-05-25

## Summary
Working session where Lalit walked Harshini through his review of the ~42 customer ideas in Aha specific to meetings, and Harshini shared five design explorations for the meetings transcript UI. Lalit had bucketed the ideas (~20 UX changes, some new features, ~4 cross-module linkages, integration requests, one logic/validation change) and pre-marked which are relevant to the meetings-transcripts story. Themes: agenda/action-item interactions (rollover, consolidation, due dates, metadata), search across meetings, notes (character limits, min-length), attachments (Google Docs/files/evidence), sharing one-on-ones with skip-level/leadership, templates, group meetings, print fixes, adding past meetings, change history. Harshini presented five layout directions and both agreed to narrow down, fix a base layout with 2–3 versions, then review with Natalia.

## Key decisions
- Prioritization approach: focus the story on ideas solvable within the meetings page + transcripts — search, delete, action-item rollover, notes, attachments, and goals. Natalia's intent is to clean up the UI and address core gaps while framing the meetings-transcripts story.
- Design should not be constrained by the current layout — build with fresh eyes, though scoping decisions determine how much to change.
- Plan: pick ~3 of the 5 explorations, fix the base layout, produce 2–3 versions (e.g., tabbed vs. expand/collapse) not restricted by technical constraints, then share with Natalia.
- Coaching tips (for both employee and manager, before one-on-ones; synthesized from previous meetings, tied to agenda topics) to be included — a Natalia ask. Ideally for both AI-suggested and manually added agenda topics, at least once agenda is frozen.

## Action items
- [ ] Lalit — Share the Aha ideas link and a short note summarizing customer requests + what's relevant to the story, with detailed per-item requirements.
- [ ] Harshini — Continue design explorations; produce 2–3 base-layout versions.
- [ ] Lalit & Harshini — Set up a catch-up the next day to deep-dive.

## Follow-ups / open questions
- Whether AI suggestions should be auto-added to the list (user deletes if unwanted) vs. left for the user to add — concern about tedium if there are many suggestions. The recommendation list is a maintained, prioritized queue (top 3/5 shown; more come as items are dismissed), fed by multiple modules/sources over time — needs a scalable pattern.
- Reporting/API gaps for one-on-ones (unclear if existing reporting covers requests).
- How coaching tips should be surfaced in the UI (part of AI brief vs. sub-items under agenda topics).

## Discussion notes
Idea buckets from Aha (meetings, ~42 ideas, mostly customer-requested):
- Agenda/action items: preserve incomplete items on past meetings (rollover), consolidate into one list, add due dates and metadata, incomplete tasks on homepage, action-item to-do list in notifications.
- Search across meetings by name (3 requests).
- Notes: increase private-note character limit; enforce minimum characters (avoid "NA"); attachments/notes at action-item level.
- Attachments: link Google Docs, add files/evidence.
- Notifications: customize/contextualize the "make meetings effective" template.
- Delete one-on-one or series; fix print (Ctrl+P breaks); block editing of past meeting notes (contradicts a request to add/edit past meetings).
- Sharing one-on-ones with skip-level manager / leadership (transcript makes this sensitive); employee-created templates; group meetings with more participants; direct Zoom integration; change history/trail.
- Goals in one-on-ones: show milestones; full create/edit and OKR updates from the detail page; one-on-one summary in conversation space.

Harshini's five explorations (built on Austin's base): (1) tabbed approach with AI brief + agenda/action items + combined notes tab + past meetings with AI-suggestions/About tabs on the right; (2) AI-recommended actions below the brief (felt hidden); (3) AI-recommended actions on the right as a carousel/card layout; (4) inline tabs (overview, transcript, AI recommendations) for the current meeting; plus variations. She de-duplicated suggested agenda topics (was appearing in both brief and AI suggestions) into one place.

## Next steps
- Lalit to connect with Natalia; both to deep-dive in a follow-up catch-up the next day.
