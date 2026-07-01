---
id: ADR-MD-005
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [pre-mortem failure mode #2]
---

# ADR-MD-005 — Carry-forward and new AI-suggested action items are visually distinct

## Status
Accepted.

## Context
The pre-mortem exercise (run during PRD §10b drafting) identified failure mode #2: "Action item reconciliation visually conflated carry-forwards with AI suggestions; managers couldn't tell what was 'still open' vs 'new' and started ignoring the list." This is the most plausible single point of UX failure for the detail page. Without explicit visual separation, the reconciliation flow degrades to a noisy list.

## Decision
The detail page's MEET-CAP-204 reconciliation flow SHALL render two visually distinct sections: (1) **Carry-forward** — open action items from prior meetings, with sub-heading "From prior meetings" and a status badge per item; (2) **New from transcript** — AI-suggested pending chips, with sub-heading "New from this meeting" and pending-state visual treatment. Confidence labels on AI items deferred per ADR-MD-005 supplementary decision (Why-this panel is the trust mechanism instead).

## Consequences
- MPAC-03 acceptance bar: ≥90% of user-testing participants can tell carry-forward apart from new at a glance.
- Design Lead owns the visual treatment.
- Rainforest user testing required pre-launch to validate the 90% bar.
- Confidence labels remain available but rendered only on items below a threshold (SHOULD, not MUST).

## Source
- PRD-MEETINGS-AI-SURFACES §10b Pre-mortem (failure mode #2)
- §10a SHOULD + §13a MPAC-03
