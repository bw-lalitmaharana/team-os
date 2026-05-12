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
