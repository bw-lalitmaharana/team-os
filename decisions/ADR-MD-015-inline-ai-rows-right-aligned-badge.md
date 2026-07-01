---
id: ADR-MD-015
status: staged
date: 2026-05-20
deciders: PM Owner (LM) — to be ratified at refinement call
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [ADR-MD-013, ADR-MD-017, ADR-MD-018]
---

# ADR-MD-015 — Inline AI rows with right-aligned ✦ AI badge (no "Suggested by AI" band)

## Status
Staged for ratification at next refinement call. PRD v0.6.0 is authored against this decision.

## Context
Pre-pivot designs (brief v2 + prototype) gave AI-suggested rows a distinct visual treatment — either grouped under a "Suggested by AI" section header, given a different background tint, or rendered in a separate card. The intent was to make AI-vs-human authorship visible at a glance.

Two problems with that approach emerged in the 2026-05-20 chat research:

1. **Distinct sections become "skip zones."** When AI outputs are grouped separately, managers either over-attend (treating the AI section as a queue to clear) or skip it (treating it as noise). Neither produces good action behavior. The Granola/Notion pattern — inline rows that look like peers of human-authored rows, distinguished only by a small badge — produces higher action rates because the AI row earns attention by sitting where the user is already looking.
2. **Inconsistent badge position in the prototype** (sometimes left of label, sometimes inline with text, sometimes top-right) created design ambiguity. A single right-aligned convention removes the question.

## Decision
- AI-authored rows in the Agenda Topics and Action Items lists render **inline in the same list** as manual rows. No "Suggested by AI" section, no separate band, no visual grouping.
- Every row that carries the ✦ AI badge SHALL render the badge **right-aligned**, in the same horizontal position across all row types and both columns (left column action items + right rail nudges).
- AI plain rows (MEET-CAP-201, MEET-CAP-204) are editable inline from first render. No accept step. Editing changes the badge label from "✦ AI" to "✦ AI · edited" but does not remove the badge.
- AI typed rows (MEET-CAP-206 Recognition/Goal/Development) are not editable inline. Review opens a side panel.
- The transcript citation sub-line ("Mentioned in Mar 7, 14, 21 1:1s" or equivalent) renders below the row text, left-aligned, with the citation as a link.

## Consequences
- The visual hierarchy of the action items list is: row text + checkbox + (optional) Rolled-over chip or AI typed-row chip on the left; ✦ AI badge + Review →/× or owner avatar on the right. Consistent across row types.
- "Distinct band" affordance is gone — engineers and designers must trust the badge + citation to communicate provenance. MPAC-13 enforces visual audit pass on this.
- Inline editability of AI plain rows means there is no separate "draft" state — the row is just there, the user can change it. Reduces cognitive overhead (no "accept first, then edit" two-step) at the cost of making AI rows easier to ignore-by-leaving-as-is. Acceptable trade-off because the citation makes provenance discoverable on demand.
- The convention applies to right-rail nudges (CAP-207) too: ✦ AI icon is right-aligned within the nudge row. No band around nudge content; nudge sits as a peer of object rows.
- Anti-pattern locked: never bring back a "Suggested by AI" section header even if user feedback suggests it would clarify. The right move would be to strengthen the badge / citation, not to group rows.

## Source
- claude.ai chat `d3e6e6d2-4fb4-4152-b26d-26f7cb4b3bd7` (2026-05-20)
- Chat research: `specs/2026-05-20-ai-nudges-in-context-cards.md` — Granola, Notion, Lattice inline-row patterns
- PRD-MEETINGS-AI-SURFACES v0.6.0 App A.2 MEET-CAP-201, CAP-204, CAP-206
- Prototype source `~/Downloads/Meetings Zoom- Container/app/` — TypedActionRow, ActionItemRow components
