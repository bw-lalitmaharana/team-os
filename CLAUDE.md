# Betterworks PM — Team OS

I'm Lalit, PM at Betterworks. This repo is my team's shared context.

## Top-level layout
- `product/` — specs, roadmap, research notes (per area)
- `analytics/` — metrics, queries, playbooks (verified by analytics)
- `team/` — roster, Slack channels, who-does-what
- `ops/` — sprint cadence, meeting notes, team rituals
- `knowledge/` — learning loop: rules, hypotheses, observations per domain
- `decisions/` — decision journal (ADRs for PM decisions)

## Don't load everything
Each subfolder has its own `CLAUDE.md`. Read that first, then drill into specific files as needed.

## Session workflow
- **Start of session:** Run `/my-actions` to surface open items before doing anything else.
- **After any meeting:** Run `/meeting-debrief <meeting-name>` immediately — do not wait until end of day.
- **Daily scheduled extraction:** Runs automatically at 8 PM IST via cron (see `.claude/commands/daily-meeting-extract.md`). Backs up any missed debriefs.
- **Before any design decision:** Check `product/meeting-transcripts/open-questions.md` for active decisions in that area.
- **Before drafting a PRD:** Run `/write-prd <feature-or-epic>`. Review the auto-gathered context, then fill genuine gaps only. Run `/prd-review` before sharing.
- **Before release refinement (or weekly during release window):** Run `/sense-backlog <release>` (e.g. `Summer 2026`). Refreshes the working ledger at `product/roadmap/<release>/` — appends Slack/meeting signal to `signals/<feature>.md`, regenerates `backlog-rank.md` and `jira-diff.md`. Read-only against Jira/Aha — all system writes happen in refinement calls only.
- **End of session:** If new patterns emerged, extract to `knowledge/<domain>/`. If a decision was made, log it to `decisions/`. PRD Constraints (§10a) that are newly locked should land in both places.

## My current focus

Areas — each has its own `CLAUDE.md`. Read the subfolder when working in that area; do not load all of them in every session.

- `product/meeting-transcripts/` — **primary**, Summer 2026, ENG-79199 (AI Processing Pipeline)
- `product/custom-roles/` — cross-area, App Platform, APP-369 / APP-370 (PRD authorship handed verbally; not yet reflected in Aha)

**Adding a new area:** `mkdir product/<slug>/`, create `CLAUDE.md` mirroring `meeting-transcripts/CLAUDE.md` (epic, status, target, people, house rules), then add a one-line pointer here. Keep this section ≤10 lines.

## PRD round-trip rule
I iterate PRDs in **claude.ai chat** (using `prd-agentic` / `pmd-template` skills), then paste the generated `.prd.md` + `.prd.html` back into this repo. After any such session, run `/sync-prd <slug>` here to reconcile version, `INDEX.md` row, `agent-card.json`, and `§14 Decisions Log`. If I forget, the next daily digest's `📝 PRD DRIFT` block flags it. Confluence / Jira / Aha pushes are **manual by me** — never by Claude.

## Context: I am a new hire
- Started at Betterworks week of May 4, 2026
- See `ops/meeting-notes/2026-05-04-week-synthesis.md` for full first-week context
- Key manager/sponsor: Nellie Lemonier
- Key collaborators: Varnica (Meetings/Goals PM), Rinku (Integrations PM), Jason Bilyeu (JB, App Platform), Jason Zhang (AI/Data Platform)

## House rules
- Never hallucinate a metric definition; check `analytics/metrics-definitions.md` first
- For PRDs, run `/write-prd` (skill: `.claude/skills/prd-agentic/SKILL.md`). Markdown `.prd.md` is the source of truth; HTML is render-only for Confluence paste (via the underlying `pmd-template` skill — do not modify it).
- For stakeholder updates, follow `.claude/skills/stakeholder-update/SKILL.md`
- Subagent and tool defaults below — follow them

## Subagents
Spawn to isolate context, parallelize independent work, or offload bulk mechanical tasks. Don't spawn when the parent needs the reasoning or when spawn overhead dominates.
- Haiku: bulk mechanical work
- Sonnet: scoped research, file exploration, in-scope synthesis
- Opus: real planning or tradeoffs

Parent owns final output; subagent returns to parent if it realizes it needs a higher tier than itself. **Default rule (principle 4 in `.claude/context-design.md`):** any read >5 files or >2000 lines goes to a subagent.

## Preferred Tools

### Data fetching
1. WebFetch — free, text-only, public pages.
2. agent-browser CLI — for dynamic pages or auth walls. Returns the accessibility tree (~80%+ fewer tokens than screenshots). Install: `npm i -g agent-browser && agent-browser install`.
3. If you find yourself fetching the same source repeatedly, propose wrapping it as a named skill or script under `## Dedicated Tools` below.

### PDF files
Use `pdftotext`, not the `Read` tool. Read loads PDFs as images, which is expensive. Use Read only when explicitly analyzing images or charts inside the PDF.

## Dedicated Tools
<!-- Project-specific tools added over time. Link to skill or script files. -->
- **Aha! MCP** — connected. Use for initiative/feature/requirement lookups during PRD pre-flight (`/write-prd` Step 1).
- **Atlassian MCP** — connected. Use for Jira epic + child story enumeration during PRD pre-flight.
- **`prd-agentic` skill** (`.claude/skills/prd-agentic/`) wraps `pmd-template` to produce Markdown PRDs with stable IDs, EARS acceptance criteria, Constraints block, Definition of Done, and a sibling `agent-card.json` (A2A static v1).
- **`sense-backlog` skill** (`.claude/skills/sense-backlog/`) refreshes a release working ledger by pulling Aha + Jira + Confluence + Slack signal into `product/roadmap/<release>/signals/<feature>.md` (append-only), then regenerates `backlog-rank.md` and `jira-diff.md`. Strictly read-only against Jira/Aha — refinement-call policy in effect. Step 0 also surfaces cross-area items where Lalit is collaborator/watcher/mentioned outside the release.
- **`sync-prd` skill** (`.claude/skills/sync-prd/`) reconciles a PRD folder after a claude.ai chat iteration: checks md ↔ html ↔ `INDEX.md` ↔ `agent-card.json` ↔ §14 consistency, applies auto-fixes (patch version bump, html re-render, agent-card refresh, decision fan-out). Local-only — never pushes to Confluence/Jira/Aha. Trigger: `/sync-prd <slug>` after pasting PRD edits back, or when daily digest's `📝 PRD DRIFT` flags it.
- **`audit-context` skill** (`.claude/skills/audit-context/`) checks CLAUDE.md / memory / signal drift against `.claude/context-design.md` sizing rules. Writes findings to `analytics/context-audit/<YYYY-MM-DD>.md`. Trigger: `/audit-context` manually or wait for the monthly scheduled run.

## See `.claude/context-design.md`
Architecture (3 time-scales, 5 principles, sizing rules, hooks & routines), knowledge loop, decision journal, and routing-table maintenance details all live there. CLAUDE.md edits auto-log to `ops/claudemd-changelog.md` via `.claude/hooks/log-claudemd-change.sh`.
