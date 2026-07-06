---
id: ADR-CD-009
status: accepted
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-CONNECT-LAYER
related_decisions: [PRD-ZOOM-CONNECTOR ZD-004 (8–13wk review window)]
---

# ADR-CD-009 — Invalidate assumption "no Marketplace review delays"

## Context
PRD-CONNECT-LAYER v0.4.0 carried the assumption: "Zoom OAuth app provisioned and scopes pre-approved by Zoom; no marketplace review delays." During the PRD-ZOOM-CONNECTOR v0.1.0 drafting on 2026-05-14, research against developers.zoom.us + dev forum established that **Zoom Marketplace review is realistically 8–13 weeks** end-to-end (ZD-004). Recent (late 2025) forum reports cite this window when security findings require remediation. No SLA published.

## Decision
Invalidate the prior assumption. The Connect Layer PRD now treats Marketplace review as a hard external constraint, not a frictionless step. May 31 Rainforest runs on Zoom **dev-app credentials** (not yet published). Summer 2026 GA on the published app is only achievable if Marketplace submission lands by **2026-06-09**.

## Consequences
- New risk R1 in PRD §7: "Zoom Marketplace review slips past Summer 2026 GA" (Med-High likelihood).
- Production behind a feature flag that allows running on dev-app credentials for internal Rainforest only.
- GTM communications need to clarify "published Marketplace app" timing distinct from "feature available in Rainforest."
- Documented alternative path required if external launch must wait for Marketplace approval.

## Source
- PRD-ZOOM-CONNECTOR §14 ZD-004
- Signal log 2026-05-14 "Zoom platform findings"
- Research: developers.zoom.us app review process; dev forum 8–13wk reports
