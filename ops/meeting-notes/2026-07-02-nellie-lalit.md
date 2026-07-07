---
date: 2026-07-02
meeting: Nellie / Lalit
type: 1:1
attendees: [Lalit Maharana, Nellie]
source: zoom
meeting_uuid: A54F1B1B-F14E-481C-B6E5-E2C605BA9F5D
backfilled: 2026-07-07
---

# Nellie / Lalit — 2026-07-02

## Summary
Two topics: (1) Lalit's proposed redesign of Personal Development Plans (PDPs) using a holistic 70-20-10 learning model; and (2) planning for the upcoming India team meeting/session in Bangalore. V1 scope was narrowed to courses and mentor matching, deferring external content sourcing due to enterprise risk concerns. A dual-LLM approach (generator + judge) was agreed for content quality control, with internal content only for V1.

## Key decisions
- V1 scope confirmed: course recommendation and mentor matching in scope; external/public content sourcing deferred.
- Internal content only for quick-win recommendations in V1 to avoid enterprise guardrail issues.
- Dual-LLM architecture: one LLM generates recommendations, a second LLM judge evaluates enterprise appropriateness.
- Judge prompts to be customizable per customer via prompt management (prompts stored in DB).
- Thumbs up/thumbs down feedback to be added to recommendations for quality evaluation.
- Goal quality / development plan quality index deferred to a later release.

## Action items
- Lalit: Connect with Arnav and Gauri to brainstorm ideas for the Bangalore session for PMs and designers.
- Lalit: Validate PDP recommendations (quick wins, social recommender, etc.) with Customer Success re: enterprise concerns.
- Lalit: Start a Slack thread with Nellie, Chao, and Jay-Z to discuss mentor matching and Chao's architecture vision.
- Lalit: Explore how AI-generated recommendations look for different development-goal types (leadership, strategy) to understand complexity/LLM output variation.
- Lalit: Implement a thumbs up/thumbs down feedback mechanism for AI recommendations.
- Lalit: For V1, focus on internal content only; implement a customizable "judge" prompt for content guardrails.
- Lalit: Discuss with JV and Nitesh the AI querying for the "Connect with Mentor" feature; review Chao's architecture proposal document.

## Follow-ups / open questions
- CS input needed on acceptability of public internet sourcing and social recommender.
- Mentor matching architecture — Chao's data platform approach to be reviewed; ownership not yet assigned.
- Does the recommended learning structure (foundation → courses → mentor) generalize across non-technical/leadership goals?
- Is there an existing internal content repository (LMS articles/videos) to substitute for public sources in V1?

## Discussion notes
- 70-20-10 model: courses (10%), social learning (20%), hands-on experience (70%); six proposed components including reading materials, quick watches, influencers, mentors, courses, and applying learning at work.
- Nellie flagged risk of public internet sourcing (YouTube, social profiles) — enterprise clients may block platforms or consider it a policy violation.
- Roadmap-format learning plan with numbered steps to convert into milestones; goal quality index surfaced as AI nudges rather than a raw score.
- For the India session: possible topics include future of PM/designer roles in the AI era and current AI/automation usage.
- Nellie is out on 4th of July (next day).

## Next steps
- Async collaboration via Slack thread; validate with CS; experiment across goal types.
