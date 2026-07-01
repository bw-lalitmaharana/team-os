---
id: ADR-CD-010
status: accepted
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-CONNECT-LAYER
related_decisions: [PRD-ZOOM-CONNECTOR ZD-001]
---

# ADR-CD-010 — Zoom adapter is a Marketplace General App, User-managed

## Context
Zoom unified Marketplace app types in Sep 2024 under a single "General App" build flow, with two management modes: User-managed (per-user OAuth, individual users install) or Admin-managed (account admin installs for the whole tenant). Server-to-Server OAuth remains a separate non-Marketplace app type (single-tenant, not publishable). For multi-tenant SaaS published on Marketplace with per-user OAuth consent (ADR-CD-003), the correct choice is unambiguous.

## Decision
The Zoom adapter SHALL be implemented as a **Zoom Marketplace General App, User-managed, "Intend to publish: Yes."** Server-to-Server is ruled out (single-tenant, non-publishable). Admin-managed remains available as an alternate install path for enterprise customers who want admin-level rollout but is not the default for MVP.

## Consequences
- Locks app-type contract for PRD-ZOOM-CONNECTOR ZOOM-CAP-001.
- All OAuth flows are per-user (matches ADR-CD-003).
- Admin enablement (ADR-CD-008) is a Betterworks-side tenant gate, not a Zoom-side app installation pattern.
- Future re-decision (e.g., adding Admin-managed variant for an enterprise customer) requires explicit reopen of this ADR via ZOPEN-D1.

## Source
- PRD-ZOOM-CONNECTOR §14 ZD-001
- developers.zoom.us/docs/build-flow/create-oauth-apps/
- devforum.zoom.us (post-Sep-2024 unified flow announcement)
