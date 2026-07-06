---
date: 2026-05-20
meeting: Meetings transcripts UX
type: design
attendees: [Lalit Maharana, Sarah Brose]
source: zoom
meeting_uuid: C8AA2D39-4D7A-48F7-8D43-2BADC1CBAC9F
backfilled: 2026-07-07
---

# Meetings transcripts UX — 2026-05-20

## Summary
Lalit and Sarah discussed integrating meeting-transcript-derived AI recommendations into the one-on-one meetings UI, focusing on the right panel design. They explored displaying AI recommendations as a reusable global component versus inline suggestions within existing sections. Sarah stressed screen-real-estate constraints (13-inch laptops, limited vertical scroll) and the importance of consistency with the current right panel. Three implementation directions were discussed: (1) a reusable panel component, (2) embedding suggestions within existing sections (action items, goals, feedback), and (3) a new section within the existing right panel. The conversation also covered handling AI suggestions when AI is disabled at the org level, and the need to align on scope for the summer release.

Background context: the right panel was originally a reusable view-only reference component (goals, feedback, recognition, conversations) with a picker at the top to address vertical space limits; it has "ballooned" over time. The talent profile feature has evolved into multiple categories; implementing a true global platform component would require cross-pod discussion and significant dev work beyond the meetings AI transcript project. The AI engine will extract signals from multiple sources (Zoom first, then Slack, Jira, Confluence) and maintain a unified ranked recommendation list, contextualized per page.

## Key decisions
- Focus design exploration on two of three directions: inline suggestions within existing sections, and a new section within the existing right panel (as default view). The reusable-global-panel option is deprioritized for this scope.
- MVP scope: Zoom integration, meeting summary, action items, and agenda extraction shown in UI; OKR/Goal and feedback recommendations pending alignment with Nellie.
- UI must work when AI is disabled at the org level or for specific groups.
- AI suggestions should roll over between meetings (user-controllable); users will need to manage/clean up the list over time.

## Action items
- [ ] Sarah — Draft a summary note outlining the 2–3 proposed design directions for integrating AI suggestions into the meetings UI; share with Lalit and Austin for review.
- [ ] Sarah — Brief Austin on current status, scope, and design options to explore.
- [ ] Lalit — Check with Nellie (and possibly the goals team) on feasibility/priority of including OKR/Goal recommendations in the MVP.
- [ ] Lalit — Send the UI bug screenshot (encountered during the meeting) to Eden and Varnica.
- [ ] Austin — Explore a two-tab right-panel concept (one tab for meeting prep/AI suggestions, one for standard content) as a potential middle-ground.

## Follow-ups / open questions
- Transcript viewing approach: redirect to source app vs. show in a sidebar for easier scrolling — undecided.
- Scope boundaries with PMs and Natalia: what level of one-on-one redesign is permitted vs. must stay as-is for V1.
- Whether dismissed/unactioned AI suggestions should roll over to the next meeting, and how that affects list growth.
- Distinction between an "action item" and an "AI suggestion" (e.g., "create a goal" as an action item vs. a suggestion) needs clear logic.

## Discussion notes
Design patterns considered:
1. Inline integration within existing sections — embed AI suggestions within action items, goals, feedback where relevant, letting users act in context.
2. Dedicated collapsible panel — separate space that scales across modules but risks competing for attention / pushing content down.
3. New section in existing right panel — AI suggestions as default first option in the right panel dropdown, preserving existing structure.
4. Two-tab approach in the right panel — meeting prep/AI suggestions vs. standard right panel content.

Constraints identified: some orgs disable AI entirely; global component work needs significant dev effort for accessibility and reusability; limited vertical scroll on smaller laptops; action items have an assignee concept where both manager and employee can create tasks for each other. Forms can be pre-filled from transcripts to reduce friction. Recognition component is designed but not yet built; the feedback AI component already exists.

Lalit and Sarah converged on integrating AI recommendations directly into existing goals/feedback/recognition sections rather than inventing new UI patterns, to preserve familiarity while surfacing AI value in context. Sarah flagged the scoping-clarity question (extensive redesign vs. fitting AI into current UI for V1) as directly impacting summer-release timeline and preventing wasted design effort.

## Next steps
- Sarah to circulate the design-directions note to Lalit and Austin.
- Lalit to align with Nellie on OKR/feedback recommendation scope for MVP.
