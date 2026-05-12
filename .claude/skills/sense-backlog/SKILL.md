---
name: sense-backlog
description: >
  Refresh the Summer/Winter release working ledger at `product/roadmap/<release>/`. Pulls signal from Aha (release
  features), Jira (epic status + sprint pull on board 237), Confluence (release brief), and Slack (per-feature
  keyword searches). Appends dated entries to `signals/<feature>.md`, regenerates `backlog-rank.md` and
  `jira-diff.md`, and surfaces a "what changed since last run" summary. Trigger on `/sense-backlog <release>` (e.g.
  `/sense-backlog Summer 2026`) or when the user asks to refresh the backlog ranking, refinement prep, release
  drift check, or "sense the backlog".
---

# sense-backlog skill

Recurring refinement-prep skill. Strict policy: **read-only against Jira/Aha — never writes.** All system-of-record changes happen in refinement calls (see memory `feedback_refinement_call_only.md`). This skill captures the diff and lets Lalit execute the writes manually with stakeholders present.

## Inputs

- `<release>` — required positional arg, matches Aha release name (e.g. `Summer 2026`, `Winter 2026`).
- Optional: `--scope ai-team` (default), `--scope full-release`.

## Steps

### 1. Resolve release across all three systems

- **Aha:** `mcp__claude_ai_Aha__search_records` with `record_type=release`, queries=`[<release>]`. Filter to AI workspace (`reference_prefix=AI` for AI team scope). Get features via `read_records` `include=[feature]`, `association_fields=standard`.
- **Confluence:** `mcp__claude_ai_Atlassian__search` with query `<release> release brief AI`. Read the brief page if found.
- **Jira:** discover board's stored filter. For AI team default to board 237. Use `searchJiraIssuesUsingJql` with `project=ENG AND fixVersion="<release>" AND issuetype=Epic` — but be aware fixVersions are often unset; cross-reference Aha→Jira links extracted from feature descriptions.

If queries return >50k chars, the result is dumped to a file — use `jq` via Bash to extract concise fields rather than reading the file directly.

### 2. Cross-reference Aha ↔ Jira

For each Aha feature, extract embedded Jira keys from `description` field. Build a map. Note:
- Features with Jira link → match.
- Features without Jira link → **add to jira-diff.md section B/C.**
- Jira epics with `fixVersion=<release>` but no Aha feature → likely missing Aha record.

### 3. Pull execution state

For matched Jira epics, query:
- Epic status, assignee, priority, fixVersion.
- Open-sprint child count per epic: `project=ENG AND sprint in openSprints() AND parent in (<epic-keys>)`. Group by parent.
- Sample child issues with status to gauge near-ship vs. early-stage.

### 4. Sense Slack per feature

For each feature, run keyword searches via `mcp__claude_ai_Slack__slack_search_public_and_private`:

| Feature theme | Suggested queries |
|---|---|
| Meeting transcripts | `meeting transcripts Recall Zoom 1:1`, `in:#temp-meeting-transcript-integration`, `in:#pod-app-platform transcripts` |
| Adaptive Learning | `Adaptive Learning LMS skill gap upskilling`, `in:#oppty_* adaptive learning` |
| MCP / Agentic | `MCP server rollout`, `in:#champagne-mcp-support`, `Agentic AI tools foundation` |
| Skills/Techwolf | `Techwolf Synopsis skills taxonomy`, `BYO Skills`, `in:#oppty_synopsys` |
| Gemma migration | `Gemma multilingual prompt`, `in:#eng-ai-engineering-lab Gemma` |
| Performance Summary | `Performance Summary AI redesign`, `in:#pod-employee-development` |

For each result with a Summer-relevant message, extract: source permalink, date, author, message excerpt, signal type (scope-decision / risk / open-question / stakeholder-position / commitment / competitive).

### 5. Append to signals/

For each new signal, append to `product/roadmap/<release-slug>/signals/<feature-slug>.md` using the template in that directory's README.md:

```
### YYYY-MM-DD — <one-line title>
**Source:** <permalink>
**Type:** scope-decision | risk | open-question | stakeholder-position | commitment | competitive
**Owner-impact:** <who needs to know / act>

<2-4 sentence summary>

**Implication for ranking:** <if any>
```

**Dedup rule:** skip if a permalink already appears in the file. Never edit prior entries; append-only.

If a feature has no signal in this run, do not edit its file.

### 6. Regenerate backlog-rank.md

Re-score each feature using the rubric:

```
Composite = (NetNewRev + Retention + MarketDiff + StrategicAlign) − Effort   [0–10 each]
Lifts: contractual +5, cross-feature unblocker +3, at-risk/unowned −2
```

For features with `score_facts` in Aha, use those. For unscored, retain prior proposed values from the previous `backlog-rank.md`. Flag any score deltas explicitly in the regeneration summary.

Bucket: P0 / P1 / P2 / P3. Tie-breakers: contractual date → cross-pod blocker → revenue tier → effort.

Capacity check: weeks remaining to code-ready × team velocity; flag if P0 effort exceeds capacity.

### 7. Regenerate jira-diff.md

Sections:
- A. Missing fixVersion="<release>" — list Jira epics that should have it but don't.
- B. Missing Jira epic (Aha-only) — features in the release with no Jira counterpart.
- C. Missing Aha→Jira link — Jira exists but Aha description lacks the link.
- D. Stale Jira status / metadata — shipped items still marked Draft, unassigned high-priority items, uniform-priority gradients.
- E. Aha score gaps — features with no score_facts; show proposed values.
- F. Aha ownership staleness — list users referenced in Aha who have departed (cross-reference team memory).
- G. Items in owner's portfolio not in the release — Summer-candidate triage.

### 8. Emit "what changed" summary

Compare current run to git HEAD of these files. For each:
- New signal entries (count + titles)
- Rank changes (before → after, with reason)
- Diff items resolved (no longer applicable) vs. new diff items
- New open questions

Output as a Slack-ready summary block at the end of the session for posting to Lalit's working channel if desired.

### 9. Update task tracking

For each new diff item, optionally create a task with `TaskCreate` tagged with the feature and "refinement-call" so it surfaces in `/my-actions` until walked through.

## Outputs (files written)

- `product/roadmap/<release-slug>/signals/<feature-slug>.md` — appended
- `product/roadmap/<release-slug>/backlog-rank.md` — overwritten (regenerated)
- `product/roadmap/<release-slug>/jira-diff.md` — overwritten (regenerated)
- `product/roadmap/<release-slug>/open-questions.md` — appended with new Q entries; existing Qs untouched
- Terminal summary — "what changed since last run"

## What this skill MUST NOT do

- Never call Jira write tools (`editJiraIssue`, `transitionJiraIssue`, etc.) or Aha write tools (`update_*`, `create_*`). All system writes happen in refinement calls only.
- Never edit prior signal entries — append-only.
- Never invent score_facts; use Aha values where present, retain proposed values from prior `backlog-rank.md` for unscored items, flag explicitly when proposing new values.
- Never collapse multiple findings into one — each Slack thread / meeting decision / Confluence change is its own dated entry.

## Cadence

Pair with `/loop 1w /sense-backlog <release>` during the release window so drift surfaces continuously. Run manually after any refinement call to capture decisions.

## Related

- `feedback_signals_capture.md` (memory) — the capture pattern this skill codifies.
- `feedback_refinement_call_only.md` (memory) — the no-writes policy.
- `project_summer2026_ownership.md` (memory) — Anthony departed; substitute Nellie when Aha attribution is stale.
- `product/roadmap/summer-2026/README.md` — the mechanism doc for the working ledger.
