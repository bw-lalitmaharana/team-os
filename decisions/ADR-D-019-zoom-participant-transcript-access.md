---
id: ADR-D-019
status: accepted
date: 2026-05-14
deciders: PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE
related_decisions: [PRD-ZOOM-CONNECTOR ZOPEN-D1 (MVP scope option a/b/c)]
---

# ADR-D-019 — Zoom participant transcript access is NOT supported via OAuth (host-only or admin-only)

## Context
Original assumption in CAP-011 / CONN-CAP-003 design: a non-host participant who joined a Zoom meeting could OAuth-connect and retrieve transcripts of meetings they attended. Research during PRD-ZOOM-CONNECTOR v0.1.0 drafting (2026-05-14) against developers.zoom.us + dev-forum staff posts established the platform constraint: Zoom Cloud Recording API's `GET /v2/users/{userId}/recordings` returns recordings owned by `{userId}` — only the host (or an admin with `:admin` scopes) can retrieve a meeting's recording metadata + transcript files via OAuth.

This invalidates a load-bearing assumption in the original CAP-011 design. The platform PRD's evidence schema + reconciliation framework + multi-user attribution model still work, but the **input contract** narrows: transcripts arrive scoped to the host's account, not the participant's.

## Decision
Platform-level acknowledgment: **Zoom transcript ingestion via OAuth is host-only** (or admin-only with `:admin` scopes). Three options for MVP coverage are tracked in PRD-ZOOM-CONNECTOR ZOPEN-D1: (a) host-only per-user OAuth, (b) admin-managed tenant-wide, (c) hybrid with downstream attendee-list cross-reference for non-host attribution.

## Consequences
- CAP-011 adapter contract for Zoom is host-scoped at the OAuth layer; non-host attribution requires downstream cross-reference logic (option c).
- New risk R4 in platform PRD §7 (Med likelihood).
- Affects MEET-CAP-201..204 (Meetings page) UX: if option (a) host-only ships, end users can only see AI surfaces for meetings they hosted. If (c) hybrid, attribution UX must indicate "from a meeting hosted by X."
- Resolution tracked: ZOPEN-D1 deadline 2026-06-09 (Marketplace submission target).
- GTM messaging must clarify coverage limits if option (a) ships.

## Source
- developers.zoom.us Cloud Recording API docs
- community.zoom.com — staff posts confirming host-only constraint
- Signal log 2026-05-14
- PRD-ZOOM-CONNECTOR §10a + ZOPEN-D1
