---
id: ADR-CD-002
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-CONNECT-LAYER
---

# ADR-CD-002 — Disconnect locks evidence; does not delete

## Context
Two patterns considered for revoke semantics: (a) disconnect immediately deletes all evidence sourced from that connection — clean but destroys audit trail and explainability; (b) disconnect soft-locks evidence (`locked=true`) and starts a retention clock; hard-delete requires an explicit user/admin request with a 30-day grace period. Industry comparisons: Gong locks, Microsoft Graph locks. Aggressive deletion only on explicit DSAR.

## Decision
Disconnect SHALL soft-lock evidence (`locked=true`); it SHALL NOT hard-delete. Hard-delete requires an explicit user (or admin) request and respects a 30-day grace period. Retention defaults: 90d pending / 180d locked / 90d dismissed, tunable per tenant.

## Consequences
- Existing AI suggestions remain visible to the user post-disconnect (with "locked" treatment) until retention reaper.
- Manager can still review what happened before they revoked.
- GDPR/DSAR responses require admin tooling to query locked evidence (R3 risk in PRD).
- Pairs with revoke matrix in PRD §A.3.

## Source
- Industry research 2026-05-13 (Gong, Microsoft Graph patterns)
- PRD-CONNECT-LAYER §1a revoke matrix + §5 MUST
