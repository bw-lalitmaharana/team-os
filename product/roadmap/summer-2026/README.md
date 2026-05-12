# Summer 2026 — AI Release Working Ledger

**Theme:** AI in the Flow of Work
**Code Ready:** 2026-08-28 · **GA:** 2026-09-15
**Owner:** Nellie LeMonier (AI/Platform pillar) · **PM for transcripts:** Lalit
**Aha release:** `AI-R-27` · **Jira board:** 237 (AI team)
**Release brief:** [Confluence page 4182409217](https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4182409217/Summer+2026+AI+in+the+Flow+of+Work+Release+Brief)

This is my (Lalit's) working ledger for Summer 2026 backlog refinement. Not the authoritative roadmap — Aha is. This is where I synthesize signal across Aha + Jira + Confluence + Slack to make ranking calls, then walk Nellie through.

## What lives here

- **`signals/`** — one file per backlog item. Append-only capture of scope decisions, stakeholder positions, risks, and open questions surfaced in Slack/meetings. Each entry is dated. **This is the "memory" layer** — when a decision drifts (e.g. Nellie pivots away from Recall, Sales adds Synopsys commitment), it goes here, not in Aha.
- **`backlog-rank.md`** *(TBD)* — current rank-order with composite scores and rationale. Refreshed after each refinement pass.
- **`jira-diff.md`** *(TBD)* — Aha↔Jira reconciliation: missing fixVersions, missing epics, stale assignments.
- **`open-questions.md`** *(TBD)* — release-wide questions not tied to one feature (vs. `product/meeting-transcripts/open-questions.md` which is feature-specific).
- **`decisions.md`** *(TBD)* — what got bumped/cut and why, so this isn't re-litigated.

## Capture mechanism

**Trigger any of these and the signal lands in `signals/<feature>.md`:**
1. Slack threads in #champagne-mcp-support, #temp-meeting-transcript-integration, #pod-app-platform, #oppty_* mention a Summer feature
2. Meeting debriefs (`/meeting-debrief`) include a Summer-feature-tagged action or scope decision
3. Daily extract surfaces a stakeholder position (Nellie, JB, Cheryl, Sarah Brose, Nataliya, etc.) on a Summer feature

**Capture format** — every entry in a signal file uses this template:

```
### YYYY-MM-DD — <one-line title>
**Source:** <slack permalink | meeting name | Aha record | Confluence page>
**Type:** scope-decision | risk | open-question | stakeholder-position | commitment | competitive
**Owner-impact:** <who needs to know / act>

<2-4 sentence summary of what changed and why>

**Implication for ranking:** <if any>
```

Append, don't edit. If something is later resolved, add a new entry that supersedes — keep the history.

## Future: `/sense-backlog` skill

To be built after this refinement pass. Will:
1. Run Slack searches per feature keyword set (saved in skill config)
2. Pull Jira epic status + sprint child counts
3. Diff Aha against Jira, write to `jira-diff.md`
4. Append new signal entries to `signals/<feature>.md`, skipping duplicates by source permalink
5. Surface a "what changed since last run" summary

Paired with `/loop 1w` during the release window so drift is continuous, not episodic.

## Cross-references

- Feature-specific deep work (especially transcripts): `product/meeting-transcripts/`
- Architecture context: `knowledge/architecture/`
- Decisions journal: `decisions/`
