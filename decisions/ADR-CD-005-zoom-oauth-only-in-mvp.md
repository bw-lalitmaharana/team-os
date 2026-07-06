---
id: ADR-CD-005
status: superseded
date: 2026-05-13
deciders: PM Owner (LM) + Integrations PM (R)
related_prd: PRD-CONNECT-LAYER
superseded_by: ADR-CD-006 (Teams elevated to MVP Stretch)
---

# ADR-CD-005 — Zoom OAuth only in MVP; adapter contract supports future sources

## Context
Originally the Connect Layer scope question was whether to ship multiple source adapters (Zoom + Teams + Slack) in MVP. The platform CAP-011 adapter contract is designed to support all four families with the same shape — but each adapter is real eng work (auth flow, scope set, webhook handling, deauthorization, error states).

## Decision
MVP ships **Zoom OAuth only**. The platform CAP-011 adapter contract MUST support Slack/Jira/HubSpot/Salesforce schema-free for future addition without contract changes. Teams (INT-181) is deferred past Summer 2026.

## Consequences
- Reduces MVP eng surface materially (one adapter, not four).
- Decouples Connect Layer from Phase 2 ingestion decisions (vendor vs native auto-flow).
- **Superseded by ADR-CD-006**: Teams was elevated from "deferred past Summer 2026" to "MVP good-to-have stretch" on 2026-05-13 to align with parent Confluence PRFAQ.

## Source
- Parent PRD §11
- Industry research 2026-05-13
