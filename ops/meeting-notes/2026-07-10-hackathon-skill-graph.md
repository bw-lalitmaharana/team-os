---
date: 2026-07-10
meeting: "Hackathon: Skill graph"
type: planning
attendees: [Manish Tomar, Lalit Maharana, Neetesh Kaushik, Dasharath, Tanveer Farooq]
source: zoom
meeting_uuid: 9A5206F6-96F8-4D81-8479-621A6629F6E7
---
# Hackathon: Skill graph — 2026-07-10

## Summary
The team scoped their AI-hackathon entry: a mentor-recommendation system built on an evidence-based skill graph. Lalit presented the initial concept — synthetic data powering a skill-intelligence graph fed by goals, feedback, and job descriptions to identify skill gaps and recommend mentors. Neetesh demonstrated existing work on a semantic skill/talent-profile graph that can be reused. After discussing implementation scope, the team converged on mentor recommendations using the existing skill-graph database, with tasks split: UI design (Lalit), skill mapping from job descriptions (Dasharath), backend/graph integration (Neetesh), UI build (Manish).

## Key decisions
- Core demo flow: user selects a target position → required skills extracted → skill gaps identified → ranked mentors recommended per skill.
- Mentor recommendations are scoped per skill, not a combined skill set; a mentor must be at the same level or more senior than the mentee.
- No request/approval friction — skip that flow and redirect directly to a Slack DM or a pre-filled 1:1 meeting.
- Evidence sources for the hackathon: goals, feedback, and recognition via internal APIs only (external sources like Jira are a later extension).
- Use the existing Lightcast skills taxonomy; map job-description text to Lightcast skills via LLM.
- Target positions are hard-coded to 2–3 demo roles with skills attached — no full DB/API structure needed for the hackathon.
- Prepare both a live demo and a recording as backup for the presentation.

## Action items
- Dasharath: build the target-position selection flow and generate required Lightcast skills for that position, with Neetesh's help on API setup.
- Lalit: prepare front-end mocks/designs for the mentor-recommendation flow (target-position selection UI, recommended-mentor display).
- Manish: implement the UI based on Lalit's mocks.
- Neetesh: build mentor scoring/ranking logic (ranked mentor list per skill); explore integrating goals into the talent graph and how to measure goal similarity.
- Team: prepare both a live demo and a recording for the hackathon presentation.

## Follow-ups / open questions
- How to reliably map free-text JD descriptions to Lightcast skill IDs — flagged as the hardest remaining step.
- Whether the existing skill-recommendation engine's output can be reused directly as evidence, or a separate evidence-logging layer is needed.
- Whether goal-similarity can be added as an additional graph node/relation to improve mentor clustering.
- Feasibility of pre-filling a 1:1 meeting form vs. falling back to a Slack DM within the hackathon timeframe.

## Discussion notes
- Neetesh's existing graph has two node types (skills, user profiles) and three relation types: profile-knows-skill, profile-similar-to-profile, skill-semantically-similar-to-skill; a succession-planning proof-of-concept already demonstrates profile match scores with semantic-similarity reasoning.
- The existing LLM engine already recommends skills per user from feedback, conversations, job title, and description — the hackathon builds mentor-matching on top of that rather than replacing it.
- Tanveer suggested direct messages as an alternative to 1:1 meetings for mentor contact; the team agreed this could be expanded post-hackathon based on feasibility.
- Team discussed org-policy restrictions on visible positions and the lack of existing UI for target-position selection; agreed to use mock designs without real DB/API calls for the demo.

## Next steps
- Dasharath and Neetesh build the position→skills and scoring pipeline; Lalit and Manish build the UI; team assembles live demo + recording backup.
