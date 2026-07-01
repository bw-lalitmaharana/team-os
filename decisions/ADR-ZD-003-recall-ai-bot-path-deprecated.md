---
id: ADR-ZD-003
status: accepted
date: 2026-05-14
deciders: PM Owner (LM) + Exec Sponsor (NL)
related_prd: PRD-ZOOM-CONNECTOR
inherits: parent-epic D-001 (2026-04-28) "Recall.ai bot path rejected"
related_decisions: [parent platform D-013 "automated Zoom = MVP required"]
---

# ADR-ZD-003 — Recall.ai bot path deprecated; native Zoom Marketplace is the only production path

## Context
The original transcript-ingestion path under consideration was Recall.ai (a bot that joins each meeting to record). POC was completed under ENG-78337. Exec Sponsor rejected this path on 2026-04-28 (parent platform D-001) on UX + security grounds: "6 attendees = 6 bots — poor UX." Plus customer-side concerns about a third-party bot joining sensitive meetings.

On 2026-05-13 (PM), the Product Acceptance call escalated automated Zoom ingestion from "MVP if doable" to "MVP required" (parent D-013). The path is native Zoom API integration via Marketplace app — not Recall, not manual paste.

## Decision
Recall.ai bot-based ingestion is deprecated for v1. PRD-ZOOM-CONNECTOR defines the only production path: native Zoom Marketplace General App with OAuth, webhooks, and Cloud Recording API transcript fetch. Manual paste (parent S-03) is retained as an internal demo-only safety net per D-013 — not a customer path.

## Consequences
- Integrations pod work focuses exclusively on Zoom Marketplace app, not Recall integration.
- Recall.ai POC (ENG-78337) closed; learnings preserved as reference only.
- Any pressure to revive Recall (e.g., from Integrations pod for faster delivery) is misaligned with this decision — escalate to PM Owner + Principal Eng per parent PRD R5.
- GTM messaging: "native Zoom integration, not a bot."

## Source
- Parent platform D-001 (Slack #temp-meeting-transcript-integration, 2026-04-28, Exec Sponsor)
- Parent platform D-013 (Product Acceptance call 2026-05-13, Zoom uuid 7D6A937E)
- PRD-ZOOM-CONNECTOR §1 Problem + §4 Scope (Out)
