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

## Addendum — July 1–7, 2026 (added 2026-07-07)
Extended the backfill through today. **21 more notes** written (Jul 1–6). Skipped 11: **5** are Jul-7 meetings still upcoming / no assets yet (Capstone connect, Meetings AI Jira Realignment, Hackathon Refinement, Course recommendations, Webhooks — these get auto-captured by `zoom-signal-sweep` on its next runs); **2** numeric-ID wrong-instance (AI Release, Lalit/Cheryl); **3** no-assets (AI Platform Product Acceptance, AI hackathon brainstorm, and **Lalit/Nova — a participant objected to being transcribed, so intentionally not written**). Meeting notes are now backfilled **May 8 → Jul 6** (plus the 2 pre-existing May 4/7 notes).

## Going forward
This gap is now **routine-covered**: `zoom-signal-sweep` (weekdays ~20:35 IST) writes BOTH decisions→`signals/` AND full notes→`ops/meeting-notes/` (fixed 2026-07-07 — Zoom connector attached + prompt extended). No more manual backfills needed. The eventual local-model version is Aegis Epic 1 (`automation/aegis/PLAN.md`).

## Recovery pass — previously-skipped meetings (2026-07-07)
Retried the skips by resolving the CORRECT historical instance UUID via `search_meetings` (Zoom `recordings_list` returns nothing — Lalit isn't the recording owner; each recurring topic exposes a `schedule_expired` placeholder whose UUID equals the numeric id, plus the real `history` instance with an alphanumeric UUID — always use the latter).

**8 recovered:** 2026-05-11 Lalit / Nellie 1:1 · 2026-05-12 App Platform QA & Product Acceptance · 2026-05-13 AI Platform Product Acceptance · 2026-05-18 App Platform - Sprint Planning (transcript-only) · 2026-05-21 Meetings Transcript - Daily Catchup · 2026-05-28 Lalit / Sriram (transcript-only) · 2026-06-17 Story pointing session Cont. (greetings-only) · 2026-07-01 AI Platform Product Acceptance.

**Confirmed unrecoverable** (no assets even at the correct instance): Backlog Refinement 05-08, AI Release 05-13 & 07-01, Sprint Retro 05-15, Data&AI Sprint Planning 05-18, Monthly UX Review 05-19, AI Projects Debrief 05-19, Conversational AI PRD 05-20, Pankaj sync 05-21 (no recorded instance), Lalit/Cheryl 06-04, Lalit/Tejas 06-16, Learning Recommendations 06-16, Story-pointing ENG-82387 06-16, Cross Team Sync 06-17, Hackathon discussion 06-25, AI hackathon brainstorm 07-03. **Access-denied (host-only):** AI Engineering Lab 05-19, AI Accelerator Briefing 07-06. **Still upcoming:** Lalit/Cheryl 07-07 (auto-captured going forward). **Intentionally excluded:** Lalit / Nova (05-20 & 07-03) — a participant objected to being transcribed.
