---
date: 2026-07-07
meeting: App Platform QA & Product Acceptance
type: review
attendees: [Nellie LeMonier, Sweta Kande, Sanchit Kanwar, Lalit Maharana]
source: zoom
meeting_uuid: 408D09A7-4FED-4723-B8C5-CBB925181736
---

# App Platform QA & Product Acceptance — 2026-07-07

## Summary
The team reviewed current development tickets and testing progress ahead of the India team's July 12–17 office meetup. Sweta gave updates on label-renaming (skip-level → second-level manager for NextGen) and custom-content-body editing tickets progressing through QA. The team discussed email module-naming and language-reflection issues, deciding to split them into separate tickets, and agreed to split review of the large ticket backlog between Nellie (top of list) and Lalit (bottom). Nellie shared plans to formalize an MCP testing inventory and strategy.

## Key decisions
- Ticket 84179: core fix is valid and passes QA; a separate ticket will be raised for the related issue where custom module-naming changes don't reflect for non-English-language users.
- Multiple workflow variants of the same naming issue will be consolidated into one new ticket rather than individual tickets per workflow.
- Testing split: Nellie starts from the top of the ticket list; Lalit starts from the bottom.
- MCP testing criteria (NPX inspector vs. Claude) to be formally defined in a dedicated strategy discussion.

## Action items
- Sweta: create one new ticket covering all workflow variants of the non-English custom module-naming issue.
- Sweta: move ticket 84179 back to dev for further work.
- Sweta: verify remaining templates for the ticket in QA before moving it to production.
- Nellie: schedule a brainstorming session this Thursday (early) with a small group on MCP testing strategy and approach.
- Nellie: review the label-change tickets (84358 and the one below it) for NextGen.
- Nellie: get the NPX inspector running locally for testing.
- Nellie: refine the MCP inventory document and share it with the team, along with prompt-ideas/expected-response documentation.
- Nellie + Tejas: build out a test org in Rainforest with correct data to support proper MCP testing.
- Lalit: split ticket testing with Nellie, starting from the bottom of the list.

## Follow-ups / open questions
- Ticket 83208 and its paired ticket: testing can only begin once Victor deploys the authorization-service fix (talent module fails org-wide when the feature flag is off).
- MCP goals filter (date range): date filter not visible in the NPX inspector, though prompt-based filtering works correctly in Claude; awaiting response from MSN.

## Discussion notes
- India team office meetup scheduled July 12–17; whole team on-site.
- Label changes for second-level and top-level leader/manager aligned to match legacy parity (NextGen only, not Legacy).
- Custom content body for conversation time/share presence is now editable under the conversation section.
- Most templates for the first QA ticket verified successfully; ready to move to production.
- Sanchit noted an MCP item related to recognition and product acceptance, and reviewed a completed goals-related item from Emerson.
- Nellie clarified her review role is to align on testing strategy and build product understanding, not to audit whether prior testing was done correctly — framed as collaboration on product quality, not oversight.
- Nellie's goals for the day: get the NPX inspector running locally; keep refining the MCP inventory document; share prompt/expected-response examples with the team.

## Next steps
- Nellie to schedule the Thursday MCP testing strategy session (Tejas, JB, Sweta, Sanchit).
- Nellie and Lalit to split and work through the ticket backlog.
- Sweta to file the new non-English naming ticket and move 84179 back to dev.
