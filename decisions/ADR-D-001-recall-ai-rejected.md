---
id: ADR-D-001
status: accepted
date: 2026-04-28
deciders: Exec Sponsor (NL)
related_prd: PRD-AI-PROCESSING-PIPELINE
related_decisions: [ADR-ZD-003 (Zoom-specific reaffirmation)]
---

# ADR-D-001 — Recall.ai (bot-based ingestion) rejected as transcript ingestion path

## Context
The team had completed a Recall.ai POC (ENG-78337) demonstrating bot-based transcript capture. Recall.ai bots join meetings as a participant, record audio, and return transcripts via webhook. Considered as a faster path to MVP than native Zoom Marketplace integration. Sriram (CS) advocated for it as acceptable for v1 ("they store transcript data, not a pass-through"). Exec Sponsor objected on UX + security grounds.

## Decision
Recall.ai bot-based ingestion is **rejected** as the Zoom/Teams ingestion path. Native API integration is the v1 path.

## Consequences
- POC ENG-78337 closed; learnings preserved as reference only.
- Native Zoom Marketplace app path locked (later codified as ADR-ZD-001 / ADR-D-017).
- Integrations pod scope: build native Marketplace app, not vendor integration.
- GTM messaging: "native Zoom integration, not a bot."
- Periodic pressure to revive Recall (e.g., for delivery speed) escalates to PM Owner + Principal Eng (R5 in PRD-CONNECT-LAYER).

## Source
- Slack `#temp-meeting-transcript-integration` 2026-04-28: "6 attendees = 6 bots in a meeting — poor UX." Plus security + customer-friction concerns.
- ADR-ZD-003 (PRD-ZOOM-CONNECTOR reaffirmation 2026-05-14)
