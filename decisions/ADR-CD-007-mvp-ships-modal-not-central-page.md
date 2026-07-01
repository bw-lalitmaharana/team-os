---
id: ADR-CD-007
status: accepted
date: 2026-05-13 (PM)
deciders: Exec Sponsor (NL)
related_prd: PRD-CONNECT-LAYER
---

# ADR-CD-007 — MVP ships Zoom connect modal (CONN-CAP-001a); central Connections page deferred to V2

## Context
The original Connect Layer design included a full Central Connections page under user settings (CONN-CAP-001) — a one-stop view of all integrations, connect/reconnect/revoke per app, status badges. The Product Acceptance call surfaced that a settings page becomes useful only when there are multiple sources to manage; in MVP there's only Zoom (Teams is contingent). Building a full page for one source is over-engineering.

## Decision
MVP ships a lightweight **Zoom connect modal** (CONN-CAP-001a, NEW) triggered from the Meetings page. Modal handles OAuth consent, scope display, completion. **CONN-CAP-001 (full Connections page) is deferred to V2** when there are several sources worth listing. Subsequent revoke/reconnect flows route through the same modal via banner trigger.

## Consequences
- Lower MVP eng surface (one modal vs full settings page).
- Users connect at the moment of value (Meetings page), not by navigating to a separate settings surface.
- Stories M-04 / C-03a use modal; ~~C-03~~ (Central page) deferred.
- Cleaner connect funnel: banner click → modal → consent → done, single surface.

## Source
- Product Acceptance call 2026-05-13 PM (Zoom uuid 7D6A937E)
- PRD-CONNECT-LAYER §A.2 (CONN-CAP-001a NEW, CONN-CAP-001 → V2)
