---
id: ADR-D-004
status: accepted
date: 2026-05-12
deciders: Cross-pod PM Meetings/Goals (VG)
related_prd: PRD-AI-PROCESSING-PIPELINE
---

# ADR-D-004 — AI goal suggestions pass through Goals admin validation framework

## Context
Goals in Betterworks have org-level governance (scope, type, mandatory attributes) enforced by the Goals admin validation framework. Question: when AI suggests a goal update or new-goal proposal, does it bypass governance (faster but undermines admin control) or pass through validation (slower but respects governance)?

## Decision
AI-suggested goal-type signals SHALL pass through the org's existing Goals admin validation framework before publishing to the Goals record. CAP-007 implements this as a passthrough — the AI does not bypass admin-defined goal rules.

## Consequences
- Goals admin governance is preserved; no shadow goal-creation path via AI.
- Slight latency overhead on goal-suggestion confirmation (validation is synchronous).
- Goals pod owns the validation framework; this PRD just calls it (CAP-007).
- Validates the broader "augment, not act" invariant: AI suggests; the system's existing guards still apply.

## Source
- Zoom uuid D236D5E5-A01C-4D20-91C3-935FF3588D90 (Varnika / Lalit, 2026-05-12)
- PRD-AI-PROCESSING-PIPELINE §5 MUST + §A.2 CAP-007
