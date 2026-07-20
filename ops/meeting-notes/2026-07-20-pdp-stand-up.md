---
date: 2026-07-20
meeting: PDP Stand Up
type: sync
attendees: [Sriram CS, Pankaj Lohmor, Nataliia Savenko, Lalit Maharana]
source: zoom
meeting_uuid: 4A75B7AF-30B8-4837-8023-0871420745EF
---
# PDP Stand Up — 2026-07-20

## Summary
The team reviewed progress on goal creation and LMS integration. Nataliia reported Saurabh's second spike on background goal creation and that structured user stories for UI implementation are complete. Pankaj is running a spike comparing local course-catalog storage vs. the old approach (tested against a 20,000-course catalog) and will sync with Nitish before sharing results. A Thursday meeting is planned to review the LMS integration approach and get formal technical sign-off. The team also discussed pending PDP settings changes and revisited the hackathon skill-graph project for potential mentor-recommendation use.

## Key decisions
- Placeholder UI can be built now; stub/KPI responses are acceptable for the next 1–2 weeks while the search approach is finalized.
- Course-recommendation/search blocker will be escalated via a direct call with JC (preferred over Slack) rather than waiting for Thursday's meeting — JC is typically available 9:30–10 AM.
- Skill graph (built by Neetesh Kaushik at the hackathon) will be explored for mentor recommendations; if not ready for summer release, it's a winter-release candidate.
- PDP settings changes (Goldstein proposing unifying category/scope/type into one flexible labeled attribute) are on hold pending Anuj/Varnika's decision; team will wait before proceeding with goal-creation work.

## Action items
- **Pankaj:** Sync with Nitish tomorrow to validate catalog-storage numbers, share results in the group, then message/call JC for sign-off ahead of Thursday.
- **Pankaj:** Speak with Anuj about potential PDP settings changes and their impact on goals configuration.
- **Pankaj:** Review Nataliia's structured user stories for UI and confirm whether APIs can be implemented and delivered against that structure.
- **Nataliia:** Share user stories with Pankaj and Nitish for review once Nitish is available.
- **Nataliia:** Prepare a formal technical sign-off document for the LMS integration approach ahead of Thursday's meeting.
- **Lalit:** Walk Nataliia through the hackathon skill-graph solution and explore integration possibilities for mentor recommendations.
- **Sriram / Lalit:** Share hackathon solution recordings (skill graph, internal mobility matching) with Nataliia.

## Follow-ups / open questions
- Final course-recommendation/search approach still under deliberation pending Pankaj's spike and JC's sign-off.
- Skill-graph integration scope and release target (summer vs. winter) not yet confirmed.
- PDP settings attribute-unification decision pending Anuj/Varnika.

## Discussion notes
- Anastasia is cleaning up the UI for a prototype to present in upcoming CS/IPP meetings.
- Most user interactions in Nataliia's shared Figma can be supported by the current system; a few are only partially supported.
- Emerson's last day is the day after tomorrow and he won't be involved in the PDP settings decision.
- Team reviewed hackathon highlights: Better Call Sal (1st), Performance Partner — Pankaj (4th/6th place, mentioned inconsistently), Skill/Knowledge Graph — Neetesh Kaushik (2nd), and Internal Mobility Matching. All are full-stack working solutions (AI inference server, backend, frontend), not architecturally polished.
- Internal Mobility Matching flagged as a natural future tie-in once aspirations functionality exists, linking mobility recommendations to stated aspirations.

## Next steps
- Pankaj to close the loop with Nitish and JC before Thursday's LMS review meeting.
- Lalit to walk Nataliia through the skill graph and assess mentor-recommendation fit.
- Nataliia to prepare the technical sign-off document for Thursday.
