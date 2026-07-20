# Local-model cost map — which model per task, and why

**Purpose.** A per-task recommendation of which locally-hosted model to run each team-os routine, command, LLM-skill, and hook on — chosen to **cut cost** while holding Claude-parity output. Companion to `.claude/local-model-routines.md` (the parity concept) and `automation/aegis/PLAN.md` (the runtime). This file is a **study / recommendation** — it changes no routine and pushes nothing. Verify tags and measure parity (§5) before flipping anything.

Hardware assumed throughout: **M4 Pro / 48 GB**, budget **<24 GB RAM, 16k ctx, no swap** — the envelope locked in `decisions/2026-07-07-aegis-local-agentic-os.md`. Runtime is **MLX** (see §2), reflecting the model already installed locally: **`gemma4 26B` (the 26B-A4B MoE)**.

---

## 1. Where the cost actually is (read this first)

The dollar cost today is **CCR / Claude cloud tokens** — every routine, command, and skill runs there. So:

- **The saving is CCR → local.** Once a task runs on the resident local model, its marginal API cost is **~zero**. That is the win, and it is the same win regardless of *which* local model serves the task.
- **Per-task model choice trades RAM & latency, not dollars.** On this box only **one large model can be resident** (`PLAN.md:66-67`). So "which model per task" is really "can I serve this on the one model I already have warm, or must I escalate?" — a budget/latency question, with a small residual that stays on Claude for quality.

**Consequence:** the cheapest correct default is to run **as many tasks as possible on the single resident model**, because it is already loaded — extra tasks on it cost no extra RAM and no cold-start. Pulling a second model to "optimize" a task usually *costs* you (RAM + swap risk), it doesn't save. **You already have that resident model: `gemma4 26B` MoE — use it.**

---

## 2. Runtime: MLX (and how it reconciles with the Aegis plan's Ollama assumptions)

The Aegis plan (`PLAN.md`, `local-model-routines.md`) assumes **Ollama** (`localhost:11434`, OpenAI `/v1`, native `format` for JSON-constrained decoding, `keep_alive`). You run **MLX**. These are no longer either/or:

- **Recommended — Ollama 0.19 on the MLX backend** (`OLLAMA_BACKEND=mlx`). Ollama 0.19 (Mar 2026) replaced its Metal backend with **MLX** on Apple Silicon (Macs ≥32 GB), ~1.6–2× faster. You get **MLX compute speed** *and* keep native JSON `format`, `keep_alive`, and the `/v1` endpoint the plan already targets — so **no rewrite of the Aegis integration is needed.** MLX-quantized builds are pulled automatically when they exist (from `mlx-community`); GGUF-only models fall back to llama.cpp.
- **Alternative — pure `mlx-lm` / LM Studio.** `mlx_lm.server` exposes an OpenAI-compatible endpoint, but you **lose native `format`** — JSON-schema-constrained decoding then comes via **Outlines' MLX backend** (schema → constrained sampling; ~50–200 ms first-schema compile, cached after). Choose this only if you want to stay off Ollama entirely; it means adding Outlines and reworking the plan's structured-output path.

Either way the parity harness (§5) is unchanged. **Recommendation: Ollama-0.19-on-MLX** — least disruptive, keeps the plan intact, gives you MLX speed.

---

## 3. Recommended lean roster (what to run)

| Model | Role | Resident? | RAM (MLX 4-bit) | Serves |
|---|---|---|---|---|
| **gemma4 26B-A4B MoE** *(already installed)* | Workhorse reasoner | **Yes — the one big model** | ~18 GB | Tier-1 mechanical **and** Tier-2 synthesis — nearly every routine |
| **bge-m3** *(or `nomic-embed-text-v2`)* | Embeddings / RAG grounding | Yes, co-resident | ~2 GB | Chroma retrieval; serve via Ollama (GPU auto) — MLX-native embedding support is still immature |
| **gemma4 31B dense** | Offline high-stakes synthesis | **No — swap in on demand** | ~19–22 GB | Tier-3 deep-research synthesis, harness review (latency-insensitive, max quality) |
| **Claude + human** | Frontier checkpoint | n/a | — | PRD authorship, harness self-review, OS self-upgrade — until golden-eval proves parity |
| **Qwen3-30B-A3B MoE** | **Cross-family eval judge** (§5) | **No — swap in for eval** | ~17–18 GB | Judges gemma4 output (different family — self-judging is biased); also the A/B generator candidate. Never co-resident with gemma4 |

**Speed on your box:** gemma4-26B-A4B at MLX 4-bit reports **~30–56 tok/s on M4 Pro 48 GB** (varies with context length and other apps) — the MoE activates only ~3.8B of 26B params per token, which is why a "26B" fits ~18 GB and runs fast. **Measure it on your machine** before setting expectations; treat published numbers as a range, not a promise.

**Commit to one embedding model** — bge-m3 and nomic vectors live in different spaces and aren't comparable; switching means a full re-index.

**Hosting many, one resident at a time.** These models don't co-reside — the OS keeps **one big model resident** and swaps as needed (evict, then load). That serial hot-swap is what lets a **different model judge the generator's output** (§5). Mechanism, literacy table, and per-routine generator/judge assignment: **`automation/aegis/model-lifecycle-and-eval.md`**.

#### Why 26B-A4B MoE resident, not 31B dense
| | **26B-A4B (MoE)** — installed | **31B dense** |
|---|---|---|
| Active params/token | ~3.8B of 26B | all ~31B |
| RAM (MLX 4-bit) | ~18 GB — fits <24 GB with headroom | ~19–22 GB — at the ceiling, little room for KV cache at 16k ctx |
| Speed | ~30–56 tok/s | ~2–4× slower (dense fires every param/token) |
| Quality | strong on scoped synthesis/extract/classify | higher ceiling on long-chain, open-ended reasoning |
| Fit | **always-resident workhorse** | **on-demand swap-in only** |

The MoE buys speed **and** RAM by activating a slice of weights per token — which is exactly why it's the right always-on default. 31B dense spends its whole budget every token, so you pay the latency and sit at the top of the RAM ceiling for a gain that **only shows on the frontier residual** (deep-research synth, harness review) — not the Tier-1/2 work that is ~95% of the cost surface. Two big models can't co-reside, so 31B always means **evicting 26B first** (a cold-swap). Reserve it for latency-insensitive Tier-3 jobs, and even there let the golden-eval (§5) decide whether 31B beats **26B + a verify pass** before accepting the cost.

### Reconciliation with the repo's older roster *(now applied)*
- `local-model-routines.md`'s roster **has been updated** (2026-07-20) to name gemma4-26B-A4B as the resident generator; it previously filed "gemma4 (installed)" as a Tier-1 small extract/classify model, which understated it — the installed model is the **26B-A4B MoE**, a Tier-2-capable *synthesis* reasoner and the resident workhorse.
- The ADR's dense-vs-MoE deliberation (`PLAN.md:56-64`) is **moot for the generator slot**: gemma4-26B is *already* an MoE, so it satisfies the speed **and** RAM budgets simultaneously — the exact property the ADR chose Qwen3-30B-A3B for. Qwen isn't needed as the *generator* — but it **is** retained as the **cross-family eval judge** (§5): gemma can't reliably judge its own family's output, so Qwen swaps in to grade it. Pull Qwen for that role, not as a second generator. (ADR amended 2026-07-20 to record this.)
- The old 7B/32B/72B ladder is now **superseded** in `local-model-routines.md`: you can't hold multiple big models resident, and a separate 7B would just add ~5 GB + a cold-start for work the warm MoE does for free. The *tiering idea* (route by difficulty) is kept; the *multi-big-model* implementation is dropped.

---

## 4. Per-task map (every routine, command, LLM-skill, hook)

Engine key (`local-model-routines.md:11-14`): **A** = deterministic, no LLM · **B** = scoped local LLM call (JSON-constrained) · **C** = code-orchestrated reasoning pipeline. "Resident model" below = **gemma4 26B-A4B MoE**.

### 4a. Hooks — already free, nothing to migrate
| Hook | Engine | Model | Note |
|---|---|---|---|
| `warn-large-reads.sh` | A | none | Pure bash (Tier-0). Zero LLM, zero cost — leave as-is. |
| `log-claudemd-change.sh` | A | none | Same. |
| `warn-claudemd-size.sh` | A | none | Same. |
| `index-signals.sh` | A | none | Same. |

### 4b. Routines (scheduled) — the cost surface
| Routine | Cadence (IST) | Engine/Tier | Recommended model | Cost note | Governance |
|---|---|---|---|---|---|
| `morning-brief` | Wkdys 08:00 | A+B / 1 | **resident MoE** | zero marginal | read-only |
| `focus-planner` | Mon 08:35 | A+B / 1 | **resident MoE** | zero marginal | HITL on calendar create |
| `focus-reminder` | Wkdys 08:50 | A+B / 1 | **resident MoE** | zero marginal | HITL on calendar holds |
| `day-end-sweep` | Wkdys 19:00 | A+B / 1 | **resident MoE** | zero marginal | append-only signals |
| `daily-meeting-extract` | Daily 20:00 | A+B / 1 | **resident MoE** | zero marginal | Slack self-DM/canvas |
| `zoom-signal-sweep` | Wkdys ~20:35 *(proposed)* | A+B / 1 | **resident MoE** | zero marginal | append-only + git |
| `monthly-audit-context` | 1st 09:00 | A(+B) / 1 | **resident MoE** | zero marginal | writes report only |
| Slack DM sweep | (Aegis Phase 1) | A+B / 1 | **resident MoE** | zero marginal | read-only |
| Jira sweep | (Aegis Phase 1) | A+B / 1–2 | **resident MoE** | zero marginal | **read-only** (writes refinement-gated) |
| Meeting-transcript → synth | (Aegis Phase 3) | A+B/C / 2 | **resident MoE** + verify + RAG | zero marginal | append-only |
| Synthesis → memory events | (Aegis Phase 3) | B/C / 2 | **resident MoE** + verify | zero marginal | append-only |
| Marking key events | (Aegis Phase 3) | A+B / 1 | **resident MoE** (vote-classify) | zero marginal | append-only |
| Task manager | (Aegis Phase 2) | A(+B) / 1 | **resident MoE** | zero marginal | HITL on writes |
| Daily/weekly digest → Slack | (Aegis Phase 3) | A+B / 1 | **resident MoE** | zero marginal | — |
| Deep research (internet) | (Aegis Phase 4) | C / 3 | **resident MoE** + **gemma4 31B dense** for synth | swap-in cost | local search (SearXNG) |
| Harness review | (Aegis Phase 4) | C / 3 | **gemma4 31B dense** + Claude/human checkpoint | swap-in + checkpoint | **propose-only (PR = HITL)** |
| Upgrade agentic OS (meta) | (Aegis Phase 4) | C / 3 | **Claude/human checkpoint** | keep on Claude | **propose-only (PR = HITL)** |

### 4c. Slash-commands (mostly manual today)
| Command | Task | Recommended model | Rationale |
|---|---|---|---|
| `my-actions` | aggregate/sort open actions | **resident MoE** (mostly Engine A) | mechanical; model only parses NL |
| `standup` | 24h Slack+Jira → Y/T/Blockers | **resident MoE** | light synthesis |
| `meeting-debrief` | extract tasks/knowledge/decisions | **resident MoE** + verify | scoped synthesis over one transcript |
| `sense-backlog` | refresh release ledger (Aha+Jira+Confluence+Slack) | **resident MoE** + verify | heavy but scoped; **read-only vs Jira/Aha** |
| `prd-review` / `spec-review` | critique vs rubric | **resident MoE** | scoped critique, read-only |
| `write-prd` (`prd-agentic`) | draft PRD | **Keep on Claude** until golden-eval; then trial the MoE **behind human review** | real open-ended planning — the frontier residual |

### 4d. LLM-skills
| Skill | Pins today | Recommended local | Note |
|---|---|---|---|
| `meeting-to-tasks` | `model: sonnet` | **resident MoE** | JSON-only extraction — safe early flip |
| `audit-context` | `model: sonnet` | **resident MoE** | counting + light synthesis — safe early flip |
| `tldr-pdf` | `model: sonnet` | **resident MoE** | summarization — safe early flip |
| `sync-prd` | Opus (main) | **resident MoE** | mechanical consistency checks + scoped fixes |
| `prd-agentic` / `pmd-template` | Opus (main) | **Keep on Claude** initially | real PRD authorship — frontier residual |

**The three `model: sonnet` skills are the best first flips** — scoped, schema-bounded, low risk, and they exercise the whole B-engine path (structured output + validate + retry).

---

## 5. Verify parity before flipping (golden-eval plan)

Per the house rule *"never claim parity you haven't measured"* (`local-model-routines.md:9,34`). For each routine, in flip order:

1. **Golden set.** Capture 5–10 recent real CCR outputs as references (from `ops/daily/`, `signals/`, `ops/meeting-notes/`, prior digests).
2. **Structural gate.** Run the local candidate; require **JSON-schema valid + all required fields present** (Ollama `format`, or Outlines on pure mlx-lm; validate, 5-retry). Target ≥95% first-pass (`PLAN.md:132`) — treat as a gate, not a given.
3. **Quality gate.** LLM-judge / rubric score of local output vs the golden reference on a held set; set a per-routine pass bar (e.g. judge-parity on ≥90%). **The judge must be a different family than the generator** — never let gemma4 grade gemma4 output (self-preference bias). Default judge = **Qwen3-30B-A3B** (cross-family), loaded by *evicting* the generator first (serial swap); **batch generation, then one swap to the judge** — don't ping-pong per item. High-stakes routines escalate the **judge** (not the generator) to **Claude** + a small human calibration set. Full mechanism + per-routine judge assignment: **`automation/aegis/model-lifecycle-and-eval.md`**. For classification routines (marking key events), use a self-consistency **vote**.
4. **Resource gate.** Confirm **8h zero-swap** via `vm_stat` with the model resident (`PLAN.md:119,133`).
5. **Flip one at a time.** Keep the CCR twin as **fallback** until the local golden-eval passes; then disable the CCR trigger. **Never run both engines for one routine** (double-posting). Hybrid escalation: on local failure or low verify-confidence, escalate that single run to CCR, logged (`local-model-routines.md:42,77`).

**Flip order (lowest risk → highest, per `local-model-routines.md:72-77`):**
1. Tier-1 deterministic — focus/calendar, Slack DM sweep, `standup`, `my-actions`, `day-end-sweep`, daily/weekly digest, the three `sonnet` skills.
2. Tier-2 synthesis — meeting synth→memory, Jira delta+risk, `sense-backlog`, `audit-context`, `sync-prd`.
3. Tier-3 frontier — deep research, harness review, `write-prd`/meta OS-upgrade **last**, with the Claude/human checkpoint retained.

---

## 6. Governance (unchanged by model choice)

Model selection never relaxes these — they are hard guards (`automation/CLAUDE.md:12`, `PLAN.md:92-96`):
- **Jira/Aha writes stay double-gated** — Chainlit HITL **and** the refinement-window policy. Aegis prepares/drafts only; the live write happens in a refinement session. Reads are unrestricted.
- **Frontier reasoning keeps a Claude/human checkpoint** (PRD authorship, harness self-review, OS self-upgrade) — propose-only, PR = HITL.
- **Memory is git-first**; Chroma is a derived, rebuildable index. **Secrets** stay in Keychain — the model never sees tokens.

---

## 7. Bottom line

- **Run the model you already have.** `gemma4 26B-A4B` (MoE, ~18 GB, ~30–56 tok/s on your M4 Pro) is the resident workhorse for Tier-1 **and** Tier-2 — every routine routes to it at **zero marginal cost**. Add an **embedding model** (bge-m3/nomic via Ollama) and keep **gemma4 31B dense** on disk for on-demand frontier synthesis.
- **Serve it via Ollama 0.19 on the MLX backend** (`OLLAMA_BACKEND=mlx`) — MLX speed while keeping the plan's `format`/`keep_alive`/`/v1` integration intact. Pure mlx-lm + Outlines is the alternative.
- **Don't** pull the old 7B/32B/72B ladder — gemma4-26B fills the MoE *generator* slot. **Do** pull **Qwen3-30B-A3B as the cross-family eval judge** (§5): gemma can't reliably grade its own family's output, and the judge swaps in serially (never co-resident). Full lifecycle + assignment: `model-lifecycle-and-eval.md`.
- The real cost win is **moving each routine CCR → local**, gated by a golden-eval, one at a time, with a Claude/human checkpoint retained only on the genuine frontier residual.

---

### Sources (external research, July 2026)
- MLX vs Ollama on Apple Silicon: https://willitrunai.com/blog/mlx-vs-ollama-apple-silicon-benchmarks
- Ollama 0.19 MLX backend: https://ollama.com/blog/mlx · https://andrew.ooo/posts/ollama-mlx-apple-silicon-review/
- Gemma 4 lineup (26B-A4B MoE / 31B dense): https://ai.google.dev/gemma/docs/core · https://artificialanalysis.ai/articles/gemma-4-everything-you-need-to-know
- gemma4-26B-A4B on M4 Pro (RAM / tok-s): https://gemma4-ai.com/blog/gemma4-mac-performance · https://gemma4-ai.com/blog/gemma4-hardware
- Qwen3-30B-A3B MLX speed (cross-family judge / A/B): https://willitrunai.com/blog/qwen-3-5-mlx-apple-silicon-guide · https://llmcheck.net/benchmarks
- MLX structured output (Outlines): https://mbrenndoerfer.com/writing/constrained-decoding-structured-llm-output
- Local embeddings on Apple Silicon: https://contracollective.com/blog/local-embeddings-apple-silicon-nomic-bge-qwen3-m5-max-2026
