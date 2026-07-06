---
date: 2026-05-21
meeting: Development Plans: Product + Dev
type: design
attendees: [Nataliya Kolb, Nellie LeMonier, Ryan Mulready, Kate Malcolm, Nitish Devadiga, Donnie Ellstrom, Pankaj Lohmor, Nataliia Savenko, Lalit Maharana]
source: zoom
meeting_uuid: 60698396-51AC-4008-8D41-C4E1E65036B0
backfilled: 2026-07-07
---

# Development Plans: Product + Dev — 2026-05-21

# Summary
Nataliya Kolb walked Product + Dev through the Personal Development Plan (PDP) / skills vision for the summer release: AI-assisted development goals, course recommendations, skill gap analysis, and aspirational career pathing. The group (product, goals, talent, integrations, AI) discussed the happy path for creating development goals with AI-recommended courses, how to source course data, how skills visibility and proficiency verification should work, and what's realistic for summer vs. later releases.

## Key decisions
- Course recommendations: start with an explicit button-click ("recommend courses for this skill") rather than auto-populating, because the agent is non-deterministic and results need to be verifiable; auto-populate can follow once it's working. (Ryan and Nataliya aligned.)
- Course sourcing: rather than giving the AI agent direct LMS API access, have it generate a search term/keyword and then perform the search deterministically against the connected LMS (Docebo/LinkedIn/Udemy) — reduces indeterminism (Nitish/Ryan).
- Goals ownership: the Goals team must own the relationship between goal creation and tying it back to talent (e.g., flag a goal as a development plan; tie course completion to goal percentage) — not the talent side (Ryan).
- Skills-visibility change: to support "people you can reach out to," peer-visible skills need a permissions change (skills are currently private). Agreement to show skill name (and possibly rolled-up source like "recommended by AI / verified") publicly while hiding sensitive AI sources (conversation/feedback details). Ryan noted this is actually easier than the course-recommendation work.
- Proficiency levels are optional per org; where not enabled, treat skills as have/don't-have rather than mastered/not.
- Skill verification stays human-in-the-loop (manager verifies/rejects). AI can surface/infer but the manager/employee makes the final call. Some orgs (e.g., dairy farmers example) will require verification for all skills.

## Action items
- [ ] Nataliya — Follow up with Barnaco (missed off the invite list) on the goals/talent relationship.
- [ ] Nataliya — Work with design to define the course-recommendation workflow (button-triggered happy path), and address use cases: client without goals module, without LMS integration, and without AI.
- [ ] Nataliya — Continue with Laura Ripple on skill gap analysis and proficiency levels.
- [ ] Team — Explore allowing orgs to add descriptions per skill level to improve AI skill-level inference (Kate's suggestion).

## Follow-ups / open questions
- How to map Docebo's skill library / course catalog to skills; per-org pre-processing needed since catalogs differ by access level (spike suggested).
- Handling users who enroll in a course directly on the LMS (Docebo/LinkedIn) without setting up a goal — what the handoff/backwards-looking-goal flow looks like.
- Whether AI can reliably infer proficiency level — Nitish cautioned proficiency is subjective and org-specific; Nataliya agreed proficiency is inherently subjective whether human- or AI-validated.
- "Applying to work" (experiential learning) and free-form aspirations → auto-recommended skills flagged as very optimistic for summer, likely winter.

## Discussion notes
- Development goal creation: standard goal-creation panel with pre-populated data; category "professional development"; whether to carry over start/end dates and certificates from Docebo TBD; category vs. scope as the trigger field still being decided (Kate).
- Personal-growth section redesign to encompass aspirations, development goals, and skills (employee-driven growth).
- Aspirations: free-form text where AI could auto-recommend skills; aspirational positions with skill-match score and upskilling path; "people you can reach out to" (mentorship/community) valued by Nellie.
- Skill graph vision: connects job-description required skills with skills of people who succeeded in a role, building a per-role/per-individual repository to enable complex gap analysis (future-forward); for summer, just have/don't-have + upskilling guidance.
- Zoom transcripts (summer release) will feed AI-inferred skills + proficiency into the employee skills section, subject to manager verification.
- Cost consciousness: tokens are a concern; Nataliya wants creative mixes of AI + matching logic to deliver value without excessive AI cost.
- Verification today: employee requests manager verification; manager accepts/rejects; a board must opt in to verification.

## Next steps
- Nataliya to progress designs and use-case coverage with the design and goals teams; continue skill gap analysis with Laura Ripple.
