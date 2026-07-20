# Local-model cost map — which model per task, and why

**Purpose.** A per-task recommendation of which locally-hosted (Ollama) model to run each team-os routine, command, LLM-skill, and hook on — chosen to **cut cost** while holding Claude-parity output. Companion to `.claude/local-model-routines.md` (the parity concept) and `automation/aegis/PLAN.md` (the runtime). This file is a **study / recommendation** — it changes no routine and pushes nothing. Verify tags and measure parity (below) before flipping anything.

Hardware assumed throughout: **M4 Pro / 48 GB**, budget **<24 GB RAM, 16k ctx, no swap**, ~273 GB/s bandwidth — the envelope locked in `decisions/2026-07-07-aegis-local-agentic-os.md`.

---

## 1. Where the cost actually is (read this first)

The dollar cost today is **CCR / Claude cloud tokens** — every routine, command, and skill runs there. So:

- **The saving is CCR → local.** Once a task runs on the resident Ollama model, its marginal API cost is **~zero**. That is the win, and it is the same win regardless of *which* local model serves the task.
- **Per-task model choice trades RAM & latency, not dollars.** On this box only **one large model can be resident** (`PLAN.md:66-67`). So "which model per task" is really "can I serve this task on the one model I already have warm, or must I escalate?" — a budget/latency question, with a small residual that stays on Claude for quality.

**Consequence:** the cheapest correct default is to run **as many tasks as possible on the single resident model**, because it is already loaded — extra tasks on it cost no extra RAM and no cold-start. Pulling a second model to "optimize" a task usually *costs* you (RAM + swap risk), it doesn't save.

---

## 2. The one rule that decides the roster

> `PLAN.md:67`: 30B-A3B (~18 GB) + 16k KV + embed (~0.5 GB) + Python/LangGraph/Chainlit/Chroma ≈ **21–23 GB**. Fits — **but only if exactly one large model is resident. Never load a 2nd big model** for a verifier pass; reuse the same model with a critic prompt, or a small model.

The **Qwen3-30B-A3B MoE** is uniquely good here because only **3.3B params are active** — ~30B-class quality at ~40 tok/s and ~18 GB (`PLAN.md:60`). A dense 32B gives slightly better raw quality but ~12–15 tok/s (misses the speed target), so it is a **swap-in, not the default** (`PLAN.md:61,64`).

---

## 3. Recommended lean roster (what to pull)

| Model | Role | Resident? | RAM | Serves |
|---|---|---|---|---|
| **Qwen3-30B-A3B MoE (Q4_K_M)** | Workhorse reasoner | **Yes — the one big model** | ~18 GB | Tier-1 mechanical **and** Tier-2 synthesis — nearly every routine |
| **bge-m3** *(or `nomic-embed-text`)* | Embeddings / RAG grounding | Yes, co-resident | ~0.5 GB | Chroma retrieval for synthesis routines |
| **Dense 32B (Q4_K_M)** | Offline high-stakes synthesis | **No — swap in on demand** | ~18–20 GB | Tier-3 deep-research synthesis, harness review (latency-insensitive) |
| **Claude + human** | Frontier checkpoint | n/a | — | PRD authorship, harness self-review, OS self-upgrade — until golden-eval proves parity |
| *(optional)* small 4B, e.g. `qwen3:4b` | Latency/throughput escape hatch | Only if a routine proves bound | ~3 GB | **Skip by default** — protects the RAM budget |

**Open tag question to settle before pulling** (`PLAN.md:64,139`): confirm the exact Ollama tag — `qwen3:30b-a3b` vs a mid-2026 `qwen3.5` 30B-A3B refresh. Do not pull blind.

**Reconciliation note.** The older roster in `.claude/local-model-routines.md:16-24` (`gemma4`/`qwen2.5:7b` → `qwen2.5:32b` → `qwen2.5:72b`) predates the locked ADR and is **superseded on this hardware**: you can't hold 7B + 32B + 72B resident, and swapping between them is slow. A separate 7B for "cheap" Tier-1 work would *add* ~5 GB and a cold-start for tasks the warm MoE already handles for free. Keep the *tiering idea* (route by task difficulty); drop the *multi-big-model* implementation. That doc's own §11 (`PLAN.md:150`) already flags itself for this update.

---

## 4. Per-task map (every routine, command, LLM-skill, hook)

Engine key (`local-model-routines.md:11-14`): **A** = deterministic, no LLM · **B** = scoped local LLM call (JSON-constrained) · **C** = code-orchestrated reasoning pipeline.

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
| `morning-brief` | Wkdys 08:00 | A+B / 1 | **30B-A3B** (resident) | zero marginal | read-only |
| `focus-planner` | Mon 08:35 | A+B / 1 | **30B-A3B** | zero marginal | HITL on calendar create |
| `focus-reminder` | Wkdys 08:50 | A+B / 1 | **30B-A3B** | zero marginal | HITL on calendar holds |
| `day-end-sweep` | Wkdys 19:00 | A+B / 1 | **30B-A3B** | zero marginal | append-only signals |
| `daily-meeting-extract` | Daily 20:00 | A+B / 1 | **30B-A3B** | zero marginal | Slack self-DM/canvas |
| `zoom-signal-sweep` | Wkdys ~20:35 *(proposed)* | A+B / 1 | **30B-A3B** | zero marginal | append-only + git |
| `monthly-audit-context` | 1st 09:00 | A(+B) / 1 | **30B-A3B** | zero marginal | writes report only |
| Slack DM sweep | (Aegis Phase 1) | A+B / 1 | **30B-A3B** | zero marginal | read-only |
| Jira sweep | (Aegis Phase 1) | A+B / 1–2 | **30B-A3B** | zero marginal | **read-only** (writes refinement-gated) |
| Meeting-transcript → synth | (Aegis Phase 3) | A+B/C / 2 | **30B-A3B** + verify + RAG | zero marginal | append-only |
| Synthesis → memory events | (Aegis Phase 3) | B/C / 2 | **30B-A3B** + verify | zero marginal | append-only |
| Marking key events | (Aegis Phase 3) | A+B / 1 | **30B-A3B** (vote-classify) | zero marginal | append-only |
| Task manager | (Aegis Phase 2) | A(+B) / 1 | **30B-A3B** | zero marginal | HITL on writes |
| Daily/weekly digest → Slack | (Aegis Phase 3) | A+B / 1 | **30B-A3B** | zero marginal | — |
| Deep research (internet) | (Aegis Phase 4) | C / 3 | **30B-A3B** + **dense-32B** for synth | swap-in cost | local search (SearXNG) |
| Harness review | (Aegis Phase 4) | C / 3 | **dense-32B** + Claude/human checkpoint | swap-in + checkpoint | **propose-only (PR = HITL)** |
| Upgrade agentic OS (meta) | (Aegis Phase 4) | C / 3 | **Claude/human checkpoint** | keep on Claude | **propose-only (PR = HITL)** |

### 4c. Slash-commands (mostly manual today)
| Command | Task | Recommended model | Rationale |
|---|---|---|---|
| `my-actions` | aggregate/sort open actions | **30B-A3B** (mostly Engine A) | mechanical; model only parses NL |
| `standup` | 24h Slack+Jira → Y/T/Blockers | **30B-A3B** | light synthesis |
| `meeting-debrief` | extract tasks/knowledge/decisions | **30B-A3B** + verify | scoped synthesis over one transcript |
| `sense-backlog` | refresh release ledger (Aha+Jira+Confluence+Slack) | **30B-A3B** + verify | heavy but scoped; **read-only vs Jira/Aha** |
| `prd-review` / `spec-review` | critique vs rubric | **30B-A3B** | scoped critique, read-only |
| `write-prd` (`prd-agentic`) | draft PRD | **Keep on Claude** until golden-eval; then trial 30B-A3B **behind human review** | real open-ended planning — the frontier residual |

### 4d. LLM-skills
| Skill | Pins today | Recommended local | Note |
|---|---|---|---|
| `meeting-to-tasks` | `model: sonnet` | **30B-A3B** | JSON-only extraction — safe early flip |
| `audit-context` | `model: sonnet` | **30B-A3B** | counting + light synthesis — safe early flip |
| `tldr-pdf` | `model: sonnet` | **30B-A3B** | summarization — safe early flip |
| `sync-prd` | Opus (main) | **30B-A3B** | mechanical consistency checks + scoped fixes |
| `prd-agentic` / `pmd-template` | Opus (main) | **Keep on Claude** initially | real PRD authorship — frontier residual |

**The three `model: sonnet` skills are the best first flips** — scoped, schema-bounded, low risk, and they exercise the whole B-engine path (structured output + validate + retry).

---

## 5. Verify parity before flipping (golden-eval plan)

Per the house rule *"never claim parity you haven't measured"* (`local-model-routines.md:9,34`). For each routine, in flip order:

1. **Golden set.** Capture 5–10 recent real CCR outputs as references (from `ops/daily/`, `signals/`, `ops/meeting-notes/`, prior digests).
2. **Structural gate.** Run the local candidate; require **JSON-schema valid + all required fields present** (Ollama `format`, validate, 5-retry). Target ≥95% first-pass (`PLAN.md:132`) — treat as a gate, not a given.
3. **Quality gate.** LLM-judge / rubric score of local output vs the golden reference on a held set; set a per-routine pass bar (e.g. judge-parity on ≥90%). For classification routines (marking key events), use a self-consistency **vote**.
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

- Pull **two models**: the resident **Qwen3-30B-A3B MoE** + an **embedding model**. Keep **dense-32B** on disk for on-demand frontier synthesis. Everything else routes to the resident MoE at **zero marginal cost**.
- **Don't** pull the old 7B/32B/72B ladder — it fights the one-big-model RAM rule and saves nothing here.
- The real cost win is **moving each routine CCR → local**, gated by a golden-eval, one at a time, with a Claude/human checkpoint retained only on the genuine frontier residual.
