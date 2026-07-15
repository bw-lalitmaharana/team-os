---
date: 2026-07-15
meeting: "Demo Recording - Skill graph"
type: review
attendees: [Lalit Maharana, Neetesh Kaushik]
source: zoom
meeting_uuid: 20D72671-CF99-4F84-A322-98E244EB1E9E
---
# Demo Recording - Skill graph: final recording — 2026-07-15

## Summary
Final recorded demo of the skill-graph hackathon build, covering architecture, provider strategy, working features, and the business/differentiation case.

## Key decisions
- Architecture confirmed: skill nodes + talent-profile nodes linked by semantic-similarity edges.
- Lightcast confirmed as the current skill-taxonomy provider, with a plug-and-play design intended to support additional providers (e.g. TechWolf) later.
- Four features demonstrated as working: search-by-skill/person, succession recommendations, mentor recommendations, CSV export.

## Action items
- None captured as firm commitments — see proposed next steps below.

## Follow-ups / open questions
- Whether to pursue a unified "work graph" spanning goals/feedback/conversations — proposed, not committed.
- Shared API endpoint across graph features — proposed, not committed.
- Natural-language/voice input — proposed, not committed.
- Mobile support — proposed, not committed.
- Compliance/security requirements at scale — proposed, not committed.

## Discussion notes
- Business case cited: 68% of skills are expected to change by 2030; 58% of the workforce will need new skills.
- Differentiator framed as Betterworks' existing performance data, versus point competitors Workday, 8fold, Gloat, Lattice, and 15Five.
- The proposed unified "work graph" echoes Jason Zhang's "people graph" idea from the 07-14 hackathon-guidance review.

## Next steps
- Use this recording plus the architecture/differentiation story to inform PRD framing and backlog-rank scoring.
- Treat the unified work-graph extension as an open scope question for a future refinement call.
