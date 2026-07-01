---
id: ADR-MD-016
status: staged
date: 2026-05-20
deciders: PM Owner (LM) — to be ratified at refinement call
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [ADR-MD-013, ADR-MD-015, ADR-MD-018]
---

# ADR-MD-016 — In-card AI nudges attached per-object with density caps

## Status
Staged for ratification at next refinement call. PRD v0.6.0 is authored against this decision.

## Context
Once ADR-MD-013 removed the ARA right-rail panel, the question became: where do AI signals about *existing* objects go? The chat session arrived at "attach the nudge directly below the specific object it references" — a Goal nudge under a goal row in the Active Goals widget; a Feedback nudge at the top of the Feedback & Recognition widget.

The risk with any nudge system is fatigue. The 2026-05-20 chat research on in-card AI nudges (Lattice / 15Five / Asana / Linear / Notion / HubSpot / Salesforce / Gong / ClickUp surveyed) surfaced four failure modes:

1. **Notification flood** — too many nudges per page → all get ignored.
2. **Hallucinated citations** — nudge claim sounds confident but transcript doesn't actually support it → trust collapses on first false-positive.
3. **Over-reliance** — managers stop reading the underlying object and just accept the nudge → quality degrades.
4. **Speaker attribution errors** — "Darrin said X" but the transcript shows the manager said X → undermines the citation primitive.

The strongest mitigation is **density caps** + **citation always visible** + **measured action-rate with auto-throttle** if action-rate drops below 15%.

## Decision
- **AI nudges in the right rail SHALL attach below the specific object they reference** (Goal nudge under the named goal row; Feedback nudge at the top of the F&R widget). Nudges SHALL NOT be grouped into a separate "AI nudges" section.
- **Density caps (MUST):**
  - Max 1 nudge per goal row.
  - Max 2 nudges visible in the Active Goals widget at one time.
  - Max 1 nudge in the Feedback & Recognition widget (person-level, not item-level).
  - Additional nudges beyond these caps SHALL be suppressed silently — no "see N more" affordance.
- Nudge structure: ✦ AI icon + 1-line claim + transcript citation link + primary CTA + "×" dismiss.
- **Dismiss is permanent per meeting instance.** A dismissed nudge SHALL NOT resurface on subsequent loads of the same meeting. (Dismiss is a learning signal; same as MEET-CAP-204 dismissal pattern.)
- **Success state:** "✓ Done" for 1.5s, then nudge row fades and collapses.
- **Action-rate auto-throttle:** if measured action rate across all nudges falls below 15% over a rolling 7-day window in production, the system SHALL reduce nudge surfacing rate by 50% per widget until action-rate recovers above 25%. (R6 mitigation.)
- **Citation is always visible**, never collapsed into a tooltip. The citation IS the trust mechanism.
- **Employee persona:** sees nudge rows but CTAs are inactive with tooltip "This action is for the meeting organiser." Dismiss control not shown to employees (manager-only).

## Consequences
- Density caps are enforced at the render layer — backend may produce more candidate nudges than slots; the surface decides which to show. Surface-side ranking heuristic (priority score from platform CAP-014) determines which fills the slot.
- The 15%/25% throttle thresholds are baselines — to be calibrated after first 30 days in Rainforest + production. Quality bar A.4 documents the rule but leaves the exact thresholds adjustable.
- If a referenced object (goal, recognition target) is deleted between nudge generation and page render, the nudge SHALL be suppressed silently on next load. MPAC-16 enforces.
- Lane C dependency: the Feedback nudge variant requires cross-meeting synthesis (CAP-017) to make the "strong moments worth recognising" claim. If OPEN-D10 (Q-A1) ratifies single-transcript-only, the Feedback nudge defers to V2 (last-meeting-only feedback signals don't support the recognition framing). Goal nudge survives single-transcript on per-goal "mentioned in this meeting" attribution.
- MOPEN-D11 (Feedback nudge count — 1 highest-confidence or all detected) is open; current spec is 1, others suppressed. Manager can regenerate to see others (not in MVP — V2 enhancement).
- MOPEN-D13 (employee visibility — visible-inactive or hidden) is open; current spec is visible-inactive with tooltip.

## Source
- claude.ai chat `d3e6e6d2-4fb4-4152-b26d-26f7cb4b3bd7` (2026-05-20)
- Chat research: `specs/2026-05-20-ai-nudges-in-context-cards.md` — failure modes (notification fatigue, hallucinated citations, over-reliance, speaker attribution); Wharton/INSEAD attention-vs-action research
- PRD-MEETINGS-AI-SURFACES v0.6.0 App A.2 MEET-CAP-207
- Prototype source `~/Downloads/Meetings Zoom- Container/app/AINudge.jsx`
