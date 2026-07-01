---
id: ADR-CD-008
status: accepted
date: 2026-05-13 (PM)
deciders: Exec Sponsor (NL)
related_prd: PRD-CONNECT-LAYER
related_decisions: [ADR-MD-008 platform-level mirror]
---

# ADR-CD-008 — Admin org-level enablement is a precondition for user-level OAuth connect

## Context
CONN-CAP-006 originally framed admin enablement as a kill-switch — admins could disable an integration org-wide but the default state was "available for users to connect." Enterprise sales feedback during the Product Acceptance call: this pattern fails procurement review. Lattice and Workday gate at the tenant boundary first; user-level consent is downstream of admin enablement. Reduces blanket-consent risk and lets admins stage rollout.

## Decision
Admin-level org enablement SHALL be a **precondition** for user-level OAuth connect. The integration is OFF by default in every tenant. No end user can initiate Zoom OAuth until the tenant super-admin has enabled Zoom integration at the org level. Admins still CANNOT connect on a user's behalf (ADR-CD-003 holds).

## Consequences
- CONN-CAP-006 scope expanded: not just kill-switch, but precondition gate.
- End-user surface adapts: "Your admin needs to enable Zoom integration first" copy when admin hasn't enabled; "Connect Zoom" CTA when admin has.
- Enterprise sales motion improves: customers can see a tenant-scoped integration pattern at the demo.
- Zoom-specific projection: PRD-ZOOM-CONNECTOR ZOOM-CAP-010.

## Source
- Product Acceptance call 2026-05-13 PM
- PRD-CONNECT-LAYER §A.2 CONN-CAP-006 + §5 MUST
