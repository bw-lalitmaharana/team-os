---
id: ADR-D-008
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE
related_decisions: [ADR-D-003 (centralized architecture)]
---

# ADR-D-008 — Evidence-centric data model + clickable source provenance is non-negotiable

## Context
Trust in AI suggestions depends on traceability. Two patterns considered for the data model: (a) summary-centric — store AI outputs (action_item, feedback_draft) directly; source attribution is metadata — clean schema but breaks down when one signal supports multiple objects, and traceability is bolted on; (b) evidence-centric — store the underlying source signal as a first-class `evidence` row with `source_ref_url` + `speaker_user_id` + `excerpt_text`; the AI output is a *derivation* from evidence — natural multi-object support, traceability is intrinsic. Industry analog: Gong's deal timeline (evidence → activity → deal).

Polymorphic FK in Postgres considered vs. property graph (Neo4j / Glean Work Graph). At 5–10M rows/year, polymorphic FK is the right operational fit; property graph is overkill.

## Decision
Evidence is a **first-class entity**. Schema: `evidence(user_id, source_system, source_ref_id, source_ref_url, observed_at, speaker_user_id, excerpt_text, signal_type, payload, confidence, object_type, object_id, link_method, link_confidence)`. Every evidence row has a **clickable deep link** to its source (internal or external). The "Why this?" panel (CAP-009) renders inline on every AI suggestion. Storage: **polymorphic FK in Postgres** (Aurora; per ADR-D-014). Property graph rejected for MVP.

## Consequences
- Every AI claim is verifiable in one click — the trust contract.
- CAP-009 (Why-this panel) becomes the most load-bearing platform capability (highest-leverage per JTBD §5).
- Polymorphic FK accepts schema evolution via `jsonb` payload column.
- Permission check at click time (CAP-009 invariant) — viewer lacking access sees disabled link but excerpt + speaker + timestamp remain.
- Drives ADR-D-014 (Aurora storage tier) + ADR-D-015 (BW LLM not Zoom Companion summaries — because they don't carry evidence).
- Migration path to graph view (Neo4j or PG recursive CTEs) preserved if cross-object reasoning becomes a product feature.

## Source
- Industry research 2026-05-13 (Gong deal timeline pattern)
- PRD-AI-PROCESSING-PIPELINE §5 MUST + §A.1 evidence schema
