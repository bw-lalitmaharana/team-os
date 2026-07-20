# Local-model routines — Claude-parity execution

How to run team-os routines (and the wider agentic personal OS) on **self-hosted / local models** at Claude-level output quality, at ~zero API cost. Tier-2: read when building, changing, or migrating a routine. Pointer from `.claude/context-design.md` § Routines.

## Why this exists
Routines today run as **CCR** cloud agents (Anthropic cloud, Claude model, claude.ai-managed MCP OAuth). Goal: move them to **local models** (Ollama on the Mac, `localhost:11434`) with the **same output**, no Claude tokens. A cloud CCR agent cannot reach `localhost`, and its `model` field is Anthropic-only — so "use my local model" **⇒ the routine must execute locally** (launchd), not in CCR. This is a runtime change, not a config flag.

## The parity thesis (the whole idea)
Claude-level *output* is not the same as a Claude-level *model*. For scheduled routines, quality is dominated by the **harness**, not raw model IQ: deterministic scaffolding, retrieval grounding, structured output, decomposition, and verification. A 7–32B local model inside a strong harness matches Claude on almost all routine work. The residual gap is only on **open-ended frontier reasoning** (deep-research synthesis, harness self-review, OS self-upgrade) — there, route to the largest local reasoning model + verification, and keep a Claude/human checkpoint until a golden-eval proves parity. **Never claim parity you haven't measured.**

## Three execution engines (pick per step, not per routine)
- **A — Deterministic (no LLM):** date/slot math, API CRUD, dedup, filtering, formatting, git writes. Do the maximum here.
- **B — Local LLM, scoped call:** summarize / classify / extract / tag / phrase over *provided* context. Always JSON-schema-constrained (Ollama `format`), validated, retried. ~90% of routine "intelligence" lives here.
- **C — Local reasoning model, orchestrated pipeline:** multi-step synthesis / research / planning, reproduced as a **code-orchestrated** fan-out → extract → synthesize → verify — NOT a model-driven agent loop (small local models are weak agents).

## Model roster (Ollama tiers)
| Tier | Use | Model to pull |
|---|---|---|
| 0 | none — pure code | — |
| 1 | extract / classify / phrase (high volume) | `gemma4` (installed) or `qwen2.5:7b-instruct` |
| 2 | synthesis, memory events, jira/meeting, tool-use | `qwen2.5:32b-instruct` |
| 3 | deep research, harness review (frontier) | `qwen2.5:72b` or a reasoning model (`qwq`, `deepseek-r1` distill) — hardware-permitting |
| emb | RAG grounding over team-os | `bge-m3` or `nomic-embed-text` |

Route by task, not habit. **Small model + good harness > big model + no harness.**

## Parity checklist (apply to every routine)
1. Push work to Engine A; call a model only for the irreducibly fuzzy step.
2. Constrain model output to a JSON schema/grammar; validate + retry on parse failure.
3. Ground with retrieval (team-os `signals/`, transcripts, memory) — don't rely on model recall.
4. Decompose: many small scoped calls beat one big call for a small model.
5. Verify high-stakes output with a **different-family judge model — never self-judge** (a model over-rates its own, and same-family, generations). Load it by evicting the generator (serial swap; ≤1 big model resident); batch generation, one swap to the judge. Self-consistency vote for classification. Mechanism + per-routine judge assignment: `automation/aegis/model-lifecycle-and-eval.md`.
6. Prefer code pipelines over model tool-loops.
7. Keep a **golden-output eval** per routine; gate any model/prompt change on it.
8. Log run + model + latency + confidence to `ops/…`; make failures loud, not silent.

## Runtime substrate
- **Orchestrator:** a shared Python framework (proposed `automation/` in this repo, or `~/.agentic-os/`): model-router, connectors (Google/Slack/Jira/Zoom/web), team-os memory+log writers, structured-output + verify helpers, per-routine golden-evals.
- **Models:** Ollama (multi-model, `localhost:11434`, OpenAI-compatible `/v1`).
- **Scheduler:** launchd (one job per routine; runs missed jobs on wake). The Mac must be awake near run time.
- **Auth:** local MCP servers run as subprocesses with tokens injected at the **transport layer from the macOS Keychain** (the LLM never sees a token); initial 3-legged OAuth via a temporary local FastAPI redirect. Reusing claude.ai's remote connectors is a bootstrap/fallback only. Concrete Aegis model: `automation/aegis/PLAN.md` §4 + `decisions/2026-07-07-aegis-local-agentic-os.md`.
- **Fallback (hybrid):** on local failure or low verify-confidence, escalate that single run to CCR/Claude, logged. Keeps reliability while local matures.

## Per-routine tiering (current personal-OS routines)
| Routine | Engine | Tier | Parity technique |
|---|---|---|---|
| Focus / block calendar | A+B | 1 | code computes free slots; model reads Notes + phrases Slack msg |
| Slack DM sweep | A+B | 1 | code pulls msgs; model summarizes/classifies → JSON |
| Jira sweep | A+B | 1–2 | code queries Jira; model summarizes deltas + flags risk |
| Meeting-transcript fetch | A(+B) | 1 | code fetches; model → fixed recap schema |
| Synthesis → memory events / logs | B/C | 2 | RAG-grounded; memory-event JSON schema; verify pass |
| Marking key events | A+B | 1 | importance classify (vote); code writes markers |
| Task manager | A(+B) | 1 | mostly deterministic; model parses NL input |
| Deep research (internet) | C | 3 | fan-out search → fetch → extract(T1) → synthesize(T3) → adversarial verify(T2) |
| Daily / weekly findings → Slack | A+B | 1 | aggregate deterministically; model phrases the digest |
| Review the harness | C + checkpoint | 3 | local + verify, keep Claude/human gate (frontier reasoning) |
| Upgrade agentic OS (meta) | C + checkpoint | 3 | propose → test → review; never fully-autonomous local |

## Routine-spec convention
Every routine declares this frontmatter in its `.claude/commands/<name>.md` or `automation/<name>/spec.md`, so the concept stays enforced and auditable:
```yaml
engine: local           # local | ccr | hybrid
tier: 1                 # 0 code | 1 small | 2 mid | 3 reasoning
model: gemma4           # generator ollama model (omit if tier 0)
schedule: "50 3 * * 1-5"   # cron, UTC
output: ops/focus/tracker.md
verify: judge           # none | judge | vote
judge_model: qwen3-30b-a3b   # MUST be a different family than `model` (never self-judge)
eval_stakes: low        # low | mid | high  (high ⇒ escalate judge to Claude + human calibration)
fallback: ccr           # engine to escalate to on failure / low confidence
golden_eval: automation/focus/eval.jsonl
```

## Migration order (lowest risk first)
1. **Tier-1 deterministic** routines (focus/calendar, slack sweep, findings digest). Reference impl = focus-time (`ops/focus/tracker.md`; trigger IDs in memory `reference_focus_time_routines`).
2. **Tier-2 synthesis** (jira/meeting/memory events) once the RAG + verify helpers exist.
3. **Tier-3** (deep research, harness review, meta-upgrade) last — keep the Claude/human checkpoint.

Keep each routine's CCR twin **enabled as fallback** until its local golden-eval passes; then disable the CCR trigger (`RemoteTrigger enabled:false`). One routine flips at a time; never both engines live for the same routine (double-posting).
