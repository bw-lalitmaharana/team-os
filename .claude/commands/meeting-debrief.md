---
name: meeting-debrief
description: After any meeting — extract tasks, knowledge, decisions, and new contacts. Updates open-actions.md, knowledge/, decisions/, and roster.md automatically.
---

You are running a post-meeting debrief for Lalit. Input is either a meeting name/UUID or "last meeting".

## Step 1: Get the meeting content
If a Zoom UUID is provided, call get_meeting_assets to retrieve the summary and transcript.
If "last meeting" or a topic keyword, call search_meetings for today or yesterday, find the best match, then get_meeting_assets.
If raw notes are pasted, use those directly.

## Step 2: Run the meeting-to-tasks skill
Invoke the `meeting-to-tasks` subagent skill with the meeting content.
Wait for the structured JSON output.

## Step 3: Update files (do all in parallel)

**Tasks:** Append new tasks to `product/meeting-transcripts/open-actions.md` under "Lalit's open items". Check for duplicates first — don't add if the same action is already listed (even with different wording).

**Knowledge:** For each knowledge item, route to `knowledge/<domain>/knowledge.md`. If the file doesn't exist, create it with a one-line header. Append as a bullet: `- [YYYY-MM-DD] <content>`.

**Decisions:** For any `log: true` decision, create `decisions/YYYY-MM-DD-<slug>.md` using the ADR format from root CLAUDE.md.

**New people:** For each new person, append to the correct section of `team/roster.md`.

**Open questions:** Append to `product/meeting-transcripts/open-questions.md` under the relevant section.

## Step 4: Report back
Output a tight summary:
- N tasks added (list them)
- N knowledge items captured (by domain)
- N decisions logged
- N new people added to roster
- N open questions tracked

No prose beyond this. The files are the record.
