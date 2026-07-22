# Local model routing (Layer 3) — interactive Claude Code → Ollama

**Purpose.** Point your **interactive** Claude Code CLI at the local models (gemma4-26B resident, Qwen swap-in) instead of the cloud API — with **per-task escalation** back to Claude for the frontier residual. This is "Layer 3" for the CLI you type at.

- **Layer 1** — skills / commands / `CLAUDE.md` / subagents / hooks (client-side; model-agnostic).
- **Layer 2** — connectors (`local-mcp-setup.md`).
- **Layer 3 (this doc)** — the model backend.

> **Two faces of Layer 3 — don't merge them.**
> - **Headless Aegis routines** route to Ollama through the Python **model-router + `with_model` switcher** — already specced in `model-cost-map.md` (per-task map) and `model-lifecycle-and-eval.md` (serial hot-swap + eval). Nothing to add there.
> - **Interactive Claude Code** (modes 1/2 from our earlier split) needs its *own* routing, because the CLI speaks the Anthropic Messages API and Ollama speaks OpenAI `/v1`. **That gap is what this doc fills.** Same models, same `localhost:11434` — different consumer.

> ⚠️ **Naming collision.** Everywhere else in team-os, **"CCR" = the cloud agent runtime** (the thing we're migrating *off*). The tool in this doc is **`claude-code-router`** (its own CLI is `ccr`, and upstream nicknames it "CCR" too). They are unrelated. This doc always spells out **claude-code-router**; if you see bare "CCR" in the rest of the repo, that's still the cloud runtime.

---

## Three ways to route, simplest → most capable

| # | Method | What you get | Use when |
|---|---|---|---|
| 1 | **`ollama launch claude --model gemma4:26b-mlx`** | All-gemma, zero config. No escalation — every request hits the local model. | Quick pure-local session; you already tried this. |
| 2 | **`ANTHROPIC_BASE_URL`** → a local OpenAI-format bridge | One backend for the whole session; blunt (no per-request routing). | You just want a single non-Claude backend and nothing fancier. |
| 3 | **`claude-code-router`** *(recommended)* | **Per-task routing:** bulk on gemma (free), frontier residual on Claude. One config, both engines. | Day-to-day mode-2 work where some steps need real Claude. |

Method 3 is the one that makes the **parity split mechanical** — it's the interactive twin of the cost-map's per-routine table.

---

## The routing (calibrated to the model story)

`claude-code-router` routes by **request shape**, not by which team-os command you ran. The four rules, mapped to the locked envelope (`<24 GB RAM, 16k ctx, no swap`, `decisions/2026-07-07`):

| Rule | Routes to | Why |
|---|---|---|
| `default` | `ollama,gemma4:26b-mlx` | Bulk interactive work → the resident MoE. **Zero marginal cost.** |
| `background` | `ollama,gemma4:26b-mlx` | Title/summary/compaction chatter → the **same resident model**. Deliberately *not* a second small model — a 2nd resident costs RAM + a cold-start (one-big-model-resident rule). |
| `think` | `anthropic,<claude>` | Plan-mode / extended reasoning = the **frontier residual** the parity thesis keeps on Claude. |
| `longContext` (> `longContextThreshold`) | `anthropic,<claude>` | Beyond the **16k no-swap ceiling**, local can't hold the context without paging (40 → ~2 tok/s under swap). Escalate to Claude's large context instead. |

Two deliberate choices worth calling out:

- **`longContextThreshold: 16000`**, not the tool's default 60000 — it's pinned to *your* no-swap context budget. Past 16k, staying local would force swap; the router hands off before that.
- **`think`/`longContext` → Claude, not Qwen.** Locally, routing `think` to Qwen would evict gemma on *every* plan-mode toggle and reload it after — the exact per-item ping-pong `model-lifecycle-and-eval.md` §3.4 forbids (≈15 s each way). Interactive sessions want gemma **continuously resident**; send the rare frontier step to the cloud. (Qwen's local role is the **batch eval judge** for headless runs, where one swap per run amortizes — not interactive turn-by-turn.)

Net: gemma resident carries `default` + `background` at ~zero cost; Claude takes only `think` + `longContext` — the two places local genuinely loses (frontier reasoning + context over the RAM ceiling). Same split the cost-map draws, made automatic.

---

## Setup

```bash
npm i -g @musistudio/claude-code-router      # provides the `ccr` CLI
mkdir -p ~/.claude-code-router
cp automation/aegis/claude-code-router.config.template.json ~/.claude-code-router/config.json
```

Then edit `~/.claude-code-router/config.json`:
1. Replace `YOUR_CLAUDE_MODEL_ID` (both places) with the exact Claude model IDs you want for `think`/`longContext` (a current Opus for max quality, or a Sonnet to trade quality for cost).
2. Confirm the Ollama model tags match `ollama list` — the template assumes `gemma4:26b-mlx` and `qwen3:30b-a3b`.
3. **Do not put your Anthropic key in the file.** The template reads `$ANTHROPIC_API_KEY` from the environment — export it in your shell profile, ideally sourced from the Keychain (same discipline as Layer 2):
   ```bash
   export ANTHROPIC_API_KEY="$(security find-generic-password -a "$USER" -s "aegis/anthropic-api-key" -w)"
   ```

Run Claude Code **through the router**, from the repo root (so Layers 1 + 2 load):
```bash
ccr code            # launches Claude Code with the router as its backend
```

**Runtime override** — force one hard task to Claude (or any provider,model) mid-session without editing config:
```
/model anthropic,YOUR_CLAUDE_MODEL_ID     # this turn onward
/model ollama,gemma4:26b-mlx              # back to local
```

> **Version note.** Recent `claude-code-router` is migrating config to SQLite + a `ccr ui` config UI; `config.json` is still read and **imported once** on first run when no SQLite config exists. If the template doesn't take effect, run `ccr ui` and set the same Providers/Router there. Field names have shifted across releases — verify against your installed `ccr -v`. Qwen3 emits `<think>` blocks; if they leak into output, add a thinking-stripping transformer to the `ollama` provider (see the project README).

---

## Secret discipline (unchanged from Layer 2)
- The Anthropic key is an **env var** (`$ANTHROPIC_API_KEY`), never committed. Source it from the Keychain.
- The committed file here is a **`.template.json`** with placeholders only. A real `~/.claude-code-router/config.json` lives outside the repo; if you ever copy one in, `.gitignore` blocks the non-template name.

## Governance (unchanged by routing)
Routing the model changes *who computes*, not *what's allowed*. Jira/Aha writes stay double-gated; frontier reasoning keeps its Claude/human checkpoint; secrets stay in Keychain (`automation/CLAUDE.md`, `PLAN.md` §6). Routing `think` to Claude is a **quality** escalation, not a governance bypass.

## Verify
1. `ccr code` from repo root → `/status` shows the router backend.
2. Ask something trivial → `ollama ps` shows `gemma4:26b-mlx` resident and serving `default`.
3. Enter plan mode (a `think` request) → confirm it routes to `anthropic` (watch `ccr` logs / your Anthropic usage), and `ollama ps` still shows gemma **resident, not evicted** — proof there's no interactive swap.
4. Paste a >16k-token file → confirm `longContext` escalates to Claude rather than paging locally (`vm_stat` stays zero-swap).

---

### Sources
- claude-code-router (config.json, Providers/Router, `ccr code`, `/model`): https://github.com/musistudio/claude-code-router
- Router rules + Ollama provider walkthrough: https://www.morphllm.com/claude-code-router · https://polyskill.ai/blog/claude-code-router
- Claude Code + local Ollama fallback config reference: https://github.com/andersondario/claude-code-fallback-to-local-ollama
- Serial-residency / no-swap rationale: `automation/aegis/model-lifecycle-and-eval.md` §3.4 · `decisions/2026-07-07-aegis-local-agentic-os.md`
