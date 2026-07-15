---
date: 2026-07-14
meeting: "Hackathon guidance - skill graph"
type: review
attendees: [Lalit Maharana, Neetesh Kaushik, Jason Zhang]
source: zoom
meeting_uuid: E40BE32D-F1F8-4B6B-8F54-D62D3B1D0D3F
---
# Hackathon guidance - skill graph — 2026-07-14

## Summary
Neetesh and Lalit walked Jason Zhang through the Neo4j-based skill-graph hackathon build (skill + talent-profile nodes, semantic-similarity edges, Cypher-based profile-similarity and mentor-matching queries). Jason endorsed the approach for PDP recommendations, revealed that the data warehouse already holds roughly 32K Lightcast SKU embeddings the team can reuse, and floated extending the same graph substrate into a much broader "people graph" (goals, feedback, conversations, org chart, policy engine).

## Key decisions
- Approach validated by Jason Zhang as suitable for PDP recommendations.
- Team will reuse the existing ~32K Lightcast SKU embeddings already in the data warehouse instead of generating new ones.

## Action items
- Jason Zhang: share prior internal "people graph" research with the team.
- Jason Zhang: send Lalit details on the existing Lightcast embeddings via Slack.
- Neetesh Kaushik: share the demo notebook; address multi-taxonomy support and performance/scalability questions raised below.

## Follow-ups / open questions
- Multi-taxonomy support: how to handle Lightcast and TechWolf skill vocabularies coexisting.
- GraphDB performance/schema design at scale — thousands of orgs, up to ~100K users each.
- Whether/how to scope a broader "people graph" (goals, feedback, conversations, org chart, policy engine) beyond the current skill-matching build.

## Discussion notes
- Jason Zhang treated this as a review of the hackathon output rather than a design session — his input reframes the effort's potential scope beyond the hackathon demo.
- Event-driven graph refresh (EDA) was mentioned elsewhere as a future improvement but not discussed in depth here.

## Next steps
- Neetesh to share the demo notebook and begin looking at multi-taxonomy and scale questions.
- Lalit to loop Nellie in on the "people graph" framing before it influences MVP scoping.
