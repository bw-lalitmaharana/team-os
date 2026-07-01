---
id: ADR-MD-013
status: staged
date: 2026-05-20
deciders: PM Owner (LM) — to be ratified at refinement call
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [ADR-MD-014, ADR-MD-015, ADR-MD-016, ADR-MD-017]
supersedes: [calibration-brief-v2 §0.3, §1.5 MEET-CAP-206 ARA proposal]
---

# ADR-MD-013 — Remove AI Recommended Actions (ARA) right-rail panel

## Status
Staged for ratification at next refinement call. PRD v0.6.0 is authored against this decision.

## Context
The 2026-05-18 prototype (`~/Downloads/Meetings Zoom- Container/`) implemented an "AI Recommended Actions" (ARA) container as a stacked right-column card alongside Goals. Calibration brief v2 (2026-05-19) calibrated to this prototype shape and proposed MEET-CAP-206 as the MVP-required ARA container with 6 UI render states (default/expanded/loading/empty/error/dismissed).

The 2026-05-20 claude.ai chat session (`d3e6e6d2-4fb4-4152-b26d-26f7cb4b3bd7`) iterated past the prototype to a different model. Two facts emerged from the deep-research pass on right-rail UX patterns (15+ tools surveyed including Lattice, Fellow, Granola, Notion, Read.ai, Fathom):

1. **No major tool puts AI-generated *new actions* in the right rail.** Tools that surface AI outputs put them inline in the host list (Notion, Granola, Fellow) or as a transient pre-meeting brief (Fathom, Read.ai). The right rail is reserved for reference context (profile, goals, history) — not action surfaces.
2. **Mixing a separate AI panel with object widgets creates a "where do I look?" problem.** Managers learn to ignore the AI panel or learn to ignore the object widget — but never both equally. The cleaner pattern is putting AI signal *into* the existing surfaces (inline in lists; nudges attached to specific objects).

A simpler mental model emerged from these findings: **create things that don't exist yet on the left; update things that already exist on the right.** Under that rule, an ARA panel that mixes both intents (create new objects + reference past evidence) violates the model.

## Decision
- **Remove MEET-CAP-206 (ARA right-rail container) from the PRD scope entirely.** No MVP, no V2.
- **Redistribute the AI surfacing across two existing locations:**
  - Inline AI typed rows (Recognition / Goal / Development) in the Action Items list (left column) — new MEET-CAP-206 (renumbered).
  - Per-object nudges attached directly below the goal/feedback item they reference (right rail) — new MEET-CAP-207.
- Adopt the governing rule **"create on the left, update on the right"** as a top-level invariant in §3 Solution sketch.
- Remove from the page: the standalone ARA card, the modal Review dialog, the "Suggested by AI" band, the consent indicator, the recording/transcribing pill, and the Growth Plan widget (out of scope for this page).

## Consequences
- Brief v2's §0.3 (ARA container spec), §0.4 (Review dialog as modal), and the MEET-CAP-206/207/208 numbering for ARA cards are obsolete. v3 brief documents the supersedure.
- MEET-CAP numbering 206/207/208 is reused for new caps with different scope.
- The Review-flow modal pattern is replaced by a side panel (480px, slides from right). Modal pattern not used anywhere in the new design.
- Lane C in v2 was framed as "ARA + Recognition + Development cards = MVP-required; if Q-A1 ratifies single-transcript, defer all three." The narrower Lane C in v0.6.0/v3 is "if Q-A1 → single-transcript, AI Brief multi-meeting narrows AND Feedback nudge defers." Other v0.6.0 caps survive on single-transcript.
- "Cleaner mental model" cuts both ways: managers who learned the prototype's ARA panel during early demos will need a brief re-orientation. Trade-off accepted because v0.6.0 has not been demoed externally yet (Rainforest target is 2026-05-31).
- Brief v2 remains in `refinement/` as historical context; not deleted.

## Source
- Calibration brief v2 (2026-05-19) — §0.3, §0.4, §1.5 — superseded
- claude.ai chat `d3e6e6d2-4fb4-4152-b26d-26f7cb4b3bd7` (2026-05-20)
- Chat research: `specs/2026-05-20-right-rail-and-zoom-ux-patterns.md` [paste pending]
- Chat research: `specs/2026-05-20-ai-nudges-in-context-cards.md` [paste pending]
- PRD-MEETINGS-AI-SURFACES v0.6.0 §3.1, §3.3
