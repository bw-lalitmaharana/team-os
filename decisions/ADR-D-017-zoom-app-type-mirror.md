---
id: ADR-D-017
status: accepted (mirror)
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE
canonical: ADR-ZD-001 (PRD-ZOOM-CONNECTOR)
also_mirrored_by: ADR-CD-010
---

# ADR-D-017 — Zoom Marketplace app type = General App, User-managed (platform-level acknowledgment)

## Context
PRD-ZOOM-CONNECTOR v0.1.0 (2026-05-14) locked the Zoom app type after research against developers.zoom.us. The platform PRD (this one) needs to acknowledge the constraint in its §5 MUST so that any future cross-PRD reasoning (e.g., CAP-011 adapter contract evolution) respects the lock.

## Decision
Platform-level acknowledgment: the Zoom adapter SHALL be implemented as a Zoom Marketplace General App, User-managed, "Intend to publish: Yes" (per ADR-ZD-001). This ADR is the platform-PRD mirror; canonical home is ADR-ZD-001 in PRD-ZOOM-CONNECTOR.

## Consequences
- CAP-011 adapter contract evolution must not assume a tenant-wide install model for Zoom.
- Any future re-decision flows through ZOPEN-D1 and updates this ADR + ADR-ZD-001 + ADR-CD-010.

## Source
- Canonical: ADR-ZD-001
- Cross-referenced: ADR-CD-010
- PRD-AI-PROCESSING-PIPELINE §5 MUST
