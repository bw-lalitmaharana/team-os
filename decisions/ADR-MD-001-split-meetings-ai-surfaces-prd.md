---
id: ADR-MD-001
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [parent PRD D-011]
---

# ADR-MD-001 — Split Meetings AI surfaces into sibling PRD

## Status
Accepted.

## Context
The parent PRD (PRD-AI-PROCESSING-PIPELINE) had grown past 30KB and conflated platform-layer concerns (evidence schema, reconciliation framework, signal extraction) with consumer-surface concerns (per-meeting UX, list-page digest, action-item carry-forward). The PRD split rule (≥3 of 6 criteria: distinct persona / distinct pod / ≥4 capabilities / independent DoD / section >8KB / distinct cross-fn consumers) was satisfied 6/6 by the Meetings surface scope.

## Decision
Promote Meetings AI surfaces to a sibling PRD (`PRD-MEETINGS-AI-SURFACES`) under the parent platform PRD. Move CAP-013 (multi-meeting digest) + all detail-page consumer surfaces into the new doc; keep platform contracts (CAP-001..009, CAP-011) in the parent.

## Consequences
- Two pods can iterate their PRDs independently (AI Platform on parent; Meetings pod on this).
- Cross-PRD contract surface: platform CAP-IDs are consumed by MEET-CAPs; changes to platform contracts must propagate.
- Decisions Log fork: MD-* prefix for Meetings-specific; D-* for platform; CD-* for connect-layer.
- Industry-pattern parallel: Amazon multi-customer PR/FAQ; Reforge sibling-PRD convention.

## Source
- Parent PRD D-011
- Industry research (Cagan / Amazon Working Backwards / Atlassian PRD-vs-spec) 2026-05-13
