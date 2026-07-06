---
id: ADR-D-013
status: accepted
date: 2026-05-13 (PM)
deciders: Exec Sponsor (NL)
related_prd: PRD-AI-PROCESSING-PIPELINE
supersedes: ADR-D-012(a) (Zoom-as-"MVP if doable")
---

# ADR-D-013 — Automated Zoom ingestion is MVP required (not "if doable"); manual paste is demo-only

## Context
Earlier-same-day decision ADR-D-012(a) had elevated Zoom API ingestion from Phase-2-deferred to "MVP if doable" with manual paste as the customer fallback. At the 2026-05-13 PM Product Acceptance call, Exec Sponsor reviewed and stated: **"Manual upload is a non-starter for adoption."** Customers will not pre-paste transcripts; automated ingestion is the product commitment. Path forward: automated Zoom Cloud Recording API ingestion is MVP-required, not optional.

## Decision
**Automated Zoom transcript ingestion (Cloud Recording API + webhook + admin-enable + user-OAuth) is MVP required.** Manual paste path is demoted from MVP customer fallback → **internal demo-only safety net**. Not a customer path. Ownership fallback: AI Platform Lead absorbs adapter ownership if Integrations pod cannot deliver in the Summer window.

## Consequences
- Integrations pod sprint planning: Zoom adapter is now a commitment, not a stretch.
- Drives the entire PRD-ZOOM-CONNECTOR sub-spec (Marketplace app, OAuth, webhooks, deauth, transcript fetch).
- New risk R2 in PRD-AI-PROCESSING-PIPELINE §7 (High likelihood — Zoom integration delivery).
- Manual paste path (S-03) demoted to "demo-only safety net" — not abandoned but reframed as demo scaffolding only.
- AI Platform Lead identified as fallback owner if Integrations capacity fails.
- Cascading: drives ADR-D-014 (Aurora), ADR-D-016 (admin precondition), and the full PRD-ZOOM-CONNECTOR creation.

## Source
- Zoom uuid 7D6A937E-6C54-4362-8AD2-8E16FF3E2A96 (Product Acceptance call, 2026-05-13 PM)
- `ops/action-notes/2026-05-13-nellie-product-acceptance.md`
