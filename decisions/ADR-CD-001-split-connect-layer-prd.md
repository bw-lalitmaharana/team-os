---
id: ADR-CD-001
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-CONNECT-LAYER
related_decisions: [parent PRD D-011, ADR-MD-001]
---

# ADR-CD-001 — Split Connect Layer into sibling PRD

## Context
Parent PRD-AI-PROCESSING-PIPELINE conflated platform contracts with user-driven auth + consent. The Connect Layer scope satisfied 5/6 split criteria: distinct pod (Connections), distinct security/legal review path, ≥4 capabilities, independent DoD, distinct cross-fn consumers.

## Decision
Promote Connect Layer to a sibling PRD under the platform PRD. Move CAP-012 (revoke matrix) + all consent + state machine + retention semantics here. Keep platform contracts (CAP-001..011) in parent.

## Consequences
- Connections pod can iterate independently from AI Platform pod.
- Cross-PRD contract: platform evidence schema honors `connection.state`; CONN-CAP-004 propagates `locked=true`.
- CD-* prefix forks from D-* (platform) and MD-* (meetings surfaces).
- Sub-spec relationship later established with PRD-ZOOM-CONNECTOR for Zoom-specific implementation.

## Source
- Parent PRD D-011
- Industry research 2026-05-13 (Amazon multi-PR/FAQ, Atlassian PRD-vs-spec)
