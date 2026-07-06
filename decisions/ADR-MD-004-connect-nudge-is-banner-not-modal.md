---
id: ADR-MD-004
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-MEETINGS-AI-SURFACES
---

# ADR-MD-004 — Connect-source nudge is banner + empty-state, never modal

## Status
Accepted.

## Context
The Meetings page needs to prompt users to connect their Zoom account, otherwise the AI surfaces have no input. Two patterns considered: (a) modal demand on first visit — high conversion but interrupts mental model and breeds resentment; (b) persistent dismissable banner + per-card empty-state CTAs — lower per-impression conversion but re-surfaces at value moments and doesn't block work. Banner-blindness is a known risk for (b), mitigated by contextual per-card empty-states.

## Decision
The connect-source nudge SHALL be implemented as a persistent dismissable banner on the list-page top, paired with an empty-state CTA on any meeting card lacking transcript data. The CTA SHALL re-surface when a new untranscribed meeting appears. The connect flow SHALL NOT be modal or otherwise block the user.

## Consequences
- MEET-CAP-103 (connect-source nudge) defines this two-surface pattern.
- Higher engineering surface (banner + N empty-states) but better UX.
- Pre-mortem failure mode #3 (banner blindness) is mitigated by per-card empty-states; instrument banner-dismiss vs empty-state-click rates to verify.
- Codified as §10a MUST in PRD body.

## Source
- Industry research 2026-05-13 (banner-blindness mitigations from Slack, Notion)
- PRD-MEETINGS-AI-SURFACES §10a MUST + §7 MEET-CAP-103
