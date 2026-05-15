# AI-201 / ENG-79199 — Meeting Transcripts (Lalit's epic)

**Aha:** `AI-201` (Tier A: Revenue Creator) · **Jira:** ENG-79199 (Draft, P2, no sprint pull)
**Owner:** Lalit (PM) · Nellie (sponsor) · Cross-pod: AI + Meetings (Varnica) + App Platform (JB) + Integrations (Rinku)
**Composite score:** 29 (proposed 9/6/9/10 −5)
**Bucket:** P0

## Signals

### 2026-05-07 — Hard date: May 31 Rainforest live for ENG-79199
**Source:** Daily meeting extract — Lalit/Cheryl 1:1 prep
**Type:** commitment
**Owner-impact:** Lalit, Nellie, AI engineering

CPTO Cheryl Johnson 1:1 prep states "ENG-79199 May 31 Rainforest target" as the headline status item, with a clear ask on engineer allocation and escalation path. This is significantly earlier than Summer 2026 code-ready (Aug 28).

**Implication for ranking:** AI-201 has a hard internal date 12 weeks before release code-ready. Sprint pull needs to happen now — current state is Draft / 0 sprint items.

### 2026-05-13 — Tentative decision: native Zoom is the v1 path (Lalit, pending refinement)
**Source:** Lalit session 2026-05-13
**Type:** scope-decision (tentative)
**Owner-impact:** Lalit, Danish, Sriram, AI engineering

Aligning with Nellie's stated preference. Recall.ai POC findings stay as reference; v1 architecture will pursue native Zoom API integration. **Final lock in refinement call** — keep open until then.

**Implication for ranking:** AI-201 effort estimate stays at 5 (native is more work than Recall bot). Architecture walkthrough output with Jay-Z will solidify.

### 2026-04-28 — Nellie prefers native Zoom API over Recall.ai bot approach
**Source:** [Slack #temp-meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/) — Nellie LeMonier
**Type:** scope-decision (contested)
**Owner-impact:** Lalit, Danish, Sriram CS, App Platform

> "recall.ai may get us there faster... but I believe a bot-like integration where every meeting attendee needs to install a bot... isn't optimal. Imagine when we support integrating all your meeting transcripts, we then have a meeting with 6 people and 6 bots. I think a native Zoom API integration is the way to go."

Recall.ai POC (ENG-78337) is Done, but Nellie's stated preference is native. Sriram CS subsequently said Recall is acceptable for v1 ("they store transcript data, not a pass-through... okay for first version"). **Unresolved tension.**

**Implication for ranking:** Architecture path materially changes effort and timeline. Worth a forcing decision before refinement.

### 2026-04-29 — Sriram CS: transcripts should consume Betterworks MCP server for action-taking
**Source:** [Slack #temp-meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/) — Sriram CS
**Type:** scope-decision (proposed)
**Owner-impact:** Lalit, JB, AI team

> "Action items from the transcript must result in actions that can be taken in our app, like creating goals, filling out conversations, updating skills, etc. We must consider using our Betterworks MCP server to achieve this... build this as foundational architecture for any future two-way integration."

MCP Internal is now live (rolled out 2026-05-06 across all four envs). This proposal couples AI-201 to MCP for write-back rather than direct API calls.

**Implication for ranking:** Scope expansion vs. v1 simplification. Either accept (effort goes up, defensibility goes up) or defer to v2.

### 2026-05-12 — Design scope still unclear; two prototype directions in play
**Source:** Group DM (Sarah Brose, Nataliya, Paul, Austine, Nellie, Lalit)
**Type:** open-question
**Owner-impact:** Lalit, Sarah Brose (Design Lead), Austine

Sarah Brose: "originally the goal was to provide direction to Austine for click-through prototype by end of week, but after discussion I'm still unclear on requirements and scope." Nataliya counter: wants "directional mocks that rethink interaction patterns and incorporate AI-driven suggestions powered by meeting transcripts." Two paths: auto-ingested transcripts vs. manually pasted.

**Implication for ranking:** Design is a critical-path dependency; ambiguity here directly threatens May 31 Rainforest date.

### 2026-04-28 — Competitive pressure: Lattice AI Meeting Agent (shipped early 2026)
**Source:** Confluence — Zoom/Teams Feature Documentation
**Type:** competitive
**Owner-impact:** Sales, Marketing, Lalit

Lattice's AI Meeting Agent auto-joins 1:1s via bot — direct competitor. Our defensibility is depth of integration with performance/skills/feedback signals, not just transcript capture.

**Implication for ranking:** Strengthens market-differentiation score; supports P0 placement.

### 2026-05-07 — Architecture walkthrough held (Nellie + JB + Lalit, 32 min)
**Source:** Daily meeting extract — 2026-05-07
**Type:** scope-decision
**Owner-impact:** Lalit

Action: Lalit to book session with Jay-Z (Jason Zhang) to walk through LLM/AI service architecture diagrams by May 9. Jay-Z has dedicated diagrams.

**Implication for ranking:** Foundation for v1 architecture pick (native vs. Recall, MCP-coupled vs. direct).

### 2026-05-14 — slack
- **Who:** Sriram CS
- **Where:** #temp-meeting-transcript-integration
- **Summary:** Organized cross-pod alignment call (10:30 PM IST, post-all-hands); asked Rinku and Tanveer to join; flagged unresolved delivery-manager question (Rinku or Tanveer?), with Anuj Pancholi as primary tech lead for Zoom native integration.

### 2026-05-14 — slack
- **Who:** Sriram CS
- **Where:** #temp-meeting-transcript-integration
- **Summary:** Proposed call agenda: (1) ownership & high-level project plan across 3 teams, (2) requirements walkthrough with Nellie and Lalit, (3) Anuj to walk through Zoom native integration challenges.

### 2026-05-14 — slack
- **Who:** Nellie LeMonier
- **Where:** #temp-meeting-transcript-integration
- **Summary:** Shared Confluence doc for Zoom/Teams Transcripts Feature Documentation (https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097/) for team transparency.

### 2026-05-14 — slack
- **Who:** Nellie LeMonier
- **Where:** #temp-meeting-transcript-integration
- **Summary:** Confirmed project kickoff readiness; acknowledged Lalit's requirements deep dive and that 3 pods (Meetings, Integration, AI) all need to collaborate.

### 2026-05-15 — slack
- **Who:** Slack system (channel admin)
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1778824551570539)
- **Summary:** Channel renamed from #temp-meeting-transcript-integration to #meeting-transcript-integration, signaling transition from POC/temp to active-project status.

### 2026-05-15 — slack
- **Who:** Lalit Maharana
- **Where:** [Group DM — Paul Agustin, Sarah Brose, Austine Joy, Nataliya Kolb, Nellie LeMonier](https://betterworks.slack.com/archives/C0B2ZDJ5K2R/p1778786930112609)
- **Summary:** Lalit articulated manager + employee personas for the feature, defining 5 core use cases: pre-meeting cross-session prep, post-meeting auto-capture (action items + agenda chips), open-item carry-forward, cross-1:1 pattern/coaching analysis, and AI-sourcing transparency ("Why-this" deep-link panel); also noted Paul's data showing users prep agendas but under-document post-meeting actions.
