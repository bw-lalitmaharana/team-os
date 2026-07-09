---
date: 2026-07-09
meeting: AI Platform Product Acceptance
type: review
attendees: [Tejas S, Nellie LeMonier, Jason Zhang, Bhavesh Vaviya, Akansha Srivastava, Imad, Christina]
source: zoom
meeting_uuid: 85644A0C-818C-4E67-95E8-EF2383CC16E6
---

# AI Platform Product Acceptance — 2026-07-09

## Summary
Product-acceptance review covered MCP tool inventory/design research, the AI pre-processing DAG backlog, the goal quality report's NextGen gap, and Performance Summary items — tokenizer fix confirmation, the still-blocked Teacher Retirement System of Texas incident, and fiscal-year-filter UX approval.

## Key decisions
- Tokenizer fix for Gemma + Feedback Summary integration confirmed resolved (output token count now logged).
- Embedding/norm-API decoupling and internal cluster-service URL migration closed out — both verified on Rainforest, released and monitoring on Pluto.
- Fiscal-year-filter UX approved: banner/dropdown to flag stale-FY display with a switch-to-current-year action; same fix slated for Feedback Summary since it shares the same underlying logic.
- Nellie proposed a separate MCP tool for team members (rather than folding into the existing search-teams tool), with pagination instead of returning all members at once for large teams.

## Action items
- Tejas: Confirm with Nellie/JZ on temporarily dropping the pre-processing DAG frequency from weekly to bi-weekly until it stabilizes.
- Akansha/Bhavesh: Continue investigating the related US-East/EU preprocessing-timing bug.
- Nellie: Communicate the Legacy-only limitation of the goal quality report to CS/Christina; design a self-service UI for the report in the admin reports section (built by the AI team using the WA API, Haven-admin first, Legacy support later).
- Nellie: Share the MCP tool inventory spreadsheet and underlying Anthropic design resources with Tejas and Lalit.
- Tejas: Review the MCP tool inventory after returning from the offsite.

## Follow-ups / open questions
- Pre-processing DAG has been running ~11.5 days (full initial load, not delta sync), with a backlog of runs queued — frequency-reduction decision still pending confirmation.
- Teacher Retirement System of Texas incident (ENG-84564): the 7/7 pre-processing re-trigger is still pending completion of the long-running DAG before the fix (regenerate + cache new data) can land — not yet resolved despite earlier "fix in progress" status.
- Goal quality report has no NextGen support (Legacy goals only) — expected to surface as a customer issue once orgs (e.g. Sony) migrate to NextGen and request the report.

## Discussion notes
- Nellie is researching MCP tool/framework design best practices (context engineering for AI agents, testing methodology) and has built a spreadsheet inventorying current MCP tools, distinguishing deprecated wrapper tools ("Lisco"-prefixed) from new native tools (prefixed "Core," "conversation," or "goals").

## Next steps
- Nellie/JZ to confirm DAG frequency change.
- Nellie to raise the NextGen goal-quality-report gap with CS/Christina and scope the self-service UI.
- Tejas to review MCP inventory post-offsite.
