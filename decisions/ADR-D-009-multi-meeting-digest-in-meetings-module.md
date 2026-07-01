---
id: ADR-D-009
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE
related_decisions: [later moved to PRD-MEETINGS-AI-SURFACES; supersedes earlier "cross-module digest" framing]
---

# ADR-D-009 — Multi-meeting digest scoped into MVP as a Meetings-module feature (CAP-013)

## Context
Earlier scoping included a "cross-module digest" as a separate surface — a global view aggregating signals across Goals/Feedback/Skills/Meetings. Question: is "multi-meeting" a separate-surface concern or a Meetings-module concern? Industry pattern (Granola/Notion) is the latter: per-meeting AI is primary; cross-meeting view is a rollup of confirmed outputs *within* the Meetings surface, not a separate global page.

## Decision
The "multi-meeting digest" is reframed as **CAP-013 — a Meetings-module feature**, not a separate cross-module surface. The Meetings page is the natural home for both per-meeting AI (CAP-201..205) and across-meeting digest (CAP-101 rollup). Later moved to PRD-MEETINGS-AI-SURFACES MEET-CAP-101/202/203 when that PRD was split off (ADR-D-011).

## Consequences
- No separate "cross-module digest" page in MVP.
- Meetings module owns the multi-meeting experience.
- MEET-CAP-101 (list-level rollup) was later demoted to V2 per ADR-MD-006 — but the architectural home remained Meetings.
- Cross-module reasoning (e.g., "skill themes across Slack + meetings + Jira") is deferred indefinitely; if it ships, it's a Talent / Skills surface, not its own page.

## Source
- PRD-AI-PROCESSING-PIPELINE §A.3 (later removed from cross-module surface list)
- PRD-MEETINGS-AI-SURFACES inherits this as MEET-CAP-101..205 home
