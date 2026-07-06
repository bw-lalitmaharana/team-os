---
date: 2026-06-29
meeting: Rec. Architecture Sync-up
type: architecture
attendees: [Nitish Devadiga, Nellie LeMonier, Jason Zhang, Lalit Maharana, Rinku, Sagar Bhat, Bhavesh Vaviya, Pankaj Lohmor]
source: zoom
meeting_uuid: CDD007A8-BB42-489F-8DC7-021FD16F8CF9
backfilled: 2026-07-07
---

# Rec. Architecture Sync-up — 2026-06-29

## Summary
The team aligned on the technical approach for LLM-based course recommendations within the PDP feature, targeting an August 10th production deadline. Key decisions were made around using the LM inference server (bypassing the proxy temporarily), a pre-processing + runtime hybrid strategy for learning path generation, and a future skill graph with embeddings for mentor matching. The recurring meeting will be replaced with a new weekly joint sync between the integration and AI platform teams.

## Key decisions
- LM Proxy bypass: use the direct LM inference server endpoint for structured tool calls now; LM Proxy not yet fully production-ready for tool/function calling.
- Gemma 4 will replace the current Llama model in production; target by August 10th.
- Context window: 64K set as current default; considered sufficient for the PDP recommendation workload.
- Course querying: only the user's selected LMS platform (Udemy, LinkedIn, or Docebo) is queried — not all three simultaneously.
- Pre-processing strategy: generate learning path steps (non-course actions) per skill + proficiency level combination without user context; apply user context only at runtime for personalized re-ranking.
- Mentor matching (near-term): use deterministic SQL queries to match users with peers/mentors at matching or higher proficiency levels; evolve to graph-based later.
- Build a skill graph with semantic embeddings to support mentor matching, career path inference, and adjacent skill discovery.
- Pre-processing outputs must go through multi-round LLM self-evaluation and human team review before deployment.

## Action items
- [ ] Nitish — Test structured output via direct LM inference server endpoint; share test notebook in channel by tomorrow night
- [ ] Nitish — Measure end-to-end latency (Gemma 4 inference + API calls); expected ~5-10 seconds worst case
- [ ] Nitish — Demo test version to Sagar, Bhavesh, Himan, and Ocon by tomorrow for production feedback
- [ ] Lalit — Write up spike stories per component (skill graph, pre-processing, runtime generation) for architecture decisions
- [ ] Nellie — Touch base with Chao on MCP tool for mentor/skill lookup using data analytics tooling
- [ ] Nellie — Cancel current recurring meeting series; schedule a new weekly joint sync (Integration + AI Platform) starting next Monday, open for others to be added

## Follow-ups / open questions
- Exact context window size for production not finalized; 64K tentatively approved pending further review.
- Mentor/connect feature scope and ownership not fully confirmed; briefly discussed but not prioritized.
- Skill graph architecture — independent skill graph vs. career-path-integrated graph — needs a spike to resolve.
- Pre-processing feasibility per skill/proficiency level combination to be validated.
- Whether Docebo (internal training provider) will return results for general skills — may yield no matches for some queries.
- How frequently user context (role, skills, goals) changes and whether it warrants runtime-only processing.
- Whether developmental goals are aligned to a business period — no confirmed answer.

## Discussion notes
- Completed: auth and proxy APIs for the unified LMS endpoint (Udemy, LinkedIn, Docebo) mostly complete and under code review.
- Blockers: structured output/function calling not working via LM Proxy with LangChain (Nitish to test directly against inference server); Gemma 4 not yet in production, limiting end-to-end testing.

## Next steps
- Replace this recurring series with a new weekly joint Integration + AI Platform sync starting next Monday.
