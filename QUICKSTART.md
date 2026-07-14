# Quickstart — run team-os locally

`team-os` is a **Claude Code operating system**, not an app you build or serve. There's nothing to compile — the repo *is* the product. "Running it locally" means pointing the Claude Code CLI at a clone so the root `CLAUDE.md`, skills, commands, and hooks load automatically.

This guide gets you from zero to your first session in ~10 minutes. For what the OS *is* and how it's organized, read [`README.md`](README.md) after setup.

---

## Prerequisites

| Need | Why | Check |
|---|---|---|
| **Claude Code CLI** | The runtime that reads this repo | `claude --version` |
| **git** | Clone + the CLAUDE.md-changelog / signal-index hooks | `git --version` |
| **bash** | The four hooks in `.claude/hooks/` are bash scripts | `bash --version` |
| **A Claude account** | Anthropic API access for the CLI | — |

Optional (only for specific skills):

| Tool | Used by | Install |
|---|---|---|
| `pdftotext` (poppler) | `tldr-pdf`, PDF reads | `brew install poppler` / `apt install poppler-utils` |
| `agent-browser` | Dynamic / auth-walled page fetches | `npm i -g agent-browser && agent-browser install` |

If you don't have the CLI yet, install it first:

```bash
npm install -g @anthropic-ai/claude-code   # then authenticate
claude   # follow the login prompt on first run
```

---

## 1. Clone the repo

```bash
git clone https://github.com/bw-lalitmaharana/team-os.git
cd team-os
```

## 2. Launch Claude Code from the repo root

```bash
claude
```

On first launch from this directory, Claude Code automatically loads:

- **`CLAUDE.md`** — root routing, house rules, tool defaults (loaded every session).
- **`.claude/settings.json`** — model (`claude-opus`), `defaultMode: plan`, permissions, and the hook wiring. No action needed; it's checked in.
- **`.claude/skills/` + `.claude/commands/`** — all skills and slash commands (e.g. `/my-actions`, `/write-prd`) become available immediately. No install step.
- **`.claude/hooks/`** — four bash hooks fire on Read/Edit/Write (large-read warnings, CLAUDE.md changelog + size guard, signal-index regen). They're already executable.

> **Trust prompt:** the CLI will ask you to trust this folder's settings and hooks the first time. Approve it to enable the hooks.

## 3. Connect the integrations (MCP servers)

The repo ships `.mcp.json` with three HTTP MCP servers that require a one-time OAuth sign-in:

| Server | Used for |
|---|---|
| `atlassian` | Jira epics/stories + Confluence (PRD pre-flight, `/sense-backlog`) |
| `notion` | Notion docs |
| `slack` | Channel/thread signal, `/standup` |

Authorize them inside an interactive session:

```
/mcp        # lists the servers; run the OAuth flow for each
```

**Other connectors** referenced across the skills — Aha!, Gmail, Google Calendar/Drive, Zoom, Figma, Betterworks — are **claude.ai connectors**, not in `.mcp.json`. They're available in the hosted setup Lalit uses; to use them from a local CLI, add them via your own `claude mcp add` / connector settings. The core navigation, PRD, and context-audit workflows all run without them.

## 4. Your first session

Follow the workflow the OS is designed around:

```
cd product/meeting-transcripts/   # scope into the area you're working in,
claude                            #   so only that area's CLAUDE.md loads
/my-actions                       # surface open items before anything else
```

Common entry points:

| You want to… | Run |
|---|---|
| See what's on your plate | `/my-actions` |
| Debrief a meeting you just had | `/meeting-debrief <meeting-name>` |
| Draft a PRD | `/write-prd <slug>` (then `/prd-review` before sharing) |
| Prep release refinement | `/sense-backlog <release>` (e.g. `Summer 2026`) |
| Check for context/memory bloat | `/audit-context` |

---

## What you *don't* need to set up

- **No build, no server, no dependencies to install** for the core OS — it's Markdown + skills + hooks.
- **Scheduled routines** (morning-brief, day-end-sweep, zoom-signal-sweep, monthly-audit-context, …) run as **CCR triggers** in Lalit's hosted environment and commit artifacts to this repo. You don't run them locally; you read their output in `ops/daily/`, `ops/meeting-notes/`, and `signals/`.
- **`ops/routines-playbook.md`** is the original one-time hosted-setup file and is now historical — you don't need it for a local clone.

## Optional / advanced: the Aegis local runtime

`automation/` holds **Aegis**, a planned local agentic runtime (Ollama + LangGraph) meant to take over the routines from CCR. The build plan (`automation/aegis/PLAN.md`) is **approved but not yet built** — there's no runtime code to start today. If you're picking that up, start with `automation/CLAUDE.md` and `.claude/local-model-routines.md`.

---

## Where to go next

- [`README.md`](README.md) — the entry point: folder layout, architecture, active skills/hooks/routines.
- `CLAUDE.md` — the live routing surface every session reads.
- `.claude/context-design.md` — the architecture rationale (3 time-scales, 5 principles, sizing rules).
