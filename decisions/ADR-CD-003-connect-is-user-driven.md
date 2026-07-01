---
id: ADR-CD-003
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-CONNECT-LAYER
---

# ADR-CD-003 — Connect is user-driven; admins cannot connect on user's behalf

## Context
Enterprise integrations sometimes default to admin-driven SSO-style bulk connect (admin authorizes once, all users in tenant are connected). This pattern simplifies deployment but removes per-user agency over what data feeds the performance system. For a feature that ingests meeting transcripts — content with high privacy expectations — this trade-off fails.

## Decision
Connect is user-driven. Each end user must complete OAuth consent themselves. Admins SHALL NOT be able to connect a source on a user's behalf. Admins enable the integration at the tenant level (CONN-CAP-006), but cannot proxy the user's consent grant.

## Consequences
- Each user sees the OAuth consent screen with explicit scope disclosure.
- Lower bulk-deployment velocity for admins, but cleaner consent posture.
- Pairs with ADR-CD-008 (admin precondition): admin gates whether users *can* connect; users decide whether *to* connect.
- Reduces blanket-consent risk in Security and Legal review.

## Source
- Industry research 2026-05-13 (security best practice)
- PRD-CONNECT-LAYER §5 MUST NOT
