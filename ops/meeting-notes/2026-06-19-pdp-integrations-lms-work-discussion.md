---
date: 2026-06-19
meeting: PDP - Integrations LMS work discussion
type: architecture
attendees: [Sriram, Nitish Devadiga, Jason Zhang, Pankaj Lohmor, Lalit Maharana, Rinku]
source: zoom
meeting_uuid: EAF87C52-0810-44CC-8448-E36D6B560867
backfilled: 2026-07-07
---

# PDP - Integrations LMS work discussion — 2026-06-19

## Summary
The meeting focused on the integration architecture for the personalized learning development program (PDP) feature, emphasizing breaking dependencies between integrations and internal modules. Sriram explained a vision of moving toward an event-based architecture where third-party integrations communicate with a central platform rather than directly with specific internal modules like goals. Nitish confirmed the current PDP work builds on existing KR integration foundations but would require additional effort to migrate to the new architecture, particularly due to webhook endpoint changes that create customer friction. The AI component was discussed, with Jason highlighting course-recommendation accuracy challenges using current text-based search versus semantic embedding approaches. Nitish agreed to contribute to the AI platform in addition to completing his LMS endpoint consolidation (~2 weeks). The group decided to form a cross-functional team (Pankaj, Nitish, Goals, AI) with technical decisions to be finalized by end of June to maintain the August delivery timeline.

## Key decisions
- Move toward an event-based integration architecture: third-party sources feed a central platform; internal modules access data via a unified interface without knowing underlying sources.
- KR Integration Service to be refactored into an event generator that converts third-party events into goal progress updates (rather than managing specific platform integrations).
- Treat existing LMS provider integrations as tech debt; apply new architecture to meeting transcripts feature first; add adapters/wrappers to simplify future migration.
- Nitish continues LMS endpoint consolidation work AND contributes to AI recommendation feature.
- Freeze all technical decisions, protocols, and contracts before end of June to enable a focused 6-8 week execution window.

## Action items
- [ ] Nitish — Complete consolidation of LMS endpoints into a unified data model (search + course data across Udemy, LinkedIn, Docebo) for AI team use (~2 weeks)
- [ ] Nitish — Investigate whether Udemy and LinkedIn offer MCP endpoints for course search; report findings
- [ ] Nitish — Support AI team on the recommendation feature after unified LMS endpoints work
- [ ] Nitish — Provide overview of current LMS integration approach and ideas to Jason and AI team in next meeting
- [ ] Jason — Schedule and lead a technical discussion (Monday 9:30) with Nitish, Pankaj, Lalit, Emerson/Goals, SDET, Okan/Danish to review AI recommendation feature and integration requirements
- [ ] Jason — Ensure Okan/Danish are included to align on webhook implementation and avoid duplicated effort
- [ ] Pankaj — Present high-level architecture and workflow for PDP in the technical meeting
- [ ] Lalit — Stay in the loop on all AI-related discussions; drive/facilitate daily stand-ups and cross-team coordination
- [ ] Rinku — Schedule/structure regular scrums and project planning for the cross-functional team (AI, Integrations, Goals, SDET) by next week
- [ ] Nitish & Pankaj — Sync with Okan (and Danish) on webhook implementation, especially auth mechanisms for Zoom integration
- [ ] All technical leads — Freeze technical decisions/protocols/contracts before end of June

## Discussion notes
- Nitish's integration work: new UI for goal creation linked to courses; webhook ingestion for progress updates already built into KR integrations for Udemy, LinkedIn, Docebo.
- Docebo integration change would require modifying webhook endpoints and rewriting flows, increasing complexity and customer friction.
- AI course recommendation: Jason flagged accuracy concerns with text-based search; proposed semantic embedding layers based on skills/competencies. Nitish suggested using system prompts to generate multiple search terms.

## Next steps
- Establish a unified cross-functional team approach for the 6-8 week implementation timeline toward the August delivery.
