---
date: 2026-06-22
meeting: Rec. Architecture Sync-up
type: architecture
attendees: [Nitish Devadiga, Nellie LeMonier, Jason Zhang, Lalit Maharana, Rinku, Sagar Bhat, Bhavesh Vaviya, Pankaj Lohmor]
source: zoom
meeting_uuid: 7AA19AFC-D66A-436C-9D28-FEA559D31DAE, 92747494557
backfilled: 2026-07-07
---

# Rec. Architecture Sync-up — 2026-06-22

## Summary
Two-part architecture sync on LLM-based course recommendations for the PDP feature. In the first part, Nitish demoed a new `/LMS` endpoint supporting LinkedIn, Udemy, and Docebo providers, returning standardized course data filterable by keyword and difficulty level. The AI layer will generate search terms, query the API, and re-rank results. Docebo is limited to internal/org-specific courses. The second part aligned on the technical approach targeting an August 10th production deadline, with decisions around using the LM inference server directly (bypassing the proxy temporarily), a pre-processing + runtime hybrid strategy for learning path generation, and a future skill graph with embeddings for mentor matching. The recurring meeting will be replaced by a new weekly joint sync between the integration and AI platform teams.

## Key decisions
- AI-generated search terms will pull profile context to refine queries (e.g., type of sales skill, not just "sales").
- Two-phase LLM approach confirmed: (1) generate search terms + difficulty filters, (2) re-rank API results.
- No paid/free course filter currently applied when linking Udemy courses to goals; to be explored.
- Docebo returns only org-specific internal courses; not suitable for broad skill-based discovery. Course descriptions available for LinkedIn and Udemy, not Docebo.
- LM Proxy bypass: use the direct LM inference server endpoint for structured tool calls now; LM Proxy not yet production-ready for tool/function calling.
- Gemma 4 will replace the current Llama model in production; target August 10th.
- Context window: 64K set as current default; considered sufficient for PDP recommendation workload.
- Course querying: only the user's selected LMS platform is queried, not all three simultaneously.
- Pre-processing strategy: generate learning path steps (non-course actions) per skill + proficiency level without user context; apply user context only at runtime for personalized re-ranking.
- Mentor matching (near-term): deterministic SQL queries to match users with peers/mentors at matching or higher proficiency; evolve to graph-based later.
- Build a skill graph with semantic embeddings to support mentor matching, career path inference, and adjacent skill discovery.
- Pre-processing outputs must go through multi-round LLM self-evaluation and human team review before deployment.

## Action items
- [ ] Nitish — Follow up with Rinku to obtain customer API tokens and run the `/LMS` endpoint against real client data to assess catalog breadth and data quality
- [ ] Nitish — Test structured output via direct LM inference server endpoint; share test notebook in channel by tomorrow night
- [ ] Nitish — Measure end-to-end latency (Gemma 4 inference + API calls); expected ~5-10 seconds worst case
- [ ] Nitish — Demo test version to Sagar, Bhavesh, Himan, and Ocon by tomorrow for production feedback
- [ ] Rinku — Coordinate with Nitish to identify customers with LMS integrations enabled and support exploratory testing
- [ ] Lalit — Write up spike stories per component (skill graph, pre-processing, runtime generation) for architecture decisions
- [ ] Nellie — Touch base with Chao on MCP tool for mentor/skill lookup using data analytics tooling
- [ ] Nellie — Cancel current recurring meeting series; schedule a new weekly joint sync (Integration + AI Platform) starting next Monday
- [ ] Team — Conduct a latency spike for the full two-phase LLM + API query flow

## Follow-ups / open questions
- Whether enterprise-tier Udemy accounts include paid courses in the catalog.
- Whether LinkedIn allows selective course access per organization (vs. full library).
- Latency impact of the two-phase LLM flow needs a dedicated spike.
- Exact production context window size not finalized (64K tentatively approved).
- Mentor/connect feature scope and ownership not fully confirmed.
- Skill graph architecture — independent skill graph vs. career-path-integrated graph — needs a spike.
- Whether Docebo will return results for general skills.
- How frequently user context changes and whether it warrants runtime-only processing.
- Whether developmental goals are aligned to a business period.

## Discussion notes
- `/LMS` endpoint returns common course data (name, description) with keyword and level filters; response in ~milliseconds.
- Auth and proxy APIs for the unified LMS endpoint mostly complete and under code review.
- Blockers: structured output/function calling not working via LM Proxy with LangChain (Nitish to test direct against inference server); Gemma 4 not yet in production limits end-to-end testing.

## Next steps
- Replace this recurring series with a weekly joint Integration + AI Platform sync.
