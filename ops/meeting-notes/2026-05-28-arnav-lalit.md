---
date: 2026-05-28
meeting: Arnav / Lalit
type: 1:1
attendees: [Arnav Garg, Lalit Maharana]
source: zoom
meeting_uuid: 90BAD2C6-BDB4-4C43-B0F7-6AE09E2118E9
backfilled: 2026-07-07
---

# Arnav / Lalit — 2026-05-28

## Summary
Onboarding / context-sharing 1:1 between Arnav and Lalit (new PM, four weeks in, working on the app platform and AI pod). Arnav gave a comprehensive overview of the product organization: the core product is Goals, Conversations, and Feedback (CFG), which generates the majority of revenue and support tickets. He outlined stakeholders for different product areas — Varnika for goals, Neeraj and Paul for conversations, Arnav himself for analytics/reporting, Saran for analytics, Chao and Jason (Deng) for data platform. Arnav covered several platform challenges: moving away from Transifex for translations due to high cost, notifications and LaunchDarkly flag management, and role-based access control (RBAC). He explained that customer interactions are handled by CSMs rather than product teams, and mentioned upcoming company-wide AI training for PMs starting mid-June (organized by Sriram).

Lalit shared that his current work is the meeting-transcript feature — summarizing action items and agenda topics from Zoom transcripts, with plans to expand to other sources (Slack, Jira). Arnav noted product team sync-ups used to be monthly but are now irregular, though the culture remains open to ad-hoc discussion.

## Key decisions
- CFG (Goals, Conversations, Feedback) is the most critical and mature part of the product; support incidents primarily originate there.
- Customer feedback / user testing should be routed through CSMs and Ingrid Cullen (design team) rather than direct product-team-to-customer contact.
- Translations: explore moving off Transifex toward in-house / resource-bundle-based options for cost and maintainability.

## Discussion notes
- Product ownership map: Varnika (goals); Neeraj and Paul (conversations); Arnav (analytics/reporting, plus CFG context); Saran (analytics); Chao and Jason Deng (data platform).
- App Platform team has had recent leadership changes; changes across modules are hard due to complex interdependencies.
- Module PM gaps: recognition and NextGen calibration lack designated PMs; recognition is particularly unattended and sometimes clubbed with other modules. Engage is covered.
- Reporting structure: Lalit reports to Nataliya; Nataliya was hired to handle new modules when Cheryl could not cover the whole area.
- Horizontal module priorities: talent, skills, succession planning (Nataliya oversees; Kate has detailed knowledge).
- AI tooling gap: everyone uses basic AI features, but advanced tools (Copilot, "CloudCo") are underleveraged; company-wide AI/PM training starts mid-June (Sriram).
- Open strategic areas awaiting leadership direction: RBAC implementation and LaunchDarkly flag cleanup (as legacy → next-gen transition completes).

## Action items
- [ ] Lalit — Connect with relevant PMs / team members (Nellie, Nataliya, Rinku, Pankaj, Anuj, Chao, Jason, Prasanna, Kate, Sharon, Sagar, JZ, etc.) to gather deeper context on app platform, AI, integrations, and talent modules.
- [ ] Lalit — Review current translation implementation (Transifex usage) and assess feasibility of moving to in-house / resource-bundle-based solutions.
- [ ] Lalit — Evaluate current state and future direction of RBAC in the app platform; initiate discussions with Nellie and other stakeholders to define deliverables and cross-module impact.
- [ ] Lalit — Investigate status/strategy for managing and sunsetting LaunchDarkly flags; consider alternatives for feature-flag management.
- [ ] Lalit — Coordinate with Sriram on the upcoming AI/PM skill-up training; consider sharing best practices / standard AI workflows across the product team.
- [ ] Lalit — Reach out to Ingrid Cullen / design team (Sarah, Brooks) for organizing customer feedback / user-testing sessions as new features develop.
- [ ] Lalit — Standardize and document PM workflows for leveraging AI tools; share findings with Arnav and Sriram.
- [ ] Lalit — Continue engaging Arnav and senior PMs for ongoing context, especially on cross-module or legacy/next-gen impacts.
