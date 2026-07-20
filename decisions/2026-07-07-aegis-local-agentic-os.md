# ADR 2026-07-07 — Aegis: local agentic Personal OS

**Decision:** Build the personal-OS routines as a local runtime ("Aegis"), locking these choices:
1. **Reasoning engine:** Qwen3-30B-A3B (**MoE**, Q4_K_M via Ollama) — *not* a dense 27–32B.
2. **Code location:** in team-os at `automation/aegis/`.
3. **Secrets:** macOS Keychain (transport-layer token injection; the LLM never sees a token).
4. **Deep-research search:** local **SearXNG** MCP.
5. **HITL channel:** **Chainlit only** (`localhost:8000`) — no Slack-mirrored approvals for v1.
6. **No direct writes without approval:** every destructive/system action (calendar create, Jira/Aha updates) is HITL-gated; Jira/Aha writes *additionally* stay **refinement-call-gated** — Aegis prepares/drafts only, never writes live.

Orchestration = LangGraph; UI = Chainlit; memory = Chroma index **derived from** git markdown; auth = local MCP servers + a temporary FastAPI OAuth handler. Full design in `automation/aegis/PLAN.md`; parity concept in `.claude/local-model-routines.md`.

**Context:** Run the whole agentic PM OS locally at Claude-parity with zero LLM-cloud leakage, on an M4 Pro / 48 GB, within a <24 GB RAM + 16k-context budget (no swap).

**Alternatives considered:**
- **Dense Qwen 32B / "27B":** ~10–15 tok/s on M4 Pro (memory-bandwidth-bound) — misses the 35–45 tok/s target. Rejected as default reasoner; kept for offline high-stakes synthesis.
- **14B dense:** fast but weaker synthesis — kept only as a Tier-1 option.
- **Reuse claude.ai remote MCP connectors via local re-OAuth:** easier bootstrap, but couples to hosted brokers and muddies the local-first security model — demoted to bootstrap/fallback (e.g., Zoom/Aha).
- **ChromaDB as primary memory:** rejected — git markdown stays source of truth; Chroma is a derived, rebuildable index.
- **Slack-mirrored HITL:** deferred — Chainlit-only for v1.

**Reasoning:** The MoE (3.3B active) delivers ~30B-class quality at ~3–4B speed → satisfies both the tok/s and RAM budgets simultaneously, which no dense model can here. Keychain transport-injection keeps credentials out of the model. Refinement-gating preserves the standing "no Jira/Aha writes outside refinement calls" house rule even under autonomy. Git-first memory keeps auditability and the context-design principles; Chroma only accelerates retrieval.

**Trade-offs accepted:**
- MoE can trail a same-total-size dense model on the hardest reasoning — acceptable for routine tasks; dense-32B retained for offline synthesis.
- **Chainlit-only HITL ⇒ approvals need the UI open.** A background run needing approval blocks/queues until Chainlit is open — no away-from-desk approvals. Revisit if it bites.
- Local SearXNG is another component to run; web queries still leave the machine (search is not "local").
- Keeping code in team-os grows the repo beyond docs; mitigated by scoping runtime under `automation/`.

**Supersedes:** the "Auth" open item + §10 open decisions in `automation/aegis/PLAN.md`; refines the Auth section of `.claude/local-model-routines.md`.

---

### Update 2026-07-20 — model roles refined (runtime = MLX; resident generator = gemma4; Qwen retained as judge)

Decision #1 and the "via Ollama" runtime assumption are **refined** (not reversed) after the model-cost + eval-lifecycle work. The locked *intent* — one MoE reasoning engine, ≤1 big model resident, <24 GB no-swap — stands; the specific bindings change:

- **Runtime = MLX**, via **Ollama 0.19 on the MLX backend** (`OLLAMA_MAX_LOADED_MODELS=1`), not the llama.cpp path. Keeps native JSON `format`/`keep_alive`/`/v1`; `mlx-serve` is the fallback if the zero-swap gate shows allocator residue. See `automation/aegis/model-cost-map.md` §2.
- **Resident generator = gemma4-26B-A4B MoE** (~3.8B active, ~18 GB, installed) — the day-to-day workhorse, with **gemma4-31B dense** as the swap-in for high-stakes synthesis.
- **Qwen3-30B-A3B is retained — repurposed as the cross-family eval judge**, not the resident generator. Self-preference bias makes same-family judging unreliable (a model over-rates its own and same-family output), so the judge must differ in *family* from the generator; gemma output is judged by Qwen (or Claude for high-stakes). This is why "hosting many, using one at a time" is a first-class OS primitive, not just a RAM trick.

The one-big-model-resident invariant is unchanged; a different judge loads **serially** (evict generator → load judge), never co-resident. Full mechanism + per-routine generator/judge table: `automation/aegis/model-lifecycle-and-eval.md`. Per-task model map: `automation/aegis/model-cost-map.md`.
