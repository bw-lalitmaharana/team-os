# Action Note — 2026-05-13 Product Acceptance call with Exec Sponsor

> Source: Zoom meeting uuid `7D6A937E-6C54-4362-8AD2-8E16FF3E2A96` (2026-05-13 14:00–15:00 UTC).
> Captured here for tracking. PRD-level decisions logged to `product/meeting-transcripts/prds/*/§14 Decisions Log`.
> Confluence parent updates applied by Exec Sponsor at pages 4280614960 (platform) and 4281139203 (Meetings).

## Decisions absorbed into PRD trio (v0.8.0 platform / v0.3.0 children)

| Decision | Where landed |
|---|---|
| Automated Zoom ingestion = MVP required; AI Platform Lead fallback if Integrations pod can't deliver | Platform §10a MUST · CAP-011 · §10 Risks · D-013 |
| Evidence rows write to data warehouse (Aurora), not siloed pod DBs | Platform §1a · §10 Dependencies · D-014 |
| AI generates summaries from raw transcripts (not Zoom Companion native) | Platform CAP-001 · §1a diagram · D-015 |
| Admin-level Zoom enablement precedes user-level connect | Platform §1c · Connect Layer CONN-CAP-006 · D-016 / CD-008 |
| List page features → V2/stretch; only connect nudge stays MVP | Meetings PRD MEET-CAP-101/102 marked stretch · §11 · MD-006 |
| Carry-forward of action items = DEFAULT (not configurable) | Meetings MEET-CAP-204 · §10a MUST · MD-007 |
| Agenda items also thread across meetings (not just action items) | Meetings MEET-CAP-203/204 renamed · MD-008 |
| Connect Layer MVP = modal in Meetings page (not full Connections page) | Connect Layer CONN-CAP-001a NEW · CONN-CAP-001 → V2 · CD-007 |
| CAP-010 Feedback pre-fill needs draft-state handling when no template exists | Platform CAP-010 flagged for Feedback pod alignment |

## Pending — needs follow-up this week

### F1. Integrations team capability spec for Thursday (2026-05-15)
- **Deliverable**: Document expected capabilities for the integration layer (auth flows, user documentation, client setup requirements) similar to AI team breakdown
- **Audience**: Integrations pod + Cross-pod PM Integrations
- **Status**: Drafted as a new sub-section in PRD-CONNECT-LAYER §7 ("Integration Layer Capability Spec")
- **Owner**: PM owner — share Confluence link + spec section before Thursday call

### F2. Feedback pod alignment
- **Purpose**: Resolve CAP-010 open issue — how to surface AI-generated feedback when users haven't created templates
- **Proposal to bring**: Draft-state object pattern (template-less first-class draft that becomes template-bound after user assigns one)
- **Owner**: PM owner — book meeting with Feedback pod PM (Performance pod)
- **Blocks**: S-14 stretch story (template-bound feedback pre-fill)

### F3. Walkthrough with App Platform Lead
- **Purpose**: Walk through the full trio (platform + meetings + connect-layer) for engineering alignment
- **Owner**: PM owner — block calendar time
- **Outcome**: Identify any platform-layer concerns before story breakdown is committed to Jira

### F4. AI Platform Lead coordination
- **Purpose**: Walk through capability breakdown; align on ticket sequencing before AI scrum meeting
- **Owner**: PM owner
- **Status**: Block scheduled

### F5. AI platform backlog sprint planning
- **GPT-4 upgrade support tickets**: AI Platform Lead completes dev part current sprint; tickets split among devs next sprint
- **Translation service (potential)**: Coordinate with AI Platform Lead — GPT-4 powered translation for template content; possible future use for transcripts
- **Owner**: PM owner — capture in AI platform backlog tickets

### F6. Exec scope-alignment for Rainforest milestone
- **Trigger**: §10 Risks (Platform PRD) flags that current story sequencing has Week 5+ items vs. May 31 target
- **Per exec sponsor**: Date may move post discussion rather than cutting scope
- **Owner**: PM owner — book in Week 2 (this week)
- **Concrete proposal to bring**: Either move date OR identify which scope items are firm-out for May 31

## PRDs / docs to draft (action items for the team-os)

### Drafted as stubs — promote when 3-of-6 split rule satisfied
- `product/meeting-transcripts/prds/_stubs/goals-ai-surfaces.stub.md` (Goals AI surfaces)
- `product/meeting-transcripts/prds/_stubs/feedback-ai-surfaces.stub.md` (Feedback AI surfaces)
- `product/meeting-transcripts/prds/_stubs/skills-ai-surfaces.stub.md` (Skills AI surfaces)

### Not yet drafted — owners need to be assigned
| PRD | Owner | Reason |
|---|---|---|
| **PRD-TRANSCRIPT-INGESTION** | Cross-pod PM Integrations | Owns the Integrations side of automated Zoom/Teams flow; needs to land before Thursday's Integrations capability spec discussion |
| **PRD-MEETINGS-CONFIRMATION-UI** | Meetings PM | Owns the user-facing accept/dismiss/edit chip behaviour; consumes platform Why-this contract |
| **PRD-TRANSLATION-SERVICE** | AI Platform Lead | Multi-language template content + future transcript translation; post-MVP but architecture overlaps |

## Discussion topics to schedule (this week)

| Topic | Participants | Priority | When |
|---|---|---|---|
| Exec scope-alignment for Rainforest (F6) | PM owner + Exec Sponsor + AI Platform Lead | **High** | Week 2 |
| Integrations capability spec (F1) | PM owner + Integrations pod + Cross-pod PM Integrations | **High** | Thursday 2026-05-15 |
| Feedback pod alignment (F2) | PM owner + Performance pod PM | Med | Week 2 |
| App Platform walkthrough (F3) | PM owner + App Platform Lead | Med | Week 2 |
| AI Platform sprint planning (F5) | PM owner + AI Platform Lead | Med | Within sprint |

## Exec frustration to monitor

- **Integrations pod is pushing for Recall AI** instead of starting with Zoom POC. Exec sponsor has rejected Recall (Decisions Log D-001) and reinforced today. Process risk added to Platform §10 Risks. Escalation path: PM owner via Principal Eng (per Owners block) if needed.

## Open links — for future sessions
- Parent Confluence (strategic PRFAQ): https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097
- Confluence: Platform v0.7.0: https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4280614960
- Confluence: Meetings v0.2.0: https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4281139203
- Local trio: `product/meeting-transcripts/prds/`
