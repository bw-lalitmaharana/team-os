---
id: ADR-D-011
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE
related_decisions: [ADR-MD-001 (Meetings split), ADR-CD-001 (Connect Layer split)]
---

# ADR-D-011 — Split PRD: Meetings AI Surfaces + Connect Layer promoted to sibling PRDs

## Context
The parent PRD-AI-PROCESSING-PIPELINE had crossed 60KB and conflated platform contracts with consumer-surface concerns (UX, list-page digest, action-item carry-forward) and auth concerns (OAuth, consent, revoke matrix, retention). Both child scopes satisfied ≥3 of 6 split criteria (distinct persona / distinct pod / ≥4 capabilities / independent DoD / section >8KB / distinct cross-fn consumers).

## Decision
Promote two sibling PRDs under this platform PRD:
- **PRD-MEETINGS-AI-SURFACES** — Meetings module surface, action-item threading, list/detail page AI
- **PRD-CONNECT-LAYER** — auth, consent, OAuth, revoke matrix, retention

Platform PRD retains: evidence schema, reconciliation framework, signal extraction, source adapter contract, Why-this panel, module-native surfacing principle.

## Consequences
- Three pods iterate their PRDs independently (AI Platform, Meetings, Connections).
- Cross-PRD contracts: CAP-IDs (CAP-001..011) consumed by MEET-CAP-* and CONN-CAP-*.
- Decision ID prefixes fork: D-* (platform), MD-* (meetings), CD-* (connect-layer); later ZD-* added for PRD-ZOOM-CONNECTOR sub-spec.
- CAP-012 (revoke matrix) detail moves to PRD-CONNECT-LAYER; CAP-013 (multi-meeting digest) detail moves to PRD-MEETINGS-AI-SURFACES.
- Matches Amazon multi-customer PR/FAQ pattern and Atlassian PRD-vs-spec convention.

## Source
- Industry research (Cagan / Amazon Working Backwards / Atlassian) 2026-05-13
- PRD-AI-PROCESSING-PIPELINE §3 + sub_prds frontmatter
