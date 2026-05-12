---
description: Refresh the release backlog working ledger (Aha + Jira + Confluence + Slack sense → signals/, backlog-rank.md, jira-diff.md). Read-only against systems of record.
---

Run the `sense-backlog` skill for release **$ARGUMENTS** (e.g. `Summer 2026`).

The skill spec lives at `.claude/skills/sense-backlog/SKILL.md`. Follow it strictly — especially:

1. **Read-only** against Jira and Aha. No writes outside refinement calls.
2. **Append-only** to `signals/<feature>.md`. Dedup by source permalink.
3. **Regenerate** `backlog-rank.md` and `jira-diff.md` deterministically from current state.
4. **Emit a "what changed" summary** at the end.

If `$ARGUMENTS` is empty, default to the current release in focus (read `product/roadmap/` for the active release directory). Confirm with Lalit before proceeding if ambiguous.
