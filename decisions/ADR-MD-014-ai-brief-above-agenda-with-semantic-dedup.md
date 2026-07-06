---
id: ADR-MD-014
status: staged
date: 2026-05-20
deciders: PM Owner (LM) — to be ratified at refinement call
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [ADR-MD-013, MOPEN-D9, MOPEN-D10, SPIKE-M01]
---

# ADR-MD-014 — AI Brief above agenda with semantic topic deduplication

## Status
Staged for ratification at next refinement call. PRD v0.6.0 is authored against this decision.

## Context
The 2026-05-15 meetings-page UX freeze established a pre-meeting context surface (originally called "Before summary" — MEET-CAP-202 in v0.4.0). The prototype rendered it as a top-of-detail-page card with narrative text + topic pills + "Use as starter agenda" CTA.

The 2026-05-20 chat session surfaced two refinements:

1. **Position and trigger are clear; behavior is not.** The card should render above Agenda Topics on the upcoming/current meeting card only, not on past meetings. It should include narrative summary + topic chips + Use-as-starter / Add-missing-topic / Regenerate / 👍👎 controls + generation timestamp.
2. **Deduplication is the load-bearing detail.** If the brief surfaces a topic that's already in the agenda (as a manual row, an AI plain row, or a rolled-over item), the brief is creating noise instead of removing prep-time burden. The dedup must be **semantic, not exact-string** — managers paraphrase, and rolled-over items often have terse phrasing that doesn't match the AI's verbose surfacing.

Without semantic dedup, the AI Brief value-prop collapses: it shows things the manager already has, which is the opposite of "reduces prep time."

## Decision
- AI Brief card (MEET-CAP-202) renders above Agenda Topics on the upcoming/current meeting card only. Hidden on past-meeting cards.
- Brief content: (a) 2–4 sentence narrative; (b) chip row "Likely topics" (empty agenda) OR "Not yet in agenda" (partial agenda); (c) primary CTA "Use as starter agenda" / "Add missing topic"; (d) secondary "↺ Regenerate"; (e) inline 👍/👎 feedback (logged silently); (f) generation timestamp.
- **Deduplication is semantic, not exact-string.** Implementation approach (embedding vs n-gram keyword vs LLM-based topic-concept match) is an engineering spike (SPIKE-M01) — but the *requirement* is semantic. False-negative rate target ≤15% (MPAC-12).
- If all suggested topics are already in agenda: chip row reads "All suggested topics are already in your agenda ✓" and the add CTA is hidden.
- Hide/show state persists per-user per-meeting. Manager and employee have independent show/hide state.
- If no prior transcript exists, the brief does not render. No placeholder.
- If processing is incomplete, brief shows "Preparing your brief…" loading state.

## Consequences
- MEET-CAP-202 description is rewritten in PRD v0.6.0 (renamed from "Cross-session Before summary" to "AI Brief card"). Capability detail in App A.2 reflects the dedup + chip + CTA structure.
- Engineering must spike the semantic-dedup approach before M-09 starts (SPIKE-M01). Two viable directions:
  - Embedding-based: more accurate, requires embedding compute on every render (or cache).
  - Keyword/n-gram: cheap, higher false-negative rate.
  - Hybrid: keyword pre-filter → LLM concept match for ambiguous cases.
- Lane C dependency: if Q-A1 (OPEN-D10) ratifies single-transcript-only, the brief's narrative narrows from "themes across last 1–2 meetings" to "from last meeting only" — still useful, but a different value claim.
- MOPEN-D9 (expanded vs collapsed default) and MOPEN-D10 (insertion point of "Add missing topic") are open design decisions downstream of this ADR.
- Risk: dedup false-negatives create "AI just shows what I already added" perception → erodes trust. Mitigation: MPAC-12 dedup correctness check pre-Rainforest; user-testing pass during M-09.

## Source
- 2026-05-15 meetings-page UX freeze (`specs/2026-05-15-meetings-page-data-model-ux-freeze.md`)
- claude.ai chat `d3e6e6d2-4fb4-4152-b26d-26f7cb4b3bd7` (2026-05-20)
- PRD-MEETINGS-AI-SURFACES v0.6.0 App A.2 MEET-CAP-202
- Prototype source `~/Downloads/Meetings Zoom- Container/app/AIBrief.jsx` (or equivalent component)
