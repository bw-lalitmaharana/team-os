# Model lifecycle + cross-model eval — Aegis OS primitive

**Purpose.** Two coupled, first-class Aegis components: (1) a **Model Lifecycle Manager** that hosts many local models but keeps **one big model resident at a time**, switching on demand; and (2) a **cross-model eval harness** that grades a routine's output with a **judge model of a different family than the generator** — its first consumer. This is an implementable spec for the `automation/aegis/` runtime (still being built). Companions: `PLAN.md` (build plan), `model-cost-map.md` (per-task model choice), `.claude/local-model-routines.md` (parity concept).

Hardware envelope (locked in `decisions/2026-07-07-aegis-local-agentic-os.md`): **M4 Pro / 48 GB**, budget **<24 GB RAM, 16k ctx, no swap**. Runtime: **MLX** (Ollama 0.19 on the MLX backend — see `model-cost-map.md` §2).

---

## 1. The constraint this resolves (read first)

`PLAN.md` §3.2 originally said *"never load a 2nd big model for a verifier pass; reuse the same model with a critic prompt."* That rule conflated two different things:

- **Co-residency** — two big models loaded *simultaneously*. 18 + 18 GB + KV + macOS blows the <24 GB no-swap budget. **Stays forbidden.**
- **Serial use** — unload the generator, *then* load the judge. Never more than one big model resident. **This is allowed, and it is what a different judge requires.**

So a judge that differs from the generator is achievable **sequentially**, RAM ceiling intact. The lifecycle manager (§3) is the mechanism; the eval harness (§4) is the reason.

**Why a different judge is not optional.** Self-preference bias is causally established: models recognize and over-rate their *own* generations — MT-Bench measured GPT-4 favoring its own answers by ~10% win-rate (arXiv:2306.05685), and self-preference scales with self-recognition ability (arXiv:2404.13076). The bias extends to the *same family*, not just literal self-judging. **A routine's generator must never grade its own output; the judge must be a different family.**

---

## 2. Model literacy table

Pick the generator **and** the judge per use-case from this table. Hard rule: **judge family ≠ generator family.** RAM/speed are MLX 4-bit, M4 Pro — *measure on your box*, treat as ranges.

| Model | Family | Arch | RAM | Speed | Strengths | Role-fit | May judge… |
|---|---|---|---|---|---|---|---|
| **gemma4-26B-A4B** *(installed)* | gemma | MoE (~3.8B active) | ~18 GB | ~30–56 tok/s | scoped synthesis, extract, classify | **resident workhorse generator** | *not* gemma output |
| **gemma4-31B** | gemma | dense | ~19–22 GB | ~2–4× slower | long-chain / high-stakes synthesis | swap-in generator / synth | *not* gemma output (same family) |
| **Qwen3-30B-A3B** | qwen | MoE (~3.3B active) | ~17–18 GB | ~40 tok/s | reasoning, instruction-following | **default cross-family judge**; A/B generator | ✅ gemma output |
| **bge-m3** / **nomic-embed-text-v2** | — | embed | ~2 GB | — | RAG grounding | embeddings (**co-resident**, exempt) | — |
| **Claude + human** | anthropic | frontier | — | — | calibration, frontier reasoning | **high-stakes judge escalation**; frontier-residual generator | ✅ any local output |

Notes: only **big models** contend for the single resident slot; the embedding model is small and stays co-resident. A *same-family, different-checkpoint* judge (e.g. gemma4-31B judging gemma4-26B) does **not** escape the bias — family, not checkpoint, is what matters.

---

## 3. Model Lifecycle Manager (the switcher)

The OS primitive every consumer goes through. Enforces the invariant **≤1 big model resident**.

### 3.1 Implementation
- **Primary — Ollama 0.19 on the MLX backend.** Set `OLLAMA_MAX_LOADED_MODELS=1` and `OLLAMA_NUM_PARALLEL=1`. Requesting model B while A is resident makes Ollama **auto-evict A (LRU)** before loading B — serial residency for free, while keeping native JSON `format`, `keep_alive`, and the `/v1` endpoint the Aegis plan already targets (no integration rewrite). Keep the workhorse warm with `keep_alive: -1`; force a release with `ollama stop <model>` (≡ `keep_alive: 0`). *(MLX backend needs ≥32 GB unified memory — 48 GB qualifies; confirm the model is on the MLX path, not the llama.cpp fallback.)*
- **Alternative — `mlx-serve`** (subprocess-per-model hot-swap, OpenAI-compatible). The only option that **guarantees full memory reclaim** — it kills model A's subprocess so the OS reclaims everything before B loads, avoiding MLX allocator fragmentation (`mx.clear_cache()` frees buffers but does not defragment). Adopt this if the zero-swap gate (§3.3) shows residue after in-process swaps. Trade-off: loses native `format` → JSON via Outlines' MLX backend.

### 3.2 Lifecycle state machine
`idle → resident:A → (evict A) → resident:B → …`
- **Acquire(model):** if `model` already resident → reuse; else evict current big model, load `model`, wait for ready.
- **Release / idle:** `keep_alive` timer or explicit stop unloads to protect the ceiling during multitasking.
- **API surface:** a single `with_model(name)` / `acquire→release` wrapper. Eval, frontier synth, and every other consumer call *only* this — the invariant lives in one place.

### 3.3 Observability & guards
- **`/api/ps`** (`ollama ps`) lists resident models; **`size_vram` < `size` ⇒ spillover** to system RAM — a memory-pressure alarm.
- **`vm_stat` zero-swap guard** across every swap (the Phase-0 exit gate, `PLAN.md:119,133`). Zero-swap is a *monitored metric, not an assumption*.

### 3.4 Switch-cost discipline
Cold-load re-reads the full model from SSD on every swap — estimate **~single-digit to ~15 s** for an ~18–22 GB 4-bit model (SSD-bound; *no citable M4-Pro benchmark — measure*). Therefore:
- **Batch by model — swap once per run, never ping-pong per item.** Generate *all* candidates with the generator resident, then swap once to the judge and score *all* of them.
- **Never overlap** two big models to "save" a swap — 18+18 GB pushes into paging, and swap collapses throughput (observed 40 → ~2 tok/s under pressure). A clean cold-load is far cheaper than paging.

---

## 4. Cross-model eval harness (first consumer)

The eval pyramid — cheap deterministic checks first, model judging only on the residual:

1. **Deterministic floor** (Engine A, every output): schema/JSON validity, required fields, tool-call / citation presence. Catches 30–60% of failures at ~zero cost.
2. **Structural gate:** ≥95% first-pass JSON-valid (`format`/Outlines, validate + 5-retry) — a gate, not a given (`PLAN.md:132`).
3. **Cross-model judge** (from §2, **different family**, **reference-guided** against the golden reference):
   - **Golden reference** = 5–10 captured real CCR/Claude outputs per routine (`model-cost-map.md` §5). Reference-guided judging is materially more reliable than reference-free (which scores too generously) — arXiv:2408.09235.
   - **Bias mitigations:** run each pairwise comparison in **both answer orders and count a win only if the same side wins both** (position bias, ~1/3 flip rate); apply a length penalty in the rubric (verbosity bias); require the judge to emit reasoning.
   - **Stakes tiers:**
     - *Low-stakes* → one local cross-family judge (Qwen for gemma output). A small **diverse-family** mini-panel is optional — value comes from family diversity, not head-count; big same-family panels waste compute (correlated errors, arXiv:2605.29800).
     - *High-stakes* (PRD authorship, harness review, OS self-upgrade) → **escalate the judge — not the generator — to Claude**, plus a small human-labeled calibration set. An LLM judge doesn't substitute for real labels (arXiv:2503.05061, arXiv:2410.13341).

### 4.1 Golden-eval run recipe (ties §3 + §4)
```
acquire(generator)              # e.g. gemma4-26B resident
  → generate all candidates     # batch — no swaps mid-batch
release(generator)              # evict
acquire(judge)                  # e.g. Qwen3-30B-A3B — one swap
  → deterministic floor + structural gate + reference-guided score (both orders)
  → flag uncertain items
release(judge)
escalate flagged/high-stakes items → Claude judge (+ human calibration)
```
One swap per eval run. Classification routines use a self-consistency **vote** instead of a pairwise judge.

---

## 5. Per-routine generator / judge assignment

Generator + judge-family + stakes, drawn from §2 (routines/commands/skills per `model-cost-map.md` §4):

| Task | Generator | Judge (family ≠ gen) | Stakes |
|---|---|---|---|
| Slack DM sweep, daily/weekly digest, `standup`, `my-actions` | gemma4-26B | Qwen (or vote) | low |
| `meeting-debrief`, meeting→memory synth, `sense-backlog` | gemma4-26B | Qwen | low–mid |
| Marking key events (classify) | gemma4-26B | self-consistency **vote** | low |
| Jira delta + risk | gemma4-26B | Qwen | mid |
| `prd-review` / `spec-review`, `sync-prd` | gemma4-26B | Qwen | mid |
| Deep-research synthesis | gemma4-26B + gemma4-31B synth | Qwen; **Claude** if high-stakes | mid–high |
| Harness review | gemma4-31B / Claude | **Claude** + human | **high** |
| `write-prd`, OS self-upgrade (meta) | Claude/human (frontier residual) | **Claude** + human | **high** |

Rule of thumb: if gemma generated it, Qwen judges it; escalate the **judge** to Claude only where consequence justifies it (`compute matches consequence`).

---

## 6. Routine-spec frontmatter additions

Extend the block in `.claude/local-model-routines.md:61-70`:
```yaml
model: gemma4-26b        # generator
verify: judge            # none | judge | vote
judge_model: qwen3-30b-a3b   # MUST be a different family than `model`
judge_family: qwen           # asserted ≠ generator family at load time
eval_stakes: low             # low | mid | high  (high ⇒ escalate judge to Claude + human calib)
eval_batch: true             # batch generation, single judge swap per run
golden_eval: automation/<routine>/eval.jsonl
```

---

## 7. Governance (unchanged by model/lifecycle choice)

- **Jira/Aha writes stay double-gated** (Chainlit HITL **and** refinement-window) — `automation/CLAUDE.md:12`, `PLAN.md:92-96`. Reads unrestricted.
- **Frontier reasoning keeps a Claude/human checkpoint** — propose-only, PR = HITL.
- **Memory git-first**; Chroma derived/rebuildable. **Secrets in Keychain** — the model never sees tokens.

---

### Sources
- Self-preference / self-recognition: https://arxiv.org/abs/2404.13076 (Panickssery, NeurIPS 2024) · https://arxiv.org/abs/2306.05685 (Zheng, MT-Bench, NeurIPS 2023) · https://arxiv.org/html/2410.21819v1
- Panels & their limits: https://arxiv.org/abs/2404.18796 (PoLL) · https://arxiv.org/abs/2605.29800 (Apple — correlated judges)
- Reference-guided / grounding limits: https://arxiv.org/html/2408.09235v3 · https://arxiv.org/html/2503.05061v2 · https://www.emergentmind.com/papers/2410.13341
- Serial residency mechanics: https://docs.ollama.com/faq · https://docs.ollama.com/api/ps · https://ollama.com/blog/mlx · https://github.com/raspoli/mlx-serve
