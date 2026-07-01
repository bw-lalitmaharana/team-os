---
id: ADR-MD-002
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-MEETINGS-AI-SURFACES
---

# ADR-MD-002 — List digest is a rollup of confirmed outputs; no independent generation

## Status
Accepted.

## Context
Industry research on Granola, Notion AI Meetings, and Fellow established a clear pattern: per-meeting AI is the primary generation step; any list-page or cross-meeting view aggregates confirmed outputs rather than generating new content independently. The alternative — running a separate cross-meeting generation pass — risks producing suggestions the user has already dismissed and erodes trust.

## Decision
The MEET-CAP-101 list-level digest (V2) SHALL be a read-only rollup of confirmed per-meeting outputs from CAP-001/CAP-002. It SHALL NOT trigger independent AI generation. Logical grouping defaults to recency; filter "group by 1:1 partner" available.

## Consequences
- Cheaper inference cost (one generation per meeting, not per view).
- Consistent surface: anything a user sees in the list is something they confirmed on a detail page.
- Dismissals propagate: dismissed-on-detail = dismissed-in-list.
- List page has no value before any detail-page confirmations exist; bootstrap problem.
- Codified as §10a MUST in PRD body.

## Source
- Industry research 2026-05-13 (Granola, Notion AI Meetings model)
- PRD-MEETINGS-AI-SURFACES §10a + §7 MEET-CAP-101
