---
date: 2026-07-14
meeting: "Zoom Meeting (Talent Graph sync)"
type: design
attendees: [Lalit Maharana, Manish Tomar, Neetesh Kaushik]
source: zoom
meeting_uuid: A498472D-2CC7-4795-96E2-3AB4D2868410
---
# Zoom Meeting (Talent Graph sync) — 2026-07-14

## Summary
The team checked in personally (Neetesh dealing with a worsening internal injury, Manish traveling in Naples and recently became a father) before working through the Talent Graph feature. Neetesh demoed current progress on a Neo4j + OpenAI-embeddings graph that finds semantically similar skills and matches profiles by skill proficiency, covering admin-side visualization, profile-similarity search, and mentor-recommendation use cases. The group reviewed the existing graph/table UI and search-by-user/search-by-skill functionality, discussed exact-vs-similar match handling and weighted scoring, the need to extract skills from job descriptions for empty positions, and possible future improvements (natural-language search, clearer similarity-score visualization).

## Key decisions
- Present Talent Graph results as a **table view**, not a graph visualization, for better user understanding.
- Add a **toggle between user-search and skill-search** modes.
- **Exact skill matches prioritized over similar/embedding matches**, with a visible match-score indicator distinguishing the two.
- Add **mentor-recommendation cards** to talent profiles.
- Add action buttons to the results table: "View Talent Profile," "Add as Successor."

## Action items
- Lalit: modify the Talent Graph UI design file to incorporate the toggle, table view, and other discussed changes; generate synthetic data (user profiles + skills) for testing.
- Neetesh: set up the local environment (Neo4j + config) for Talent Graph; implement logic to extract skills from job descriptions for empty positions; implement mentor-recommendation logic (exact + similar matches, ranked table); add visual match-score indicators; implement the table's action buttons.
- Team (Lalit, Manish, Abhishek, Ayush): divide and implement the discussed Talent Graph and Succession-page features.

## Follow-ups / open questions
- **90-95% of talent profiles have no job description attached**, which blocks automatic skill extraction/assignment for those profiles — no resolution decided, noted as an open gap in current scope.
- Whether to add natural-language search capability to the Talent Graph search UI (raised as a potential improvement, not committed).
- How to better visualize similarity scores between profiles (raised as a potential improvement, not committed).

## Discussion notes
- Existing job descriptions (where present) could be used to auto-derive skills for talent profiles; the team explored building endpoints to assign skills from JDs, but implementation details weren't finalized.
- The graph already distinguishes exact matches from similarity-based (embedding) matches; the open design question was how to score/display both together.

## Next steps
- Lalit updates the design file and prepares synthetic test data; Neetesh builds out the backend (Neo4j setup, JD-based skill extraction, mentor logic, scoring/visual indicators); Manish and the wider team pick up UI/succession-page implementation.
