---
date: 2026-06-04
meeting: Nellie / Lalit - Roadmap priorities
type: planning
attendees: [Nellie, Lalit Maharana]
source: zoom
meeting_uuid: 3764708C-B75E-461C-A2C1-D4C399427512
backfilled: 2026-07-07
---

# Nellie / Lalit - Roadmap priorities — 2026-06-04

## Summary
Nellie and Lalit conducted a roadmap and technical status review focused on AI features and various product development items. They identified duplicate tickets related to meeting-transcript processing, deciding to close one as a duplicate and link it to the existing AI processing pipeline. They reviewed progress on policy-engine support for business entities (not customer-facing until the winter release) and confirmed public MCP data had been shipped. They discussed custom content by tenant notifications nearing completion pending QA, and Lalit agreed to own the preview functionality. The conversation covered business-entities rollout planning, custom roles support, branding updates, and translations modules, with Lalit taking ownership of several notification-related features. It ended with a brief discussion on performance-summary bucketing by fiscal year and its potential impact on existing filters.

## Key decisions
- Close the duplicate "transmit from external meeting tools" ticket and link it to the correct existing AI processing pipeline ticket (after informing Natalia); move it to the appropriate pod.
- Deprioritize policy-engine support for business entities for the summer release (other priorities; custom roles won't be ready until winter).
- Public MCP data shipped; only a small disclaimer task remaining.
- Lalit to own several epics: adding preview to custom-content-by-tenant notifications, business entities (notification-related), and admin notifications.
- Move the AI assistant internal version to development phase; the sales version to pre-planning.
- Move async: business entities represent groups of people at specific locations (unlike departments/groups which can cross business entities); costs/profits tracked at this level. The system does not currently track financial info (salaries/payments) for cost-center purposes.

## Action items
- [ ] Lalit — Close duplicate ticket for "transmit from external meeting tools" after informing Natalia; link to correct AI processing pipeline ticket
- [ ] Lalit — Own the epic for adding preview to custom-content-by-tenant notifications; ensure feature flag is set up (with Nellie's support)
- [ ] Lalit — Own the business-entities (notification) epic; complete the spike researching how existing batch notifications work in legacy, documenting current functionality
- [ ] Lalit — Check with the team on what remains for custom-roles support in branding, settings, or integrations
- [ ] Nellie — Add feature flags in LaunchDarkly (or alternative) for items missing them, including Lalit's new epic ownerships
- [ ] Nellie — Clean up duplicate stories related to policy-engine support and custom-role support for business entities
- [ ] Nellie — Refine stories for "customize and translate module names"; check remaining areas (branding, settings, integrations) for custom-roles support
- [ ] Nellie — Refine the performance-summary bucketing-by-fiscal-year story; discuss with the team (incl. Jay-Z) and define the filtering/searching improvement
- [ ] Nellie — Set up time to add feature flags for all items missing them
- [ ] Nellie — Coordinate with Emerson to clarify QA requirements for "customize and translate module names"

## Follow-ups / open questions
- Custom-role support for admin UI and branding — some areas (branding, settings) may still need attention.
- Performance-summary bucketing by fiscal year — potential impact on existing search/filters, needs further team discussion.

## Discussion notes
- Custom content by tenant nearly ready; requires end-to-end QA testing (PM Eden). Preview has a spike planned for the current sprint.
- MCP: JB's research indicated all tools could consolidate into one MCP server; MCP beta continues to evolve and exposes REST endpoints for other tooling. Good progress on the AI chat assistant component (used for both the current project and the agentic flow).
- General admin notifications mostly shipped except one outstanding ticket; spike needed to research legacy batch notifications.
- Translations vs Transifex: Transifex handles dynamic text (error messages); translations handle static content like conversation templates.
- Gemma 4 upgrade + creating an AI service for modules; need to prep for refinement and address QA requirements with Emerson.

## Next steps
- Nellie to add feature flags the next day; new AI-board item on performance-summary bucketing by years to be discussed with the team.
