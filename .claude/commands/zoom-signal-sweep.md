---
name: zoom-signal-sweep
description: Proposed CCR routine (NOT yet created as a trigger). Captures DECISIONS from Lalit's Zoom meetings into the git signal ledger — the gap that day-end-sweep (Slack/Gmail only) and daily-meeting-extract (Slack Canvas only) do not cover.
status: proposed — routine not yet created; see "How to activate" below
---

# Zoom Signal Sweep — System Reference

## Why this exists (the gap)

As of 2026-07-01 four CCR routines keep `origin/main` current, but **none writes Zoom
*meeting decisions* into the git signal ledger**:

| Routine | Sources | Writes to |
|---|---|---|
| `morning-brief` | Jira / Slack / Calendar | `ops/daily/` (git) |
| `day-end-sweep` | **Slack + Gmail** | `signals/*.md` (git) |
| `monthly-audit-context` | repo | `analytics/context-audit/` (git) |
| `daily-meeting-extract` | **Zoom** + Calendar | **Slack Canvas + self-DM — NOT git** |

So refinement/architecture/scope decisions that happen in Zoom meetings never reach
`product/roadmap/*/signals/*.md`. They had to be backfilled manually for June 9–30
(see the 2026-06-30 entries in `signals/ai-201-meeting-transcripts.md`). This routine
closes that gap so it does not recur.

## The routine prompt (ready to paste into a CCR routine)

> Suggested schedule: `0 15 * * 1-5` (weekday, ~20:30 IST — after `day-end-sweep`).
> Environment: same as the other routines (`env_019WSww4TWQ5kPmhR9hV4UHX`).
> Required MCP: Zoom-for-Claude. Required tools: Bash, Read, Edit, Write, Glob, Grep.

```
You are the Zoom meeting-signal sweep routine for Lalit's team-os.

Determine today's date via `date +%Y-%m-%d` (IST). Use it as <date>.

GOAL: capture DECISIONS from Lalit's Zoom meetings into the git signal ledger — the
gap that day-end-sweep (Slack/Gmail only) and daily-meeting-extract (Slack only) miss.

1. Zoom search_meetings: from 26h ago -> now (26h catches late-generating AI summaries),
   meeting_category=history, page_size 30. Keep meetings with has_summary OR has_transcript.

2. For each kept meeting, get_meeting_assets(meeting_uuid).
   TOKEN RULE: use meeting_summary.summary_markdown only. Transcript fallback capped at
   8000 words. Never load both for one meeting.

3. Route each meeting to a feature signal file. For each feature in
   product/roadmap/*/CLAUDE.md, use its keyword set (frontmatter `search-keywords`,
   else derive 2-3 keywords from the feature name). Match the meeting topic/summary to a
   feature. A decision-bearing meeting that matches nothing goes to
   product/roadmap/<current-release>/signals/_unfiled.md.

4. Extract ONLY decisions / scope-changes / risks / open-questions / commitments
   (skip status updates and pleasantries). If a meeting produced no decision, skip it.
   APPEND one dated entry per meeting to the matched signals file, using the entry
   template in product/roadmap/<release>/README.md:

   ### <date> — <topic> (zoom)
   **Source:** Zoom — "<topic>" <date> (UUID <uuid>)
   **Type:** scope-decision | architecture | risk | open-question | commitment
   **Owner-impact:** <who needs to know / act>
   <2-4 sentence synthesis of what changed and why it matters>
   **Implication for ranking:** <if any>

   STRICTLY APPEND-ONLY. Never modify existing entries. Dedup by UUID — skip any meeting
   whose UUID already appears anywhere in the target file.

5. NEVER write to Jira or Aha (refinement-call policy — read-only if consulted at all).
   Only edit files under product/roadmap/. Capture any implied system-of-record change
   as a signal entry, not by calling a write tool.

6. Commit + push:
   - git add product/roadmap/
   - git commit -m "zoom-signal-sweep: <date>"
   - git push origin main
   If no new decisions were found, exit without an empty commit.
```

## How to activate

The prompt above cannot be pushed into a live trigger from a Claude Code session
(`update_trigger` only changes name/cron/enabled — not the prompt body). Activate it one
of two ways:

1. **Routines UI** — create a new routine at https://claude.ai/code/routines, paste the
   prompt, set the schedule + Zoom MCP + git-repo source (mirror an existing routine's config).
2. **Ask Claude** — "create the zoom-signal-sweep routine" and Claude will attempt it via
   `create_trigger` + a test fire to verify git-push + Zoom access before relying on it.

## Related staleness to fix (separate)

The live `daily-meeting-extract` trigger prompt (`trig_01RjvZpCXJPe1gVu1mBMgvca`) is stale:
it still cites the **May-31 Rainforest** target, "Pankaj **Lomo**" (should be **Lohmor**),
and "**Gauri**" as designer (should be **Harshini Vijay**). Refresh it in the Routines UI —
it also can't be edited from a session.
