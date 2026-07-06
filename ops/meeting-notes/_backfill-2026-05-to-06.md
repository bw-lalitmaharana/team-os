# Meeting-notes backfill — May 8 → Jun 30, 2026

One-time manual backfill run **2026-07-07**, closing the gap where meeting notes were never written to git (the `daily-meeting-extract` routine wrote to Slack canvas/self-DM, not the repo). Notes were built from Zoom assets (`get_meeting_assets`: AI summary → my_notes → transcript, in that order), faithful to source — no content invented. Duplicate captures of the same meeting were merged into one note.

## Coverage
- **55 notes written** across 29 meeting-days (May 8 → Jun 30). Plus the 2 pre-existing notes (May 4, May 7).
- Scope = substantive meetings. **43 recurring/social meetings were intentionally not attempted**: daily standups/scrums, "Retro and Demo (Optional)", All-Hands, water-cooler/TRIVIA/chess (Pawns Gambit), Fireside Chat, and the "AI in PM Training" series.
- Where a meeting had no AI summary, the note was reconstructed from the transcript / my_notes. Attendees were derived from transcript speakers when the API returned no participants list.

## Skipped (attempted but no note written) — 23 meetings

| Date | Meeting | Reason |
|---|---|---|
| 05-08 | App Platform Backlog Refinement | numeric ID → wrong instance, no assets |
| 05-11 | Lalit / Nellie 1:1 | numeric ID → resolved to Jul-6 instance |
| 05-12 | App Platform QA & Product Acceptance | numeric ID → Jul-1 instance |
| 05-13 | AI Release | numeric ID → Jun-24 instance, no assets |
| 05-13 | AI Platform Product Acceptance | numeric ID → Jul-1, no summary |
| 05-15 | App Platform - Sprint Retro | 403 permission denied |
| 05-18 | Data Platform & AI Sprint Planning | numeric ID → Jun-29 instance |
| 05-18 | App Platform - Sprint Planning | numeric ID → Jun-29 instance |
| 05-19 | Monthly UX Review | no recording/notes/summary |
| 05-19 | AI Projects Debrief | correct instance had no assets |
| 05-19 | AI Engineering Lab | numeric ID → Jun-30 instance |
| 05-20 | Lalit / Nova | numeric ID → Jul-3 instance |
| 05-20 | Conversational AI PRD discussion | no assets on either uuid |
| 05-21 | Pankaj <> Lalit Weekly Sync | numeric ID → Jul-2 instance |
| 05-21 | Meetings Transcript - Daily Catchup | numeric ID → Jun-8 instance |
| 05-28 | Lalit / Sriram | 403 permission denied |
| 06-04 | Lalit / Cheryl | empty my_notes, no summary/transcript |
| 06-16 | Lalit / Tejas | marked upcoming, no assets |
| 06-16 | Learning Recommendations | "insufficient transcript", no notes |
| 06-16 | Story pointing (ENG-82387) | no summary, no my_notes |
| 06-17 | Story pointing session Cont. | trivial 4-line transcript, no content |
| 06-17 | Cross Team Sync | recording only, permission denied |
| 06-25 | Hackathon discussion | empty my_notes, no summary/transcript |

**Skip reasons:** ~11 are the numeric-ID recurring-resolution issue (below); 2 are 403-permission; ~10 had genuinely no retrievable assets.

## Known caveats
1. **Numeric meeting IDs resolve to the *latest* instance of a recurring meeting**, not the historical occurrence — so recurring meetings whose only identifier was numeric returned July/June content and were skipped rather than misdated. Recovering them needs the exact May-instance UUIDs (from the calendar event or recording list).
2. **`2026-06-16-project-plan-meeting-transcript.md`** merges 11 captures that share one meeting number but whose transcripts reference different dates — likely distinct daily recurrences folded into one note. All 11 uuids are listed in its front-matter; split per-day in a later pass if per-recurrence granularity is needed.
3. A few notes are transcript-only (no AI summary existed); flagged in-file where partial.

## Going forward
No routine yet writes full notes to `ops/meeting-notes/`. Decisions ARE auto-captured to `signals/` by the `zoom-signal-sweep` routine (weekdays 20:30 IST). Making this backfill self-sustaining = extend `zoom-signal-sweep` to also emit a note here, or build Aegis Epic 1 ("meeting-transcript fetch → git"). See `automation/aegis/PLAN.md`.
