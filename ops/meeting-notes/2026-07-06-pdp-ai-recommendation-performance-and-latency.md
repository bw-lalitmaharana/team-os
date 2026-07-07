---
date: 2026-07-06
meeting: PDP: AI Recommendation Performance and Latency
type: review
attendees: [Nataliia Savenko, Nataliya Kolb, Nitish Devadiga, Nellie LeMonier, Pankaj Lohmor, Rinku, Lalit Maharana]
source: zoom
meeting_uuid: 9ECD0C03-1234-465A-9883-216AE7462CDA
backfilled: 2026-07-07
---

# PDP: AI Recommendation Performance and Latency — 2026-07-06

> Note: AI summary permission was denied for this meeting; notes below are reconstructed from the transcript only.

## Summary
Nitish presented findings from his latency investigation on AI course recommendations for the PDP (Personal Development Plans) flow, walking through a Google Colab that outlines the intended production flow (tools/endpoints, not exact infra). The course recommender is split into two LLM calls: (1) query generation from user context, and (2) re-ranking of LMS results. Total latency is ~30–40 seconds on the Gemma 4 instance, with re-ranking the dominant cost (~30s). The team discussed UX strategies to mask/reduce perceived latency — parallel requests, cascading/streaming delivery, and preprocessing — and agreed to build the workflow and test the experience, then align with the AI team on streaming and pre-processing.

## Key decisions
- Fire two requests in parallel when the user selects a skill to develop: AI-suggested upskilling steps + AI course recommendations, to buy time against second-screen latency.
- Build out the proposed workflow first, test the real user experience, then have a follow-up with the AI team on creative latency mitigations (streaming, preprocessing, visual cues).
- The "take courses" / mentor-connect step is deterministic (SQL-driven) and can be shown immediately, independent of AI readiness.

## Action items
- Lalit: raise the streaming question and the pre-processing question at today's Integrations/AI weekly sync (already scheduled) — i.e., when streaming will be available and whether anything can be pre-processed and shown upfront.
- Nellie: invite Nataliya Kolb and Nataliia Savenko to the Integrations/AI weekly sync.
- Team: implement the parallel/cascading workflow and evaluate the user experience before further optimization.

## Follow-ups / open questions
- Streaming is on the AI team's roadmap but not currently supported; feasibility/timing for summer unclear — to confirm with the AI team.
- Whether a "fake"/cascading latency (deliver step 1, then step 2, then step 3) is worth it — Nitish noted each new step is a new LLM prompt, adding latency.
- Preprocessing is not ideal because it must be done per skill, per user, per skill-level (could be ~1,000 skills per user) with 30–40s latency — wasteful if the user never uses the feature.

## Discussion notes
- Two-LLM recommender: Phase 1 (query generation, ~7–10s) generates ~3 queries per skill narrowing broad terms (e.g., "data analysis") to focused, role-appropriate topics; the queries hit the connected LMS provider (Udemy, LinkedIn, Docebo) via unified LMS endpoints live on Rainforest, returning ~50–80 deduped courses. Phase 2 (re-ranking, ~30s) re-ranks to the top ~20 by job profile. Fetch step ~2s (provider-dependent).
- For the search flow, using only Phase 1 plus round-robin interleaving of results is deterministic and instant; interleaved courses overlap ~50% with the re-ranked subset — not perfect but usable.
- Model comparison: GPT-5 Nano (OpenAI) ~15s total vs 30–40s on Gemma 4, but OpenAI is discouraged for production (not private, variable cost) and infra is moving to the internal Gemma/Zima endpoint.
- Gemma 4 token output speed observed ~17 tokens/sec; generating upskilling steps reasonably estimated at 10s+.
- Nataliya pushed for an AI-native experience where the user is never staring at a blank screen: cascading delivery of steps, "thinking"/status language, an action button to view results while more content streams in (referencing Claude/ChatGPT patterns); AI must always return something beneficial so users don't give up.
- Nataliia Savenko suggested imitating AI work as a first step using predefined data (e.g., show internal-network avatars + generic text with a loading imitation) while the real AI text recommendation loads in parallel.

## Next steps
- Take the streaming and pre-processing questions to today's Integrations/AI cross-team sync.
- Build and test the parallel/cascading workflow; reconvene with the AI team on latency UX.
