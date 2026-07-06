---
id: ADR-ZD-004
status: accepted
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-ZOOM-CONNECTOR
mirrors: ADR-CD-009 (parent-PRD acknowledgment)
---

# ADR-ZD-004 — Zoom Marketplace review window is 8–13 weeks

## Context
PRD-ZOOM-CONNECTOR v0.1.0 drafting (2026-05-14) required a defensible estimate for Zoom Marketplace review timeline. Parent PRD-CONNECT-LAYER carried the assumption "no marketplace review delays" — research was needed to validate or invalidate that.

Research conducted against:
- developers.zoom.us/docs/distribute/app-review-process/
- developers.zoom.us/docs/distribute/security-requirements/
- developers.zoom.us/docs/distribute/app-review-guidelines/
- devforum.zoom.us (late 2025 reports)

Zoom does not publish a guaranteed SLA. Their own docs say review time "varies." Recent (Sep–Dec 2025) developer-forum reports show end-to-end approval taking **~10–13 weeks** when security findings require remediation. A clean first pass can be faster but a multi-week security-review phase is the norm. Plan for **8–13 weeks**.

## Decision
Treat Zoom Marketplace review as a **hard external constraint of 8–13 weeks**. This invalidates the parent assumption "no marketplace review delays" (acknowledged via ADR-CD-009).

Production posture:
- May 31 Rainforest runs on Zoom **dev-app credentials** — not the published app.
- Summer 2026 GA on the published app requires Marketplace submission **no later than 2026-06-09** (12-week buffer to summer release).
- Production feature-flagged behind dev-app credentials for internal Rainforest only; external customer launch requires published app.

## Consequences
- New risk R1 in PRD-ZOOM-CONNECTOR §7 (Med-High likelihood).
- Marketplace submission target locked at **2026-06-09** (drives Z-02 sequencing).
- All ZOOM-CAPs required for submission (001, 002, 003, 005, 008, 009) must be production-grade by 2026-06-09 — significantly earlier than the August code-ready date for non-Marketplace features.
- GTM communications need to clarify "feature available in Rainforest" vs "published Marketplace app" timing.
- Documented alternative path required if external launch must wait for Marketplace approval beyond Summer GA.

## Source
- developers.zoom.us/docs/distribute/app-review-process/
- developers.zoom.us/docs/distribute/security-requirements/
- devforum.zoom.us (late 2025 dev-forum reports of 10–13wk timelines)
- Signal log 2026-05-14 "Zoom platform findings"
- ADR-CD-009 (parent-PRD acknowledgment)
