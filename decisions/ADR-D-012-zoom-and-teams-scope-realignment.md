---
id: ADR-D-012
status: superseded (partially, on Zoom scope by ADR-D-013)
date: 2026-05-13 (AM)
deciders: Exec Sponsor (NL)
related_prd: PRD-AI-PROCESSING-PIPELINE
superseded_by: ADR-D-013 (Zoom = MVP required, not "if doable")
---

# ADR-D-012 — Zoom + Teams scope realignment with parent Confluence PRFAQ

## Context
Discrepancy between the operational PRD (which deferred automated Zoom ingestion past Summer 2026 and marked Teams MUST-NOT) and the parent Confluence PRFAQ (which lists "Zoom & Teams Transcripts" as a Summer 2026 commitment, with Teams as Path A). Exec Sponsor flagged 2026-05-13 AM: PRD must align with PRFAQ.

Three sub-decisions:
- (a) Zoom API ingestion: Phase-2-deferred → "MVP if doable"; manual paste remains MVP fallback.
- (b) Microsoft Teams ingestion: MUST-NOT-Summer-2026 → good-to-have stretch (in scope if Zoom lands early).
- (c) Backfill from parent Confluence: release theme ("AI in the Flow of Work"), Level A Revenue Creator classification, Aha! IDs (AI-201, MEET-48, INT-181, INT-185, INT-I-110, AI-I-52), Innovation Partner Program early-access cohort.

## Decision
Apply (a), (b), (c) as scope adjustments. **Partial supersession 2026-05-13 PM (ADR-D-013):** sub-decision (a) was elevated from "MVP if doable" → "MVP required" later that day at the Product Acceptance call. Sub-decisions (b) and (c) remain accepted.

## Consequences
- Trio aligned with parent Confluence PRFAQ.
- Teams adapter (INT-181) added to Connect Layer as MVP stretch (later codified ADR-CD-006).
- Release classification "Level A — Revenue Creator" anchored in frontmatter.
- Aha! IDs added to §C resources across trio.
- (a) supersession is partial — (b) and (c) of this ADR remain in force.

## Source
- Exec alignment 2026-05-13 AM
- Parent Confluence PRFAQ (pageId 4247257097)
