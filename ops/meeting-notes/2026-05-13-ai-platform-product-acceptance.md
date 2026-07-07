---
date: 2026-05-13
meeting: AI Platform Product Acceptance
type: review
attendees: [Lalit Maharana, Nellie LeMonier]
source: zoom
meeting_uuid: 7D6A937E-6C54-4362-8AD2-8E16FF3E2A96
backfilled: 2026-07-07
---

# AI Platform Product Acceptance — 2026-05-13

## Summary
Nellie and Lalit worked through the design of an AI-powered platform to bridge conversations and work — extracting insights from meeting transcripts and integrating them with Betterworks objects (goals, meetings, feedback). They reviewed the platform's components, data model, and UX (especially the meetings feature).

Key discussion threads:
- **AI-driven meeting documentation:** Three documents completed so far covering platform components, meeting surfaces, and the connect interface. AI layer collects "evidence" from meetings starting with Zoom transcripts, later feedback, goals, and other sources (Slack, Jira, HubSpot, Salesforce). Every suggestion links to Betterworks objects for traceability, keeping humans in the loop on suggested actions.
- **Source adaptive framework:** Manages auth and replay checks. Signal extractor is an LLM engine that extracts signals from transcripts. Agreed to write evidence rows to the data warehouse for reporting and cross-pod access. Reconciliation checks against existing data objects and populates suggestions.
- **Signal categorization schema:** To be reviewed with engineering. Decided on polymorphic matching (Gong-style) over a graph model (Glean-style) as better suited to their scale; implementable on existing Postgres/Aurora.
- **Summary generation:** They will generate their own summaries from raw transcripts rather than relying on Zoom's summaries.
- **AI coaching:** Gather info before and after 1:1 meetings rather than during them; AI must show sources/evidence; page-specific modulations (meetings, feedback). Connect layer to be a separate PRD (problem rationale, customer pain, positioning). Target ~30% confirmation rate for AI suggestions to ensure value.
- **Platform capabilities for the study:** summary generation; action-item and discussion-topic extraction; signal extraction; pre-meeting coaching prompts; reconciliation framework; evidence presentation with feedback collection. Open concern: how feedback surfaces when users have no templates (possibly create draft objects for approval — to detail in a separate story).
- **Feature planning:** Automated transcript injection is an MVP feature; manual upload a possible V1 option. If the integrations pod cannot deliver automated transcript, JZ will take it on to guarantee inclusion.
- **Integration layer:** Nellie asked for a capabilities breakout to drive direction; Lalit to complete. Multi-language: initially source and summary languages the same. Meetings feature plan: list page, details page, calendar integration (Zoom integration not yet confirmed); auto-fill agenda chips, action suggestions, rollover of action items from previous meetings.
- **Configuration & pricing:** Debated whether carry-over settings are configurable or default-on. Explored tiered pricing — base meeting structures standard, AI integrations as a premium add-on. UX: action-item management, inline branding, tracking user modifications.
- **Meeting management UX:** Last-meeting recap and cross-session summaries in the details page; agenda and action items as distinct objects. MVP to focus on details-page functionality rather than list-level digests across meetings (too complex for v1). "Connect" (Zoom transcripts) is the only list-page capability initially.
- **Zoom integration:** Start with a modal in the meetings page rather than a full connections page. Document integration-layer scope and present Thursday. Nellie frustrated the integrations team is oversimplifying the Zoom POC. Reviewed AI platform upgrade backlog (Gemma 4 support; a potential new translation service for template content).

## Key decisions
- Prioritize the details page over the list page for MVP.
- Automated transcript integration from Zoom is a core/MVP feature (JZ backstops if integrations pod cannot deliver).
- Focus on pre- and post-meeting AI suggestions rather than live in-meeting suggestions.
- Use polymorphic matching (not a graph model) for signal-to-object matching at current scale.
- Generate summaries in-house from raw transcripts rather than relying on Zoom summaries.

## Action items
- Lalit: Document a high-level story breakdown of integration-layer capabilities for review with the integrations team; present Thursday.
- Lalit: Update documentation with a callout explaining the transcript is transformed/summarized by AI; clarify in diagrams.
- Lalit: Review and update the evidence schema with engineering.
- Lalit: Create tickets (break down the epic) for the AI platform backlog; summarize/reorder; review with JZ.
- Lalit: Block time with JV to walk through meetings plans and thinking.
- Lalit: Add admin-level Zoom connection enablement to the platform documentation.
- Lalit: Focus MVP on details-page changes for meetings; move list-page digest features to stretch/V2.
- Lalit: Document expected integration-layer capabilities (auth flows, user docs, client setup requirements) as guidance for the integrations team.
- Lalit: Split GPT-4 upgrade support tickets among developers for the next sprint after JZ completes the dev part in the current sprint.
- Lalit: Coordinate with JZ on a potential translation service (GPT-4) for template content; discuss possible future use for transcripts.

## Follow-ups / open questions
- How is feedback surfaced when users have no templates? (Possibly draft objects for approval — detail in a separate story.)
- Zoom calendar/integration confirmation for the meetings feature.
