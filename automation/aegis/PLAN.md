# Project Aegis — team-os rework plan (FOR REVIEW)

**Status:** **APPROVED — decisions locked 2026-07-07** (see `decisions/2026-07-07-aegis-local-agentic-os.md`; supersedes the §10 open decisions below). Reconciles **Aegis PRD v1.0** with team-os and the concept doc `.claude/local-model-routines.md`. Locked: one MoE reasoning engine · code in `automation/aegis/` · macOS Keychain · local SearXNG · Chainlit-only HITL · no direct writes without approval (Jira/Aha also refinement-gated). Next: Phase 0 (§8).

> **Refined 2026-07-20 — model roles + runtime (read before the model sections below).** The MoE-over-dense reasoning and the RAM math in §3 stand, but the specific bindings are now: **runtime = MLX** (Ollama 0.19 MLX backend, not llama.cpp); **resident generator = gemma4-26B-A4B MoE** (installed; gemma4-31B dense = high-stakes swap-in); **Qwen3-30B-A3B is retained as the cross-family eval judge, not the resident generator.** Where the sections below say "Qwen3-30B-A3B" / "30B-A3B" as the *reasoning engine* or "(Ollama, Q4_K_M)" as the *runtime*, read gemma4-26B-A4B on MLX. Authoritative: `automation/aegis/model-cost-map.md` (per-task map) + `automation/aegis/model-lifecycle-and-eval.md` (lifecycle + generator/judge assignment). ADR amended same date.

---

## 0. TL;DR — the one reconciliation that matters
**team-os and Aegis are two layers of one system, not competitors:**
- **team-os = long-term memory + governance** (git markdown: `signals/`, `decisions/`, `knowledge/`, `ops/`, auto-memory; the context-design principles; the refinement-write policy).
- **Aegis = the local runtime** (LangGraph + a resident MoE generator on MLX + Chainlit + local MCP) that *reads and writes* team-os. Aegis is the engine that operationalizes the concept already recorded in `.claude/local-model-routines.md`.

**Three flags before you build** (detail below): (1) the model/speed conflict — use the **MoE**, not a dense 27–32B; (2) Aegis **Jira/Aha writes must stay behind the existing refinement-call policy**, not just HITL; (3) the **vector DB is a derived index over team-os git markdown**, not a second source of truth.

---

## 1. Architecture map
```
                 ┌──────────────── Chainlit UI (localhost:8000) ───────────────┐
 you ───────────►│  live graph view · <thinking> debugger · HITL Approve/Reject │
                 └───────────────▲──────────────────────────────┬──────────────┘
 launchd (cron) ─── triggers ────┘                              │ approvals
                                 ▼                              ▼
                    ┌──────────────── LangGraph orchestrator ───────────────┐
                    │  state machine · ReAct loop · retries(5) · verify node │
                    └───▲───────────────▲──────────────────────▲────────────┘
             reason │             tools │                  memory │
                    ▼                   ▼                        ▼
        gemma4-26B-A4B MoE        local MCP servers        Chroma vector index
        (MLX; localhost:11434)    (Keychain-injected       (nomic-embed / bge-m3)
        one big model resident;   tokens; stdio subproc)   built FROM team-os md
        Qwen3-30B-A3B swaps in
        as judge; JSON-decode
                                          │                        ▲
                                          ▼                        │  rebuildable
                              Google / Slack / Jira / Zoom   team-os git (source of truth)
                              / local web-search MCP         signals · decisions · ops · memory
```

---

## 2. Fit against current team-os — what stays / changes / is new
| | Current team-os | Under Aegis |
|---|---|---|
| Knowledge/state | git markdown (signals/decisions/knowledge/ops/memory) | **Unchanged — stays source of truth.** Aegis reads/writes it. |
| Routines | CCR cloud agents (Claude) via `/schedule` | **Migrated to local LangGraph nodes** (Ollama). CCR = per-routine fallback until golden-eval passes. |
| Concept doc | `.claude/local-model-routines.md` (parity-via-harness) | **Extended** with the Aegis stack decisions; Auth section corrected (below). |
| Retrieval | grep / read on demand | **New:** Chroma vector index derived from the same markdown. |
| Approvals | focus routine's "reply in Slack to create" | **New:** Chainlit HITL for destructive tools (+ optional Slack mirror). |
| UI | none (files only) | **New:** Chainlit at `localhost:8000`. |
| Secrets | claude.ai-managed connector OAuth | **New:** macOS Keychain + local 3-legged OAuth. |
| Code | none (docs only) | **New:** `automation/aegis/` runtime (or a sibling repo — open decision). |

---

## 3. Tech-stack review (the expert pass)

### 3.1 Reasoning engine — CHANGE the PRD's pick
The PRD wants **~30B quality at 35–45 tok/s on an M4 Pro**. On 273 GB/s memory bandwidth those two goals are mutually exclusive for a **dense** model (token-gen is bandwidth-bound: dense-32B-Q4 ≈ 10–15 tok/s here; M4 *Max* only manages ~24). Resolution:

| Option | ~tok/s (M4 Pro) | RAM | Verdict |
|---|---|---|---|
| **Qwen3-30B-A3B (MoE, 3.3B active) Q4_K_M** | **~40** | ~17–18 GB | **Recommended — hits both targets** |
| Dense 32B Q4_K_M | ~12–15 | ~18–20 GB | Best raw quality; **misses speed target** |
| 14B Q4 | ~25–35 | ~9 GB | Fast/cheap; weaker synthesis (Tier-1 only) |

**Action:** adopt an **MoE** reasoning engine (the analysis above is architecture-level and holds for any ~30B-class MoE). **Refined 2026-07-20:** the resident generator is now **gemma4-26B-A4B MoE** (installed, ~18 GB, ~30–56 tok/s) with **gemma4-31B dense** as the high-stakes swap-in; **Qwen3-30B-A3B is retained but repurposed as the cross-family eval judge** (see banner + `model-lifecycle-and-eval.md`). Keep a dense model available for offline/high-stakes synthesis where latency doesn't matter. Runtime is MLX (Ollama 0.19 MLX backend) — confirm the model resolves on the MLX path, not llama.cpp.

### 3.2 RAM budget (<24 GB) — feasible with one rule
30B-A3B (~18 GB) + 16k KV (~1–2 GB) + embed model (~0.5 GB) + Python/LangGraph/Chainlit/Chroma (~1–2 GB) ≈ **21–23 GB**. Fits — **but only if exactly one large model is resident at a time.** The rule forbids **co-residency** (two big models loaded simultaneously), **not** using a different model: a different judge/synth model is loaded **serially** by *evicting* the current one first (set `OLLAMA_MAX_LOADED_MODELS=1` so Ollama auto-evicts LRU before loading the next). Only the small embed model stays co-resident. Tune Ollama `keep_alive` / unload the reasoner when idle to protect the 24 GB ceiling during design-tool/browser multitasking. Zero-swap is achievable; make it a monitored metric, not an assumption. **Serial hot-swap + the cross-model eval it enables are specced in `automation/aegis/model-lifecycle-and-eval.md`.**

### 3.3 Orchestration — LangGraph is fine, but honor the parity thesis
LangGraph earns its weight for **state + HITL + persistence + retries**. Caveat from `.claude/local-model-routines.md`: **don't let the model do what code can.** Keep nodes deterministic where possible (Engine A: date math, dedup, formatting, git); reserve the ReAct/tool-loop for genuinely fuzzy steps; force **JSON-constrained decoding** (Ollama `format`/grammar) on every structured output; keep a **golden-eval** per routine. The PRD's 5-retry + verify node is exactly the right shape.

---

## 4. Security & auth — adopt the PRD model, demote last-week's shortcut
The PRD's **local-MCP-server + Keychain + transport-layer token injection ("Interceptor")** is the correct primary design and matches the local-first objective: the LLM only ever sees tool descriptions, never tokens.

- **Primary:** run local MCP servers as subprocesses; `langchain-mcp-adapters` injects the Keychain token as an env var per server. 3-legged OAuth handled by a temporary local FastAPI redirect handler (Slack, Jira, Google).
- **Demoted (was my prior suggestion):** reusing the claude.ai-authenticated *remote* connectors via local re-OAuth. Keep this only as a **bootstrap spike / fallback** for connectors lacking a mature local MCP server (likely **Zoom, Aha**).
- **"Zero data leakage" — stated precisely:** going local removes leakage to **LLM providers** (no prompts/content to Anthropic/OpenAI). It does **not** mean zero network — calendar/Slack/Jira calls still hit those vendors (that's where the data lives), and deep-research queries still hit the internet/search backend. Scope the claim to *inference privacy*, and prefer a **local SearXNG** for search to minimize even query leakage.

---

## 5. Memory & synthesis — reconcile Chroma with the git knowledge loop
The PRD adds a ChromaDB vector store. To avoid two competing memories:
- **Source of truth stays git markdown** (`signals/`, `decisions/`, auto-memory). Structured JSON synthesis is **written there first** (append-only signals; ADRs for decisions), preserving auditability (git history) and the context-design principles.
- **Chroma is a derived, disposable retrieval index** built from that markdown (+ transcripts), embedded via `nomic-embed-text`/`bge-m3`, **rebuildable from git** at any time. "What did we decide about the auth flow last week?" → retrieve from Chroma → cite the underlying `decisions/…md`.
- **"Key Events" / "marking key events"** map onto existing `decisions/` ADRs + `signals/` + memory events — not a new store. Reuse the routine-spec + a memory-event JSON schema.

---

## 6. Governance reconciliation (do not skip)
team-os house rule (root `CLAUDE.md`; `process_rules` memory): **no Jira/Aha writes outside refinement calls.** This constrains Aegis Epic 1 & 3:
- **Jira/Aha READS** (sweeps, digests, epic mapping) — fine, unrestricted.
- **Jira/Aha WRITES** (`update_jira_ticket`, Aha edits) — gated by **BOTH** Chainlit HITL **AND** the refinement-window policy. Aegis **prepares/stages** the change and drafts it; the live system write happens **in a refinement session**, not autonomously. Encode this as a hard guard, not a prompt suggestion.
- **Calendar / Slack-to-self / local file / git writes** — allowed (personal surface), still HITL for destructive calendar ops.
- **Autonomy ceiling:** Epic 4 "self-upgrade / harness review" is **propose-only** (opens a PR / writes a suggestion), never self-edits code or prompts autonomously. Dynamic MCP-schema refresh (hot-reload tool lists) is fine — that's low-risk.
- **Every action → audit log** in `ops/aegis/audit/<date>.md` (tool, args-redacted, approval, result).

---

## 7. Per-routine mapping (your current personal-OS routines → Aegis)
Model = **generator** (resident). Judge column added — judge family ≠ generator family; full assignment in `model-lifecycle-and-eval.md` §5.
| Routine | Epic | Engine/Tier | Generator | Judge (≠ family) | HITL | Governance | Output |
|---|---|---|---|---|---|---|---|
| Focus / block calendar | 3 | A+B / 1 | gemma4-26B | Qwen (or vote) | yes (create) | personal | `ops/focus/tracker.md` + events |
| Slack DM sweep | 1 | A+B / 1 | gemma4-26B | Qwen (or vote) | no (read) | — | `ops/daily/<date>.md` |
| Jira sweep | 1 | A+B / 1–2 | gemma4-26B | Qwen | read-only | read-only | `ops/daily/<date>.md` |
| Meeting-transcript fetch → synth | 1+2 | A+B/C / 2 | gemma4-26B | Qwen | no | append-only | `signals/…`, `decisions/…`, Chroma |
| Synthesis → memory events/logs | 2 | B/C / 2 | gemma4-26B | Qwen | no | append-only | memory + Chroma |
| Marking key events | 2 | A+B / 1 | gemma4-26B | vote (self-consistency) | no | append-only | `decisions/…` |
| Task manager | 3 | A(+B) / 1 | gemma4-26B | Qwen | on writes | personal | `ops/…` |
| Deep research (internet) | 3 | C / 3 | gemma4-26B (+gemma4-31B synth) | Qwen; Claude if high-stakes | no | local search | `product/**/research` |
| Daily/weekly Slack delivery | 3 | A+B / 1 | gemma4-26B | Qwen | no | — | Slack self-DM |
| Harness review | 4 | C / 3 | gemma4-31B / Claude | **Claude** + human | **PR = HITL** | propose-only | PR |
| Upgrade agentic OS (meta) | 4 | C / 3 | Claude/human (frontier residual) | **Claude** + human | **PR = HITL** | propose-only | PR |

---

## 8. Phased build (lowest risk first; CCR twin stays fallback per routine)
- **Phase 0 — Foundation:** Ollama 0.19 (MLX backend) + gemma4-26B-A4B resident, `OLLAMA_MAX_LOADED_MODELS=1`, Qwen3-30B-A3B pullable as judge; the model-lifecycle switcher (`with_model` acquire→evict→load); LangGraph skeleton + persistent state; Chainlit; Keychain + FastAPI OAuth for **one** connector (Google Calendar) as the **auth spike**; Chroma + embeddings; a golden-eval harness. *Exit:* one read routine end-to-end + a clean generator→judge swap + **8h zero-swap** verified via `vm_stat`.
- **Phase 1 — Read routines (Tier-1, no writes):** Slack DM sweep, Jira sweep, daily/weekly digest, calendar read. Run alongside CCR.
- **Phase 2 — Execution + HITL:** calendar blocking (HITL) → port the focus routine; Jira/Aha *prepare* (HITL + refinement gate). Flip focus CCR→fallback after its golden-eval passes.
- **Phase 3 — Memory & synthesis:** transcript fetch → JSON → git + Chroma; key-event marking; retrieval Q&A.
- **Phase 4 — Frontier:** deep research (local search MCP), harness review, self-upgrade — all propose-only / HITL, Claude/human checkpoint retained.

One routine flips CCR→local at a time; never both engines live for the same routine (double-posting).

---

## 9. Success metrics — with honest measurement
| PRD metric | Target | How we prove it (don't assume) |
|---|---|---|
| Tool-calling accuracy | >95% first-pass | golden-eval suite per routine; JSON-grammar + 5-retry. Realistic with gemma4-26B-A4B, but **measure** — treat 95% as a gate, not a given. |
| Zero-swap | 8h workday | `vm_stat`/memory-pressure monitor; enforce one-big-model + keep-alive. |
| Time saved | ≥5 h/week | routine run-logs + a manual weekly tally to start. |

---

## 10. Open decisions for you
1. **Reasoning model:** ~~Qwen3-30B-A3B MoE~~ **Resolved 2026-07-20 — resident generator = gemma4-26B-A4B MoE (installed); gemma4-31B dense = high-stakes swap-in; Qwen3-30B-A3B repurposed as the cross-family judge.** Runtime = MLX. See `model-cost-map.md` + `model-lifecycle-and-eval.md`.
2. **Where the code lives:** `automation/aegis/` in *this* repo, or a sibling repo (team-os stays docs/state only).
3. **Secrets:** macOS Keychain (simplest) vs Bitwarden CLI (`bw`).
4. **Web search backend:** local **SearXNG** (max privacy) vs a hosted search API (faster, minor query leakage).
5. **HITL channel:** Chainlit-only (needs the UI open) vs **also mirror approvals to Slack** (better for a background OS when you're away). Recommend the Slack mirror.
6. **Jira/Aha writes:** confirm they stay **refinement-gated** (Aegis prepares only). Assumed yes.

---

## 11. What lands in team-os once you approve
- Formalize the **`automation/`** area: `automation/CLAUDE.md` (≤40 lines) + a one-line pointer in root `CLAUDE.md`; `automation/aegis/` runtime + per-routine specs carrying the `engine/tier/model/verify` frontmatter from `.claude/local-model-routines.md`.
- **Update `.claude/local-model-routines.md`:** fold in the Aegis stack (LangGraph/Chainlit/MLX + gemma4-26B generator + Qwen judge/Keychain), correct the **Auth** section to local-MCP-primary, and record the speed/model finding.
- **Decision log:** `decisions/2026-07-07-aegis-local-agentic-os.md` (MoE-over-dense rationale, refinement-gated writes, Chroma-as-derived-index).
- This `PLAN.md` is the reference until the area is formalized.

---

### Sources (hardware/model reconciliation)
- Apple-silicon LLM tok/s by chip/model (2026): https://llmcheck.net/benchmarks · https://insiderllm.com/guides/best-local-llms-mac-2026/ · https://willitrunai.com/macs/m4-pro-48gb
- Qwen3-30B-A3B MoE efficiency (~30B quality at 3–4B speed): https://www.aimagicx.com/blog/local-ai-models-2026-qwen-mistral-llama-hardware-guide · https://codersera.com/blog/run-qwen3-vl-30b-a3b-thinking-on-macos-installation-guide/
