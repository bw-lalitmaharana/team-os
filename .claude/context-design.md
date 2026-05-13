# team-os Context Design

This document explains how the OS is structured to keep Claude's context window small and useful. It is the ethos that makes token efficiency a structural property, not a daily discipline.

Read this once when joining the team or when adding a new area / skill / routine.

## Three time-scales

Claude works across three time-scales. Each has its own mechanism for keeping context lean.

| Scale | Mechanism | Concrete things |
|---|---|---|
| Within a response | `effortLevel`, `MAX_THINKING_TOKENS` | One Claude turn |
| Within a session | **Hooks** (`.claude/hooks/`, wired in `.claude/settings.json`) | Filter/gate what enters context per tool call |
| Between sessions | **Routines** (scheduled remote agents via `/schedule`) | Pre-fetch context before you arrive; capture state after you leave |

## Five principles (where things live)

1. **Two-tier knowledge.** Tier-1 is *always loaded*: root `CLAUDE.md`, scoped sub-`CLAUDE.md`, and auto-memory. Tier-2 is *on-demand*: skills, `knowledge/`, `signals/`, `decisions/`. Decide which tier *before* writing. If unsure, default Tier-2.
2. **Orthogonal scoping.** A fact lives in exactly one place. Root has identity + universal house rules. Each sub-folder `CLAUDE.md` has *only* deltas unique to that folder. Same fact in two files = paying twice every turn.
3. **Workflows live in skills, not `CLAUDE.md`.** Skills load on invocation. A 100-line "how to do X" in `CLAUDE.md` taxes every session; the same in `.claude/skills/<x>/SKILL.md` taxes only X-sessions.
4. **Subagent for heavy reads.** Any operation that reads >5 files or >2000 lines goes to a subagent. The verbose output stays in the subagent's context; only the summary returns.
5. **Append-only signals; never promote into Tier-1.** Findings go to `signals/<feature>.md` (Tier-2). Resist promoting them into `CLAUDE.md` or memory — that just inflates Tier-1.

## Decision tree: where does this fact go?

```
Is it ALWAYS true and AFFECTS HOW I WORK in every session?       → Tier-1 root CLAUDE.md (≤80 lines)
Is it specific to one area and affects work in that area?         → Tier-1 sub-folder CLAUDE.md
Is it about ME (role, sponsors, persistent preferences)?          → Auto-memory (~/.../memory/)
Is it a workflow / playbook / how-to?                             → Tier-2 skill (.claude/skills/<x>/)
Is it a dated finding or observation?                             → Tier-2 signals/<feature>.md (append-only)
Is it a decision with reasoning?                                  → Tier-2 decisions/YYYY-MM-DD-<topic>.md
Is it a fact derivable from grep/git/code?                        → Don't write it down
```

## Sizing rules

| File | Soft limit | Why |
|---|---|---|
| Root `CLAUDE.md` | ≤80 lines | Loads every session at this cwd |
| Sub-folder `CLAUDE.md` | ≤40 lines | Loads when cwd is in that folder |
| Memory entry | ≤30 lines | Loads every session globally |
| `MEMORY.md` index | ≤30 lines | First 200 lines auto-load; index should be 1 line per memory |
| `signals/<feature>.md` | unbounded | Tier-2 — only read when investigating that feature |
| Skill `SKILL.md` | ≤200 lines (recommend <100) | Loads on invocation only |

Stub sub-folder `CLAUDE.md` files (≤15 lines, just a pointer) should be **deleted** — fold the pointer into the parent.

## Hooks (in-session filters)

Wired in `.claude/settings.json`. See `.claude/hooks/*.sh`. Currently active:

- `log-claudemd-change.sh` (PostToolUse Edit/Write) — appends to `ops/claudemd-changelog.md`
- `warn-claudemd-size.sh` (PostToolUse Edit/Write) — warns when any `CLAUDE.md` grows past its soft limit
- `warn-large-reads.sh` (PreToolUse Read) — warns when reading files >2000 lines; suggests subagent
- `index-signals.sh` (PostToolUse Edit/Write on `signals/**/*.md`) — keeps `signals/INDEX.md` fresh

Hooks are insurance, not the only mechanism. Principles come first.

## Routines (between-session work)

Scheduled remote agents via `/schedule`. They run in their own context, write artifacts to disk, and cost zero tokens to you until you read the artifact.

| Routine | Cadence | Output |
|---|---|---|
| Morning brief | Weekdays 8:00 | `ops/daily/<date>.md` — overnight Jira changes, Slack mentions, calendar peek |
| Day-end signal sweep | Weekdays 19:00 | Appends to `product/roadmap/<release>/signals/<feature>.md` for each feature mentioned |
| Monthly audit-context | 1st of month 9:00 | `analytics/context-audit/<YYYY-MM>.md` — flags drift |
| Quarterly archive | Jan/Apr/Jul/Oct 1st | Moves resolved signals to `_archive/` |

The morning brief eliminates the most common in-session question: "what's the current state of X?" The answer is already a file.

## Adding new structure

| When adding... | Do this |
|---|---|
| A new product area | `mkdir product/<slug>/`, create `CLAUDE.md` ≤40 lines, add one-line pointer in root `CLAUDE.md` § Areas |
| A new workflow | Create `.claude/skills/<name>/SKILL.md` with YAML frontmatter; add one-line pointer in root `CLAUDE.md` § Dedicated Tools |
| A new finding | Append to existing `signals/<feature>.md`. Never create a new always-loaded file for a single finding |
| A new hook | Add script under `.claude/hooks/`, wire in `.claude/settings.json`, document above |
| A new routine | Use `/schedule` to register; document above |

## Auditing drift

Run `/audit-context` (skill at `.claude/skills/audit-context/`) any time. Spawns a subagent to:

- Count lines in every `CLAUDE.md` against soft limits
- Check memory file count + total size
- Find duplicated phrases across `CLAUDE.md` files
- List signals files untouched for >90 days
- Report findings to `analytics/context-audit/<YYYY-MM-DD>.md`

Scheduled to run monthly (1st of month). Drift accumulates silently; the audit makes it visible.
