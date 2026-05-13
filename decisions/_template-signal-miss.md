# Signal-miss postmortem — YYYY-MM-DD — <topic>

> Template. Copy to `decisions/YYYY-MM-DD-signal-miss-<topic>.md` whenever a session uncovers a signal that the system should have caught earlier but didn't. The point is to harden the system, not just patch the symptom.

## What was missed
<1–2 sentences. Include the artifact: Aha key, Jira key, meeting UUID, Slack permalink — whichever applies.>

## When it should have been caught
<The earliest moment a healthy system would have surfaced this. E.g., "next /sense-backlog run after the 2026-05-11 1:1", "in the 2026-05-12 daily digest".>

## Why detection failed
<Pick one or more. Be specific.>
- Scope filter too narrow (`/sense-backlog` only queries assigned features)
- Manual step skipped (`/meeting-debrief` not run)
- No filesystem bridge from external system (Slack/Confluence/Aha) into team-os
- Root `CLAUDE.md` didn't route attention to the relevant area
- PRD round-trip drift (claude.ai edits not re-synced)
- Other: ____

## System fix
<Which of the existing controls (C1 area index, C2 cross-area sweep, C3 daily SIGNAL GAPS, C4 weekly cross-area routine, C5 this template, C6 PRD sync) closes the gap? If none does, what new control is needed?>

## How to test the fix
<Concrete: "next /sense-backlog run should list APP-369 in `## Cross-area items`", or "next daily digest should flag 2026-05-11 in `📋 SIGNAL GAPS`".>

## Re-test date
<When you'll come back and confirm. If the system doesn't catch a re-introduced miss, the fix didn't work.>

## Related
- Knowledge entry: `knowledge/<domain>/...` (if a new pattern emerges)
- Skill updated: `.claude/skills/<name>/SKILL.md` (if a control was patched)
