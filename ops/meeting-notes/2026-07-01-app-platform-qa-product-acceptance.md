---
date: 2026-07-01
meeting: App Platform QA & Product Acceptance
type: review
attendees: [Nellie, Sweta]
source: zoom
meeting_uuid: 2CDF306A-C2FD-4E69-B424-885B34DAAA2B
backfilled: 2026-07-07
---

# App Platform QA & Product Acceptance — 2026-07-01

## Summary
Nellie and Sweta reviewed App Platform QA tickets and product acceptance status. Sweta confirmed she had completed testing of user creation, editing, and deactivation for an org and was ready to move those tickets to product acceptance. They reviewed notification features, language configuration, and a skip-level manager filtering bug in the groups/org-chart UI. Nellie proposed bringing Tejas in to develop a strategy for MCP testing since it will be used by the AI chat feature. Sweta agreed to provide regular App Platform updates in Slack.

## Key decisions
- Move the tested Okta/Skim user-management ticket to product acceptance.
- Bring Tejas into MCP testing strategy; hold a team touch-base next week.
- Use Slack notifications alongside JIRA alerts since Nellie sometimes misses JIRA notifications.
- Acceptance criteria for adding languages should be placed at the bottom of the configuration interface, not the top.
- Place the skip-level ticket in QA to track the Ryan/JB disagreement before proceeding.

## Action items
- Nellie: Pull Tejas into the MCP testing strategy discussion and collaborate with him.
- Nellie: Accept the Skim ticket Sweta tested and move it to product acceptance.
- Nellie: Message Sweta on Slack with JIRA IDs for tickets needing attention.
- Nellie: Let Eden know about the acceptance-criteria placement issue for notifications.
- Sweta: Check and address the 3 new tickets that flowed into QA.
- Sweta: Fix the JIRA comments regarding Eden's ticket-creation request.
- Sweta: Test remaining bug issues after Nellie's review and update the ticket.
- Sweta: Move the Azure-related Skim ticket into "Ready for QA" and test it.
- Sweta: Provide regular App Platform updates in the Slack channel.

## Follow-ups / open questions
- Skip-level manager filtering (ticket 83137): user could not find their head user in search despite selecting Skip Level Manager as the type; may relate to how skip-level distances are calculated. JB indicated the feature may not be properly implemented; Nellie questioned why the option is shown if it can't be implemented. Consult JB before proceeding.
- Test automation: nothing is currently automated; a future plan is needed but neither Sweta nor Sanjit has bandwidth now.

## Discussion notes
- Some features were found not yet enabled for next-gen.
- Sweta created a two-part ticket for Nellie (Okta testing + Azure side); the Okta part is now in product acceptance.
- Sweta can test newly deployed features in Rainforest and update the ticket afterward; she has admin access for Azure testing, with time being the only blocker.

## Next steps
- Team touch-base next week including Tejas on the MCP testing approach.
