---
id: ADR-ZD-002
status: proposed (working assumption pending refinement)
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-ZOOM-CONNECTOR
open_decision: ZOPEN-D2 (confirm or reverse before Marketplace submission)
---

# ADR-ZD-002 — Working assumption: persist raw transcripts in Betterworks

## Context
The PRD-ZOOM-CONNECTOR drafting on 2026-05-14 surfaced an unresolved question: does Betterworks persist raw transcript text in our own datastore, or process-and-discard (ingest → extract signals → drop raw text; only signals persist)? The storage decision changes (a) the Marketplace submission Technical Design Document (TDD) data-handling description; (b) Security/Legal review depth; (c) potential DSAR scope. AI Platform Lead + Security pod had not yet weighed in at PRD draft time.

To allow the PRD to advance, a working assumption was required.

## Decision
**Working assumption (pending AI/Security refinement):** Betterworks SHALL persist raw transcripts. Marketplace submission TDD will be drafted on this basis. If reversed in refinement (ZOPEN-D2), the storage description in the TDD must be revised; scope-justification copy and OAuth scope set are unaffected.

## Consequences
- TDD storage section is draftable.
- ZOPEN-D2 tracked as open decision; deadline before Marketplace submission target (2026-06-09).
- Security/Legal review scope depends on this — if reversed to process-and-discard, review is materially easier.
- DSAR responses, if persisted, must cover raw transcripts; if discarded, only extracted signals are in scope.
- This ADR is **proposed**, not **accepted** — promotes to accepted only after refinement-call decision.

## Source
- PRD-ZOOM-CONNECTOR §1 Problem (working assumption note) + ZOPEN-D2
- Signal log 2026-05-14
