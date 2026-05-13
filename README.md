# team-os

**Betterworks PM Operating System** · `v0.1` · Live · Last updated: 2026-05-14

Personal-but-shareable operating system for Lalit's PM work at Betterworks. The repo is the shared context every Claude Code session reads from. This document is the entry point — start here if you've just opened the repo, are joining the team, or are evaluating where to put new content.

> This is a **living document**. Every meaningful change to the OS structure adds an entry to the [Iteration log](#iteration-log) at the bottom. Treat the table of contents as "current state" and the iteration log as "how we got here."

## Contents

- [Quickstart](#quickstart)
- [Folder layout](#folder-layout)
- [Architecture — the five principles](#architecture--the-five-principles)
- [Tier-1 (always loaded) vs Tier-2 (on-demand)](#tier-1-vs-tier-2)
- [Active skills & commands](#active-skills--commands)
- [Active hooks](#active-hooks)
- [Active routines](#active-routines)
- [A day in the OS](#a-day-in-the-os)
- [Adding new structure](#adding-new-structure)
- [Iteration log](#iteration-log)
- [References](#references)

## Quickstart

1. Read root `CLAUDE.md` (≤80 lines) — universal house rules + dedicated tool routing.
2. Read `.claude/context-design.md` once — the architecture this OS is built on.
3. `cd` into the area you're working in (e.g. `product/meeting-transcripts/`). Each area has its own scoped `CLAUDE.md`.
4. Start with `/my-actions` to surface open items.
5. For drafting a PRD, run `/write-prd <slug>`. For sensing release state, run `/sense-backlog <release>`.

## Folder layout

| Path | Purpose | Tier |
|---|---|---|
| `CLAUDE.md` | Root routing — identity, session workflow, dedicated tools, house rules | **Tier-1** |
| `.claude/context-design.md` | This OS's architecture — principles, sizing rules, hooks & routines catalogue | Tier-2 |
| `.claude/skills/` | Workflow playbooks (PRD, sense-backlog, audit-context, etc.) — load on invocation | Tier-2 |
| `.claude/commands/` | Slash commands — `/my-actions`, `/meeting-debrief`, `/write-prd`, etc. | Tier-2 |
| `.claude/hooks/` | Event-driven scripts that filter or guard context | — |
| `product/` | Per-area specs, roadmap ledgers, signals | Mixed |
| `knowledge/` | Learning loop — rules, hypotheses, observations per domain | Tier-2 |
| `decisions/` | Decision journal — ADRs for PM decisions | Tier-2 |
| `ops/` | Sprint cadence, meeting notes, daily briefs, team rituals | Mixed |
| `analytics/` | Metric definitions, audit reports, playbooks | Tier-2 |
| `team/` | Roster, Slack channels, who-does-what | Mixed |

## Architecture — the five principles

Full version in `.claude/context-design.md`. Summary:

1. **Two-tier knowledge.** Tier-1 is always loaded; Tier-2 is on-demand. Decide which tier *before* writing.
2. **Orthogonal scoping.** A fact lives in exactly one place. No duplication between root and sub-`CLAUDE.md`, or between repo and auto-memory.
3. **Workflows live in skills, not `CLAUDE.md`.** Skills load on invocation; a 100-line "how to" in `CLAUDE.md` taxes every session.
4. **Subagent for heavy reads.** Any operation reading >5 files or >2000 lines goes to a subagent. Verbose output stays in the subagent's context; only the summary returns.
5. **Append-only signals; never promote into Tier-1.** Findings go to `signals/<feature>.md`. Resist promoting them into `CLAUDE.md` — that inflates Tier-1.

## Tier-1 vs Tier-2

|  | Tier-1 (always loaded) | Tier-2 (on-demand) |
|---|---|---|
| **What** | Root `CLAUDE.md`, scoped sub-`CLAUDE.md`, auto-memory | Skills, `knowledge/`, `signals/`, `decisions/`, this README |
| **Cost** | Every Claude turn, every session | Only when invoked or grep'd |
| **Sizing rule** | Root ≤80 lines · Sub ≤40 lines · Memory entry ≤30 lines | Unbounded by design |
| **What goes here** | Identity, universal house rules, workflow triggers, dedicated tool routing | Workflow detail, playbooks, dated findings, decisions, learning |

## Active skills & commands

| Name | Trigger | Purpose |
|---|---|---|
| `prd-agentic` | via `/write-prd` | Draft Markdown PRDs with stable IDs, EARS acceptance criteria, agent-card.json |
| `sense-backlog` | `/sense-backlog <release>` | Refresh release working ledger from Aha + Jira + Confluence + Slack signal |
| `sync-prd` | `/sync-prd <slug>` | Reconcile md ↔ html ↔ INDEX ↔ agent-card after claude.ai chat iteration |
| `meeting-to-tasks` | auto on transcripts | Extract structured tasks, knowledge, decisions, people from a meeting transcript |
| `tldr-pdf` | on demand | 200-word TL;DR from a PDF without loading full text into parent context |
| `audit-context` | `/audit-context` + monthly | Check `CLAUDE.md` / memory / signal drift against the sizing rules |
| `/my-actions` | start of session | Surface open items before doing anything else |
| `/meeting-debrief` | after meetings | Capture decisions, tasks, signals from a meeting |
| `/standup` | daily standup | Synthesize yesterday/today/blockers |
| `/daily-meeting-extract` | cron 20:00 IST | Backup extraction in case live debriefs were missed |

## Active hooks

Wired in `.claude/settings.json` · scripts in `.claude/hooks/`

| Hook | Event | Effect |
|---|---|---|
| `log-claudemd-change.sh` | PostToolUse Edit/Write/MultiEdit | Appends every CLAUDE.md edit to `ops/claudemd-changelog.md` |
| `warn-claudemd-size.sh` | PostToolUse Edit/Write/MultiEdit | Warns when any CLAUDE.md crosses soft limit (root 80, sub 40) |
| `warn-large-reads.sh` | PreToolUse Read | Warns on reads >2000 lines; suggests subagent |
| `index-signals.sh` | PostToolUse Edit/Write/MultiEdit on `signals/**/*.md` | Regenerates `signals/INDEX.md` automatically |

## Active routines

Scheduled remote agents — run in their own context, write artifacts to disk, never tax foreground sessions.

| Routine | Cadence | Output | Status |
|---|---|---|---|
| **daily-meeting-extract** | weekdays 20:00 IST (system cron) | Per-meeting extracts | Live |
| **morning-brief** | weekdays 08:00 IST | `ops/daily/<date>.md` | Pending registration |
| **day-end-sweep** | weekdays 19:00 IST | Appends to `signals/<feature>.md` | Pending registration |
| **monthly-audit-context** | 1st of month 09:00 IST | `analytics/context-audit/<date>.md` | Pending registration |
| **quarterly-archive** (optional) | 1st of Jan/Apr/Jul/Oct | Moves stale signals to `_archive/` | Pending registration |

Registration prompts: `ops/routines-playbook.md` (one-time setup file, self-deletes after applying).

## A day in the OS

1. **Morning:** The *morning-brief* routine has already written `ops/daily/<today>.md` with overnight Jira/Slack/calendar state. Open and skim — no need to ask Claude "what changed?"
2. **Work session start:** `cd` into the area folder (e.g. `product/meeting-transcripts/`) so only that scope's `CLAUDE.md` loads. Run `/my-actions`.
3. **After a meeting:** `/meeting-debrief <meeting-name>` — decisions go to `decisions/`, signals to `signals/<feature>.md`, tasks captured.
4. **Drafting:** PRDs via `/write-prd`; refinement prep via `/sense-backlog <release>`. Heavy reads → subagent (the `warn-large-reads.sh` hook will remind you if you slip).
5. **End of day:** The *day-end-sweep* routine collects mentions you missed and appends to relevant signal files. Quarterly the *archive* routine prunes resolved signals.
6. **Once a month:** The *monthly-audit-context* routine writes a drift report. Glance at `analytics/context-audit/<date>.md` to see if any file has grown past its soft limit.

## Adding new structure

| When you want to add… | Do this |
|---|---|
| A new product area | `mkdir product/<slug>/`, create `CLAUDE.md` ≤40 lines mirroring `meeting-transcripts/CLAUDE.md`, add one-line pointer in root `CLAUDE.md` § My current focus |
| A new workflow / playbook | Create `.claude/skills/<name>/SKILL.md` with YAML frontmatter; add one-liner under root `CLAUDE.md` § Dedicated Tools |
| A new finding | Append to existing `signals/<feature>.md`. Never create a new always-loaded file for a single finding. |
| A new hook | Script under `.claude/hooks/`, wire in `.claude/settings.json`, document in this README's hooks table and in `.claude/context-design.md` |
| A new routine | Register via `/schedule`; document in this README's routines table |
| A new always-true fact about Lalit | Auto-memory (`user_lalit_pm.md` or `process_rules.md`). Not `CLAUDE.md`. |
| A meaningful change to the OS itself | Add an entry to the [Iteration log](#iteration-log) below. |

## Iteration log

Newest first. Each entry: date, version bump, one-sentence summary, then bullets of what changed and where to find detail.

### v0.1 — 2026-05-13 · Establish context-design ethos

Initial structural refactor. Token efficiency moves from daily-discipline to OS-property.

- Added `.claude/context-design.md` as the architecture source of truth: 3 time-scales, 5 principles, sizing rules, hooks & routines catalogue.
- Added `audit-context` skill — Sonnet subagent, drift checker. Triggerable as `/audit-context`; scheduled monthly.
- Added three hooks: `warn-claudemd-size.sh`, `warn-large-reads.sh`, `index-signals.sh`. Wired alongside the pre-existing `log-claudemd-change.sh`.
- Trimmed root `CLAUDE.md` 107 → 77 lines. Migrated knowledge-loop, decision-journal, and routing-table-maintenance detail into `.claude/context-design.md`.
- Consolidated auto-memory at `~/.claude/projects/-Users-lalitkumarmaharana/memory/`: 6 files / 7.8 KB → 3 files / 5.5 KB (29% reduction).
- Added `ops/routines-playbook.md` for the manual steps tooling could not perform (`/mcp`, `/schedule`, global settings env block).
- Quantified impact: root `CLAUDE.md` always-load −28%, memory always-load −29%, MCP startup −35% after manual disables, thinking-token ceiling 8000/turn.

Branches: `claude-context/ethos-foundation` (foundation), `claude-context/trim-claude-md` (trim + playbook + this README).

<!-- ADD NEW ITERATION ENTRIES ABOVE THIS LINE, NEWEST FIRST.
     Each entry follows the v0.1 template: version, date, one-line summary, bullets, branches. -->

## References

- `CLAUDE.md` — root routing for every session
- `.claude/context-design.md` — full architecture document
- `ops/routines-playbook.md` — current manual steps (delete after applying)
- `ops/claudemd-changelog.md` — auto-log of every CLAUDE.md edit (maintained by hook)
- `analytics/context-audit/` — monthly drift reports (oldest first)
- `decisions/` — ADRs for PM decisions
- `knowledge/` — learning loop: rules / hypotheses / observations per domain
- `README.html` — same content as this file, styled for browser viewing

---

*This README is the entry point. It is updated with every meaningful iteration to the OS — see the iteration log above. For the live Claude routing surface, see `CLAUDE.md`. For the architecture rationale, see `.claude/context-design.md`.*
