---
date: 2026-07-03
meeting: AI Recommendation sync
type: sync
attendees: [Lalit Maharana, Nataliia, Nitish, Pankaj]
source: zoom
meeting_uuid: 9827810B-A016-4F1E-A1AE-FEBF75C518BE
backfilled: 2026-07-07
---

# AI Recommendation sync — 2026-07-03

## Summary
Lalit walked Nataliia through a comprehensive PDP (Personal Development Plan) vision built on a 70-20-10 learning model, proposing a multi-agent recommendation engine covering courses, mentors, external content, and work application. The presentation was well-received, with agreement on course and mentor recommendations as MVP scope. Open questions around external content restrictions, latency, and organizational data access will be discussed further on Monday with Nitish and Natalia.

## Key decisions
- MVP scope confirmed: course recommendations and mentor recommendations included; all other components (external influencers, reading/watching material, apply-to-work) remain open.
- Mentor MVP approach: simple database query matching employees with higher proficiency in the target skill — no complex AI ranking logic for the initial release.
- Latency mitigation: surface mentor and generic content first; trigger the course recommendation engine in parallel when a user clicks a skill; cache results so re-opening doesn't reprocess the pipeline.
- Roadmap format for the learning plan: structured numbered steps (not plain text) to enable conversion into milestones in the goal-creation flow.
- Goal quality index not displayed as a raw score; the AI assistant nudges the user with guidance (e.g., "your goal needs more content") instead of surfacing the number.

## Action items
- Lalit: Test recommendation output format for multiple skills; validate whether the numbered-step structure (convertible to milestones) is achievable from the prompt.
- Pankaj: Complete a spike on cross-organizational data access restrictions for mentor/peer visibility.
- Nitish: Continue latency testing on the AI course recommendation pipeline; present findings Monday.
- Nataliia: Facilitate the Monday session — Lalit to walk through the PDP vision with Natalia and Nitish together; schedule follow-up if time is insufficient.

## Follow-ups / open questions
- External content (reads, videos, influencers): needs enterprise customer validation — acceptability of open-internet recommendations, regional/language specificity, and source reliability unresolved.
- Mentor visibility restrictions: Pankaj to check if cross-department employee data access is restricted (spike).
- Mentor CTA workflow: linking to Teams/Slack chat or scheduling a 1:1 — deferred; generic email option considered for summer MVP, final workflow to align with Natalia.
- Apply-to-work component: requires manager workflow and project assignment tracking; moved to V2 pending research.
- Which AI model powers mentor ranking and generic content (course recommendation uses OpenAI, migrating to Gemma/Llama).
- Ownership for mentor ranking development not yet identified.

## Next steps
- Monday: joint session with Natalia, Nitish, and Lalit to review latency results and the PDP recommendation vision; follow-up session if needed.
