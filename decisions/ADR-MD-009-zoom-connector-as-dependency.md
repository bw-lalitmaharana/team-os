---
id: ADR-MD-009
status: accepted
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [PRD-ZOOM-CONNECTOR ZD-004 (Marketplace review timeline)]
---

# ADR-MD-009 — Add PRD-ZOOM-CONNECTOR as dependency; refactor §7 capabilities to canonical reference table

## Status
Accepted.

## Context
On 2026-05-14, the new `PRD-ZOOM-CONNECTOR` sub-spec (v0.1.0) shipped under `PRD-CONNECT-LAYER`. Research conducted during its drafting invalidated a parent-layer assumption ("Zoom OAuth app provisioned and scopes pre-approved by Zoom; no marketplace review delays"): actual Marketplace review timeline is 8–13 weeks (ZD-004). This materially affects PRD-MEETINGS-AI-SURFACES because the detail-page AI surfaces (MEET-CAP-201/202/203/204) all consume Zoom transcripts — if the Marketplace review slips past Rainforest, demo data has no source unless the dev-app posture (ZOPEN-D4) is locked.

Additionally, the same pass refactored §7 Capabilities from prose-with-embedded-constraints into a canonical reference table + capability detail block, for readability.

## Decision
- Add `PRD-ZOOM-CONNECTOR` to §10 Dependencies and §12 Documentation links.
- Surface a new risk R5 (Zoom transcript availability gated by Marketplace review) with Med-High likelihood + mitigation tracking ZOPEN-D4.
- Refactor §7 to a canonical capability reference table with `MEET-CAP-ID | Name | Surface | MVP/V2 | Consumes platform CAPs | Aha | Jira | Last change` columns; preserve capability detail prose below the table.
- Tabularize §3 Benefits and §10 Dependencies + Risks (separate readability pass).

## Consequences
- This PRD is now a 3-tier consumer: it depends on PRD-AI-PROCESSING-PIPELINE (platform contracts) + PRD-CONNECT-LAYER (consent flow) + PRD-ZOOM-CONNECTOR (transcript data path).
- R5 risk owner = PM Owner; tracking via ZOPEN-D4 deadline 2026-05-20.
- §7 reference table becomes the canonical source for eng handoff — capability detail prose is supporting.
- Set the stylistic precedent later applied to all four PRDs in the trio (table refactor pass, then story-driven spine in v0.4.0).

## Source
- PRD-ZOOM-CONNECTOR §14 ZD-004 (Marketplace review timeline)
- Signal log entry 2026-05-14 ("Zoom platform findings")
- PRD-MEETINGS-AI-SURFACES v0.3.1 changeset
