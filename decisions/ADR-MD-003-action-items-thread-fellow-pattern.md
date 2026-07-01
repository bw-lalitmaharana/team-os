---
id: ADR-MD-003
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-MEETINGS-AI-SURFACES
---

# ADR-MD-003 — Action items thread across recurring meetings as the same object

## Status
Accepted.

## Context
Industry pattern study (Fellow, MeetGeek) showed two distinct approaches to multi-meeting action item handling: (a) re-extract action items per meeting and "diff" against open ones — complex, brittle, prone to duplication; (b) thread action items as a single object across the recurring meeting series — simple, matches user mental model that "what we agreed last week" is the same commitment, not a new one. Fellow's adoption data supports (b).

## Decision
The Meetings module SHALL thread `action_item` objects across recurring meetings using a single `action_item.id` that carries forward until `state = done` or `state = dismissed`. AI-suggested new items append to the thread; carry-forward items remain in the carry-forward section until acted on.

## Consequences
- Data-model change: `action_item` schema extended with thread reference and status transitions (Enabler E-M01).
- Carry-forward section in MEET-CAP-204 is a render of the same objects, not duplicates.
- Visual distinction required between carry-forward and new (see ADR-MD-005).
- "Completion lift" metric (DO-MGR-03) becomes meaningful because the same item can be tracked across meetings.
- Locks the `action_item.id` contract — changing it breaks every carry-forward.

## Source
- Industry research 2026-05-13 (Fellow pattern; carry-forward semantics)
- PRD-MEETINGS-AI-SURFACES §10a MUST + Appendix B E-M01
