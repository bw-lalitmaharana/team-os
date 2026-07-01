---
id: ADR-D-018
status: accepted (mirror)
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE
canonical: ADR-ZD-004 (PRD-ZOOM-CONNECTOR)
also_mirrored_by: ADR-CD-009
---

# ADR-D-018 — Zoom Marketplace review window = 8–13 weeks (platform-level acknowledgment)

## Context
Research conducted during PRD-ZOOM-CONNECTOR v0.1.0 drafting (2026-05-14) established that Zoom Marketplace review is realistically 8–13 weeks (canonical ADR-ZD-004). This is a hard external constraint that affects platform PRD risk surface — May 31 Rainforest runs on dev-app credentials; Summer GA on the published app requires submission by 2026-06-09.

## Decision
Platform-level acknowledgment: Marketplace review window of 8–13 weeks is a hard external constraint. Acknowledged in PRD §7 risk R3 with Med-High likelihood. Canonical decision is ADR-ZD-004 in PRD-ZOOM-CONNECTOR.

## Consequences
- New risk R3 in platform PRD §7.
- Dev-app posture for Rainforest tracked via ZOPEN-D4 (PRD-ZOOM-CONNECTOR).
- Production behind feature flag on dev-app credentials for internal Rainforest only.

## Source
- Canonical: ADR-ZD-004
- Cross-referenced: ADR-CD-009
- PRD-AI-PROCESSING-PIPELINE §7 R3
