# Automation — Aegis local runtime

Home for the local agentic Personal OS ("Aegis") that runs team-os routines on **local models** (Ollama) instead of CCR/Claude. team-os = memory/governance; **Aegis = the runtime** that reads/writes it.

## What's here
- `aegis/PLAN.md` — build plan (approved 2026-07-07).
- `aegis/model-cost-map.md` — which local model per task (cost map).
- `aegis/model-lifecycle-and-eval.md` — serial model hot-swap primitive + cross-model eval (judge ≠ generator family).
- `aegis/` — runtime: LangGraph orchestrator, local MCP tool servers, Chainlit UI, per-routine specs. *(being built)*

## Rules
- Concept + parity techniques: `.claude/local-model-routines.md`. Decisions: `decisions/2026-07-07-aegis-local-agentic-os.md`.
- Every routine carries `engine`/`tier`/`model`/`verify` frontmatter (routine-spec convention in the concept doc).
- **No direct writes without approval:** destructive/system actions are HITL-gated in Chainlit. **Jira/Aha writes ALSO stay refinement-call-gated** — Aegis prepares/drafts only, never writes live.
- **Memory:** write structured synthesis to git markdown (`signals/`, `decisions/`) FIRST; Chroma is a derived, rebuildable index — never the source of truth.
- **Secrets:** macOS Keychain; the model never sees tokens (transport-layer injection).
- **Reasoning engine:** one big model resident at a time (RAM budget <24 GB, 16k ctx). A different judge/synth model loads **serially** by evicting the current one — co-residency is what's forbidden, not a 2nd model. See `aegis/model-lifecycle-and-eval.md`.
