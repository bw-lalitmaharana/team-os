---
id: ADR-D-005
status: accepted
date: 2026-05-12
deciders: Cross-pod PM Meetings/Goals (VG) + PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE
---

# ADR-D-005 — Phase 1 scope locked to Meetings module; Goal suggestions are stretch only

## Context
The pipeline architecture supports four destination modules (Goals, Feedback, Skills, Meetings) — but shipping all four in MVP requires alignment with three additional pods (Goals, Performance, Talent Intelligence) plus their respective admin governance frameworks. Meetings is the most ready: per-meeting AI capture (summary + action items + agenda) has the clearest user value and the smallest cross-pod dependency surface. Cross-pod ambition risks delaying everything.

## Decision
Phase 1 (Summer 2026 MVP) is scoped to the **Meetings module surface**. Goal suggestions on Goals page (S-15), template-bound feedback pre-fill (S-14), and Skills surfacing are **stretch only**. Canonical user verbs "Review → Refine → Apply" adopted as the design language for all surfaces.

## Consequences
- Cross-pod coordination cost reduced for MVP.
- PRD-MEETINGS-AI-SURFACES is the consumer-surface PRD; Goals/Feedback/Skills PRDs are stretch / future.
- Stretch stories S-13/14/15 can land if Meetings ships early and pod capacity exists.
- "Review → Refine → Apply" becomes the canonical verb set across all surfaces (codified as parent ADR-D-005 reference).

## Source
- Zoom uuid D236D5E5-A01C-4D20-91C3-935FF3588D90 (Varnika / Lalit, 2026-05-12)
- PRD-AI-PROCESSING-PIPELINE §4 Scope + §A.3 UX framing
