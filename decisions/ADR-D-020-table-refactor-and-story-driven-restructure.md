---
id: ADR-D-020
status: accepted
date: 2026-05-14 (table refactor) + 2026-05-15 (story-driven spine)
deciders: PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE (applies to all trio + zoom-connector)
related_decisions: [meta-decision about PRD legibility]
---

# ADR-D-020 — Trio-wide refactor: tabularization + story-driven spine restructure

## Context
Two related but distinct PRD-legibility refactors:

**Pass 1 (2026-05-14):** §3 Benefits + §10 Assumptions/Dependencies/Risks converted from prose-with-bullets to tables across all four PRDs. No semantic changes other than the absorption of ADR-D-017/018/019 + parallel ADR-CD/MD/ZD updates.

**Pass 2 (2026-05-15):** Story-driven spine restructure (POC on meetings-ai-surfaces v0.4.0, propagated to all trio + zoom-connector at v1.0.0 / v0.5.0 / v0.3.0). Sections reduced from ~20+ per PRD to **7 + 4 appendices**. Inline §14 Decisions Log extracted to `/decisions/ADR-*` files. Anti-patterns removed per Reforge / Lenny / Cagan convention (deep nesting, metric duplication, decision logs in body, "kitchen-sink" sections).

## Decision
Adopt the story-driven spine as the canonical PRD structure across the trio. Future PRDs in the meeting-transcripts feature (Goals AI Surfaces, Feedback AI Surfaces, Skills AI Surfaces — currently stubs) inherit this structure. Decisions log moves permanently to `/decisions/`; PRD §5 Constraints sources reference ADR IDs.

## Consequences
- Spine length per PRD: ~150–270 lines (vs. prior 370–770).
- Appendices preserve all locked contracts (capabilities, ACs, story decomposition, evidence schema).
- Decisions become individually addressable (ADR-* files survive PRD rewrites).
- Confluence republish required (HTML re-render deferred until validation gate passes).
- `/sync-prd` skill may need updating if it expects §14 in body (TBD).
- Cross-references to D-NNN / CD-NNN / MD-NNN / ZD-NNN preserve compatibility (IDs unchanged; only location moved).

## Source
- PRD legibility research 2026-05-15 (Reforge, Lenny, Cagan, Shape Up, Amazon PR/FAQ, Cutler, Spec Kit)
- POC: PRD-MEETINGS-AI-SURFACES v0.4.0 (2026-05-15)
- Validation gate criteria: 60-second skim test + eng handoff test + decision recoverability test
