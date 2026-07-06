---
date: 2026-06-23
meeting: PDP: AI Recommendation sync
type: design
attendees: [Nataliia Savenko, Nataliya Kolb, Nellie LeMonier, Lalit Maharana]
source: zoom
meeting_uuid: C80A0846-7405-45DA-9369-528F730AC0B8
backfilled: 2026-07-07
---

# PDP: AI Recommendation sync — 2026-06-23

## Summary
The team aligned on introducing AI/LLM-generated fallback recommendations for skill development, applicable both when LMS is unavailable and when LMS queries time out. The approach provides immediate value to users regardless of integration status. Scope for the summer MVP release will be scoped down to the happy path (course selection + AI placeholder), with mentorship and goal-conversion features deferred to a later phase.

## Key decisions
- LLM fallback recommendations will be shown always — as a default when LMS is disabled, or while LMS data is loading (with a loading indicator).
- Fallback and LMS recommendations will appear in the same UI location, not separate areas.
- Both the LLM fallback and LMS integration features must be configurable per organization (can be toggled off).
- MVP scope: happy path = selected courses + AI recommendation placeholder; converting AI recommendations to PDP/development goals is deferred.
- AI guardrails/prompt engineering will be developed by the AI team to prevent hallucination in LLM recommendations.

## Action items
- [ ] Nataliia — Add LLM fallback recommendation placeholder to feature description; discuss with engineering team
- [ ] Nataliia + Nataliya — Mock/wireframe the recommendation UI (AI fallback + LMS courses in same view) before tomorrow's sync
- [ ] Nellie / AI Team — Build internal API endpoint queryable by LLM to retrieve colleague skill proficiency data (Talent API); add guardrails
- [ ] Nellie — Test LMS integration POC against existing customer environments to assess data return quality and latency
- [ ] Team — Prototype full recommendation flow (AI + LMS + goal conversion) to evaluate MVP vs. V2 scope after Thursday meeting

## Follow-ups / open questions
- Exact scope of what can be delivered in the summer release — to be confirmed after Thursday's meeting.
- Whether AI recommendation text should be auto-converted into a development goal or milestone, and how to carry it through without losing it.
- Feasibility and design of activity type categorization within milestones (course, mentorship, webinar) — flagged as a potential V2 feature (Lalit's suggestion based on prior tools).
- How to capture and persist AI recommendations into development goals without losing the information post-interaction.
- Whether a Mentor field in Talent API can be leveraged to recommend colleagues with advanced skills as mentors — noted as a longer-term initiative.
- Whether mentorship-driven recommendations should be surfaced to IPP customers for feedback.

## Discussion notes
- Rationale for always-on LLM fallback: LMS querying happens in real time with potential ~10s latency; showing the LLM's "how you could obtain this skill" recommendation immediately provides value whether or not LMS returns data.
- LLM could suggest practice initiatives, code already in the org, or colleagues who have mastered the skill (via fuzzy logic on adjacent skills), then display LMS course recommendations below.
- Lalit suggested introducing an activity-type dropdown on milestones (course, mentorship connect, webinar) to holistically cover learning — deferred for exploration.

## Next steps
- Wireframe/prototype the flow, then decide what can be delivered within the summer release; flesh out details after Thursday's meeting.
