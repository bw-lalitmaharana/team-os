---
name: sync-prd
description: >
  Reconcile a PRD after a claude.ai chat iteration. Use after pasting an updated `.prd.md` / `.prd.html`
  back into `product/<area>/prds/<slug>/`. The skill verifies local consistency — md ↔ html ↔ INDEX.md row ↔
  agent-card.json ↔ §14 Decisions Log — and flags drift. Local-only: never pushes to Confluence/Jira/Aha
  (those are manual by Lalit). Trigger on `/sync-prd <slug>` or when the daily digest's `📝 PRD DRIFT` block
  surfaces an inconsistency.
---

# sync-prd skill

Closes the round-trip loop for PRDs that Lalit iterates on in claude.ai chat using `prd-agentic` /
`pmd-template`. The chat produces the canonical `.prd.md` + `.prd.html`; Lalit pastes them back into
this repo. After paste, things drift: `INDEX.md` version isn't bumped, `agent-card.json` capability
list lags, decisions noted in chat never reach §14, related signal files aren't cross-linked.

This skill is **local-only**. It does not call Confluence, Jira, or Aha. Lalit pushes those manually
based on his daily digest.

## Inputs

- `<slug>` — required. Matches the folder name under `product/<area>/prds/<slug>/`.
  Example: `/sync-prd ai-processing-pipeline`, `/sync-prd custom-roles`.
- Resolves area by searching `product/*/prds/<slug>/` (typically `product/meeting-transcripts/prds/<slug>/`
  or `product/custom-roles/prds/<slug>/`).

## What "drift" means here

The PRD folder is consistent iff all of the following hold:

1. `<slug>.prd.md` frontmatter `version` matches the `Version` column for the slug in `prds/INDEX.md`.
2. `<slug>.prd.html` mtime ≥ `<slug>.prd.md` mtime (html re-rendered after md edit).
3. `agent-card.json` `capabilities[]` count + names match `§7 Capabilities` rows in `.prd.md`.
4. `agent-card.json` `version` matches `.prd.md` frontmatter `version`.
5. Every decision in `§14 Decisions Log` that mentions another area has a corresponding entry in `decisions/YYYY-MM-DD-*.md`.
6. The signal file `product/roadmap/<release>/signals/<feature-key>-<slug>.md` (if it exists) has at
   least one entry dated within 7 days of the PRD's latest version bump.

## Steps

### 1. Locate PRD folder
- Glob `product/*/prds/<slug>/` and `product/*/prds/_stubs/<slug>.stub.md`. Fail loudly if not unique.

### 2. Read current state
- `<slug>.prd.md` — frontmatter + §7 Capabilities + §14 Decisions Log
- `<slug>.prd.html` — mtime only (do not parse content)
- `prds/INDEX.md` — find the row for `<slug>`
- `agent-card.json` — full read

### 3. Run the 6 drift checks above

Output a table:

| Check | Status | Details |
|---|---|---|
| 1. md ↔ INDEX version | ✅ / ⚠ | `0.9.0` in md, `0.8.0` in INDEX |
| 2. html mtime ≥ md mtime | ⚠ | html is 2 days older than md — re-render needed |
| 3. agent-card caps ↔ §7 | ✅ | 11 caps both sides |
| ... | | |

### 4. Apply auto-fixes (with confirmation prompt before each)

- **Patch version bump** (auto-suggest): if md is `0.9.1` and INDEX says `0.9.0`, bump INDEX. Minor/major bumps require explicit Lalit confirmation per the convention in `prds/INDEX.md` §"Versioning convention".
- **Re-render html**: regenerate via the `pmd-template` skill's render path. Never hand-edit html.
- **Update agent-card.json**: regenerate capability list + version from `.prd.md`. Preserve hand-curated fields (anchors, A2A discovery hints) by reading current file and only updating drifted fields.
- **Fan-out decisions**: for each §14 row that names another area, propose a new `decisions/YYYY-MM-DD-<topic>.md` entry. Show diff before write.
- **Signal-file freshness**: if signal file is >7 days older than the PRD bump, append a dated entry pointing at the PRD version bump as the trigger.

### 5. Emit summary

Plain text block, suitable for the daily digest's `📝 PRD DRIFT` follow-up:

```
sync-prd <slug> — applied:
  - INDEX version 0.8.0 → 0.9.1
  - re-rendered html (was 2d stale)
  - agent-card.json: added cap CAP-012 "evidence retention policy"
  - new ADR: decisions/2026-05-13-evidence-retention-cross-pod.md
Still needs manual push (you do this):
  - Confluence parent: paste new html into page 4280614960
  - Jira: update ENG-79199 description if §10a MUSTs changed
```

## What this skill MUST NOT do

- Never call Confluence write APIs. Never call Jira/Aha write APIs. Pushes are manual.
- Never hand-edit `.prd.html` — always regenerate via `pmd-template`.
- Never invent version bumps beyond patch. Minor/major requires Lalit confirming.
- Never edit prior §14 entries — only append. Same append-only discipline as `signals/`.
- Never delete drifted fields silently — surface them in the drift table even if auto-fix succeeded.

## When to run

- Immediately after a claude.ai PRD session where you pasted `.prd.md` / `.prd.html` back into repo.
- When the daily digest's `📝 PRD DRIFT` block flags this slug.
- Before any `/sense-backlog` run if you suspect PRD versions are stale.

## Related

- `.claude/skills/prd-agentic/SKILL.md` — writes new PRDs (this skill reconciles existing ones).
- `.claude/skills/PMD-Template/` — the html render engine. Do not modify; this skill calls it.
- `product/meeting-transcripts/prds/INDEX.md` — versioning convention reference.
- `decisions/_template-signal-miss.md` — log here if drift caused a missed cross-area signal.
