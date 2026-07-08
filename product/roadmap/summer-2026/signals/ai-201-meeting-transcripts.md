# AI-201 / ENG-79199 — Meeting Transcripts (Lalit's epic)

**Aha:** `AI-201` (Tier A: Revenue Creator) · **Jira:** ENG-79199 (Draft, P2, no sprint pull)
**Owner:** Lalit (PM) · Nellie (sponsor) · Cross-pod: AI + Meetings (Varnica) + App Platform (JB) + Integrations (Rinku)
**Composite score:** 29 (proposed 9/6/9/10 −5)
**Bucket:** P0

## Signals

> **2026-06-30 backfill** — 10 entries below (2026-06-10 → 06-30) reconstructed from Zoom AI-summaries to close the June 9–30 gap (ledger was last touched 2026-06-08). Two sessions left no recorded assets and are flagged inline as gaps: "Meeting Transcript - AI sync" (6/9) and "Story pointing ENG-82387" (6/16).

### 2026-06-30 — Implementation kicked off; full task-level timeline (dev-complete ~Aug 10); extensible DB schema; debrief → monthly
**Source:** Zoom — "Estimations | Meeting Transcript" 2026-06-30 (UUID 2B037EA4-56C3-477C-942A-0C8240FA88AC) + "AI Projects Debrief" 2026-06-30 (UUID A63F8BF8-843E-4537-9428-94DC600BC48A). AI summaries digested.
**Type:** planning + scope-decision + status
**Owner-impact:** Lalit, Sagar, Hemant, Anuj, Danish, Tanveer, Nellie/Maher

Design is aligned across all three pods and the project moved **POC → implementation** (Hemant + Sagar on DB schema). First concrete task-level plan sequences dev work **July 1 → ~Aug 10** (≈5-day buffer before the Aug 15 pre-prod date); no major blockers, several inter-team dependencies. DB schema built **extensible** — Zoom-only source now, but must absorb Teams/Slack/Jira/free-text without rework (matches Lalit's stated Phase-2 order: Teams → Slack → Jira). In-house inbound webhook confirmed (Okan's spike found no viable OSS; ingests provider events → Kafka). Recap refresh is **per-instance** (not unified); old summary + new recap coexist behind an **org-level enablement flag**; email/push notification kept as a task but **explicitly not release-blocking** (needs an LLM-Engine notification spike). GPT-5 used as LLM judge in POC eval. Maher approved dropping the AI Projects Debrief to **monthly** — leadership reads the project as stable. **Lalit's most time-sensitive blocker:** deliver finalized **recap/prep key fields** to Sagar — his prompt engineering can't start (July 2) without them. Same-day infra gaps: S3 bucket Terraform (Anuj→Emerson), EDA-event DB schema (Anuj+Hiten); Hiten's frontend estimates still outstanding.

**Implication for ranking:** On track for Aug 29 / pre-prod Aug 15; risk shifted from scope to schedule-compression on Lalit-owned inputs + infra setup.

### 2026-06-29 — Transcripts execution-ready; OPEN-D11 substrate resolved (direct LM inference server, Gemma 4 by Aug 10, 64K ctx); MCP V2 goals contract
**Source:** Zoom — "Lalit / Nellie 1:1" 2026-06-29 (UUID 25E15DB1-1035-4CA7-A37F-927A4D62ADFD) + "Rec. Architecture Sync-up" 2026-06-29 (UUID CDD007A8-BB42-489F-8DC7-021FD16F8CF9) + "Goals and MCP" 2026-06-29 (UUID D637A051-8F78-45DF-B4C4-47F595B5C8D7). AI summaries digested.
**Type:** scope-decision + architecture
**Owner-impact:** Lalit, Nellie, Sagar, Hemant, Emerson, Varnica

(1) Nellie confirmed the **transcripts track is execution-ready** — designs mostly complete; next gates = Lalit reviews the sprint plan with her, then Sagar + Hemant present spike findings to the full team and run story refinement. (2) **OPEN-D11 inference substrate resolved for MVP** → **direct LM inference server endpoint** (LM Proxy can't yet do structured/function calling via LangChain), **Gemma 4 replacing Llama in production by ~Aug 10**, **64K-token context** default (≈1hr meeting per Hemant's POC). Embeddings/skill-graph move to a future-evolution role (mentor matching SQL-first, embeddings later) — the Sagar/Pankaj/Aryan embedding track now has a downstream home rather than gating MVP. (3) **MCP V2 goals contract** (backend under the Meetings "Create Goal" / goal-recommendation cards): four tools — `list goals`, `update goal`, `goals get settings`, `create goal`; no bulk; Tier-1 default. **PATCH-at-service-layer is the critical outstanding backend task (Emerson) and gates `update goal`** (detail in [[mcp-internal]]). Nellie also steered Lalit toward a new Slackbot/MCP connector + a notifications-batching design (see [[mcp-internal]]); Custom Roles on hold pending Alex's return.

**Implication for ranking:** The long-open substrate question (OPEN-D11) is now a known MVP path — materially de-risks the AI pipeline. Meetings goal-card flow inherits a dependency on MCP V2 + the PATCH gap.

### 2026-06-25 — AI surface design finalized: 5 meeting-state tags, recap + prep-brief content schema, "AI Suggested" header removed, Figma = source of truth
**Source:** Zoom — "Meetings" 2026-06-25 (UUID 451648E8-6B95-41DF-B999-1C68BBCC3942). AI summary digested.
**Type:** scope-decision + ux
**Owner-impact:** Lalit, Harshini, Varnica, eng

Core AI surface locked. **Five meeting-state tags** (only one shown per meeting at a time): *AI Prep Ready* · *Upload Transcript to Update AI Insights* (non-Zoom only) · *Processing* (simplified from "Processing Transcript") · *AI Updates Available – Reload* · *AI Updated*. **Recap schema:** Summary → Blockers (max 3) → What Happened (decided / agreed / open risks) → Follow-ups (max 5); outcome caps scale by duration (≤30min = 3 pts, 30–60min = 5 pts). **Prep-brief schema:** ARC Synthesis (1–2 plain sentences, no title) → Attention Flags (unlabeled bullets) → Goal Signals (unlabeled bullets); AI logo only on individual line items. **"AI Suggested" header block removed** (redundant with per-item logos). Past meetings drop the "Completed" tag and the "Meeting Recap [date]" label. Uploaded transcripts shown read-only. **Workflow ruling: Claude for flows/prototypes; Figma is source of truth for styling/spacing/dev handoff** (to prevent the component-mismatch rework seen on a prior feature). Goals form will eventually load inline platform-wide; redirect is the stopgap pending the dev spike. **Lalit owes:** review + confirm the documented tag-state matrix (upcoming vs past).

**Implication for ranking:** Design risk for the Meetings surface largely retired; remaining open = goal inline-vs-redirect.

### 2026-06-23 — Integration sidebar consolidation; transcript contract extended through July
**Source:** Zoom — "Meetings AI" 2026-06-23 (UUID 95BEC3FA-BC62-40E0-999B-CEA13EBDCD3B) + "Lalit / Nellie 1:1" 2026-06-23 (UUID 2FE3D86A-5DAB-43F0-A571-C311C71D3950). ("PDP: AI Recommendation sync" same day → routed to [[ai-203-adaptive-learning]].) AI summaries digested.
**Type:** ux-decision + scope + stakeholder-position
**Owner-impact:** Lalit, Harshini, Varnica, Anuj, Nellie

Meetings connection UX: a **single consolidated integration sidebar** replaces the calendar-only pattern, categorized (Calendar: Google/Outlook; Meetings: Zoom, future Teams). **Banner-suppression is category-based** — hides when ≥1 app per category is connected (Lalit's cluster logic). Redundant right-side nudge removed; top + in-meeting banners retained for now. Zoom auth = internal Betterworks consent screen → Zoom admin-level authorization (no user-level OAuth). Open: whether Google Calendar also needs a pre-auth consent screen (Varnica → Anuj); goal inline-creation vs redirect (dev spike — Anuj is shared eng lead for Goals + Meetings goals logic). From the Nellie 1:1: **meeting-transcript contract confirmed through July** (scope continuity).

**Implication for ranking:** Connection/onboarding flow defined; some dev migration of the existing Google Calendar approach required.

### 2026-06-19 — Transcripts named first use case for the new event-based integration platform; end-of-June technical freeze
**Source:** Zoom — "PDP - Integrations LMS work discussion" 2026-06-19 (UUID EAF87C52-0810-44CC-8448-E36D6B560867). AI summary digested. (Cross-posted to [[ai-203-adaptive-learning]].)
**Type:** architecture + cross-team dependency
**Owner-impact:** Lalit, Pankaj, Nitish, Danish, Okan, Jason Sites, Rinku

Strategic direction: a **decoupled, event-based integration platform** where internal modules no longer know about specific third-party sources. Nitish recommended **validating the new architecture on meeting transcripts FIRST** (LMS integrations treated as tech debt to migrate later) — giving transcripts a foothold in the platform redesign. Danish/Okan's inbound-webhook spike is now a **named dual-use dependency** for the PDP/LMS team too → bandwidth-contention risk on Danish. **All technical decisions/protocols/contracts to be frozen by end of June 2026** to protect August delivery — making Lalit's attendance at Jason Sites' Monday 9:30 technical meeting time-critical. Cross-functional team formed (Pankaj, Nitish, Goals/Emerson, AI, SDET, Okan/Danish).

**Implication for ranking:** Raises shared-infra coupling between transcripts and PDP/LMS — coordination + the EOJ freeze are the near-term risks.

### 2026-06-18 — AI module enable/disable control surface has gating bugs (admin-trust risk pre-GA)
**Source:** Zoom — "AI tickets for AI module enable/disable" 2026-06-18 (UUID B6AAFE92-CCB9-4A30-ADA8-48B09ABA0B67). AI summary digested.
**Type:** risk + scope-decision
**Owner-impact:** Lalit, Nellie, Eden (UI team), Tejas

Triage surfaced a real gating risk: **disabling a module (e.g. Goals) does not reliably suppress its AI feature flags**, and saving system-admin settings can restore AI flags even when the module is off — directly relevant to how admin orgs gate the transcripts/AI features before GA. 1:1 settings are dependency-linked to the meeting-summary feature (disable needs a page reload; proposed auto-reload on save). Action-button-visibility bug (hidden during impersonation) reclassified as a global-component issue → **Eden's UI team**, not AI. Operational note: org hit its **Claude monthly usage cap on 6/18** (ChatGPT interim fallback). **Lalit owes:** clean up the ticket doc (proposed solutions + AI-vs-other-pod ownership split), share with Nellie; log the visibility bug to Eden; add AC to Tejas's ticket.

**Implication for ranking:** Module-gating reliability is a GA-blocking quality item for any AI feature shipping behind org enablement.

### 2026-06-16 — Project-plan alignment: admin OAuth + consent-based per-participant processing locked; scale targets; sync daily scrum; POC complete
**Source:** Zoom — "Project Plan | Meeting Transcript" 2026-06-16 (UUID 0501939E-0758-4A0C-9B8F-4D130A12F5CF) + "AI Projects Debrief" 2026-06-16 (UUID DB2BD344-0701-46C2-9C86-D48F689CB172). **GAP:** "Story pointing for Meetings transcripts ENG-82387" 2026-06-16 (UUID 9B91A12D-…) had **NO recorded assets** — recover point estimates/sequencing from Jira/attendees. AI summaries digested.
**Type:** scope-decision + architecture + planning
**Owner-impact:** Lalit, Anuj, Danish, Sagar, Hemant, Harshini, Tanveer

Primary architecture/UX alignment. **Locked:** OAuth is **admin-level, one-time per org** (users give in-app consent only — no per-user Zoom redirect); **consent-based per-participant processing** — if A consents and B doesn't, only A's transcript is processed, B sees nothing until consent, **future meetings only** (no retroactive); consent flag travels in the Meetings→AI payload; AI emits **two suggestion types (create / update-close)** with entity IDs for UI grouping; for MVP the AI fetches goals directly from the Goals microservice by participant ID; manual paste/upload supported when Zoom isn't connected (validated → S3 by Meeting Service); a third **"AI Transcript" tab** (name kept per Sriram). **Scale estimate:** ~1,600 concurrent participants / ~400 simultaneous transcripts at peak → single inference server insufficient, horizontal scaling (HPA) needed. **Process change:** async scrum dropped → synchronous **daily 15-min scrum at 12pm IST**. **Open:** webhook routing — single Betterworks-wide URL (via account_id) vs per-org URL (Pankaj + Danish offline); whether Zoom Marketplace approval is required for prod GA (Anuj). From the debrief: **POC complete and successful** (data extraction + source citation + timestamps validated); story-pointing ~half done; Lalit framed a ~**6–8 week runway**; the Meetings API hands the AI team an **S3 link** (Meetings pod owns transcript-storage infra, keeping AI infra scope lean).

**Implication for ranking:** Major scope/architecture de-risking; admin-OAuth + consent model are now firm PRD constraints.

### 2026-06-15 — Nellie 1:1: backlog hygiene + risk flags (Docebo at risk, TechWolf licensing, embeddings status)
**Source:** Zoom — "Lalit / Nellie 1:1" 2026-06-15 (UUID DECC97E4-936E-4C28-835E-0E1341569187). AI summary digested.
**Type:** stakeholder-position + risk
**Owner-impact:** Lalit, Nellie, Rinku, Danish

Broad backlog + cross-team hygiene review. Risk flags: **Docebo integration at risk** (dependency issues — Lalit to assess feasibility with Rinku before committing); **TechWolf taxonomy/licensing** (Lightcast vs TechWolf) unresolved, gates Phase-2 Kafka/webhook work (follow up Ocon); **embeddings work needs a status follow-up** (Ulama→Gemma migration done). Process steers: leverage **Prasanna** (delivery manager, underutilized) for standup facilitation/process; a **QA-rigor gap** across pods (JB's pod weaker than AI side) that Nellie will raise with Cheryl. Reinforced standing expectation: Lalit owns ticket-level hygiene + cross-team follow-up proactively.

**Implication for ranking:** No scope change; Docebo + TechWolf are watch-items that could affect Phase-2 integration sequencing.

### 2026-06-11 — Design review: Phase-1 scope cuts (due dates, AI notes) + two-layer consent + async processing pattern
**Source:** Zoom — "Meetings AI" 2026-06-11 (UUID 63FE0187-3DBD-4164-80D1-1E00621BF377). **GAP:** "Meeting Transcript - AI sync" 2026-06-09 (UUID E4E45AEA-…) had **NO recorded assets**. AI summary digested.
**Type:** scope-decision + ux
**Owner-impact:** Lalit, Harshini, Varnica, Anuj

Design review (Harshini/Varnica/Lalit). **Scope cuts:** action-item **due dates removed from MVP** (admin-config complexity); **AI-generated notes deferred**; Recognition + Feedback kept in Figma for visibility but **out of Phase-1 scope** (goals flow only). **Flows:** "Create Goal" from an AI suggestion → redirect to Goals page with pre-filled attributes; "Update Goal" → open goal form with AI hints (not auto-applied); after creation the goal reference is added to action items but needs a **page reload** (no real-time update). **Consent:** two-layer model confirmed — Betterworks disclaimer screen, then Zoom OAuth redirect. **Processing UX:** ~**5–10 min async**, status states "Add transcript…" → "Insight generation in progress" → "Updates available" (reload). Open: dismiss = modal vs toast (Lalit); pre-fill vs hint feasibility in MVP (Varnica/Anuj); event-based callback on goal-save to refresh the recommendations queue (POC ticket to be created).

**Implication for ranking:** Trims MVP surface (due dates, AI notes out) and firms the consent + async-processing patterns.

### 2026-06-10 — Refinement (epic-7 story review) + Nellie 1:1 scope-setting (summer/winter split; MeetingsPod owns ingestion; epic rename; Phase-2 → separate Aha)
**Source:** Zoom — "Meeting Transcripts - Refinement" 2026-06-10 (UUID B47492F3-960B-4616-BCD3-114A9520E312) + "Lalit / Nellie 1:1" 2026-06-10 (UUID 5D3A03B3-E5FD-47FA-9CB7-0789CE160969). AI summaries digested.
**Type:** scope-decision + planning
**Owner-impact:** Lalit, Nellie, Danish, Anuj, Sagar, Hemant

**Refinement** walked the epic-7 stories pod-by-pod toward one signed-off I/O contract before implementation. Decisions: AI brief generation runs as a **daily batch 12–24h before upcoming meetings** (+ manual refresh); **speaker identity resolution target 90–95% accuracy**, matched on email + employee ID, handled at the **Meetings-service level (not Integrations)**; **meeting exclusions owned by Meetings service**; admin-level Zoom enablement spans org settings + a third-party integration page; event-driven (vs static-endpoint) integration preferred for scalability; Anuj to share an S3 sample-transcript bucket with folder/naming conventions. **Nellie 1:1 (scope-setting):** locked the **summer/winter split** — Summer = Zoom + manual only (**Teams explicitly out**); **Phase-2 signal extraction (goals/recognition/skills) must become its own Aha feature for Winter**, with Confluence updated to show the split. Feedback: **rename the parent epic** (don't imply "AI pipeline only"); decompose coarse stories before refinement; whole AI team (incl. JZ) joins refinement (no Hemant/Sagar silo). Speaker-resolution + user-revoke stories move to MeetingsPod. Lalit to set up a shared Google Drive of sample 1:1 transcripts for Hemant's POC.

**Implication for ranking:** First firm summer-vs-winter scope boundary + ownership model; creates new standing PM obligations (epic rename, Phase-2 Aha epic, Confluence split, story decomposition).

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

### 2026-05-18 — slack
- **Who:** Sriram CS
- **Where:** [#pod-meetings](https://betterworks.slack.com/archives/C035AAZ5P6H/p1779100845297159)
- **Summary:** Asked Anuj Pancholi to discuss the meeting transcript feature design with Lalit and the designer (Sarah/Austine), signalling active cross-pod coordination on design handoff.

### 2026-05-19 — slack
- **Who:** Nellie LeMonier
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1779137966414569)
- **Summary:** Proposed using Zoom's MCP server to ingest per-user transcripts as an alternative to vendors like Unified.to, citing a successful personal proof-of-concept via Claude → Zoom MCP (filtered by day/meeting name, extracted action items and summary).

### 2026-05-19 — slack
- **Who:** Sriram CS
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1779192068406249)
- **Summary:** Pinged Anuj Pancholi and Danish Sharma to review and comment on Nellie's Zoom MCP proposal.

### 2026-05-19 — slack
- **Who:** Danish Sharma
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1779195019575879)
- **Summary:** Rejected Zoom MCP as the ingestion mechanism — product requires multi-user background fetching with persistent token management, webhook listeners, and job queues that MCP cannot provide; reframed the architectural decision as direct provider APIs vs. Unified.to, not MCP vs. either.

### 2026-05-20 — slack
- **Who:** Nataliya Kolb
- **Where:** [Group DM — Paul Agustin, Sarah Brose, Austine Joy, Nataliya Kolb, Nellie LeMonier, Lalit](https://betterworks.slack.com/archives/C0B2ZDJ5K2R/p1779221811906849?thread_ts=1779221811.906849&cid=C0B2ZDJ5K2R)
- **Summary:** Sales/CS request to (1) manually add transcript notes from Zoom or Gong calls, and (2) create retroactive historical 1:1 records for meetings that happened outside Betterworks (e.g., Slack huddles, ad hoc calls).

### 2026-05-20 — slack
- **Who:** Austine Joy
- **Where:** [Group DM — Paul Agustin, Sarah Brose, Austine Joy, Nataliya Kolb, Nellie LeMonier, Lalit](https://betterworks.slack.com/archives/C0B2ZDJ5K2R/p1779271731147669?thread_ts=1779221811.906849&cid=C0B2ZDJ5K2R)
- **Summary:** Confirmed manual transcript input will be added to v1; Meetings engineering team completed a refinement call and will begin development soon.

### 2026-05-22 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread — subject "Meeting assets for Meetings Transcript - Daily Catchup are ready!" (thread 19e4ad7896a8efc7)
- **Summary:** Zoom delivered meeting recap for the daily ENG-79199 sync; recap notes the session focused on synchronizing progress and addressing blocking issues on a story.

### 2026-05-25 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Lalit Maharana / Varnika Garg](https://betterworks.slack.com/archives/D0B2L15AY2W/p1779679800158759)
- **Summary:** Lalit DM'd Varnika Garg to (1) request help pulling Metabase usage data for shared notes, private notes, rollover action/agenda items, and admin-edited items, and (2) sync on the meetings transcript story progress.

### 2026-05-25 — slack
- **Who:** Anuj Pancholi
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1779714397168189)
- **Summary:** Raised Zoom account registration blocker — Betterworks emails cannot register new Zoom accounts; proposed creating Gmail IDs as a workaround to enable testing; awaiting confirmation from Pankaj and Danish.

### 2026-05-25 — slack
- **Who:** Anuj Pancholi
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1779716713396459)
- **Summary:** Shared Google Sheets with prodUS and prodEU anon DB stats on meeting instances, providing token-processing baseline data for the AI team.

### 2026-05-25 — slack
- **Who:** Hemant Kumar
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1779724016268189)
- **Summary:** Shared documentation on how Goal Assist fetches data from three nextgen services (Goals, Feedback, Conversations) and persists it into dsml.llm_user_prompts, with direct code links (file paths and line numbers) in the llm-engine repo.

### 2026-05-25 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread — subject "Meeting assets for Meetings Transcript - Daily Catchup are ready!" (thread 19e5f61e7907f269)
- **Summary:** Zoom AI recap of May 25 daily catchup; key decisions: Zoom API lacks per-speaker IDs so a bot (Fireflies/Recall) is required for attribution; Unified excluded as pass-through only; baseline data scope set at 1 year; Prasanna flagged accuracy risk (wrong speaker ID → wrong goal assignment). Actions: Anuj to share token stats, Hemant to share DB docs, Pankaj to share sample transcript, Danish to evaluate Recall/Unified.

### 2026-05-26 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread — subject "Meeting assets for Lalit / Nellie 1:1 are ready!" (thread 19e647c275e41cbb)
- **Summary:** Zoom AI recap of May 26 Lalit/Nellie 1:1; Lalit presented 49 categorized AHA tickets for meetings/transcripts features consolidated into 15–18 ranked stories; Nellie shared Gong customer research on manager pain points; AI story and Zoom integration confirmed as critical-path MVP items; agreed Lalit will align with Varnika (meetings pod PM) to avoid overlap and co-create roadmap.

### 2026-05-26 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19e648f0ec161e83 — "Meeting assets for Meetings Transcript - Daily Catchup are ready!"
- **Summary:** Daily ENG-79199 catchup focused on discussing implementation of an AI system to generate user recommendations from meeting transcripts.

### 2026-05-27 — slack
- **Who:** Lalit Maharana
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1779866939205349)
- **Summary:** Shared WIP Confluence PRD for AI Processing Pipeline for Meeting Transcripts Phase 1 (Zoom as source, meeting items + goals nudges) with the channel for team visibility.

### 2026-05-27 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Harshini Vijay](https://betterworks.slack.com/archives/D0B58DS1W1K/p1779867082596929)
- **Summary:** Shared Confluence PRD link for AI Processing Pipeline for Meeting Transcripts Phase 1 directly with Harshini Vijay.

### 2026-05-27 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19e685581e77fbb1 — "Meeting assets for Meetings Backlog / Usage Data are ready!"
- **Summary:** Lalit + Varnika synced on usage data access (Metabase/Mixpanel credential issues), meeting transcript roadmap status (most items in planning/dev, resource constraints with Anuj split across goals + meetings), and UI redesign plans — Varnika flagged information density risk for new users.

### 2026-05-27 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19e68db3df86e116 — "Meeting assets for Meeting Transcript - Refinement are ready!"
- **Summary:** Architecture refinement call: team aligned on recommendation system design (Zoom transcripts → goals/action items/agenda/recognition queue); key decisions: priority levels over complex re-ranking, 1 fiscal year window for goals, 3-month window for recognition, Sagar's team owns architecture freeze and LLM engine integration.

### 2026-05-27 — slack
- **Who:** Sagar Bhat
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1779885872544779)
- **Summary:** Flagged he'll miss the meeting transcript sync due to a home situation; asked Lalit to confirm if anything changed from the plan discussed earlier that day.

### 2026-05-27 — slack
- **Who:** Tejas S
- **Where:** [DM — Lalit Maharana](https://betterworks.slack.com/archives/D0B2C9ECV4Y/p1779888396295609)
- **Summary:** Flagged he'll miss the meetings transcript call; noted he's working on Synopsys regression dashboard; asked Lalit to surface anything requiring his attention.

### 2026-05-29 — slack
- **Who:** Harshini Vijay, Lalit Maharana
- **Where:** [DM](https://betterworks.slack.com/archives/D0B58DS1W1K/p1780036106277139)
- **Summary:** Harshini clarified two mutually exclusive transcript scenarios (Zoom-connected = auto-sync, no manual upload; Zoom-not-connected = manual upload only); Lalit confirmed Zoom takes precedence, attachments should split into "meeting transcript" vs "notes/files" types, and past meetings will allow manual transcript attachment since old Zoom meetings won't retroactively sync.

### 2026-06-01 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Sagar Bhat](https://betterworks.slack.com/archives/D0B1WU4C08Z/p1780297180379059)
- **Summary:** Lalit reached out to Sagar Bhat to set up a sync on meeting transcripts.

### 2026-06-01 — slack
- **Who:** Rinku Ravi
- **Where:** [DM — Lalit Maharana](https://betterworks.slack.com/archives/D0B19L7D33M/p1780310988720169)
- **Summary:** Rinku asked whether user stories have been designed for Meeting Transcripts yet.

### 2026-06-01 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Rinku Ravi](https://betterworks.slack.com/archives/D0B19L7D33M/p1780313871677389)
- **Summary:** Lalit shared that ENG-82387 has been created so far, and flagged he still needs to discuss meeting-related stories with Anuj and Pankaj.

### 2026-06-02 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Sagar Bhat](https://betterworks.slack.com/archives/D0B1WU4C08Z/p1780378903603759)
- **Summary:** Lalit sent Sagar Bhat the ENG-79199 Jira link directly — likely active follow-up coordination after their June 1 sync to align on engineering scope.

### 2026-06-03 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1780489868706839)
- **Summary:** Sagar flagged he'd miss today's transcript connect; confirmed AI team walkthrough complete and POC for transcript processing is now underway.

### 2026-06-03 — slack
- **Who:** Lalit Maharana
- **Where:** [Group DM (Anuj Pancholi, Varnika Garg)](https://betterworks.slack.com/archives/C0B5XMSN155/p1780429179795989)
- **Summary:** Lalit shared detailed UI states spec for meetings/transcripts (object states per story, added to Confluence) and requested Varnika Garg review for coverage gaps.

### 2026-06-02 — gmail
- **Who:** Zoom (no-reply@zoom.us)
- **Where:** Email — "Meeting assets for Meetings Transcript - Daily Catchup are ready"
- **Summary:** Zoom meeting summary and action items from the June 2 Meetings Transcript Daily Catchup are available; recap mentions AI implementation discussions.

### 2026-06-03 — gmail
- **Who:** Sagar Bhat
- **Where:** Calendar — "Meetings Transcript - Daily Catchup" (Wed Jun 3 @ 7pm IST)
- **Summary:** Sagar Bhat declined the Meetings Transcript Daily Catchup meeting for June 3.

### 2026-06-03 — gmail
- **Who:** Nellie LeMonier
- **Where:** Calendar — "Meetings Transcripts - UX Sync" (Wed Jun 3 @ 11pm IST)
- **Summary:** Nellie LeMonier accepted the Meetings Transcripts UX Sync meeting scheduled for tonight.

### 2026-06-03 — gmail
- **Who:** Sarah Brose
- **Where:** Calendar — "Meetings Transcripts - UX Sync" (Wed Jun 3 @ 11pm IST)
- **Summary:** Sarah Brose accepted the Meetings Transcripts UX Sync meeting scheduled for tonight.

### 2026-06-03 — gmail
- **Who:** Cheryl Johnson (via Aha notification)
- **Where:** Email thread 19e8ebb06d193156 — "[AHA] Cheryl Johnson updated feature: AI Processing Pipeline for Meeting Transcripts"
- **Summary:** Cheryl Johnson (CPTO) updated the AI-201 feature record in Aha, signalling active executive-level engagement with the meeting transcripts pipeline.

### 2026-06-04 — slack
- **Who:** Anuj Pancholi
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1780555212521689)
- **Summary:** Asked Lalit to include Brahadeesh in all calls for this initiative; Brahadeesh will help Anuj with meetings-service engineering effort and contribute to plan/architecture discussions.

### 2026-06-04 — slack
- **Who:** Anuj Pancholi
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1780575460420809)
- **Summary:** Missed today's call; no new blockers; currently doing code review of calendar-integration PR to get conferencing data from calendar events.

### 2026-06-05 — slack
- **Who:** Hemant Kumar
- **Where:** #meeting-transcript-integration
- **Summary:** Missed today's catchup; working on quality testing the prompt for transcript processing and action item generation.

### 2026-06-05 — slack
- **Who:** Hemant Kumar
- **Where:** #pod-ai-platform
- **Summary:** Running small-scale Gemma tests (one meeting transcript), hitting max token limit; planning a load test to determine max concurrent request capacity.

### 2026-06-05 — slack
- **Who:** Lalit Maharana
- **Where:** DM — Pankaj Lohmor
- **Summary:** Asked Pankaj to create Jira stories per the meeting transcript plan.

### 2026-06-05 — slack
- **Who:** Lalit Maharana
- **Where:** DM — Rinku Ravi
- **Summary:** Shared a Google doc link (likely stories/planning doc for transcript feature) with Rinku.

### 2026-06-05 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19e92dbb11541e4b — "Meeting assets for Meetings Transcript - Daily Catchup are ready!"
- **Summary:** POC findings: context limit ~60k tokens (~1h meeting), 25s inference latency; Hemant applied schema-first prompting and 7 other techniques; next steps are LM-as-judge quality eval (Tejas to advise on GPT-5 with temp=0) and load testing.

### 2026-06-05 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19e939793d054869 — "Meeting assets for Nellie / Lalit - Roadmap priorities are ready!"
- **Summary:** Duplicate Aha ticket for "transmit from external meeting tools" flagged for closure; Lalit to link it to the correct AI processing pipeline ticket (ENG-79199).

### 2026-06-08 — slack
- **Who:** Lalit Maharana
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1780900025482199)
- **Summary:** Lalit posted ENG-79199 link in the channel sharing that stories and related epics have been structured and detailed, inviting team to discuss and plan.

### 2026-06-08 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Harshini Vijay](https://betterworks.slack.com/archives/D0B58DS1W1K/p1780900615080239)
- **Summary:** Lalit DM'd Harshini Vijay with ENG-79199 link; newly added stories ready to discuss.

### 2026-06-08 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Varnika Garg](https://betterworks.slack.com/archives/D0B2L15AY2W/p1780900638302939)
- **Summary:** Lalit DM'd Varnika Garg with ENG-79199 link; requested her review and suggestions on newly added stories.

### 2026-06-09 — slack
- **Who:** Anuj Pancholi
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1780986658445869)
- **Summary:** Following yesterday's call, raised two Zoom OAuth approaches for user-level transcript consent: (1) Zoom app with user-level OAuth, (2) Zoom app with admin-managed org-level OAuth + BW-managed user consent. Flagged that auth-proxy expertise (Danish / Integrations) is needed to pick; followed up asking whether the meetings service can call Zoom APIs for transcript download via auth-proxy without needing the user's token directly. Tagging Danish Sharma and Lalit to connect.

### 2026-06-09 — slack
- **Who:** Sagar Bhat
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1780981949949849)
- **Summary:** Standup update: discussed meeting transcript POC results and strategy with Hemant; planning next steps with Tanveer today for AI team handoff.

### 2026-06-09 — gmail
- **Who:** Jira Automation (jira@betterworks.atlassian.net → lalit.maharana@betterworks.com)
- **Where:** Email thread 19ea784d08ff7c94 — "[JIRA] (ENG-79199) AI Processing Pipeline for Meeting Transcripts"
- **Summary:** Jira automation set start date on ENG-79199 to 2026-06-08, signalling the epic is now formally open for work scheduling.

### 2026-06-10 — slack
- **Who:** Hemant Kumar
- **Where:** [Group DM — Sagar Bhat, Hemant Kumar, Lalit Maharana](https://betterworks.slack.com/archives/C0B7KG9AZQV/p1781067440411349)
- **Summary:** Shared LLM quality evaluation prompt (JUDGE_SYSTEM) for scoring meeting transcript AI outputs on completeness, accuracy, summary quality, and third-speaker attribution — signals active AI quality work for the pipeline.

### 2026-06-10 — gmail
- **Who:** Anuj Pancholi (via Jira)
- **Where:** Email thread 19eacc61652f7b5c — "[JIRA] (ENG-82992) Spike: AI surface contract, meeting lifecycle infrastructure & state model"
- **Summary:** Anuj posted 4 detailed spike comments on ENG-82992 covering I/O contracts for post-meeting processing, pre-meeting brief, meeting lifecycle infrastructure, and meeting page rendering architecture.

### 2026-06-10 — gmail
- **Who:** Zoom (no-reply@zoom.us)
- **Where:** Email thread 19eb118477d54ba1 — "Meeting assets for Meeting Transcripts - Refinement are ready!"
- **Summary:** Zoom recap of refinement call where team reviewed all 7 epic stories for the transcript integration project.

### 2026-06-10 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781095674335789)
- **Summary:** Clarified AI pipeline architecture: REST API endpoints (not EDA listeners) will trigger insight generation; flagged that current ingestion is .txt upload to S3 and asked whether multi-source extensibility requires a different approach.

### 2026-06-10 — slack
- **Who:** Danish Sharma
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781092573478839)
- **Summary:** Confirmed design direction looks good; will be sharing HLD for the webhook gateway soon.

### 2026-06-10 — slack
- **Who:** Rinku Ravi
- **Where:** [DM — Lalit Maharana](https://betterworks.slack.com/archives/D0B19L7D33M/p1781075210145209)
- **Summary:** Asked whether a dedicated standup exists for meeting transcripts; flagged integration-side delivery as a concern to watch.

### 2026-06-11 — slack
- **Who:** Lalit Maharana
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781165179184129)
- **Summary:** Shared meeting-states reference document with Anuj Pancholi to guide engineering implementation of meeting lifecycle state transitions ("Download and open in browser, this covers the different states of meetings").

### 2026-06-15 — slack
- **Who:** Lalit Maharana
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781530094707919?thread_ts=1781523006.582699&cid=C0ACYVAG5A8)
- **Summary:** Lalit pinged Sagar Bhat, Danish Sharma, and Anuj Pancholi in standup thread asking for progress updates on contract documentation — signals contract spec is now the active blocker being tracked.

### 2026-06-15 — gmail
- **Who:** Hemant Kumar (via Jira ENG-82389)
- **Where:** Email thread 19ecb061612c2d13 — "[JIRA] Hemant Kumar mentioned you on ENG-82389"
- **Summary:** Hemant confirmed quality milestone on the transcript POC: LLM achieves accurate source captioning with timestamps; shared speaker-attributed action item JSON from a real meeting (Sagar Bhat confirmed as owner of dummy API contract + Bhavesh loop-in for response structure finalization).

### 2026-06-15 — gmail
- **Who:** Anuj Pancholi (via Jira ENG-82992)
- **Where:** Email thread 19eacc61652f7b5c — "[JIRA] (ENG-82992) Spike: AI surface contract, meeting lifecycle infrastructure & state model"
- **Summary:** Anuj updated the post-meeting I/O contract comment in the ENG-82992 spike — active engineering documentation of the AI surface API contract is ongoing ahead of dummy API handoff to meetings team.

### 2026-06-16 — slack
- **Who:** Prasanna Poojary
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1781589004503929)
- **Summary:** Prasanna called the team to review Meeting Transcripts Epic tickets ahead of a 3pm story-pointing session, asking members to come prepared with questions for Lalit.

### 2026-06-16 — slack
- **Who:** Tanveer Farooq
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781592143010799)
- **Summary:** Tanveer scheduled a 4:30pm team alignment call to review high-level items (attendees: Sagar, Anuj, Lalit, Pankaj, Danish, Sriram).

### 2026-06-16 — slack
- **Who:** Anuj Pancholi
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781607336644569)
- **Summary:** Anuj shared a Google Doc in the channel ahead of the 4:30pm alignment call (likely architecture or design spec).

### 2026-06-16 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781611668063139)
- **Summary:** Sagar shared three Claude.ai design prototypes — Zoom Integration Flow, Meetings AI page UI, and Create Goal Flow — posted after the 4:30pm alignment call.

### 2026-06-16 — gmail
- **Who:** Tanveer Farooq (invite to lalit.maharana@betterworks.com et al.)
- **Where:** Email thread 19ecf29953d6cb08 — "Invitation: Project Plan | Meeting Transcript @ Tue Jun 16, 2026 4:30pm – 5pm (IST)"
- **Summary:** Calendar invite for "Project Plan | Meeting Transcript" team sync Jun 16 4:30–5pm IST; attendees include Sriram, Anuj, Pankaj, Sagar, Danish, and Lalit.

### 2026-06-17 — slack
- **Who:** Danish Sharma
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781695833385089)
- **Summary:** Danish announced PTO June 18–24 (key delivery risk: Zoom OAuth implementation lead out for a week); offered to share the authn-proxy branch link covering Zoom OAuth setup with Anuj Pancholi by EOD today.

### 2026-06-18 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Harshini Vijay](https://betterworks.slack.com/archives/D0B58DS1W1K/p1781774945153469)
- **Summary:** Lalit sent detailed QA/UX feedback to Harshini Vijay on the Meetings flow — flagging missing transcript while AI prep icon is shown, checkbox design issues in agenda and action items, missing delete/refetch transcript options, inconsistent zoom icon states across meeting types, and action item completion discrepancy vs. goal creation flow.

### 2026-06-19 — slack
- **Who:** Nellie LeMonier
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1781822492948249)
- **Summary:** Nellie reassigned the Webhook spike (ENG-82678) to Okan, who has bandwidth to explore and build out the capability; Danish is on PTO Jun 18–24 (Zoom OAuth lead absent for a week), making this handoff timely.

### 2026-06-22 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782109493847029)
- **Summary:** Sagar flagged he'll miss today's standup — third consecutive standup absence flagged in this channel (Jun 3, Jun 9 pattern); Danish still on PTO, so two senior leads are simultaneously unavailable today.

### 2026-06-24 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19ef592c2dbdfe94 — "Meeting assets for Lalit / Nellie 1:1 are ready!"
- **Summary:** Lalit/Nellie 1:1 (Jun 23): Lalit mentioned receiving a contract for meeting transcripts covering through July, and flagged feeling slow on progress with integrations and meetings teams; Nellie offered support.

### 2026-06-25 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Harshini Vijay](https://betterworks.slack.com/archives/D0B58DS1W1K/p1782364900125659)
- **Summary:** Lalit flagged a #meeting-transcript-integration thread to Harshini noting the team "seems confused" — possible alignment gap on AI Meeting Prep spec requiring Lalit/Harshini follow-up.

### 2026-06-25 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782372946300089)
- **Summary:** Sagar posted a detailed AI Meeting Prep + Meeting Recap schema proposal: Meeting Prep pulls last 4 meetings, is persona-specific (manager gets coaching_cards/attention_flags/goal_signals; peers/direct-reports get my_wins/my_commitments/recurring_topics), and is refreshable; Meeting Recap uses per-meeting transcript data in persona-agnostic structured format. TODO: Lalit and Harshini to decide which keys to surface in the UI.

### 2026-06-25 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Jason Sites](https://betterworks.slack.com/archives/D0BD2S67MUJ/p1782374724075319)
- **Summary:** Lalit reached out to Jason Sites asking (1) whether an endpoint exists to search users by skills and proficiency levels to surface mentors within an org, and (2) whether current skill/proficiency data per user can be fetched — to power skill recommendations derived from meeting transcripts, Slack conversations, and Jira updates.

### 2026-06-26 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Tanveer Farooq](https://betterworks.slack.com/archives/D0B90D9LQ74/p1782461986469199)
- **Summary:** Lalit asked Tanveer to add end dates to meeting transcript tasks and share status with Sriram — signals active timeline management on ENG-79199.

### 2026-06-29 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782721102536089)
- **Summary:** Sagar raised a UX question about three separate refresh buttons (for meeting prep, recap, and recommendations), questioning whether a single unified refresh would be less confusing; thread resolved with Lalit confirming a unified refresh that updates all stale AI-connected parts at once is the right direction.

### 2026-07-01 — gmail
- **Who:** Tanveer Farooq (tanveer.farooq@betterworks.com)
- **Where:** Email thread 19f171135767e994 — "Updated invitation: Daily Scrum | Meeting Transcript @ Weekly from 12pm to 12:30pm on weekdays"
- **Summary:** Daily standup for meeting transcript formalized as a weekly recurring scrum (Mon–Fri, 12–12:30pm IST) starting Jun 29; full cross-pod attendee list (Harshini, Anuj, Pankaj, Prasanna, Sagar, Danish, Varnika, Hemant) — signals structured delivery cadence is now in place.

### 2026-07-01 — gmail
- **Who:** Tanveer Farooq (tanveer.farooq@betterworks.com)
- **Where:** Email thread 19f17440d4c52779 — "Invitation: Estimations | Meeting Transcript @ Tue Jun 30, 2026 3:30pm – 4pm (IST)"
- **Summary:** Tanveer scheduled an estimations call for the meeting transcript epic with Lalit, Hemant, Anuj, Sagar, Danish, and Hiten — signals active sprint planning and story-pointing effort is underway.

### 2026-07-01 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782889916781049)
- **Summary:** Asked Anuj Pancholi to share transcript pre-processing validation details that the meetings team will apply before passing data to AI for recommendation generation.

### 2026-07-01 — slack
- **Who:** Anuj Pancholi
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782890101487809)
- **Summary:** Outlined transcript validation plan: MIME type (vtt/txt), max 5 MB file size, valid VTT with speaker tags, unique speaker tags attributed to BW users in metadata; not yet implemented.

### 2026-07-01 — slack
- **Who:** Lalit Maharana
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782891054483569)
- **Summary:** Flagged edge states to document and handle in transcript processing: multiple transcripts, more than 2 participants, dropped-meeting (half transcript), and conference room device joining.

### 2026-07-01 — slack
- **Who:** Lalit Maharana
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782891406248169)
- **Summary:** Clarified AI generation logic: upcoming meetings → generate Prep + Recap + Recommendations; past meetings with added/updated transcript → generate Recap only (refresh Prep and Recommendations if doable). Tagged Anuj Pancholi and Sagar Bhat.

### 2026-07-01 — slack
- **Who:** Lalit Maharana
- **Where:** [DM — Harshini Vijay](https://betterworks.slack.com/archives/D0B58DS1W1K/p1782890631904329)
- **Summary:** Asked Harshini to address remaining Figma design gaps: past meetings transcript flow (full CRUD), AI component feedback elements (like/dislike/copy), and combined Zoom and meeting updates view.

### 2026-07-01 — slack
- **Who:** Varnika Garg
- **Where:** [Group DM — Varnika Garg, Harshini Vijay, Lalit Maharana](https://betterworks.slack.com/archives/C0B8WG1RRP0/p1782895058105479)
- **Summary:** Active design review thread for overall meetings transcript designs — Varnika, Harshini, and Lalit collaborating on design coverage.

### 2026-07-01 — slack
- **Who:** Hemant Kumar
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782902008622149)
- **Summary:** Asked Tanveer to share the tracker sheet with the AI team to help keep transcript work on track — signals need for shared progress visibility across pods.

### 2026-07-02 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1782975148017229)
- **Summary:** Clarified refresh semantics in standup thread: Recap is persona-agnostic and refreshes for all users simultaneously; Prep and Recommendations are persona-specific and refresh only for the requesting user — key design decision now documented in channel.

### 2026-07-02 — slack
- **Who:** Lalit Maharana
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1782985152219739)
- **Summary:** Posted <!here> in #pod-ai-platform inviting Sagar and Hemant to today's scrum to discuss the AI meeting transcripts plan and architecture and share status updates asynchronously before the call.

### 2026-07-02 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f2230bda469668 — "Meeting assets for Sagar / Lalit are ready!"
- **Summary:** Sagar/Lalit sync: Sagar is designing DB schema for transcript management (series+instance IDs, transcript-source enum, hash to avoid reprocessing); Hemant integrating transcript processing pipeline; Sagar to create dummy APIs by evening to unblock meetings pod; target August production release; Lalit to clarify scope of learning recommendation engine work with Nitish.

### 2026-07-02 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f2178b570ee52b — "Meeting assets for Hemant / Lalit are ready!"
- **Summary:** Hemant/Lalit catch-up: Hemant confirmed transcript implementation has started; team split suggested as 80% AI team work / 20% misc; Lalit to focus on meeting transcripts in July; Hemant tracking 3 Jira tickets for prompt migration to DB (running in parallel with Gemma upgrade).

### 2026-07-02 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f21b9876d830cf — "Meeting assets for Tanveer / Lalit are ready!"
- **Summary:** Tanveer/Lalit intro sync: Tanveer manages 4 teams including meeting transcripts; confirmed dev-complete and tested by August 15 for summer release; Lalit to support hackathon in person; Tanveer to schedule requirements call next week.

### 2026-07-02 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f2169cb36d112f — "Meeting assets for Aakansha / Lalit are ready!"
- **Summary:** Aakansha/Lalit status sync: discussed AI processing pipeline for meeting transcripts and skill-to-learning matching; Aakansha flagged tokenizer implementation risk — suggested validating and potentially removing the tokenizer before full build to avoid blockers; Lalit working on Gemma upgrade and LLM prompt management in parallel.

### 2026-07-03 — slack
- **Who:** Laurie Hawco
- **Where:** [#ask_rypple](https://betterworks.slack.com/archives/)
- **Summary:** Gen 3 "Meetings" page shipped in Ask Rypple — AI-powered meeting prep and commitment tracking across Today/My Schedule/Completed sections; stats bar shows meetings, commitments (including overdue); AI insights surfaced per meeting with voice+text continuity and Slack integration. Signals internal bar for meeting intelligence UX that AI-201 will need to match or exceed.

### 2026-07-06 — slack
- **Who:** Lalit Maharana
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1783342118000819)
- **Summary:** Lalit shared a Google Doc capturing consent, sensitivity, data-availability, and user-expectation scenarios for meeting transcripts (post-catchup); tagged Sagar, Hemant, Anuj, and Harshini Vijay for discussion in next catchup — input required before Sagar's prompt-engineering can proceed.

### 2026-07-06 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f3886584065824 — "Meeting assets for Integrations/AI Cross Team Sync are ready!"
- **Summary:** First weekly alignment call for summer projects between the integrations and AI teams; meeting summary and action items now available in Zoom.

### 2026-07-06 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f38610c62f7d73 — "Meeting assets for Lalit / Nellie 1:1 are ready!"
- **Summary:** Nellie and Lalit discussed several tactical items and goals for AI projects; meeting summary and action items now available.

### 2026-07-07 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f3b46a633d2b8e — "Meeting assets for Meetings AI Jira Realignment are ready!"
- **Summary:** Hemant and Lalit discussed implementation of consent-based data processing for meeting transcripts; Jira realignment session with action items now available.

### 2026-07-06 — Lalit/Nellie 1:1 (zoom)
**Source:** Zoom — "Lalit / Nellie 1:1" 2026-07-06 (UUID 22045743-D219-45C6-AA3D-E13DB53C05F1)
**Type:** commitment
**Owner-impact:** Lalit, Nellie, Brian Jacobs (InfoSec)

Lalit and Nellie kicked off the InfoSec review process for meeting-transcript consent: document consent/wording on Confluence, then send to Brian Jacobs (Head of InfoSec) for review ahead of the summer release, following the same process used for MCP; a walkthrough with the architect (and Nellie) will follow. Separately, webhook-ownership scope was clarified — AI-specific features (meeting transcripts, TechWolf, PDP) must be covered by the inbound webhook framework regardless of which team builds it, with Lalit driving clarity on what the integration team delivers.

**Implication for ranking:** InfoSec sign-off is now a named, scheduled gate ahead of summer release — track alongside the transcript delivery timeline; webhook ownership ambiguity (integration team vs. Okan's spike vs. AI team) remains unresolved and worth flagging in refinement.

### 2026-07-07 — Meetings AI Jira Realignment (zoom)
**Source:** Zoom — "Meetings AI Jira Realignment" 2026-07-07 (UUID 05F5F260-81F1-4BBC-8993-F70275DAF83E)
**Type:** scope-decision
**Owner-impact:** Hemant, Lalit, InfoSec

Hemant and Lalit locked the consent model for recap/prep generation: full consent required for any transcript-derived recap (any non-consenting participant excludes the transcript); notes/agenda/action items are generated implicitly and aren't consent-gated; an unplanned third-party join discards the entire recap; retroactive consent has no backfill; revoked consent halts future generation but retains past artifacts pending InfoSec confirmation. Recommendations will no longer use the transcript at all — structured meeting data only. A series/instance-level sensitivity flag is under consideration, and edge-case work is estimated at 7–9 days.

**Implication for ranking:** Consent architecture is now concrete enough to unblock Sagar's prompt-engineering and Hemant's parsing work; InfoSec confirmation on retention policy is the remaining hard dependency before edge-case implementation starts.

### 2026-07-07 — gmail
- **Who:** Danish (via Zoom AI summary)
- **Where:** Zoom meeting "Webhooks" (email to lalit.maharana@betterworks.com)
- **Summary:** Danish reviewed his implementation of a webhook gateway service as a platform component — this is the inbound webhook for the transcripts ingestion pipeline (provider events → Kafka).

### 2026-07-08 — gmail
- **Who:** Harshini Vijay, Anuj Pancholi (via Zoom AI summary)
- **Where:** Zoom meeting "Lalit Maharana's Zoom Meeting" (email to lalit.maharana@betterworks.com)
- **Summary:** Harshini, Lalit, and Anuj discussed implementation of Zoom transcript integration; full meeting assets and action items available in Zoom.

### 2026-07-08 — slack
- **Who:** Anuj Pancholi
- **Where:** [#pod-meetings](https://betterworks.slack.com/archives/C035AAZ5P6H/p1783486970169059)
- **Summary:** Standup update: merging PRs in code review for meetings transcripts, actively working on transcripts tasks, one deployment issue in calendar service to resolve.

### 2026-07-08 — slack
- **Who:** Sagar Bhat
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1783492874540969)
- **Summary:** Transcript standup check — Sagar pinged the channel to confirm standup attendance; thread has 5 replies suggesting discussion proceeded.

### 2026-07-08 — slack
- **Who:** Harshini Vijay
- **Where:** [#meeting-transcript-integration](https://betterworks.slack.com/archives/C0ACYVAG5A8/p1783510224923099)
- **Summary:** Three open design questions raised for Lalit and Anuj on Zoom connected-state behavior: (1) should manual upload be allowed when Zoom is connected? (2) what happens when two transcripts exist (Zoom + manual)? (3) confirmation needed on delete-Zoom-transcript and re-sync flow.

### 2026-07-07 — Webhook gateway architecture reviewed; positioned as shared platform component (zoom)
**Source:** Zoom — "Webhooks" 2026-07-07 (UUID E8683DD9-A5A8-409E-B39A-0B8A2D56276F)
**Type:** architecture
**Owner-impact:** Danish, Okan, Nellie, JB (App Platform), Sagar, Hemant

Danish walked the team through the inbound webhook gateway service that AI-201's Zoom transcript ingestion depends on: an auth-proxy-managed layer that issues unique webhook URLs/credentials per vendor-org for individually-provisioned vendors (Docebo, LinkedIn Learning), but requires manual CLI provisioning for Zoom's shared-webhook/marketplace-app model. The gateway does enrichment, Redis-based deduplication, and CRC handshake for Zoom, publishing to internal Kafka topics without schema validation (deferred, to keep latency low). Okan pushed for aligning the event schema to Cloud Events standards and flagged that Zoom's shared-webhook pattern (vs. per-org webhooks used by other vendors) may need a JIRA ticket to formalize whether it's industry-standard or a one-off. Group agreed to position this as a reusable platform component, not a transcripts-only build.

**Implication for ranking:** Confirms the webhook gateway is now a cross-project dependency (transcripts + future integrations), raising the bar on review requirements — JB (App Platform) and InfoSec sign-off both needed before Danish's PR merges, which could add lead time to AI-201's transcript-ingestion critical path.

### 2026-07-08 — Three-level consent model locked; series-level checkbox deferred to follow-up; sensitive-flag + manual-upload flows designed (zoom)
**Source:** Zoom — "Lalit Maharana's Zoom Meeting" 2026-07-08 (UUID 30528AE0-B600-4415-8D59-F6C9827F296A)
**Type:** scope-decision
**Owner-impact:** Lalit, Harshini, Anuj, AI team (sensitive-flag regeneration)

Lalit, Harshini, and Anuj locked the consent model for Zoom transcript ingestion: org-level + user-level consent via the global "Connect Apps" side panel (covers all future series by default), plus a series-level "Sync meeting transcripts" checkbox (default ON, opt-out per series) — but the series-level checkbox is explicitly deferred until after core ingestion + AI insights ship, to avoid delaying delivery. Existing series get a Connect banner + confirmation pop-up rather than a full consent re-flow. A per-instance "sensitive" flag was designed: transcript is stored but never sent to AI, and if flagged post-ingestion, recap/prep get regenerated without that transcript (pending AI-team feasibility check). Manual upload when Zoom is connected only unlocks after the user deletes the Zoom transcript; multiple file uploads supported; upload/paste stays open both before and after meeting-end to avoid users forgetting.

**Implication for ranking:** Two open risks worth tracking for scope creep: (1) the Zoom-vs-manual-upload race condition (simultaneous arrival) has no finalized resolution strategy, and (2) sensitive-flag-triggered regeneration of recap/prep needs AI-team sign-off — both were pushed to a Lalit/Anuj follow-up later the same day rather than resolved in this session.

### 2026-07-08 — Webhook ownership resolved (India/AI team, not Integrations); JB+JZ review + InfoSec gate added; summer delivery reconfirmed (zoom)
**Source:** Zoom — "Nellie / Lalit" 2026-07-08 (UUID 01A86199-2B52-4C03-8F03-CBAB29BE3129)
**Type:** scope-decision + risk
**Owner-impact:** Lalit, Nellie, Danish, Okan, JB, JZ

Nellie resolved a cross-team friction point: the India/AI team (not Integrations) will own the inbound webhook implementation, closing out Okan's concern about being sidelined after his spike research. As a condition of moving forward, **JB and JZ (system architects) must both be added to the webhook PR review**, and an **InfoSec review is required before release** — formalizing the review gate already flagged in the 2026-07-07 Webhooks meeting. Lalit to nudge Danish to submit the PR and set up the review call, and to brief JB directly given the integrations team has been building without his visibility. Separately, Lalit reconfirmed to Nellie that the Zoom transcript feature is on track for summer delivery, with Sagar and Hemant doing one review round.

**Implication for ranking:** Adds two named-approver gates (JB, JZ) plus InfoSec sign-off ahead of merge — consistent with the 2026-07-07 entry's flagged risk, now confirmed as a hard requirement rather than a proposal. Worth tracking whether these reviews get scheduled promptly given Danish is the sole implementation owner.
