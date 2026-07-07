---
date: 2026-07-06
meeting: Integrations/AI Cross Team Sync
type: sync
attendees: [Nellie LeMonier, Lalit Maharana, Nataliya Kolb, Nitish Devadiga, Jason Zhang, Sagar Bhat, Okan Akbulut, Danish Sharma, Pankaj Lohmor]
source: zoom
meeting_uuid: FB70D4B2-1D82-4B9E-A8C7-F315DC57F85F
backfilled: 2026-07-07
---

# Integrations/AI Cross Team Sync — 2026-07-06

## Summary
First weekly alignment call for summer projects between the integrations and AI teams, covering development plans and meeting transcripts. The main discussion centered on 30–40 second latency in AI-generated course recommendations for personal development plans and the risk of user drop-off. The team aligned on an MVP approach: fire two parallel AI requests (upskilling steps + course recommendations) when a user selects a skill, and defer streaming to a V2 phase. Skill graph was identified as a valuable future optimization but deprioritized for the August delivery. A follow-up webhook-infrastructure call was scheduled for the next morning.

## Key decisions
- Parallel AI requests: on skill selection, trigger two concurrent requests (upskilling steps + course recommendations) rather than processing sequentially.
- MVP-first on latency: ship without preprocessing or streaming initially; assess real latency impact before investing further.
- Streaming as V2: streaming requires multi-hop pipeline changes (API gateway, LM Engine/LM Proxy, inference server) plus DevOps/app-platform work; treat as a follow-on phase, not a blocker.
- Skill graph deferred: valuable for long-term recommendation quality but not feasible before August; could later feed into the LLM for contextual refinement.
- LLM remains the primary/core approach for contextual personalization.

## Action items
- Lalit / Nitesh: build mock data scenarios (with and without existing development goals) to test recommendation quality across skill types and industries, and to validate AI model output quality for upskilling steps.
- Jason: deploy the streaming proof-of-concept with Gemma 4; coordinate with DevOps/FF4 on API gateway infrastructure this week; follow up with the product team on tomorrow's meeting.
- Jason / Sagar: evaluate Gemma 4 with a golden dataset to benchmark output quality before full implementation.
- Nellie: schedule tomorrow's 8 AM webhook review call (Danish, Okan, Sagar; Jason optional) to review the webhook gateway MVP; schedule future weekly syncs earlier to accommodate time zones.
- Nataliya / Nellie: communicate the "bring-your-own-LMS" requirement to sales enablement (Kate) ahead of go-to-market.
- Okan: spike on the security aspects of webhooks.

## Follow-ups / open questions
- Quality and specificity of AI-generated upskilling steps — are milestones actionable enough to create goals with start/end dates?
- Whether preprocessing high-frequency skills in advance is worth the transaction cost given uncertain user demand.
- Streaming infrastructure feasibility — Jason to complete the PoC deployment this week.
- Should the skill graph be scoped as a post-MVP optimization to improve precision and fix taxonomy issues (e.g., "presentation" returning cooking results)?
- How many launch clients will have an active LMS integration ready?

## Discussion notes
- Course recommendation flow (Nitish): generate multiple queries per skill (3), call the connected LMS provider via unified endpoints, then re-rank ~60–80 results to a top-20 list using an LLM; ~30 seconds in Gemma 4. Two-layer solution: high-level skill recommendations + mentor connections (the latter easier via SQL queries).
- Streaming: Sagar confirmed no current implementation but a prior PoC using a self-hosted model. Jason said streaming is possible but needs significant infra work; suggested testing performance and preprocessing first. Nellie proposed an MVP (basic streaming without preprocessing) with a V2 adding full streaming.
- Parallel workflows: Jason confirmed production can handle multiple simultaneous AI requests. Current inference latency is high due to new GPT-4/NVIDIA integration; future optimizations expected to roughly double performance (projected ~2x improvement).
- Skill graph (Okan): proposed as a more deterministic, predefined-pathway alternative to LLMs; team agreed it fits a future phase.
- LMS integration (Nataliya): Docebo integration in place for internal courses, but clients must bring their own LMS instance (Docebo, Degreed, etc.) for full functionality; requires individual integration and testing. Nitish confirmed unified endpoints created to make future LMS integrations plug-and-play. Docebo Marketplace not active internally.
- Webhooks: Danish built and demoed a working webhook gateway MVP integrated for Zoom — capturing events and publishing to an internal topic; docs shared with the team.

## Next steps
- Tomorrow 8 AM webhook review call (Nellie to set up).
- Jason to progress the streaming PoC and API-gateway infra coordination this week.
- Lalit/Nitesh to build mock-data test scenarios for recommendation quality.
