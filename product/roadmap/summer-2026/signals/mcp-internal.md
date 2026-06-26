# MCP Internal — Shipped, dogfooding

**Jira:** likely ENG-76815 "MCP - Internal Version" (status: Draft → **needs update to Done**)
**Owner:** Jason Bilyeu (JB) / App Platform · Nellie sponsor
**Status:** **SHIPPED 2026-05-06.** Not a Summer 2026 ranking item. Tracked here because it's a dependency for AI-201 (transcripts write-back) and AI Assistant.

## Signals

### 2026-05-06 — MCP Servers launched on all four internal envs
**Source:** [Slack #general](https://betterworks.slack.com/archives/C0298HV20/p1778093375442609) — Nellie LeMonier
**Type:** commitment-shipped
**Owner-impact:** All AI/Platform consumers

Live on Rainforest, Pluto, Orchard, Champagne. ChatGPT (web + desktop) and Claude Desktop connectors working. Champagne is read-only with limited tools; others have admin-level access. Direct URLs available for non-default clients.

### 2026-05-06 — Innovation contest, submissions due May 22
**Source:** [Slack #general](https://betterworks.slack.com/archives/C0298HV20/p1778093723529919) — Cassie Fulton Flores
**Type:** stakeholder-position
**Owner-impact:** Sales, CS, Product

Internal + customer use-case submission contest. Outputs feed Summer 2026 backlog scope.

**Implication for ranking:** Watch May 22+ for new MCP-driven feature candidates; may shift Summer mix.

### 2026-05-08 — MS Copilot gap confirmed
**Source:** [Slack #champagne-mcp-support](https://betterworks.slack.com/archives/C0B0Q5WBN0N/p1778263712105789) — Paul Agustin
**Type:** risk
**Owner-impact:** Sales, Raghu's enterprise prospects

MS Copilot does not support attaching external MCP servers today (product-level limitation, not MCP-spec). Most enterprise customers are MS-shop. Workarounds via Power Platform / Copilot Studio plugins exist but are not MCP.

**Implication for ranking:** Not a blocker, but a Sales/CS narrative gap. Track for release brief Open Questions.

### 2026-05-06 — JB's vision: public MCP = small user-level tools, separate from public API V2
**Source:** [Slack #pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1778090496972519) — Jason Bilyeu
**Type:** scope-decision
**Owner-impact:** Product, App Platform

> "Public API V2 is more for super-admin reports/reporting. Public MCP should be small, building-block user-level interactions — my goals, update progress, summarize direct reports. Separate controllers/modules; can share underlying services."

This is the architectural line for the **Public MCP Server** Summer commitment (distinct from the Internal shipped today).

**Implication for ranking:** Public MCP Server needs a Jira epic and a fixVersion — not currently surfaced in Nellie's epic list. **Aha gap to add.**

### 2026-05-07 — Active dogfooding pain points in #champagne-mcp-support
**Source:** [Slack #champagne-mcp-support](https://betterworks.slack.com/archives/C0B0Q5WBN0N/) — multiple
**Type:** risk (UX)
**Owner-impact:** App Platform

- UUID prompting: Claude asks user for UUID on first ask; should infer from auth (Maher: need `/me` tool capability)
- Auth loops in some flows (Nellie hit once, browser-tab confusion)
- Server-side errors on some queries (Raghu — resolved on re-auth)

**Implication for ranking:** Polish items for Public MCP launch; not blocking, but worth backlog-tracking.

### 2026-05-15 — slack
- **Who:** Bhargav Prajapati
- **Where:** [#pod-engage](https://betterworks.slack.com/archives/C05MZESVCTV/p1778843406338179)
- **Summary:** Created a custom New Relic MCP server for reading logs during debugging (PR #7 in engage-workspace); demonstrates internal MCP-server pattern spreading beyond Betterworks product into engineering tooling.

### 2026-05-18 — slack
- **Who:** Balram Agnihotri
- **Where:** [#pod-engage](https://betterworks.slack.com/archives/C05MZESVCTV/p1779094722648109)
- **Summary:** Created a new custom MCP server for Codecov and unified all MCP server locations in engage-workspace per VSCode guidelines (PR #9); extends the pattern of engineering-tooling MCP adoption beyond product features.

### 2026-05-22 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1779399619060769)
- **Summary:** PR #55 in public-api-mcp wires MCP log context into the service; JB continues active development on the shipped internal MCP server.

### 2026-05-29 — slack
- **Who:** Mary Makris
- **Where:** [#mktg-weekly-updates](https://betterworks.slack.com/archives/C09DP7MRB8X/p1780005055611429)
- **Summary:** PMM weekly update lists "MCP Server GTM Plan" as upcoming work — marketing planning for the shipped internal MCP server is now active alongside competitive docs (Lattice, UKG, Cornerstone).

### 2026-06-02 — slack
- **Who:** Eric Toner (relaying Nicholas VanKlompenberg, Sr People Ops Tech Partner, Jump Trading)
- **Where:** [#jumptrading-oppty](https://betterworks.slack.com/archives/C0ALYKNA6SF/p1780343722556079)
- **Summary:** Jump Trading prospect flagged "Native MCP and Talent Management features" as having high potential after a sales demo; noted role matching as a possible future fit; identified engagement branching logic and performance task delineation as gaps — strong external prospect validation of MCP.

### 2026-06-05 — slack
- **Who:** Mary Makris
- **Where:** #mktg-weekly-updates
- **Summary:** PMM weekly check-in lists "MCP Server GTM Plan" as upcoming work alongside competitive builds for Workday and Oracle.

### 2026-06-05 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19e939793d054869 — "Meeting assets for Nellie / Lalit - Roadmap priorities are ready!"
- **Summary:** Nellie confirmed public MCP data is shipped with only a small disclaimer task outstanding; JB's research indicates all tools can consolidate into one MCP server, with MCP beta evolving to expose REST endpoints for other tooling.

### 2026-06-09 — slack
- **Who:** Nellie LeMonier
- **Where:** [Group DM (Akhil Desai, Aakansha Srivastava, Nellie LeMonier, Lalit Maharana)](https://betterworks.slack.com/archives/C0B7Y7CRWJH/p1780945871914749)
- **Summary:** Product vision: extend AI Chat to support connecting to external MCP tools beyond Betterworks MCP, positioning BW as a "connective hub" that ingests and analyzes data from multiple sources — analogous to Claude's cross-tool experience but native within BW, without requiring Claude.

### 2026-06-12 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1781206572855129)
- **Summary:** Opened 4 coordinated PRs adding Core /api/llm-tools support (BetterWorks main PR #28660, public-api-mcp PR #57, helmfiles PR #934, dev-env PR #103) — active delivery on Public MCP Server.

### 2026-06-12 — slack
- **Who:** Sriram CS
- **Where:** [#hackathon-product-prep-temp](https://betterworks.slack.com/archives/C0B8526SM8U/p1781236005095859)
- **Summary:** Listed Betterworks MCP server as a pre-training topic for the upcoming hackathon/offsite alongside AI platform (Gemma, N8N, Embedding engine) and Integration platform tracks.

### 2026-06-17 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1781647406689859)
- **Summary:** Updated MCP search tools — renamed `size` → `limit` parameter (standards alignment), enforced max 50 cap, added Agent/LLM hints; Core PR #28666 and public-api-mcp PR #64 posted for review.

### 2026-06-24 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19ef592c2dbdfe94 — "Meeting assets for Lalit / Nellie 1:1 are ready!"
- **Summary:** Lalit/Nellie 1:1 (Jun 23): Nellie's action item to send inventory of MCP items to clients for early feedback — signals client-facing MCP readiness check is now in motion.

### 2026-06-26 — slack
- **Who:** Paul Agustin
- **Where:** [#champagne-mcp-support](https://betterworks.slack.com/archives/C0B0Q5WBN0N/p1782469277599309)
- **Summary:** Paul shared a detailed "Betterworks MCP Data Inventory — Scorecard KPIs" with JB and Nellie (prompted by Sean Godfrey use case), mapping 16 KPIs across live/simulated/not-exposed endpoints; surfaced 5 priority API asks: add `from_user_id` to `list_recognitions`, expose `completion_summary` on conversation deployments, fix `list_feedback` auth scope, add `completion_pct` to team/user objects, and build a `list_succession_plans` endpoint.
