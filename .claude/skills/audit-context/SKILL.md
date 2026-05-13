---
name: audit-context
description: >
  Audit the team-os context surface for drift against the sizing rules in `.claude/context-design.md`.
  Spawns a subagent to count CLAUDE.md lines, check memory size, find duplicated phrases across
  CLAUDE.md files, list stale signals/, and report findings to `analytics/context-audit/<YYYY-MM-DD>.md`.
  Trigger on `/audit-context` or when the user asks to check context bloat, CLAUDE.md drift, memory
  pollution, or "is the OS still lean?". Also runs scheduled monthly via the audit-context routine.
agent: true
model: sonnet
---

# audit-context

Quarterly/monthly drift check against `.claude/context-design.md`. Output is a file, not chat — keeps the parent context unaffected.

## Inputs

- None. Operates on the current repo tree.

## Steps

### 1. CLAUDE.md sizes

For every `CLAUDE.md` under the repo root (exclude `node_modules`, `.git`):

- Line count
- Flag entries that exceed the soft limit (root ≤80, sub-folder ≤40)
- Identify stubs (≤15 lines) — candidates for deletion + folding into parent

### 2. Memory inventory

Read `~/.claude/projects/-Users-lalitkumarmaharana/memory/MEMORY.md` and list every file in the same directory:

- Total file count
- Total bytes
- Flag any file >30 lines
- Identify entries duplicated by content in any `CLAUDE.md` (grep for distinctive phrases)

### 3. Cross-file duplication

For each non-trivial sentence in root `CLAUDE.md`, grep for near-matches in:

- All sub-folder `CLAUDE.md` files
- All memory files

Report any matches >70% similar.

### 4. Signal freshness

For each `product/roadmap/*/signals/*.md`:

- Last modified date (`git log -1 --format=%ai`)
- Flag any unchanged in >90 days as archive candidates

### 5. Skill / command inventory

- Count skills, commands
- Flag any `SKILL.md` >200 lines

### 6. Write report

Write findings to `analytics/context-audit/<YYYY-MM-DD>.md`. Format:

```markdown
# Context audit — <YYYY-MM-DD>

## CLAUDE.md sizes (limits per .claude/context-design.md)
- ✅ / ⚠️ root CLAUDE.md — <N> lines (limit 80)
- ... per file

## Memory
- N files, total <bytes>
- ⚠️ <file>: <reason>

## Duplication
- <root-line> echoed in <sub-claude.md or memory file>

## Stale signals
- <file> — last touched <date>

## Skills / commands
- <count> skills, <count> commands
- ⚠️ <skill>: <reason>

## Recommendations
- One-line actions ranked by impact
```

Then return a one-paragraph summary to the parent — leave the detail in the report file.

## Output contract

- Parent receives a short summary + path to the report
- Detailed findings live in `analytics/context-audit/<YYYY-MM-DD>.md`
- No edits to any other file — this is read-only / report-only
