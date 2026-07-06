---
id: ADR-ZD-001
status: accepted
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-ZOOM-CONNECTOR
mirrors: ADR-CD-010 (parent-PRD acknowledgment)
---

# ADR-ZD-001 — Zoom Marketplace app type = General App, User-managed, "Intend to publish: Yes"

## Context
Research against Zoom developer docs (developers.zoom.us) on 2026-05-14 established the platform-defined options post-Sep-2024 unified build flow: General App with management type User-managed (per-user OAuth) or Admin-managed (account-level admin install). Server-to-Server OAuth is a separate non-Marketplace app type — single-tenant, non-publishable, not viable for multi-tenant SaaS.

For Betterworks (multi-tenant SaaS, per-user OAuth consent per ADR-CD-003, Marketplace-published for procurement-readiness per JS-012), the platform-correct choice is unambiguous.

## Decision
Zoom adapter SHALL be implemented as a **Zoom Marketplace General App, User-managed, "Intend to publish: Yes"**. Admin-managed remains available as an alternate install path for enterprise customers requesting it, but is not the MVP default. Server-to-Server is ruled out.

## Consequences
- Locks ZOOM-CAP-001 app-type contract.
- Per-user OAuth flow (matches ADR-CD-003).
- Each Betterworks customer (Zoom account) sees individual users complete OAuth — admin enables at tenant level (ADR-CD-008), users grant consent themselves.
- Any future re-decision (e.g., adding an Admin-managed variant for a specific enterprise customer) requires explicit reopen via ZOPEN-D1.
- Parent PRD-CONNECT-LAYER acknowledges this in ADR-CD-010.

## Source
- developers.zoom.us/docs/build-flow/create-oauth-apps/
- devforum.zoom.us — post-Sep-2024 unified flow announcement
- PRD-ZOOM-CONNECTOR §5 MUST + §1 Problem
