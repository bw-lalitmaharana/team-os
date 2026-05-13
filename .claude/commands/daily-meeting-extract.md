---
name: daily-meeting-extract
description: Scheduled daily run at 8 PM IST via CCR remote agent (trig_01RjvZpCXJPe1gVu1mBMgvca). Extracts tasks/knowledge from Zoom meetings, checks tomorrow's Google Calendar, updates Slack Canvas action tracker, sends structured digest to Lalit's self-DM (D0B0W25MMV2).
---

# Daily Meeting Extract — System Reference

This command runs automatically every night at 8 PM IST via a remote Claude Code routine.
Do NOT run this manually unless testing — use `/meeting-debrief` for on-demand meeting processing.

## What the routine does

### Step 0 — Dedup check
Reads D0B0W25MMV2 for a message containing "Daily Meeting Extract" + today's date.
If found: exits silently. Prevents double-sends on manual trigger + scheduled run same day.

### Step 1 — Bootstrap Slack Canvas
Searches D0B0W25MMV2 for a message containing "CANVAS_ID:".
- If found: reads the canvas for current action status.
- If not found: creates "Lalit's Open Actions — Team OS" canvas, sends CANVAS_ID marker.

### Step 2 — Check completions
Reads D0B0W25MMV2 for messages starting with "done:" in past 48h.
Matches against canvas actions and marks them complete.

### Step 3 — Past meetings (48h window, Zoom only)
search_meetings: 48h ago → now, meeting_category=history, has_summary OR has_transcript.
Skips meetings already reflected in canvas.
48h window (not 24h) to catch late-generating Zoom AI summaries.

### Step 4 — Extract (token-efficient)
TOKEN RULE: summary_markdown first (much shorter). Full transcript only if no summary exists, capped at 8000 words. Never both.
Extracts: tasks, knowledge, decisions, new contacts, open questions.

### Step 5 — Tomorrow's calendar (Google Calendar only)
Lists tomorrow's events IST. Applies importance labels. Generates prep notes.
Zoom = transcripts only. Google Calendar = upcoming meetings only.

### Step 6 — Update canvas
Rewrites canvas with completed/new/carried-over actions.

### Step 7 — Send digest
Structured format to D0B0W25MMV2:
- TOMORROW (importance-labelled with prep)
- YOUR OPEN ACTIONS (from canvas, deadline-sorted, overdue flagged)
- WAITING ON OTHERS
- TODAY'S MEETINGS (one-line per meeting)
- INSIGHTS & DECISIONS
- NEEDS MANUAL DEBRIEF

## Meeting importance labels
🔴 Critical — 1:1 with Cheryl or Sriram; exec reviews; go/no-go; major demos
🟠 High — 1:1 with Nellie; sprint planning; architecture decisions; cross-functional stakeholder sessions
🟡 Medium — standups; working sessions; design reviews; PM syncs
🟢 Low — optional; FYI; rituals Lalit doesn't own

## How to mark actions complete
Reply in the self-DM thread: `done: [action text]`
The next run picks it up and marks it ✅ in the canvas.

## Connectors used
- Zoom-for-Claude — past meeting summaries/transcripts
- Slack — canvas read/write, digest delivery to D0B0W25MMV2
- Google-Calendar — tomorrow's meetings only

## Routine ID
trig_01RjvZpCXJPe1gVu1mBMgvca
Manage at: https://claude.ai/code/routines/trig_01RjvZpCXJPe1gVu1mBMgvca
