# Roadmap

## What's here

- `<release-slug>/` — per-release working ledger (e.g. `summer-2026/`, `winter-2026/`). Each release directory follows the structure documented in its own `README.md`.

## Working ledger pattern (per release)

```
<release-slug>/
├── README.md           — mechanism doc + capture template
├── backlog-rank.md     — composite-scored, bucketed ranking (regenerated)
├── jira-diff.md        — Aha↔Jira reconciliation checklist (regenerated)
├── open-questions.md   — release-wide unresolved questions
├── decisions.md        — decisions log (what got bumped/cut and why)
└── signals/
    ├── <aha-key>-<slug>.md   — append-only per-feature signal log
    └── _low-signal.md         — items with no recent external signal
```

## Rules

- **System-of-record edits (Jira, Aha) happen only in refinement calls.** This directory is the working ledger; it captures the diff for refinement-call execution. No direct writes from sessions.
- **Signal files are append-only.** New entries are dated; superseded entries stay in history. Don't edit prior entries.
- **`backlog-rank.md` and `jira-diff.md` are derivative.** Regenerate from `signals/` via `/sense-backlog <release>` rather than hand-editing.
- **Scoring rubric** is documented in each release's `backlog-rank.md`. Keep it stable across runs unless explicitly changed in a refinement call (and logged in `decisions.md`).

## Workflow

- Before a refinement call: `/sense-backlog <release>` to refresh signal + diff.
- During release window: `/loop 1w /sense-backlog <release>` for continuous drift detection.
- After a refinement call: re-run `/sense-backlog` to capture decisions; log any rubric/scope changes in `decisions.md`.

## Authority

- Aha (`AI-R-<n>`) is the planning ledger.
- Jira (board 237 for AI team) is the execution ledger.
- This directory is **Lalit's working ledger** — derivative, walked through Nellie periodically. Not authoritative for stakeholders outside that flow.
