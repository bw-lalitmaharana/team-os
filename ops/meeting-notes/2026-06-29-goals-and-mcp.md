---
date: 2026-06-29
meeting: Goals and MCP
type: planning
attendees: [Nellie LeMonier, Emerson Matthews, Jason Bilyeu, Varnika Garg, Paul Agustin, Lalit Maharana]
source: zoom
meeting_uuid: D637A051-8F78-45DF-B4C4-47F595B5C8D7
backfilled: 2026-07-07
---

# Goals and MCP — 2026-06-29

## Summary
The team planned the V2 beta release of MCP tools for goals management. They reviewed a spreadsheet of V1 tools to deprecate and replace with lightweight, LLM-friendly endpoints. Four primary goal tools were prioritized for the summer release: list goals, update goal, goals get settings, and create goal. Bulk operations and complex analytics were deprioritized to later releases. Discussion covered implementation approaches — guardrails, rate limiting, and ensuring tools respect existing permissions — with Jason emphasizing keeping tools simple and building-block-like for future integration.

## Key decisions
- Deprecate all V1 tools; replace with new lightweight, minimal-response endpoints — no more direct public API wrappers.
- Four V2 tools confirmed for summer release: list goals, update goal, goals get settings (foundational — do before update/create), create goal.
- No bulk operations for V2; bulk update/create deferred to V3+; repeat single-endpoint calls instead.
- Bulk delete excluded from MCP; internal teams directed to existing Postman/API approach with existing safeguards.
- No separate "get goal by ID" tool needed; list goals filtered by ID is sufficient (avoids N+1 problem).
- "Check-in" terminology retired; progress update is just a goal update via the standard update endpoint.
- Aggregate/exec reporting (e.g., goal progress by department) deferred to analytics/data team.
- Tool design philosophy: product provides prompts/use cases; engineers decide minimum tools needed — avoid tool explosion.

## Architecture & technical decisions
- PATCH required over PUT for update; no patch exists at service layer yet — longest outstanding backend task.
- Permissions respected automatically by reusing existing internal endpoint authorization code.
- Goal settings (fiscal calendar, category requirements, etc.) stored in goals DB; goals get settings scoped to goal-relevant config only, not full org settings.
- Rate limiting to be implemented at Kong layer per endpoint, based on session ID header (not IP, since all traffic is internal).
- Lightweight tools prevent context overload; smaller response shapes improve LLM comprehension.
- OpenAPI-to-MCP tool generator built by Emerson; teams can auto-generate tools from Swagger docs with minimal MCP repo changes.
- Tiered tool access (pricing/permissions by org) planned for winter release; all V2 tools default to Tier 1 (public for all).
- Integration pattern (e.g., Jira): use Jira MCP to pull data, then Betterworks MCP to write/update goals — no routing through Betterworks to reach Jira; no persistent mapping storage required in V2.

## Action items
- [ ] Emerson — Finish list goals tool, then build reusable OpenAPI spec combiner tooling, then update goals (implement PATCH at service layer)
- [ ] Emerson — Update list goals story with minimal serializer field details; share annotated prompt list for test scenarios; provide prompt template/Claude skill for internal bulk delete via API
- [ ] Emerson — Implement goals get settings tool before the update goal tool
- [ ] Jason (JB) — Collaborate with Emerson on OpenAPI tool generator issues; share CI inference testing examples; spike on Kong rate limiting for MCP tools at endpoint level
- [ ] Nellie — Share inventory spreadsheet with Varnika; update template to capture prompts and tool details
- [ ] Nellie — Schedule CI/testing brainstorm session later in the week (QA engineers, possibly Tejas)
- [ ] Nellie — Work with JB on prompt spike POC; apply to goals as first real use case
- [ ] Nellie — Check with Chao on aggregate goal-progress-by-department tool (may belong to analytics)
- [ ] Varnika — Review goals tool inventory sheet; flag additional filters; provide input for V3/winter planning
- [ ] Nellie + Varnika — Meet in a few weeks to decide additional goals tools for winter release (V3)

## Testing strategy
- Manual testing: Sanchit (QA) uses MCP Inspector; known Inspector bugs may obscure product bugs.
- CI testing: run on merge to main + weekly cadence (not every PR push) to manage CI cost; JB has existing CI inference testing examples.
- Emerson generating a prompt test list (easy -> complex) to validate tool capabilities before PR opens.

## Follow-ups / open questions
- Spike needed on Kong rate limiting guidelines and per-service config setup.
- Prompt templates for MCP server (one per team for summer) — feasibility uncertain given teams' existing plans.
- Chao's team to confirm ownership of analytics/exec reporting goal data.
- Whether goals get settings must be built before or alongside update goal — JB recommends before.
- MCP beta tracking: tool calls, prompts, and inputs are tracked, but the actual pre-invocation user text is not yet visible; will be possible with the upcoming internal chat interface (end of summer).

## Next steps
- Begin V2 tool implementation (list goals first); establish testing methodology; plan V3/winter tools separately.
