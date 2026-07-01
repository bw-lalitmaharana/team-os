---
id: ADR-D-016
status: accepted
date: 2026-05-13 (PM)
deciders: Exec Sponsor (NL)
related_prd: PRD-AI-PROCESSING-PIPELINE
mirrors: ADR-CD-008 (parent invariant for Connect Layer)
---

# ADR-D-016 — Admin-level org enablement is a precondition for user-level OAuth connect

## Context
Enterprise sales requirement: customers refuse to deploy integrations where end users self-authorize before the admin has enabled the integration at the tenant level. Lattice + Workday gate at the tenant boundary first; user-level consent is downstream. Reduces blanket-consent risk and lets admins stage rollout.

## Decision
Admin-level org enablement SHALL be a **precondition** for user-level OAuth connect to any source. The integration is OFF by default in every tenant. No end user can initiate OAuth until the tenant super-admin has enabled the integration at the org level. Admins still CANNOT connect on a user's behalf (separate invariant, ADR-CD-003).

## Consequences
- Platform-level invariant; inherited by all source-specific PRDs.
- CONN-CAP-006 scope expanded (ADR-CD-008 — Connect Layer projection).
- ZOOM-CAP-010 implements the Zoom-specific surface.
- Enterprise sales motion improves: customers can demo a tenant-scoped integration pattern.
- End-user surface adapts based on tenant state: "Your admin needs to enable Zoom integration first" vs "Connect Zoom" CTA.

## Source
- Product Acceptance call 2026-05-13 PM
- PRD-AI-PROCESSING-PIPELINE §5 MUST
- Parallel ADR-CD-008 in PRD-CONNECT-LAYER
