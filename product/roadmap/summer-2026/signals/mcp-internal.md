# MCP Internal — Shipped, dogfooding

**Jira:** likely ENG-76815 "MCP - Internal Version" (status: Draft → **needs update to Done**)
**Owner:** Jason Bilyeu (JB) / App Platform · Nellie sponsor
**Status:** **SHIPPED 2026-05-06.** Not a Summer 2026 ranking item. Tracked here because it's a dependency for AI-201 (transcripts write-back) and AI Assistant.

## Signals

### 2026-06-29 — MCP V2 goals contract defined (4 tools; no bulk; Tier-1 default; PATCH-at-service-layer is the blocker)
**Source:** Zoom — "Goals and MCP" 2026-06-29 (UUID D637A051-8F78-45DF-B4C4-47F595B5C8D7). AI summary digested.
**Type:** scope-decision + architecture
**Owner-impact:** JB, Emerson, Nellie, Varnica, Lalit (consumer via Meetings "Create Goal")

V1 MCP tools deprecated → lightweight LLM-friendly endpoints (no raw public-API wrappers). **Four V2 goals tools for summer:** `list goals`, `update goal`, `goals get settings`, `create goal` — `goals get settings` built first. **No bulk ops** (deferred V3+); bulk delete excluded entirely (use Postman/API); no "get goal by ID" (filtered `list goals` avoids N+1); "check-in" terminology retired (use `update goal`). Permissions reuse existing internal-endpoint auth (no separate layer). **PATCH (not PUT) at the service layer is the longest outstanding backend task — Emerson owns; gates `update goal`.** Jira integration pattern: Jira MCP to pull, Betterworks MCP to write (no persistent mapping in V2). All tools Tier-1 (public) by default; tiered pricing → winter. Open: Kong rate-limiting spike (session-ID based).

**Implication for ranking:** This is the backend contract under [[ai-201-meeting-transcripts]]'s Meetings "Create Goal" / goal-recommendation cards — the PATCH gap is a shared dependency.

### 2026-06-29 — New project: Slackbot connector powered by MCP (Lalit exploring ownership)
**Source:** Zoom — "Lalit / Nellie 1:1" 2026-06-29 (UUID 25E15DB1-1035-4CA7-A37F-927A4D62ADFD). AI summary digested.
**Type:** scope-decision (new initiative)
**Owner-impact:** Lalit, Nellie

Nellie steered Lalit toward owning a **Slackbot connector powered by MCP** — internal-first for dogfooding, then scale to customers; a broken earlier version already exists. Lalit agreed to explore ownership. Related: Nellie sent the **MCP items inventory to clients for early feedback** (external socialization of MCP direction); a **notifications-batching UI** (building on Hung's digest-batching spike) is also now a Lalit deliverable.

**Implication for ranking:** Potential new owned initiative for Lalit beyond AI-201; watch for it needing its own Aha/Jira surface.

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

### 2026-07-02 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-feedback](https://betterworks.slack.com/archives/C08HR9851PS/p1782932413198439)
- **Summary:** JB opened PRs adding LLM Tool support to feedback-api (PR #682) and public-mcp (PR #76) with an initial `list_feedback` tool/endpoint — active delivery on Public MCP Server surface expansion.

### 2026-07-02 — slack
- **Who:** Nellie LeMonier
- **Where:** [#product](https://betterworks.slack.com/archives/C033TEH2T/p1782957275351269)
- **Summary:** Answered inbound question in #product: Betterworks MCP does not integrate with Pendo guides; provided two paths for customers — (1) bring your own LLM and prompt it with Pendo guide content via our MCP server, or (2) use BW AI Chat where customer-specific guidelines/prompt content can be stored natively.

### 2026-07-03 — slack
- **Who:** Balram Agnihotri
- **Where:** [#eng-ai-engineering-lab](https://betterworks.slack.com/archives/C08V0C3JRGE/)
- **Summary:** Flagged that GitHub repo `github.com/kalub92/betterworks-mcp` is being indexed as a public internet source by GPT — asked whether it is an internal tool. Raises IP/discoverability risk: public LLMs may surface internal MCP schema or capabilities to external users.

### 2026-07-06 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f38610c62f7d73 — "Meeting assets for Lalit / Nellie 1:1 are ready!"
- **Summary:** Nellie and Lalit discussed tactical items and goals for AI projects, including MCP-related items; meeting summary now available.

### 2026-07-07 — slack
- **Who:** Emerson Matthews
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1783373675800269)
- **Summary:** Emerson proposed auto-generating MCP server tool definitions and a Redocly documentation site combining OpenAPI specs for v1/v1.5/v2 customer-facing docs (ENG-43053); offered to demo ideas to the team.

### 2026-07-07 — slack
- **Who:** Aimie Lim
- **Where:** [#hr-pulse](https://betterworks.slack.com/archives/C0APX9835BN/p1783367479741089)
- **Summary:** HR Pulse session discussed MCP launch messaging strategy — avoid "MCP" jargon with ICPs, lead with outcomes; narrative arc outlined: frictionless adoption → data inferred skills → MCP collapsing walls between succession, L&D, performance, and career pathing; Jamie's "scaly fish" progression framing.

### 2026-07-06 — App Platform - Daily Standup (zoom)
**Source:** Zoom — "App Platform - Daily Standup" 2026-07-06 (UUID 25ACE9F7-3B57-4432-9DDE-6E113EE3C899)
**Type:** risk
**Owner-impact:** JB, Emerson

JB flagged a tool-explosion risk on MCP during a broader MCP-vs-Public-API-V2 architecture discussion: V2 can follow the normal 2-week release cadence, but MCP is expected to update near-instantly/programmatically, so the team needs to be deliberate about what gets added rather than letting anything in. Emerson is finishing a write-up covering both the MCP and V2 solutions for team review.

**Implication for ranking:** Direct governance signal for MCP scope discipline — worth folding into whatever "MCP items inventory" Nellie is building (see 2026-06-29 entry above) so the diligence bar is written down, not just verbally agreed.

### 2026-07-07 — App Platform QA & Product Acceptance (zoom)
**Source:** Zoom — "App Platform QA & Product Acceptance" 2026-07-07 (UUID 408D09A7-4FED-4723-B8C5-CBB925181736)
**Type:** open-question
**Owner-impact:** Nellie, Sanchit, Tejas, JB

MCP testing strategy remains informal: Sanchit found the NPX inspector doesn't surface the goals date-range filter (though the same prompt works fine via Claude), and the team punted the "NPX inspector vs. Claude, what's our pass/fail criteria" question to a dedicated Thursday strategy session (Nellie, Tejas, JB). Nellie is separately building an MCP tool inventory and a prompt/expected-response document, and plans a Rainforest test org with correct data to support proper MCP testing.

**Implication for ranking:** Testing-strategy formalization is now scheduled (Thursday) — good checkpoint to confirm whether it produces a written criteria doc, since QA capacity is currently just Nellie + Lalit splitting the ticket backlog manually.

### 2026-07-08 — slack
- **Who:** Emerson Matthews
- **Where:** [#pod-goals](https://betterworks.slack.com/archives/CTEDNQQLS/p1783453508896099)
- **Summary:** Emerson posted MVP Jira ticket list for MCP goal management to Nellie and Varnica: ENG-83695, ENG-83383, ENG-84574–84579 (8 tickets; mostly small due to code reuse).

### 2026-07-08 — slack
- **Who:** Nellie LeMonier
- **Where:** [#pod-goals](https://betterworks.slack.com/archives/CTEDNQQLS/p1783469907297459)
- **Summary:** Nellie added Emerson's list to her MCP inventory spreadsheet and scheduled a 3-person sync for tomorrow morning to align on scope.

### 2026-07-08 — slack
- **Who:** Jason Bilyeu, Emerson Matthews
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1783450807240479)
- **Summary:** JB proposed a "Quarterly Goal Prep" MCP prompt (review feedback, conversations, skills → suggest next-quarter goals); confirmed custom MCP prompts already supported in Rainforest; Emerson asked for a definition of "MCP workflow" vs. tool call for goal-suggestion scenarios.

### 2026-07-08 — MCP smoke tests scoped to a single example test in Quality Automation Services repo (zoom)
**Source:** Zoom — "OKR Team - Daily Standup" 2026-07-08 (UUID 9093DC61-F910-4628-9444-6B7F26C0E5AC)
**Type:** scope-decision
**Owner-impact:** Jason Bilyeu, Nellie, Tejas, Sanchit

MCP smoke tests will live in the Quality Automation Services repo under a new "MCP tests" folder; the original spike was renamed "MCP smoke test" to reflect its narrower scope. Approach settled on a single example test (the "Who Am I" tool) using a static public API token, using dynamic org creation if already available in the QA suite (Sanchit to verify). JB to write the example test plus a scheduled GitHub Action; Nellie to post the approach to the app-platform Slack channel for Tejas's feedback. OAuth flow testing for MCP was flagged as likely needing a separate spike given browser-interaction complexity.

**Implication for ranking:** this is the first concrete automated-test coverage plan for MCP tools — worth tracking as a dependency before broader MCP tool expansion.

### 2026-07-09 — Nellie's MCP tool inventory/design research shared with AI pod (zoom)
**Source:** Zoom — "AI Platform Product Acceptance" 2026-07-09 (UUID 85644A0C-818C-4E67-85E8-EF2383CC16E6)
**Type:** architecture
**Owner-impact:** Nellie, Tejas, Lalit

Nellie is researching MCP tool/framework design best practices (context engineering for AI agents, testing methodology) and built a spreadsheet inventorying current MCP tools, distinguishing deprecated wrapper tools ("Lisco"-prefixed) from new native tools (prefixed "Core," "conversation," or "goals"). She proposed a separate tool for team members rather than folding it into the existing search-teams tool, with pagination instead of returning all members at once for large teams. Nellie will share the spreadsheet and the underlying Anthropic design resources with Tejas and Lalit; Tejas will review after returning from the offsite.

**Implication for ranking:** the tool-inventory work is a precursor to any MCP tool consolidation/cleanup — relevant context for the next MCP-adjacent Jira grooming pass, though this is internal tooling housekeeping rather than a scored feature.

### 2026-07-10 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1783624483528149)
- **Summary:** Initiated repo rename from `public-api-mcp` → `public-mcp` via corp.betterworks.co PR #253 — signals ongoing repo housekeeping and consolidation of the public MCP surface.

### 2026-07-10 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-devops](https://betterworks.slack.com/archives/CHL819EM7/p1783626857381719)
- **Summary:** ECR deployment broken after repo rename — new repo name `public-mcp` not yet created in ECR registry (error: "The repository with name 'public-mcp' does not exist"); asked DevOps for guidance on whether a corp repo rename requires a separate ECR creation step.

### 2026-07-10 — slack
- **Who:** Mary Makris
- **Where:** [#marketing-ops-marketing-requests](https://betterworks.slack.com/archives/C0A2NBEDDHV/p1783631972278909)
- **Summary:** MCP Landing Page request submitted to Marketing Ops — Lucas wireframing the page (PMM draft linked); plan is an ungated product tour → Book a Demo/Qualified scheduler at end; email-only capture being tested on back end.

### 2026-07-10 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1783634835858379)
- **Summary:** Opened PR #78 in public-api-mcp to fix deprecated MCP tool names — active housekeeping ahead of public launch.

### 2026-07-10 — slack
- **Who:** Nellie LeMonier
- **Where:** [#ai-innovation-lab](https://betterworks.slack.com/archives/C0AML6FH22H/p1783645549047309)
- **Summary:** Slack launched native MCP support in Slackbot; Nellie tested connecting it to the Betterworks Rainforest MCP but the BW Slack instance does not yet support calling tools from Slackbot (possibly plan restriction); flagged Ash to investigate — potential path to the Slackbot/MCP connector Nellie steered Lalit toward on 2026-06-29.
