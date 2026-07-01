---
id: ADR-D-002
status: accepted
date: 2026-04-30
deciders: Exec Sponsor (NL)
related_prd: PRD-AI-PROCESSING-PIPELINE
---

# ADR-D-002 — Adopt Before / During / After UX framing for AI moments

## Context
Initial framing for AI surfaces was generic ("AI suggestions everywhere"). Exec Sponsor proposed a temporal model: organize AI value by **when** in the meeting workflow it lands — Before the 1:1 (prep), During (live), After (capture + signals). This anchors the AI into the user's existing workflow rather than creating a separate "AI module" experience.

## Decision
Adopt **Before / During / After** as the canonical UX framing for all AI moments. MVP scope: Before (coaching prep) + After (post-meeting capture + signals). During is deferred (real-time AI assist is Phase 2+).

## Consequences
- All consumer-surface PRDs (PRD-MEETINGS-AI-SURFACES, future Goals/Feedback) inherit this framing.
- Forces AI into the existing detail-page mental model — no separate "AI inbox" surface (later codified as ADR-D-003 module-native principle).
- "During" is explicitly out of scope; design effort focuses on the surfaces that exist today.
- The framing becomes a litmus test: a new AI feature must answer "is this Before, During, or After?"

## Source
- Slack `#temp-meeting-transcript-integration` 2026-04-30
- PRD-AI-PROCESSING-PIPELINE §A.3
