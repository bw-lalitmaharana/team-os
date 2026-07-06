---
date: 2026-07-06
meeting: Team sync: Discussion on Hackathon topic, feasibility and approach
type: sync
attendees: [Lalit Maharana, Tanveer Farooq, Neetesh Kaushik, Abhishek Pandey, Manish Tomar, Dasharath]
source: zoom
meeting_uuid: 4BDBD057-D345-46D7-9888-5A0A7916E6DF
backfilled: 2026-07-07
---

# Team sync: Discussion on Hackathon topic, feasibility and approach — 2026-07-06

## Summary
The team aligned on switching the hackathon project to an AI-driven successor recommendation system for TalentPort's succession module, replacing the original idea. The concept uses a Neo4j graph database and vector embeddings to find semantically similar talent profiles based on skills. Team name confirmed as VectorMinds, with a submission deadline of July 15, 8 PM.

Neetesh had built a rough weekend prototype: a Jupyter notebook connecting to a local talent database, extracting profile and skill data, and building a Neo4j graph with two node types (user profile nodes, skill nodes) plus verb-based relationships. Skill nodes carry a vector embedding property, indexed in Neo4j for fast semantic retrieval (cosine similarity). Given a profile, the query returns top-K similar profiles with exact-match score, semantic score, and the matching skills as reasoning (e.g., Vue.js ≈ React.js counted as semantically similar even without a direct link).

## Key decisions
- Idea change approved: switched to AI-based succession planning; confirmed by Sriram (via Tanveer's 1:1) and by team consensus.
- Approach: Neo4j graph with user profile nodes + skill nodes; vector embeddings enable semantic skill matching.
- Scope constraint: only core skill-matching parameters in scope for the hackathon; skill-level weighting and readiness levels deferred to future improvements (explicitly stated as assumptions in the demo).
- Team name: VectorMinds selected (over "BestWork" and "Vectorize").
- Delivery format: a recorded demo/presentation required by the code-freeze deadline (July 15, 8 PM).
- Rationale for topic choice (per Akhil Desai's morning call): prefer a topic that is anyway on the roadmap; succession AI is slated for a later/winter release, so building it early is beneficial.

## Action items
- Neetesh + Lalit: connect tomorrow to refine and document requirements (by Wednesday).
- Neetesh: draft project description and problem statement; share with Tanveer (by tomorrow morning if possible) so Tanveer can submit title + problem statement to organizers.
- Team: follow a 6-hour delivery plan on hackathon day — development complete by hour 6, final 2 hours for polish and recording.

## Role assignments
- Neetesh → core implementation (Neo4j graph + similarity logic).
- Lalit → requirements definition; refine scope with Neetesh.
- Abhishek → infrastructure, scalability review, and time accountability for the team on hackathon day (present in person); also takes part of the presentation.
- Tanveer → virtual support; team coordination and project description submission to organizers.

## Follow-ups / open questions
- Skill proficiency levels (e.g., 8/10 vs 7/10) and readiness levels not yet incorporated — acknowledged as future enhancements (raised by Manish).
- Abhishek flagged limited exposure to TalentPort and to the coding side (DevOps background); to focus on infra/scalability and time-keeping.

## Discussion notes
- Succession today is manual: a plan is created and successors are selected by hand based on the manager's knowledge. The proposal is to use AI to surface the closest-matching internal candidates by skills.
- Problem statement kept simple: find similar talent profiles based on skills; can also be used to find candidates for a newly created position with defined skills.
- Hackathon time: code freeze July 15, 8 PM; official ~6–8 hour window on the day, but teams can start early. Neetesh (from college hackathon experience) noted the on-site hours are usually for polishing and incorporating judge feedback.

## Next steps
- Neetesh to ping Lalit after the call; the two connect tomorrow to document refined requirements by Wednesday.
- Neetesh to send project description/problem statement to Tanveer for organizer submission.
