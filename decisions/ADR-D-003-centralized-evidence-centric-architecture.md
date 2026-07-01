---
id: ADR-D-003
status: accepted
date: 2026-05-08
deciders: Exec Sponsor (NL) + PM Owner (LM) + Design Lead (GT)
related_prd: PRD-AI-PROCESSING-PIPELINE
related_decisions: [ADR-D-008 (evidence schema lock)]
---

# ADR-D-003 — Centralized suggestion architecture: evidence-centric + reconciliation framework + per-user data

## Context
Two architectural patterns considered for routing AI signals to the four destination modules (Goals, Feedback, Skills, Meetings): (a) per-module pipelines — each module ingests its own transcript signals, runs its own dedup logic, owns its own UI — duplicates effort and produces inconsistent suggestions across modules; (b) centralized evidence model — one schema for all signals, one reconciliation framework, module-native surfacing — single source of truth, cross-module consistency.

## Decision
Adopt **(b) centralized evidence-centric architecture**: one `evidence` table; one Reconciliation Framework (CAP-005) that links evidence to Betterworks objects; module-native surfacing per object. **No global suggestions queue** — each module surfaces its own AI signals on its existing page. Per-user data partitioning at the row level.

## Consequences
- Single contract for all AI signals (lower complexity, lower duplication).
- Reconciliation logic centralized in one framework (CAP-005); tunable per signal type.
- Cross-module dedup is free (same evidence row, multiple object links).
- Module-native surfacing (CAP-006) — Goals page surfaces goals; Feedback page surfaces drafts; etc.
- "AI inbox" or global queue is explicitly rejected — users see suggestions where they already work.
- Drives ADR-D-008 schema lock + ADR-D-014 storage tier (Aurora).

## Source
- Zoom uuid F6113EF7-3757-491E-B45C-4B1E53D8D31F (MVP scope alignment, 2026-05-08)
- PRD-AI-PROCESSING-PIPELINE §3 + §5 MUST NOT
