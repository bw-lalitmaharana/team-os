---
date: 2026-07-07
meeting: Course recommendations
type: design
attendees: [Nitish Devadiga, Pankaj Lohmor, Lalit Maharana]
source: zoom
meeting_uuid: B183C2AC-EE91-46CE-9741-136FECDB37F2
---

# Course recommendations — 2026-07-07

## Summary
The team reviewed a two-pass LLM pipeline for generating personalized course recommendations from LMS providers (LinkedIn, Udemy). The approach uses a first LLM pass to generate targeted search queries based on user skill/proficiency context, and a second pass to re-rank the returned results. Key tradeoffs around latency (~10 seconds for pass 1, ~30s for pass 2), result quality, and re-ranking necessity were debated, with the team agreeing to automate and compare multiple strategies before committing to one approach.

## Key decisions
- Two-pass pipeline adopted as the current working approach: Pass 1 generates queries, Pass 2 re-ranks results by user context.
- Round-robin interleaving used to merge results from multiple queries into a final set of 20 courses, ensuring diversity across query angles.
- Re-ranking is deemed necessary because LMS providers return results with their own ranking logic, which may surface irrelevant courses (e.g., a Snowflake certification for a Product Manager).
- Automation of evaluation agreed as the immediate next step — multiple strategies (two-pass vs. single-pass, per-provider variations) to be tested comparatively rather than decided manually.
- Dislike as a metric is insufficient — it conflates latency dissatisfaction with result-quality issues.

## Action items
- Nitish: automate the end-to-end flow for course recommendation, including multiple strategies (two-pass vs. one-pass, interleaving vs. direct ranking) for evaluation.
- Nitish: create a golden dataset for testing and evaluation of the course recommendation system.
- Nitish: implement the LLM-based query generation and re-ranking system, focusing on user-context personalization.
- Nitish: experiment with different LMS providers (LinkedIn, Udemy) to compare the effectiveness of the recommendation strategies.
- Nitish: optimize for latency in the course recommendation pipeline, aiming to reduce response time.
- Nitish: connect with the AI team for guidance on technical implementation and dataset creation.

## Follow-ups / open questions
- Whether LMS provider search APIs (LinkedIn, Udemy) are advanced enough to handle enriched contextual queries, potentially eliminating the need for Pass 2.
- Whether a single-pass approach (relying on provider ranking) produces meaningfully worse results — needs empirical testing.
- Feasibility of maintaining a cached internal course catalog to avoid wasted inference when provider results are sparse or irrelevant.
- How to handle missed webhook events — webhooks are one-time delivery with no retroactive querying capability.
- Definition of a reliable quality metric beyond likes/dislikes for comparing pipeline variants.
- Whether to apply interleaving only for LinkedIn and single-pass only for Udemy as a provider-specific strategy.

## Discussion notes
- Pass 1: LLM generates up to ~20 complementary search queries per skill, accounting for the user's current and target proficiency level (e.g., beginner → intermediate queries only, not beginner-level content).
- Pass 1 latency: ~7.42s for inference, ~1.82s for fetching queries in parallel → ~10s total.
- Pass 2 latency: ~30s for re-ranking via Gemma (~17 tokens/second).
- Overlap observed: 7 of 20 courses matched between raw interleaved results and LLM re-ranked results — moderate but imperfect alignment.
- Query fetch: 3 queries generated → 55 unique courses retrieved after deduplication from ~20 results per query.
- Nitish and Lalit discussed data-entry approach tradeoffs: AI documentation could give better-quality results but faces latency and incident-speed constraints with certain tools.
- User data integration: org-level API data available via webhooks, but course-completion data from Udemy/Lumdrum isn't maintained; webhooks are one-time delivery with no retroactive query capability.
- Personalized learning path advisor concept discussed: LLM-generated personalized skill-development paths based on user context and existing knowledge, with keyword search through an Elasticsearch engine against the course catalog.
- Pankaj noted the LMS provider's existing ranking algorithm can surface irrelevant courses for a user's role, reinforcing the case for re-ranking.

## Next steps
- Nitish to automate multi-strategy testing (two-pass vs. single-pass, interleaving vs. direct ranking) and build the golden dataset, coordinating with the AI team.
