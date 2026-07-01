---
id: ADR-MD-008
status: accepted
date: 2026-05-13 (PM)
deciders: Exec Sponsor (NL) + PM Owner (LM)
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [ADR-MD-003 (action item threading)]
---

# ADR-MD-008 — Agenda items also thread across recurring meetings

## Status
Accepted.

## Context
The 2026-05-13 Product Acceptance call surfaced a symmetry question: action items thread across recurring meetings (ADR-MD-003), but what about agenda items? In current product, agenda items are per-meeting and reset each session. The proposal was to extend threading semantics to agenda items so that carry-over topics ("we didn't get to X last week") surface on the next meeting's detail page rather than being lost or manually re-added.

## Decision
Agenda items SHALL also thread across recurring meetings — carry-over agenda topics surface on the next meeting's detail page with the same semantics as action items. MEET-CAP-203 (last-meeting recap) and MEET-CAP-204 (reconciliation flow) scope is expanded to include agenda items, not just action items.

## Consequences
- MEET-CAP-203/204 names updated to reflect "action + agenda" thread.
- Data-model extension: `agenda_item` schema gains a thread reference similar to `action_item` (covered in Enabler E-M01 scope).
- Symmetric UX between action and agenda items reduces cognitive load.
- "Carry-over agenda topic" becomes a measurable signal — could inform a future "things we keep meaning to discuss" surface.

## Source
- Product Acceptance call 2026-05-13 PM
- Confluence Meetings page edit (parent PRFAQ pageId 4281139203)
- PRD-MEETINGS-AI-SURFACES §10a MUST + §7 MEET-CAP-203/204
