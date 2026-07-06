---
date: 2026-05-14
meeting: POC Demo for Unified (Transcript Integrations)
type: planning
attendees: [Lalit Maharana, Sriram CS, Nellie LeMonier, Jason Zhang, Anuj Pancholi, Pankaj Lohmor, Nataliya Kolb]
source: zoom
meeting_uuid: 9999BABE-88D4-4913-8990-A6A5A57430DF
backfilled: 2026-07-07
---

# POC Demo for Unified (Transcript Integrations) — 2026-05-14

## Summary
Kickoff for the cross-pod project to build AI-powered meeting intelligence that extracts signals from meeting transcripts (initially Zoom) and surfaces actionable insights — agenda items, action items, summaries — within the Betterworks platform. Lalit presented MVP scope and architecture. The core challenge is selecting an integration approach (iPaaS vendors such as Unified/Combo were evaluated) that balances enterprise security, scalability, and time-to-market for the summer release. Sriram outlined the team structure and delivery approach, and the group aligned that a first decision milestone — finalizing the Zoom data-acquisition method — must land within 1–2 weeks.

## Key decisions
- Lalit is the primary PM and day-to-day contact, leading overall scope and coordination across three collaborating pods (AI platform, integrations, meetings).
- V1 focus: Zoom transcripts via a Zoom Marketplace app, with manual upload as fallback; show "what happened before" summaries and suggested action items on meeting detail pages.
- Prefer a Zoom-native integration over third-party meeting bots (bots face InfoSec blockers at large enterprises; manual copy-paste risks low adoption). Leverage Betterworks' strong Zoom partnership to accelerate approvals.
- Architecture must be scalable/extensible to other signal sources (Slack, Jira, etc.) beyond Zoom; treat the AI engine as a platform that other teams can call.
- Consider an iPaaS vendor for integrations for data privacy and scalability — but must verify vendors truly pass data through without retaining records.
- Team commitments: Anuj (delivery lead), Danish (integrations, with JZ on data flow), JZ (AI platform lead), Pankaj (principal engineer, cross-pod architecture), new developer Hiten full-time through summer release.

## Action items
- [ ] Anuj — Create a high-level project plan/schedule with Lalit and JZ; identify immediate milestones/decision points (integration solution, architecture specs) in the next 1–2 weeks, especially the Zoom-data solution or manual-input fallback. Complete the spike with relevant members and produce a clear plan.
- [ ] Sriram — Confirm and update the team by tomorrow on who will be the project manager (Tanvi or Rinku).
- [ ] Sriram — Ask Austin to connect with Anuj on the UX route so front-end development can proceed once the prototype is ready.
- [ ] Austin (UX) — Connect with Anuj to share/review the meetings UX prototype and coordinate on front-end development.
- [ ] Lalit — Serve as primary PM leading overall scope and coordination.
- [ ] Project Manager (once identified) — Schedule regular syncs: daily standups (India time) and frequent review calls starting next week; initiate VRA scrum calls from next month.
- [ ] Engineering (Anuj, Danish, JZ) — Complete integration/meetings/AI architecture spike; finalize Zoom data-acquisition approach within 1–2 weeks; support each other across pods as needed.
- [ ] Anuj — Invite Lalit and Nellie to the demo call; record and share with the full team.
- [ ] Danish, Anuj, Hiten — Coordinate with the India AI team (Sagar, Prasanna, Akansha, Babesh, Heyman) to understand the AI framework and find improvement opportunities.

## Follow-ups / open questions
- Project manager identity (Tanvi or Rinku) to be confirmed by next week.
- Meetings-pod developer TBD.
- Nataliya requested demo access once available; Sriram confirmed a recording and follow-up invite.

## Discussion notes
- End-to-end vision: connect multiple sources (Zoom, Slack, Jira) → extract signals with confidence → store evidence → link to user objects (goals, feedback, skills) → surface suggestions in the meetings UI.
- User consent flow: admin enables at tenant level; employees authorize the Zoom connector with clear data-usage disclosure.
- Nellie emphasized enterprise constraints: enterprises already trust Zoom's security posture; solution must be scalable/extensible to other sources.
- JZ noted AI-team capacity (India-side team available) and an opportunity to spread AI-platform knowledge across pods to accelerate future features.
- Integration approach: iPaaS vendors (Unified, Combo) evaluated as pass-through to reduce per-integration lead time and maintenance; must confirm no data retention. First decision milestone is finalizing Zoom data acquisition within 1–2 weeks so the team can focus on AI and UX work.

## Next steps
Deliver AI-generated meeting insights (summaries, action items) by the summer release with three pods collaborating under unified PM leadership (Lalit). Finalize integration architecture quickly to avoid a bottleneck while meeting enterprise security standards and enabling future data sources. Maintain momentum via cross-pod resource sharing, daily standups (India time), and weekly reviews.
