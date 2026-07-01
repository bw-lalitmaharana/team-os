---
id: ADR-MD-007
status: accepted
date: 2026-05-13 (PM)
deciders: Exec Sponsor (NL)
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [ADR-MD-003 (threading mechanic)]
---

# ADR-MD-007 — Action item carry-forward is DEFAULT, not user-configurable

## Status
Accepted.

## Context
During the 2026-05-13 Product Acceptance call, the question arose whether users (managers) should be able to opt-out of action-item carry-forward per recurring meeting series. Two patterns considered: (a) carry-forward is a default behavior with no user-facing toggle — simpler surface, matches user mental model that incomplete commitments persist; (b) carry-forward is opt-in or has a per-series toggle — more user control, larger settings surface, easier to disable accidentally. Exec Sponsor framing: "More features require removing features."

## Decision
Action-item carry-forward across recurring meetings SHALL be DEFAULT behavior. There SHALL NOT be a user-facing configuration toggle to disable carry-forward per series, per user, or per meeting in MVP. Users can mark individual items `done` or `dismissed`, which removes them from the carry-forward thread — that is the supported path.

## Consequences
- Reduced settings surface; no admin or user toggle needed.
- Matches user mental model: "what we agreed last week is still on the table until we close it out."
- A user who wants to abandon a carry-forward thread must mark items dismissed (or done) explicitly.
- Pairs with ADR-MD-003 (threading mechanic) — together these define the carry-forward contract.
- Codified as §10a MUST.

## Source
- Product Acceptance call 2026-05-13 PM
- PRD-MEETINGS-AI-SURFACES §10a MUST
