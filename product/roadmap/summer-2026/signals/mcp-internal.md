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

### 2026-07-13 — slack
- **Who:** Lalit Maharana
- **Where:** [DM (self)](https://betterworks.slack.com/archives/D0B0W25MMV2/p1783912048564419)
- **Summary:** Week-of-Jul-13 focus plan slots Thu Jul 16 for "verify ENG-69839 Jira link; transition ENG-76815 → Done; create Public MCP Server epic if missing", and Fri Jul 17 for "decide whether to own MCP Slackbot v2; scope notifications-batching UI".

### 2026-07-15 — slack
- **Who:** Sudin Maharjan
- **Where:** [#pod-conversations](https://betterworks.slack.com/archives/CELP1R10D/p1784058944993189)
- **Summary:** Release v0.452.0 shipped to pre-prod and prod — includes "Fixed MCP user_id filtering" and "Fixed MCP question response value handling"; release also expands Organization Settings management APIs and improves Conversation service reliability.

### 2026-07-15 — slack
- **Who:** Aimie Lim
- **Where:** [#salesteam](https://betterworks.slack.com/archives/C04KBSK65/p1784054172021499)
- **Summary:** Bi-weekly sales content digest includes "Betterworks MCP Server: Performance Intelligence in ChatGPT, Claude, or Any AI Tool" as a product news item — active external marketing of the MCP capability to the sales team.

### 2026-07-15 — slack
- **Who:** Paul Agustin
- **Where:** [Group DM (Paul Agustin, Varnika Garg, Sharan, Gauri Thakur, Lalit Maharana)](https://betterworks.slack.com/archives/C0BD5B5KDJN/p1784084135657839)
- **Summary:** Paul Agustin added Lalit to capstone project GitHub repo (github.com/paulagustin-bw/capstone) — project leverages the Pluto MCP for engagement data; recognition data not yet accessible via MCP (flagged as gap).

### 2026-07-15 — slack
- **Who:** Brian Jacobs, Allie Collins, Doug Dennerline, Raj Sinkar, Ash Todd
- **Where:** [#ai-innovation-lab](https://betterworks.slack.com/archives/C0AML6FH22H/p1784050022738729)
- **Summary:** AI Core governance debate on agentic AI tools: Cowork being restricted/replaced; ChatGPT Work phased rollout proposed by JB — Phase 1 (48h) marketing access with no external connectors, Phase 2 (1–2 weeks) connector-by-connector approval, Phase 3 selective agentic actions. All MCP connectors subject to the same review process. Doug overruled cost concerns; JB confirmed all agentic tools including Cowork under the same governance umbrella. Signals increased internal scrutiny on MCP connector access controls.

### 2026-07-17 — slack
- **Who:** Aimie Lim
- **Where:** [#mktg-weekly-updates](https://betterworks.slack.com/archives/C09DP7MRB8X/p1784228456573119)
- **Summary:** MCP marketing deliverables fully launched — QA completed and all MCP launch assets shipped; coordinated with the public MCP Server LinkedIn announcement today.

### 2026-07-17 — slack
- **Who:** Emerson Matthews
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1784228335598349?thread_ts=1784162009.283619&cid=C01GYVBME90)
- **Summary:** Submitted fix PR public-api-mcp/pull/87 in the App Platform thread — active engineering work on MCP V2.

### 2026-07-17 — slack
- **Who:** Emerson Matthews
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1784237169347519)
- **Summary:** Posted PRs for MCP V2 "goal settings tool" — goals-api PR#904 and public-api-mcp PR#88; this is the first V2 goals tool to be built per the 2026-06-29 contract (goals get settings built first).

### 2026-07-17 — slack
- **Who:** Joy Johnson
- **Where:** [#mktg-weekly-updates](https://betterworks.slack.com/archives/C09DP7MRB8X/p1784246942725989)
- **Summary:** MCP Launch design assets complete — carousel and featured images done; Summer Campaign LinkedIn and display ads also delivered; coordinated marketing push around the MCP public announcement.

### 2026-07-17 — gmail
- **Who:** GaggleAMP (member-noreply@gaggleamp.com → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f6e75d3b89adda — "You have New Messages to Share on betterworks"
- **Summary:** GaggleAMP social-amplification request for a LinkedIn post announcing the Betterworks MCP Server publicly: "Today, we're introducing the Betterworks MCP Server, bringing Betterworks performance intelligence directly into ChatGPT, Claude, Microsoft Copilot, Gemini, and other MCP-compatible AI tools" — first confirmed external public announcement of the MCP product.

### 2026-07-21 — slack
- **Who:** Emerson Matthews
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1784579598067649)
- **Summary:** Emerson shared PRs for a goals-api and public-api-mcp refactor (removing unit tools, using raw label instead) — see PR descriptions for pros/cons. goals-api PR#909, mcp PR#92.

### 2026-07-22 — slack
- **Who:** Emerson Matthews
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1784661765553469)
- **Summary:** All original goal tools (ENG-83695, ENG-83383, ENG-84574–84579, ENG-84847) now at Ready for QA; goals-api endpoints released to prod. Flags: MCP+goals-api latency is fast but Claude Sonnet 5 (Low effort) is slow — worth testing other models; token usage unchecked but likely a concern; ambiguous prompts (e.g. "close out goals") need improved tool descriptions to prevent misinterpretation.

### 2026-07-22 — slack
- **Who:** Paul Agustin
- **Where:** [#tmp_betterbrain](https://betterworks.slack.com/archives/C0B7VHX4Y73/p1784688469586489?thread_ts=1784688469.586489&cid=C0B7VHX4Y73)
- **Summary:** Discovered goal weights not exposed via Betterworks MCP today; weights live in `report-weight` service area of goals-api (not wrapped as MCP tool) — would be a net-new tool request, not a config change. MCP still beta on internal envs only.

### 2026-07-28 — slack
- **Who:** Emad Ahmed (via Early Access Request bot)
- **Where:** [#early-access-requests](https://betterworks.slack.com/archives/C0AS5U6HWBU/p1785234491488049)
- **Summary:** Early Access request ENG-85247 submitted for NextGen Test Arcesium (Org ID 1607) to join the MCP Early Access Program; Nellie LeMonier invited this customer — they were the original driver for building MCP and had previously built a private/public-key workaround; timeline requested ASAP.

### 2026-07-28 — slack
- **Who:** Cheau-Long Ng
- **Where:** [#pod-analytics](https://betterworks.slack.com/archives/C016U7X79UL/p1785210948021229)
- **Summary:** Merged PRs adding foundation for analytics MCP tools: 4 new endpoints in data-api (/analytics/metrics, /analytics/recommendations, /analytics/search, /analytics/narratives), plus a new analytics schema migration (090_analytics) in warehouse-db; more changes expected over the next 2 sprints.

### 2026-08-04 — slack
- **Who:** Holly Wenneson
- **Where:** [#early-access-requests](https://betterworks.slack.com/archives/C0AS5U6HWBU/p1785787760105469)
- **Summary:** Early access request submitted for Sinclair (Org ID 1591) to verify MCP functionality in their NextGen test environment (ENG-85629 "Sinclair NextGen Test - MCP Enablement"); routed to AI Platform pod — second named customer after Arcesium (Jul 28) now in the MCP early access queue.

### 2026-08-05 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1785879999259509)
- **Summary:** Triggered deployment of Public MCP to version 0.72.0 in internal environments via PR #108 (github.com/BetterWorks/public-api-mcp/pull/108).

### 2026-08-05 — slack
- **Who:** Jason Bilyeu
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1785880812706469)
- **Summary:** Confirmed MCP 0.72.0 release complete across all internal environments; verified the new `talent_list_profile_skills` tool works correctly in champagne.

### 2026-08-11 — slack
- **Who:** Nellie LeMonier
- **Where:** [#champagne-mcp-support](https://betterworks.slack.com/archives/C0B0Q5WBN0N/p1786399853474379)
- **Summary:** Nellie announced a new ChatGPT connector "Betterworks Champagne Beta V2" including goal creation and update capabilities; a new app was required because ChatGPT failed to read the latest MCP tool definitions; Michelle Wu flagged the root issue.

### 2026-08-12 — slack
- **Who:** Jason Bilyeu
- **Where:** [#eng-releasemgmt](https://betterworks.slack.com/archives/C43EBBLCV/p1786503011484569)
- **Summary:** ENG-84586 "Core MCP Tool | List Team Members" shipped to production in Betterworks v1.290.1 (App Platform pod).

### 2026-08-13 — slack
- **Who:** Victor Chen
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1786571403475239)
- **Summary:** Victor Chen updated the AC for goals-api-mcp and submitted a fix for ENG-84578: goals-api PR#930 and public-api-mcp PR#114 — active delivery on MCP V2 goals contract; Nellie LeMonier cc'd.

### 2026-08-14 — slack
- **Who:** Paul Agustin
- **Where:** [#product](https://betterworks.slack.com/archives/C033TEH2T/p1786655573207919?thread_ts=1786655360.653929&cid=C033TEH2T)
- **Summary:** Suggested PowerBI + Copilot as a potential Betterworks MCP use case — if PowerBI has an MCP connector through Copilot Studio, it could be tested to verify BW MCP accessibility via Microsoft Copilot, extending the reach of the MCP surface.

### 2026-08-19 — slack
- **Who:** Zapier MQL bot
- **Where:** [#mql-ent-emea-3](https://betterworks.slack.com/archives/C09D015BG58/p1787124679324779)
- **Summary:** Mirna Victor (Global Talent Manager, Aramex, ICP fit 7) converted to MQL via betterworks.com/magazine/betterworks-mcp-server — external inbound interest from a talent leader driven by the MCP server marketing content.

### 2026-08-25 — slack
- **Who:** Mollie Barz
- **Where:** [#salesteam](https://betterworks.slack.com/archives/C04KBSK65/p1787597299477829)
- **Summary:** Summer '26 Release internal e-learning (Betterworks University) now live, covering MCP Server Beta under AI & Platform; GTM enablement sessions scheduled 8/27 + 9/2 — PMs to demo live and answer questions.

### 2026-09-01 — slack
- **Who:** Drew Diaz
- **Where:** [#oppty_tungstenautomation](https://betterworks.slack.com/archives/C0BNCH06P47/p1788217028938079)
- **Summary:** Tungsten Automation (2,200 employees, 32+ countries) uses Forge as their internal MCP connecting systems to Claude; after a second demo they want clarity on Forge↔Betterworks MCP interop, PII/sensitive-data protection, role-based access controls, and global data privacy — Drew tagged Nellie, Brian Jacobs, Paul Agustin seeking Product and InfoSec guidance before the next follow-up.

### 2026-09-01 — gmail
- **Who:** Nellie LeMonier, Lalit Maharana (Zoom AI summary)
- **Where:** Email thread 1a05d6279eaa57ce — "Meeting assets for Lalit / Nellie 1:1 are ready!"
- **Summary:** Nellie assigned Lalit to own engineering of MCP tools and prompts for Performance Partner (AI221 GA); plan to inventory existing AI features and convert into context-aware MCP tools (feedback writing, goal writing, skill recommendations); skill gap analysis prototype also flagged as MCP tool candidate.

### 2026-09-03 — slack
- **Who:** Nellie LeMonier
- **Where:** https://betterworks.slack.com/archives/C0BEMU079J7/p1788392014242119
- **Summary:** Nellie proposed in #pod-ai-chat that Slack/Teams integration via Slack MCP belongs in Performance Partner's initial release — reasoning: shallow feedback context today (only Betterworks goals/feedback), Jason Zhang's POC proves it works, enterprise data governance story; suggested two-layer consent (super-admin enables → user opts in), and noted the pattern could extend to Gmail/Outlook/Aha/Monday/Asana MCP connectors.

### 2026-09-09 — gmail
- **Who:** Nellie LeMonier, Lalit Maharana (Zoom AI summary)
- **Where:** Email thread 1a087871a0ab0e69 — "Meeting assets for Performance Partner tools for winter are ready!"
- **Summary:** Zoom session (2026-09-09): Nellie and Lalit discussed MCP development in the context of Performance Partner tools for winter; full meeting assets now available for review.

### 2026-09-22 — gmail
- **Who:** Nellie LeMonier (session host), Betterworks engineering org
- **Where:** [Zoom email — "Meeting assets for MCP Tool & Prompt Training Session 1 are ready!"](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1877055024060937019)
- **Summary:** Zoom AI summary and action items ready for MCP Tool & Prompt Training Session 1 led by Nellie.

### 2026-09-22 — gmail
- **Who:** Nellie LeMonier
- **Where:** [Email — "MCP Tool & Prompt Training Session 1" recording](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1877059661641110622)
- **Summary:** Nellie distributed the recording link for MCP Tool & Prompt Training Session 1 to broad engineering org (~90 recipients).

### 2026-09-22 — gmail
- **Who:** Nellie LeMonier, Lalit Maharana (Zoom meeting)
- **Where:** [Zoom email — "Meeting assets for Lalit / Nellie 1:1 are ready!"](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1877042996754450410)
- **Summary:** Lalit/Nellie 1:1 covered MCP training session status and Phase 1.5 updates.

### 2026-09-23 — gmail
- **Who:** Nellie LeMonier
- **Where:** [Calendar invite — "Lalit/Nellie TB on MCP Tools & Prompts"](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1877100612583603268)
- **Summary:** Nellie scheduled follow-up touchbase on MCP Tools & Prompts for Wed Sep 23 7–7:30pm IST.

### 2026-09-23 — gmail
- **Who:** Jason Bilyeu (Confluence author)
- **Where:** [Confluence weekly digest](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1877100444805315211)
- **Summary:** Confluence weekly digest surfaced JB's "LLM-friendly JSON Format Spec + Examples" and "REST endpoint pattern guide" — relevant to MCP tool authoring standards.

### 2026-09-23 — gmail
- **Who:** Lalit Maharana, Nellie LeMonier (Zoom meeting)
- **Where:** [Zoom email — "Meeting assets for Lalit/Nellie TB on MCP Tools & Prompts are ready!"](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1877129782136183879)
- **Summary:** Zoom meeting assets delivered for the Lalit/Nellie MCP Tools & Prompts touchbase; summary indicates the meeting focused on the approach for MCP prompts.

### 2026-09-24 — slack
- **Who:** Jason Zhang, Ryan Mulready, Jason Bilyeu
- **Where:** [#pod-ai-chat](https://betterworks.slack.com/archives/C0BEMU079J7/p1790196026390699)
- **Summary:** Jason Zhang built out the MCP prompt endpoint (prompts/list and prompts/get via public-api-mcp server); JB confirmed prompts should be independently listable/executable from Claude or ChatGPT; design decision to not mirror MCP spec 1:1 to prevent system API exploitation via prompt introspection.

### 2026-09-30 — slack
- **Who:** Nellie LeMonier
- **Where:** [#eng-mcp](https://betterworks.slack.com/archives/) — 2026-09-30 18:33–18:35 IST
- **Summary:** Nellie shared recording from 2nd MCP training workshop (passcode shared in channel) and announced a technical deep-dive call with JB for Thursday Oct 1 at 7 AM PST / 8:30 PM IST (recorded for those who can't attend).

### 2026-09-30 — slack
- **Who:** Aditya Maliyan
- **Where:** [#pod-feedback](https://betterworks.slack.com/archives/) — 2026-09-30 16:57 IST
- **Summary:** PR review requests for feedback-api/pull/775 and public-api-mcp/pull/125 shared with team for review.

### 2026-10-19 — slack
- **Who:** Nellie LeMonier
- **Where:** [DM Nellie ↔ Lalit](https://betterworks.slack.com/archives/D0B1DFSV5SR/p1792377487005029)
- **Summary:** Nellie asked Lalit to scope ENG-89357 to Conversations only, create separate Feedback and Recognition MCP epics and move tickets, and add "create recognition" tool as a story under the new Recognition epic (update/delete recognition low priority).

### 2026-10-19 — gmail
- **Who:** Paul, Lalit Maharana (Zoom meeting)
- **Where:** [Zoom email — "Meeting assets for Paul / Lalit are ready!"](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1879484731278654734)
- **Summary:** Zoom recap of Paul/Lalit sync focused on status of MCP tools and the PM workflow guide.

### 2026-10-20 — slack
- **Who:** Nellie LeMonier, Jason Bilyeu
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1792428266681249?thread_ts=1792428266.681249&cid=C01GYVBME90)
- **Summary:** Nellie asked whether the Betterworks MCP can be added to Copilot; JB replied that it's just an MCP config entry pointing at the Rainforest `mcp-beta` endpoint.

### 2026-10-20 — slack
- **Who:** Hung Truong
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1792445776067209)
- **Summary:** Hung offered to also pick up ENG-88893 (spike: make MCP tools work with org-customized module names).

### 2026-10-20 — slack
- **Who:** Nellie LeMonier (to Eden Owen, Lalit)
- **Where:** [Group DM Eden/Nellie/Lalit](https://betterworks.slack.com/archives/C0BMJA3T796/p1792423283865009)
- **Summary:** Nellie wants a reusable Jira template (or Confluence page / Rovo skill) for MCP tool and MCP prompt tickets.

### 2026-10-20 — slack
- **Who:** Ryan Mulready
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1792417690091259)
- **Summary:** public-api-mcp PR #134 refactors MCP index.ts into reusable functions; requested a deep review.

### 2026-10-20 — slack
- **Who:** Ryan Mulready (to Jason Zhang)
- **Where:** [#pod-ai-chat](https://betterworks.slack.com/archives/C0BEMU079J7/p1792440865866149)
- **Summary:** agent-runtime PR #154 passes the real MCP tool error response back to the LLM so it can self-correct.

### 2026-10-20 — gmail
- **Who:** Nellie LeMonier (via Aha)
- **Where:** [Aha update — AI-233](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1879532791811908827)
- **Summary:** Nellie updated Aha feature AI-233 "AI Modules - MCP Tools & Prompts" (status Pre-Planning).

### 2026-10-20 — gmail
- **Who:** Eden Owen (via Jira)
- **Where:** [ENG-88948 thread](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1878291673571358501)
- **Summary:** ENG-88948 (Feedback summary tool for MCP) rolled from Sprint 296 into Sprint 297.

### 2026-10-21 — slack
- **Who:** Ryan Mulready
- **Where:** [#pod-app-platform](https://github.com/BetterWorks/public-api-mcp/pull/143) — 2026-10-20 22:45 IST
- **Summary:** Opened public-api-mcp PR #143, which adds structuredOutput to LLM tool responses, and asked for review.

### 2026-10-21 — slack
- **Who:** Justine OConnell (reactions from Allie Collins, Cassie Fulton Flores)
- **Where:** #general — 2026-10-21 18:22 IST
- **Summary:** At UNLEASH Paris, Rhys Kirby's session drew 180+ attendees to an overflowing room and the MCP visuals and videos were a highlight (12 meetings booked onsite). This is external market interest in Betterworks MCP.

### 2026-10-22 — slack
- **Who:** Jason Bilyeu
- **Where:** #pod-app-platform / #pod-ai-chat — 2026-10-21 19:29–23:34 IST
- **Summary:** MCP PRs up: new @api_mcp decorator in Core (ENG-89758, BW #28910), generated tools from updated docs (public-api-mcp #149), outputSchema support (ENG-89771, #151), tool-list pagination (ENG-86537, #152) — needs agent verification before merge.

### 2026-10-22 — slack
- **Who:** Nellie LeMonier
- **Where:** #prod-squad, #eng-mcp — 2026-10-22 04:52 IST
- **Summary:** Published MCP Tools user-story template (Confluence) as the new standard for all teams ahead of Winter MCP GA; retrofits of existing tools will follow.

### 2026-10-22 — slack
- **Who:** Nellie LeMonier
- **Where:** Group DM (Kate Malcolm, Viktoriia Bondareva, Nataliia Savenko, Nellie, Lalit) — 2026-10-21 19:25 IST
- **Summary:** Added Lalit as the person tracking MCP tools being added across modules.

### 2026-10-22 — slack
- **Who:** Jason Zhang, Ryan Mulready
- **Where:** #pod-ai-chat — 2026-10-22 05:00–18:40 IST
- **Summary:** Chat page-context design: Haven to export accepted routes (haven PR #7146); MCP server serves them as a resource (/resources/haven-routes.md) plus new tools so agent-runtime can fetch the record the user is viewing.

### 2026-10-22 — slack
- **Who:** Hemant Kumar (to Lalit)
- **Where:** DM Hemant/Lalit — 2026-10-22 10:54 IST
- **Summary:** Hemant is involved in Engage MCP tools but only has development status, no visibility into wider plan.

### 2026-10-22 — gmail
- **Who:** Ankit Sharma (via Jira)
- **Where:** [ENG-89918 thread](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1879738329699004110)
- **Summary:** SPIKE ENG-89918 (Permissions and MCP patterns for AI features) moved Draft → Ready for Refinement; Part A write-up compares how services expose MCP tools and how permissions work.

### 2026-10-22 — gmail
- **Who:** Ankit Sharma (via Jira)
- **Where:** [ENG-88948 thread](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1878291673571358501)
- **Summary:** ENG-88948 (Feedback summary tool for MCP) moved In Progress → On Hold.

### 2026-10-23 — slack
- **Who:** Jason Bilyeu
- **Where:** #pod-app-platform — 2026-10-22 22:33 – 2026-10-23 03:01 IST
- **Summary:** public-api-mcp PRs up: remove deprecated MCP tools (ENG-89957, #154), security library upgrades (ENG-89962, #160), MCP system instructions (ENG-89915, #161).

### 2026-10-23 — slack
- **Who:** Ryan Mulready
- **Where:** #pod-ai-chat — 2026-10-23 01:03 IST
- **Summary:** ENG-89361 PR stack to add Haven route tools to public-api-mcp (SDK dep + GitHub Packages auth #155, local tool support #156, ...); nothing live until PR #3.

### 2026-10-23 — slack
- **Who:** Martha Rankins
- **Where:** #pod-app-platform — 2026-10-23 19:04 IST
- **Summary:** Updating core tool descriptions for MCP GA (ENG-89629, ENG-89649) — BetterWorks PR #28913.

### 2026-10-23 — slack
- **Who:** Viktoriia Bondareva
- **Where:** Group DM (Kate Malcolm, Viktoriia, Nataliia Savenko, Nellie, Lalit) — 2026-10-22 20:25 IST
- **Summary:** Shared light draft for Talent MCP (succession) defining AI tools to find best-fit successors; requested comments in doc.

### 2026-10-23 — slack
- **Who:** Ankit Sharma
- **Where:** #pod-ai-platform — 2026-10-22 20:25 IST
- **Summary:** ENG-89918 permissions findings posted to ticket (how tools are exposed over MCP, current permissions, proposed path for feedback summary); now drafting MCP building-block (tools/prompts/tasks/skills) recommendations per AI use case.

### 2026-10-23 — gmail
- **Who:** Martha Rankins (via Jira)
- **Where:** [ENG-88105 thread](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1876553198002044755)
- **Summary:** ENG-88105 (AI Modules - MCP Tools & Prompts) moved Draft → In Progress.

### 2026-10-26 — gmail
- **Who:** Ankit Sharma (Jira notification)
- **Where:** [ENG-89918 SPIKE: Permissions and MCP patterns](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1879738329699004110)
- **Summary:** Ankit posted Part B of the MCP permissions/patterns spike ("MCP building blocks" — tools, prompts, tasks, skills), following Part A on how services expose MCP tools and how permissions work.

### 2026-10-27 — slack
- **Who:** Ankit Sharma
- **Where:** #pod-ai-platform — 2026-10-27 11:25 IST
- **Summary:** Shared artifacts from today's call on exposing AI services via MCP: (1) exposing tools and LLM services such as feedback summary through MCP, (2) MCP building blocks — tools vs. prompts vs. skills vs. tasks and client support.

### 2026-10-27 — slack
- **Who:** Viktoriia Bondareva
- **Where:** Group DM (Kate Malcolm, Viktoriia, Nataliia Savenko, Nellie, Lalit) — 2026-10-26 22:07 IST
- **Summary:** Defined Talent MCP v1 scope in ENG-89859 (Talent | MCP Tools & Prompts v1 – Succession), updated the ideas doc, and drafted stories starting with talent_get_job_profile_skills.

### 2026-10-27 — gmail
- **Who:** Viktoriia Bondareva
- **Where:** [Invitation: Talent MCP tool sync](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1880209968751435653)
- **Summary:** Talent MCP tool sync scheduled Fri Oct 30, 8–8:30 PM IST with Lalit, Nellie, Kate Malcolm (cc Nataliia).

### 2026-10-27 — gmail
- **Who:** Jason Zhang
- **Where:** [Invitation: Performance Summary MCP tools Discussion](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1880177822946551676)
- **Summary:** Performance Summary MCP tools discussion held Oct 27 10:30–11:15 IST (Aakansha, Ankit, Hemant, Okan; cc Lalit, Cheau, Sagar, Nellie).

### 2026-10-28 — slack
- **Who:** Jason Bilyeu
- **Where:** #pod-app-platform — 2026-10-27 23:46 IST
- **Summary:** PRs up for MCP OAuth scope support (ENG-90003, ENG-90004) in Core and public-api-mcp.

### 2026-10-28 — slack
- **Who:** Nellie LeMonier / Martha Rankins
- **Where:** #eng-mcp / #pod-app-platform — 2026-10-28 01:29–05:20 IST
- **Summary:** MCP GA work in sprint: module icons for Core MCP tools (ENG-90009, PR open; Nellie pushing Gauri to confirm material-symbols icons) and Core tool description updates (ENG-89629/89649).

### 2026-10-28 — slack
- **Who:** Ryan Mulready
- **Where:** #pod-ai-chat — 2026-10-28 18:31 IST
- **Summary:** New MCP prompt "Draft Conversation Responses" is the first requiring arguments; BetterAI Chat needs a new input UX for argument prompts.

### 2026-10-28 — slack
- **Who:** Jason Zhang
- **Where:** #pod-ai-chat — 2026-10-28 04:47 IST
- **Summary:** agent-runtime connects to rainforest public-api-mcp via public endpoint (services/mcp-beta/mcp); asked JB to confirm same pattern for orchard/pluto/champagne.

### 2026-10-28 — slack
- **Who:** Emad Ahmed / Nellie LeMonier; Rhys Kirby
- **Where:** #signaturesupport — 2026-10-27 20:31–21:02 IST; #product — 2026-10-27 23:40 IST
- **Summary:** HelloFresh wants a native Gemini MCP connection path (docs only cover Claude/ChatGPT/CLI; Nellie: any MCP-capable AI works); EMEA sales asked whether MCP actions have an audit log.

### 2026-10-28 — slack
- **Who:** Ankit Sharma
- **Where:** DM with Ankit Sharma — 2026-10-28 10:37 IST
- **Summary:** Asked Lalit to review the MCP artifacts, then set up a discussion to finalize implementation.

### 2026-10-28 — gmail
- **Who:** Ankit Sharma / Automation for Jira (Jira notifications)
- **Where:** [ENG-89918 SPIKE: Permissions and MCP patterns](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1879738329699004110) · [ENG-88105 AI Modules - MCP Tools & Prompts](https://mail.google.com/mail/?authuser=lalit.maharana@betterworks.com#all/thread-f:1876553198002044755)
- **Summary:** ENG-89918 pointed at 2 SP; ENG-88105 rolled-up points grew 11 → 14.
