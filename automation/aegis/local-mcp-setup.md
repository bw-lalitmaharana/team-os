# Local MCP connectors (Layer 2) — Aegis / local Claude Code

**Purpose.** Give a **locally-run** Claude Code session *and* the headless Aegis routines access to the external connectors (Calendar, Gmail, Slack, Jira, Zoom, Aha…) **without** claude.ai's managed OAuth. This is "Layer 2" of running local:

- **Layer 1** — skills / commands / `CLAUDE.md` / subagents / hooks — already works the moment you launch `claude` from the repo root. It's client-side; the model backend is irrelevant.
- **Layer 2 (this doc)** — the external connectors.
- **Layer 3** — routing the model to Ollama (`model-cost-map.md`, `model-lifecycle-and-eval.md`).

Why Layer 2 is a real gap, not a setting: the Slack/Gmail/Jira connectors in the claude.ai-hosted session are **claude.ai-managed** — OAuth'd in the cloud and injected for you. A Claude Code process on your Mac has none of them; it must reach those services through **its own MCP servers with its own credentials.**

---

## Two tiers (you will use both)

### Tier B — remote HTTP MCP (bootstrap; already wired)
`.mcp.json` already declares three vendor-hosted MCP endpoints:
```json
"atlassian": { "type": "http", "url": "https://mcp.atlassian.com/v1/mcp" },
"notion":    { "type": "http", "url": "https://mcp.notion.com/mcp" },
"slack":     { "type": "http", "url": "https://mcp.slack.com/mcp" }
```
- **To use (interactive only):** launch `claude` from the repo, run `/mcp`, authenticate each once in the browser. Claude Code caches the grant.
- **Good for:** immediate interactive use with gemma — zero code.
- **Limits:** (1) the OAuth is **interactive** — a launchd/headless routine has no browser, so this tier *cannot* serve unattended runs; (2) it **couples to hosted brokers** — your tool-args transit the vendor's MCP service — which `PLAN.md` §4 explicitly demotes to bootstrap/fallback. Keep it for convenience; don't build the OS on it.

### Tier A — local stdio MCP + Keychain injection (the durable target)
A local MCP server runs as a **subprocess**; a thin wrapper pulls the credential from the **macOS Keychain** and injects it into the subprocess environment at launch. The model only ever sees the server's **tool descriptions** — never the token (transport-layer injection, ADR decision #3). This is the **only** tier that serves **headless** routines, and it keeps credentials off hosted brokers.

```
.mcp.json ──► bash automation/aegis/mcp/<connector>.sh
                     │  security find-generic-password   (macOS Keychain)
                     ▼
              export TOKEN=…   exec <vetted MCP server>   ◄── speaks stdio MCP to the client
```
No secret ever touches `.mcp.json` (it's committed) or the model context.

---

## Secret types → handling

| Credential | Examples | Handling |
|---|---|---|
| **Static token / API key** | Atlassian API token, Aha key, Slack bot/user token, Zoom Server-to-Server | Store once in Keychain → wrapper injects as env var → `exec` server. Fully non-interactive → **headless-safe.** |
| **OAuth-refresh** | Google Calendar / Gmail / Drive | One-time 3-legged browser auth (temp local FastAPI redirect, `PLAN.md` §4); cache the **refresh token** (or client-creds JSON) in Keychain; the server refreshes the short-lived access token itself each run. |

---

## Keychain commands (macOS)
Store (interactive `-w` prompt keeps the secret out of shell history):
```
security add-generic-password -a "$USER" -s "aegis/google-calendar" -w -U
```
Read / rotate / remove:
```
security find-generic-password -a "$USER" -s "aegis/google-calendar" -w
security delete-generic-password -s "aegis/google-calendar"
```
Convention: service name = `aegis/<connector>`. The wrappers here read exactly these.

---

## Wrapper scripts (`automation/aegis/mcp/`)
- `_lib.sh` — `kc_get <service>`; fails loudly with the `add` command if the secret is missing; never echoes a secret.
- `gcal.sh` — worked **OAuth** example (Google Calendar).
- `jira.sh` — worked **static-token** example (a local alternative to the remote Atlassian entry, for headless use).
- `slack.sh` — worked **static-token** example (bot token; a local alternative to the remote Slack entry, for headless use).

Each wrapper has one line you must set — `MCP_<X>_CMD`, the actual MCP server command — left **empty on purpose** so the wrapper fails fast instead of running an unpinned package.

> ⚠️ **Supply-chain — read this before pointing a wrapper at any server.** An MCP server runs **with your real token**. Before you trust one: read its source, **pin a version** (never float `@latest`), prefer official/audited servers. A malicious or compromised MCP server is a straight credential-exfiltration path. This is the one place the local-first model can bite harder than the hosted tier — the token is on your machine, in that subprocess.

---

## Wire it into `.mcp.json`
Keep the three remote entries; add a stdio entry per local connector **once its wrapper + Keychain secret + server command are set up** (adding it before then just shows a failed server on launch):
```json
"google-calendar": {
  "command": "bash",
  "args": ["automation/aegis/mcp/gcal.sh"]
}
```
Launch `claude` from the repo root (the `args` path is relative to it). Claude Code prompts to **approve** project-scoped MCP servers on first load — that approval is itself a HITL gate; approve only wrappers you wrote.

---

## Which consumer uses which tier
| Consumer | Tier | Why |
|---|---|---|
| Interactive Claude Code (today) | **B** for Atlassian/Notion/Slack (`/mcp` auth); **A** as you migrate | fastest path now |
| Headless Aegis routines (launchd) | **A only** | no browser at run time → interactive OAuth impossible |

Migrate a connector B → A when its routine goes headless, or when you want its credentials off the hosted broker.

---

## Governance carries over unchanged
- **Jira/Aha WRITES stay double-gated** (host HITL **and** the refinement-window policy) regardless of tier. A local MCP server *exposing* a write tool does **not** relax this — Aegis calls only **read** tools live and **drafts** writes for a refinement session (`automation/CLAUDE.md`, `PLAN.md` §6). Reads unrestricted.
- Secrets stay in Keychain; the model never sees a token. Never commit a credential — `.gitignore` blocks the usual cached-cred paths, but the real guard is the wrapper pattern.

---

## Phase-0 spike (smallest end-to-end proof — matches `PLAN.md` §8)
1. Pick a vetted Google Calendar MCP server; set `MCP_GCAL_CMD` in `gcal.sh`.
2. One-time browser OAuth; store the refresh cred: `security add-generic-password -a "$USER" -s "aegis/google-calendar" -w -U`.
3. Add the `google-calendar` stdio block to `.mcp.json`.
4. `claude` from repo root → approve the server → ask *"what's on my calendar tomorrow?"*
5. Confirm gemma calls the tool and the token never appears in context. That's Layer 2 proven — and the same server is what Aegis Phase 0 calls headlessly.

---

### Sources
- Claude Code MCP (project `.mcp.json`, stdio + remote http, `/mcp` auth, approval prompt): https://docs.claude.com/en/docs/claude-code/mcp
- Model Context Protocol reference servers: https://github.com/modelcontextprotocol/servers
- Atlassian remote MCP server: https://www.atlassian.com/platform/remote-mcp-server
- macOS Keychain `security(1)`: https://ss64.com/osx/security.html
