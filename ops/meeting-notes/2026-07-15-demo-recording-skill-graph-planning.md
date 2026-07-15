---
date: 2026-07-15
meeting: "Demo Recording - Skill graph"
type: planning
attendees: [Lalit Maharana, Neetesh Kaushik, Manish Tomar]
source: zoom
meeting_uuid: 24240C75-C131-437F-9F9E-2D159EB63F16
---
# Demo Recording - Skill graph: planning call — 2026-07-15

## Summary
Planning call ahead of the recorded skill-graph demo, settling implementation shortcuts needed to hit the recording deadline.

## Key decisions
- Succession and mentor recommendations reuse the existing search-by-skill API — no new endpoint.
- Position-related skills are hard-coded for the demo rather than LLM-extracted from job descriptions.
- LLM-based JD-extraction engine deferred as too complex to build in time.
- Score legend fixed: green = exact match, a different color = similar match.

## Action items
- Team: implement demo against the reused search API and hard-coded position skills.

## Follow-ups / open questions
- LLM-based JD skill extraction remains unbuilt — same gap flagged in the 07-14 Talent Graph sync (90-95% of profiles have no linked JD).

## Discussion notes
- Hard-coding position skills is an explicit shortcut for the demo, not a production design decision.

## Next steps
- Proceed to record the demo using the reused API and hard-coded skill set.
