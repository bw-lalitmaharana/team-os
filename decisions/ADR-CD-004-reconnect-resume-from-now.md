---
id: ADR-CD-004
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-CONNECT-LAYER
---

# ADR-CD-004 — Reconnect resumes from "now" by default; back-fill is opt-in

## Context
When a user reconnects after a token expiry or voluntary disconnect, two patterns: (a) automatically back-fill all historical transcripts available since disconnect — maximum data but surprises the user with reprocessing of data they may have intentionally let go; (b) resume from "now" by default with an opt-in option to back-fill the last 30 days — user controls historical scope.

## Decision
Reconnect SHALL default to resume-from-now. Opt-in back-fill SHALL be offered as a one-click option ("Back-fill last 30 days?") at reconnect time. Back-fill window is bounded to 30 days; longer windows require admin action.

## Consequences
- No surprise reprocessing of data the user expected to be gone.
- Story split: C-06a (reconnect happy path) + C-06b (opt-in back-fill) — different UX moments and API workloads.
- Manager who briefly disconnected to deal with a sensitive period can resume without auto-ingesting that period.
- 30-day cap balances coverage against rate-limit exposure on Zoom.

## Source
- PRD-CONNECT-LAYER §1a state machine + §A.2 CONN-CAP-005
