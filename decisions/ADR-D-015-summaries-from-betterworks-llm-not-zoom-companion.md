---
id: ADR-D-015
status: accepted
date: 2026-05-13 (PM)
deciders: Exec Sponsor (NL) + PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE
---

# ADR-D-015 — CAP-001 generates summaries from raw transcripts via Betterworks LLM, NOT Zoom AI Companion

## Context
Zoom's AI Companion produces native meeting summaries. Tempting shortcut: consume Zoom's pre-generated summary instead of running our own extraction over the raw transcript. Three reasons against: (1) **Different intent** — Zoom Companion summarizes for general note-taking; Betterworks needs performance-system-routable signals (action items, goal updates, skill demos, feedback moments) with provenance to specific transcript moments; (2) **Different user base** — Zoom Companion summaries lack Betterworks user-ID resolution and object linking; (3) **Different downstream routing** — Betterworks objects (Goals, Feedback, Skills) need typed signals, not prose summaries.

Plus: relying on Zoom Companion couples our roadmap to Zoom's AI roadmap and pricing tier (Companion requires specific Zoom plans).

## Decision
CAP-001 (Meeting Summary Generation) SHALL generate summaries from **raw transcripts via Betterworks' own LLM stack** (LM Engine + LM Proxy per ADR-D-007). SHALL NOT rely on Zoom AI Companion's native summary.

## Consequences
- Owns the summary contract end-to-end.
- Decoupled from Zoom Companion availability + pricing.
- Higher inference cost (we run our own model on every transcript) — acceptable given private LLM stack.
- Enables Why-this panel: our summary carries `evidence_ids[]` pointing to specific transcript moments; Zoom Companion doesn't.
- Codified in §5 MUST. The raw transcript fetch surface (PRD-ZOOM-CONNECTOR ZOOM-CAP-006) is required regardless.

## Source
- Product Acceptance call 2026-05-13 PM
- PRD-AI-PROCESSING-PIPELINE §5 MUST + §A.2 CAP-001
