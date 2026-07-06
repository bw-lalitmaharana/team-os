---
date: 2026-05-08
meeting: Gauri / Lalit
type: 1:1
attendees: [Lalit Maharana, Gauri]
source: zoom
meeting_uuid: 5C80334B-5A25-4D36-B67A-EB44F1CC65A1
backfilled: 2026-07-07
---

# Gauri / Lalit — 2026-05-08

## Summary
Introductory meeting between Lalit (new Senior PM, started Monday, will oversee AI and platform features) and Gauri (Senior UX Designer, ~2 years at Betterworks, works on AI and homepage pods) to align on the meeting transcripts project, Lalit's first assignment. They discussed the current state of AI adoption at Betterworks — design transformation initiatives led by Sriram and the company's shift toward becoming AI-native across functions. Gauri emphasized clearly defining feature scope before planning a workshop, suggesting they review prior brainstorming sessions and documentation to establish specific goals and MVP requirements. Lalit presented an initial architecture concept (transcript processing, AI-powered summary generation, and user action suggestions). They agreed to coordinate with Nelly to finalize project scope before further planning.

## Key decisions
- Workshop approach: hold a scope-definition meeting with Nelly first, then run a structured workshop with QA, designers, and developers to fast-track prototype development.
- MVP focus: single source (Zoom/Teams transcript or manual paste), AI summarization engine, deduplication layer, and a suggestions queue with frontend display.
- Timeline: target a summer release for the meeting transcripts feature.

## Action items
- [ ] Lalit — Review the recording/transcript from the previous brainstorming meeting on meeting transcripts (to be shared by Nelly).
- [ ] Lalit — Sync with Nelly (optionally Gauri and others) to finalize scope and timeline, including MVP definition and summer target release.
- [ ] Lalit — Gather details on delivery timeline, target users/use cases, and engineering feasibility for the MVP scope.
- [ ] Lalit — After scope is defined, consult engineering to assess what can be delivered in MVP vs. later phases.
- [ ] Lalit & Gauri — Design a 15–20 minute workshop agenda and structure once scope is confirmed.
- [ ] Gauri — Share general workshop documentation template and help structure the workshop agenda once scope is finalized.

## Follow-ups / open questions
- Scope definition pending a meeting with Nelly to finalize MVP boundaries and feature set for the summer release.
- Workshop agenda (goals, timeline allocation, desired outcomes) to be defined once scope is locked.
- Engineering feasibility: how much of the proposed architecture fits in MVP vs. future phases.
- User research: gather information about target users and use cases.

## Discussion notes
- Roles: Lalit oversees AI/platform features and may serve as Gauri's main coordination point; Gauri is a senior UX designer on AI and homepage pods. New AI projects have resumed under Nelly's leadership (performance summary and skills features).
- AI transformation context: dev team already using GitHub Copilot and AI testing tools; design exploring ChatGPT Enterprise, Claude, and Replo to reduce the design-to-code gap; roles becoming more fluid (QAs experimenting with design, PMs reviewing code). Company-wide AI-native initiative led by Sriram.
- Project architecture (meeting transcripts):
  - Data sources: Zoom API, Teams API, or manual transcript paste as MVP starting point; future expansion to Jira interactions, Slack/Teams DMs.
  - Backend: AI service engine (summarize transcripts, identify signals, structure output); deduplication service (checks existing user data — action items, past meetings, goals — to avoid duplicate suggestions); suggestions queue table (ordered queue from multiple sources: goals, meetings, feedback).
  - Frontend: suggestion cards with header, subtext, source attribution, CTA button, and dismiss option; actions include add one-on-one record, add feedback entry, update goal record.
- Recent project history: a brainstorming session ~2 weeks prior explored all possible transcript features (V1/V2/MVP) without technical restrictions. Prior AI-pod PM was Bharat (India-based); projects paused during PM transition until Nelly joined March/April. Performance summary and skills projects nearing completion.
- Table display design: Lalit presented a draft (header, subtext, source, CTA buttons, distance options); Gauri confirmed alignment with prior discussions and suggested using AI tools to build a prototype.

## Next steps
Once the scope meeting with Nelly is complete, Lalit will sync with Gauri to finalize the workshop structure and invite the cross-functional team (QA, design, engineering) for a collaborative prototyping session.
