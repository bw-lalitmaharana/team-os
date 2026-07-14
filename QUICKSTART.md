# Quickstart — build your own team-os (without inheriting mine)

`team-os` is a **Claude Code operating system**, not an app you build or serve. There's nothing to compile — the repo *is* the product. "Running it" means pointing the Claude Code CLI at a folder so the root `CLAUDE.md`, skills, commands, and hooks load automatically.

> ⚠️ **This repo is a live personal workspace.** It contains real meeting notes, names, emails, Jira/Aha keys, Slack IDs, roadmap signals, and decision records. **Do not clone it and republish it as your own** — you'd be redistributing someone else's PII and company-confidential data. Cloning is fine for *teammates who already have access* to this data; it is **not** the way to "build the same system" for yourself.
>
> To stand up the *same system* with *your own* data, use the scaffold path below. It copies the reusable framework and leaves every content folder empty.

---

## The mental model: three layers

| Layer | Examples | Safe to reuse? |
|---|---|---|
| **Clean framework** | `.claude/hooks/`, `.claude/settings.json`, `.claude/context-design.md`, `.mcp.json`, the generic commands (`/standup`, `/write-prd`, `/prd-review`, `/spec-review`) and the `tldr-pdf` skill | ✅ Copy as-is |
| **Contaminated framework** | Root `CLAUDE.md` (my name/manager/epics), `prd-agentic`/`sync-prd`/`sense-backlog`/`meeting-to-tasks`/`audit-context` skills, the routine commands (`daily-meeting-extract`, `zoom-signal-sweep`) — real names, emails, `trig_…`/`env_…`/Slack IDs, and my macOS username baked in | ⚠️ Reusable logic, but **scrub before use** |
| **Personal content** | `ops/`, `decisions/`, `product/`, `team/`, `knowledge/`, `analytics/` — entirely my data | ❌ Never copy — recreate empty |

The scaffold generator handles the first and third layers automatically and gives you a **clean-by-construction** starting point. You opt into the second layer one file at a time.

---

## Prerequisites

| Need | Why | Check |
|---|---|---|
| **Claude Code CLI** | The runtime that reads your OS | `claude --version` |
| **git** | Version control + the changelog / signal-index hooks | `git --version` |
| **bash** | The four hooks in `.claude/hooks/` are bash scripts | `bash --version` |
| **A Claude account** | Anthropic API access for the CLI | — |

Optional, only for specific skills: `pdftotext` (poppler) for `tldr-pdf`/PDF reads; `agent-browser` (`npm i -g agent-browser && agent-browser install`) for dynamic/auth-walled fetches.

If you don't have the CLI: `npm install -g @anthropic-ai/claude-code`, then run `claude` once to authenticate.

---

## 1. Generate a clean skeleton

From a checkout of this repo (or a teammate's), run the generator with a fresh target path **outside** this repo:

```bash
./scripts/new-team-os.sh ../my-team-os
```

It copies only the verified-clean framework files, creates the content folders empty with placeholder `CLAUDE.md` files, writes a templated root `CLAUDE.md` full of `<PLACEHOLDER>` tokens, and drops in the PII scanner. No meeting notes, PRDs, decisions, roster, or signals come along.

## 2. Verify it's clean

```bash
cd ../my-team-os
./scripts/scan-pii.sh .
```

Expect `CLEAN — no known PII markers found.` This scanner greps for the specific markers known to appear in the source (names, emails, company, Jira/Aha keys, `trig_`/`env_`/Slack IDs, absolute user paths). **Run it before you ever push or publish your copy.** It's a heuristic that errs toward over-flagging — review every hit and confirm it's generic or intentionally yours.

## 3. Make it yours

```bash
git init
claude
```

Fill in the `<PLACEHOLDER>` tokens in the root `CLAUDE.md` (your name, company, focus areas, collaborators) and in each area's `CLAUDE.md`. Read `.claude/context-design.md` once — it's the architecture the whole OS is built on, and it's generic. Then start adding *your* content: create `product/<area>/`, log decisions to `decisions/`, etc.

## 4. Connect your integrations (MCP)

The scaffold ships `.mcp.json` with three HTTP MCP servers that need a one-time OAuth sign-in — swap them for whatever your team uses:

| Server | Used for |
|---|---|
| `atlassian` | Jira + Confluence |
| `notion` | Notion docs |
| `slack` | Channel/thread signal, `/standup` |

Authorize inside a session with `/mcp`. Add or remove servers to match your stack. (Other connectors the skills mention — Aha!, Gmail, Google, Zoom, Figma — are yours to wire up; nothing about them is inherited.)

## 5. Add the advanced skills (opt-in, scrub each)

The powerful skills — `prd-agentic`, `sync-prd`, `sense-backlog`, `meeting-to-tasks`, `audit-context` — carry reusable logic but have my specifics baked in. **Don't bulk-copy `.claude/skills/`.** Port them one at a time:

1. Copy the one skill folder into your `.claude/skills/`.
2. Scrub it: replace `Betterworks` → your company, real names → roles/placeholders, `@betterworks.com` emails → yours, `ENG-####`/`APP-###` → `<JIRA-KEY>`, and any `-Users-<username>` / `trig_…` / `env_…` / Slack IDs with your own or a placeholder.
3. Run `./scripts/scan-pii.sh .claude/skills/<name>` until it's `CLEAN`.
4. Repeat.

The routine commands (`daily-meeting-extract`, `zoom-signal-sweep`) are the *most* personalized — they hardcode a trigger ID, env ID, Slack DM ID, and personal names. Treat them as patterns to rewrite from scratch, not files to copy.

---

## What you *don't* need to set up

- **No build, no server, no dependencies** for the core OS — it's Markdown + skills + hooks.
- **Scheduled routines** (morning-brief, day-end-sweep, etc.) run as hosted **CCR triggers** in *my* environment and commit to *my* repo. You'd register your own triggers against your own repo; none of mine carry over.
- **The Aegis local runtime** (`automation/`) is an approved-but-not-yet-built plan. If you want to explore it, read `automation/CLAUDE.md` and `.claude/local-model-routines.md` — but there's no runtime code to start today.

## Where to go next

- [`README.md`](README.md) — folder layout, architecture, active skills/hooks/routines.
- `.claude/context-design.md` — the generic architecture rationale (3 time-scales, 5 principles, sizing rules).
- `scripts/scan-pii.sh` / `scripts/new-team-os.sh` — the sanitization + scaffold tools this guide relies on.
