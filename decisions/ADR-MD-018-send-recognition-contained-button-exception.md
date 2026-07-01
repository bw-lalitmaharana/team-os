---
id: ADR-MD-018
status: staged
date: 2026-05-20
deciders: PM Owner (LM) — to be ratified at refinement call
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [ADR-MD-015, ADR-MD-016]
---

# ADR-MD-018 — "Send recognition" contained-button exception to AI CTA de-emphasis rule

## Status
Staged for ratification at next refinement call. PRD v0.6.0 is authored against this decision.

## Context
ADR-MD-015 established that AI-sourced action CTAs (Review →, Log progress →, etc.) render as plain text-link affordances, not contained buttons. The rationale: contained buttons signal "primary action of this surface" — but every AI row is a suggestion, not a primary action. De-emphasizing the CTA prevents the AI surface from competing visually with the host surface (the action items list, the goals widget).

The Feedback & Recognition widget's "Send recognition" nudge breaks this rule. In the chat session, when this was first prototyped, the CTA was a contained filled button — visibly stronger than other AI CTAs. The natural design instinct was to demote it to a text link for consistency.

That instinct was rejected after considering the action's nature:
- "Review →" creates a draft record (a goal in draft state, a recognition in draft state). Reversible. Low stakes.
- "Log progress →" updates a numeric field on an existing object. Reversible. Low stakes.
- **"Send recognition" sends a notification to a colleague.** Irreversible. The colleague sees it. Cannot be un-sent.

Every email client, every Slack-style product, every communication tool draws this line: "send" actions are visually stronger than "save" or "draft" actions. The cross-pattern convention is so universal that demoting "Send" to a text link in service of internal consistency would *create* a usability bug.

## Decision
- All AI-sourced action CTAs in this PRD SHALL render as **plain text-link affordances** with an arrow ("→"), not contained buttons. This applies to: Review → (AI typed rows), Log progress → (Goal nudges), Add missing topic / Use as starter agenda (AI Brief), Regenerate (AI Brief secondary), Open in Zoom ↗ (Transcript tab).
- **Exception:** The "Send recognition" nudge CTA in the Feedback & Recognition widget SHALL render as a **contained filled button** in the primary brand color.
- The exception is justified by the action's nature, not by widget chrome: any AI CTA that triggers a communication act sent to another user (recognition, public praise, shared visibility) inherits the contained-button treatment. Any AI CTA that creates a private draft or updates an internal record uses the text-link treatment.

## Consequences
- Engineering build: two CTA styles in the AI nudge component — text-link variant (default) and contained-button variant (opt-in via prop). Default is text-link.
- Visual consistency: the "Send recognition" button will look heavier than its peer nudges in the same widget area. Acceptable; the asymmetry is the point.
- If future capabilities add new "send-type" actions (e.g. "Share to growth-plan owner", "Notify HR"), they SHALL inherit the contained-button treatment. The rule is "communication act vs draft act," not a per-CTA whitelist.
- The text-link arrow ("→") is a load-bearing affordance — without the arrow, text links risk being mistaken for inline body text. MPAC visual audit pass enforces.
- This decision intentionally does NOT establish a generic "primary AI action" rule. Within the AI layer, there is no concept of "primary action" — every AI row is a suggestion. The contained-button is reserved for the specific category of "irreversible communication."

## Source
- claude.ai chat `d3e6e6d2-4fb4-4152-b26d-26f7cb4b3bd7` (2026-05-20)
- PRD-MEETINGS-AI-SURFACES v0.6.0 §5.2 + App A.2 MEET-CAP-207
- Industry convention (email clients, Slack, Linear, Notion comments — all use contained "Send" / "Post" buttons)
