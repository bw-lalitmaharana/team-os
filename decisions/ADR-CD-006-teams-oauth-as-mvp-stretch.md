---
id: ADR-CD-006
status: accepted
date: 2026-05-13
deciders: Exec Sponsor (NL)
related_prd: PRD-CONNECT-LAYER
related_decisions: [ADR-CD-005 (which it supersedes on Teams scope)]
---

# ADR-CD-006 — Teams OAuth upgraded to good-to-have stretch in MVP

## Context
The parent Confluence PRFAQ (pageId 4247257097) lists Microsoft Teams as Path A — a stated GTM commitment for the Summer 2026 release. Earlier scoping (ADR-CD-005) deferred Teams past Summer 2026 for MVP discipline. Exec Sponsor flagged the inconsistency 2026-05-13: the public-facing PRFAQ promises Teams; the operational PRD defers it. One must move.

## Decision
Microsoft Teams OAuth (INT-181) is elevated from "deferred past Summer 2026" to **good-to-have MVP stretch**. In scope only if the Zoom path (CONN-CAP-003 + PRD-ZOOM-CONNECTOR) lands early enough to free Integrations pod capacity. Not a commitment — a contingent goal.

## Consequences
- Aligns Connect Layer with parent Confluence PRFAQ.
- Integrations pod capacity planning now has a contingent Teams workstream.
- ADR-CD-005 is partially superseded for the Teams scope clause; Zoom-only-in-MVP remains the firm commitment.
- GTM messaging can mention Teams as a stretch without overpromising.

## Source
- Exec alignment 2026-05-13
- Parent Confluence PRFAQ (pageId 4247257097)
