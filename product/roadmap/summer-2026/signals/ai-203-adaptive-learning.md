# AI-203 / ENG-80931 — AI-Powered Skill-to-Learning Matching Engine

**Aha:** `AI-203` (Tier E in Aha custom field, but scored highest: 10/8/10/10) · **Jira:** ENG-80931 (Draft, **unassigned**, 0 sprint pull)
**Owner:** Nellie (Aha) / **unassigned in Jira** ← largest delivery risk
**Composite score:** 34 (highest)
**Bucket:** P0

## Signals

> **2026-06-30 backfill** — entries below (2026-06-16 → 06-29) from Zoom AI-summaries of the Rec.-Architecture / PDP / Learning-Recommendations sessions. ("Learning Recommendations" 6/16, UUID 8DB0EFDD, had NO recorded assets.) These share the inference substrate + integration platform with [[ai-201-meeting-transcripts]].

### 2026-06-29 — Substrate + skill-graph strategy locked (direct LM inference server, Gemma 4 by Aug 10, 64K ctx; mentor matching SQL-first→graph)
**Source:** Zoom — "Rec. Architecture Sync-up" 2026-06-29 (UUID CDD007A8-BB42-489F-8DC7-021FD16F8CF9). AI summary digested.
**Type:** architecture
**Owner-impact:** Nellie, Sagar, Pankaj, Aryan, Nitish, Lalit

MVP inference path = **direct LM inference server endpoint** (LM Proxy bypassed — structured/function calling via LangChain not yet prod-ready), **Gemma 4 in production by ~Aug 10**, **64K context** default. Hybrid recommendation strategy: pre-generate per-(skill × proficiency) learning-path steps offline (LLM self-eval + human review before deploy), personalize/re-rank at runtime with user context. **Mentor matching: deterministic SQL first** (peers at ≥ proficiency), **skill graph with semantic embeddings later** for adjacency/career-path inference. End-to-end latency target ~5–10s worst case (Nitish to measure Gemma 4 + API). Only the user's selected LMS platform is queried at runtime. **Lalit owes spike stories** per component (skill graph, pre-processing, runtime generation).

**Implication for ranking:** Substrate de-risked; shares the exact stack decision with AI-201 (transcripts OPEN-D11). Aug 10 Gemma-4 prod date is the hard gate.

### 2026-06-23 — LLM-fallback recommendations always-on; ~10s LMS latency acknowledged; goal-conversion deferred
**Source:** Zoom — "PDP: AI Recommendation sync" 2026-06-23 (UUID C80A0846-7405-45DA-9369-528F730AC0B8). AI summary digested.
**Type:** scope-decision + architecture
**Owner-impact:** Nellie, Nataliya Kolb, Nataliia Savenko, AI team, Lalit

LLM-generated recommendations shown **always** — as default when LMS is off, and as a loading fallback while LMS fetches (~**10s** real-time latency); both render in the same UI location and are per-org configurable. **Summer MVP = happy path** (course selection + AI recommendation placeholder); converting AI recommendations into PDP/development goals **deferred** (open design hole — how to persist rec text into a goal without loss). Nellie proposed an internal **Talent API** endpoint queryable by the LLM for colleague skill proficiency (mentor recommendations); AI guardrails/anti-hallucination prompt work owned by AI team.

**Implication for ranking:** Expands the AI surface for summer (fallback always-on) while deferring goal-conversion to V2.

### 2026-06-22 — Unified /LMS endpoint live in sandbox; two-phase LLM (search-terms → re-rank); latency unmeasured
**Source:** Zoom — "Rec. Architecture Sync-up" 2026-06-22 (UUID 7AA19AFC-D66A-436C-9D28-FEA559D31DAE). AI summary digested.
**Type:** architecture + open-question
**Owner-impact:** Nitish, Rinku, AI team, Lalit

New `/LMS` endpoint (LinkedIn, Udemy, Docebo) returns standardized course data filterable by keyword + difficulty; LMS call latency ~ms but the **two-phase LLM overhead (generate search terms → re-rank) is unmeasured → dedicated latency spike required.** AI search terms use profile context, not just raw skill names. Docebo is org-internal-only (structurally weaker for broad discovery). Nitish to test `/LMS` against real customer tokens (via Rinku); sandbox catalog breadth may not be representative.

**Implication for ranking:** Integration plumbing exists; latency of the LLM-augmented flow is the open scalability question.

### 2026-06-19 — Transcripts = first validation use case for the new event-based integration platform; LMS = tech debt to migrate
**Source:** Zoom — "PDP - Integrations LMS work discussion" 2026-06-19 (UUID EAF87C52-0810-44CC-8448-E36D6B560867). AI summary digested. (Cross-posted to [[ai-201-meeting-transcripts]].)
**Type:** architecture + cross-team
**Owner-impact:** Pankaj, Nitish, Jason Sites, Danish, Okan, Lalit

Decoupled event-based integration platform is the strategic direction; existing LMS integrations become tech debt to migrate **after the new architecture is validated on meeting transcripts first**. Semantic-embedding (skills/competency) search agreed over text-based LMS search. **EOJ-2026 technical freeze** on contracts/protocols to protect August. Cross-functional team (Pankaj/Nitish/Emerson/AI/SDET/Okan/Danish); Monday 9:30 technical review (Jason Sites).

**Implication for ranking:** PDP/LMS recs now share webhook + AI-platform infra with AI-201 — coordination + Danish bandwidth are shared risks.

### 2026-06-16/23/29 — Nellie steering: PDP prototype is now a deliverable; 10/20/70 learning-plan framework; Talent API dependency; Custom Roles on hold pending Alex
**Source:** Zoom — "Lalit / Nellie 1:1" 2026-06-23 (UUID 2FE3D86A) + 2026-06-29 (UUID 25E15DB1) + "AI Projects Debrief" 2026-06-16 (UUID DB2BD344). AI summaries digested.
**Type:** stakeholder-position + scope
**Owner-impact:** Lalit, Nellie, Natalia (designer), Jason Seitz (Talent), JZ

Nellie elevated the **AI-recommendation prototype from exploratory to an expected deliverable** (goal-based learning suggestions + find-similar-skill users), gated on designs from **Natalia** (on leave — design-direction + token-usage discussion with Natalia + JZ deferred to her return). Confirmed **learning-plan framework: 10% study / 20% social / 70% practical projects** (courses → social → capstone w/ assessments). New cross-team dependency: a **privacy-preserving Talent-team skill-search API** (Lalit → Jason Seitz). Learning recommendations named the **next product track after transcripts**. PDP / Custom-Roles platform work **on hold pending Alex's return**.

**Implication for ranking:** AI-203 actively progressing under Nellie; key risks = Natalia's availability + the new Talent API dependency.

### 2026-05-13 — Scope decision: AI-generated guidance IS in v1 (Lalit)
**Source:** Lalit session 2026-05-13
**Type:** scope-decision (locked, pending refinement call confirmation)
**Owner-impact:** Lalit, Nellie, AI team, Sales (Nataliya)

V1 includes both LMS-content matching AND AI-generated guidance when LMS gaps exist. Aligns with Sales narrative already in market (Nataliya, Sony Interactive opp). Aha description needs widening to match.

**Implication for ranking:** Effort goes up (call it 5 vs original 4) → composite drops from 34 to 33 but still #1. Risk of unowned/unstaffed epic is now sharper.

### 2026-04-23 — Customer-facing framing has shifted: AI generates content when LMS gaps exist
**Source:** [Slack #oppty_sony_interactive](https://betterworks.slack.com/archives/) — Nataliya Kolb
**Type:** scope-decision (expanding)
**Owner-impact:** Product, Sales, AI team

> "We're still delivering AI-powered development plans and adaptive learning, just not framing them as traditional skills-gap analyses. Employees can get personalized upskilling guidance based on the skills they want to develop via LMS integrations, and if content isn't available, AI will generate practical guidance and next steps."

The Aha description is narrower (match employee skill gaps to LMS content). Sales is now positioning AI-generated guidance as a fallback when LMS doesn't have content. **Scope expansion via Sales narrative — not yet reflected in Aha or Jira.**

**Implication for ranking:** Already at P0; this expands effort. Need a scope-lock conversation before refinement.

### 2026-05-13 — No Jira assignee, no sprint pull, despite highest composite score
**Source:** Jira query (this session)
**Type:** risk
**Owner-impact:** Nellie, Lalit (during walkthrough)

ENG-80931 is unassigned and has zero open-sprint items. For the highest-scored Aha feature in the release, this is the gating delivery risk.

**Implication for ranking:** Either reaffirm P0 and resource it, or downgrade. Walking through Nellie.

### 2026-06-16 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19ecfaff3f721aa5 — "Meeting assets for Learning Recommendations are ready!"
- **Summary:** Zoom summary arrived for a "Learning Recommendations" meeting today; AI could not generate a summary due to insufficient transcript — signals the topic is being actively discussed in calls.

### 2026-06-19 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19ede613388803a2 — "Meeting Summary for PDP - Integrations LMS work discussion"
- **Summary:** Cross-functional sync (Sriram, Nitish, Jason Zhang, Pankaj, Rinku, Lalit) on LMS integration architecture for AI course recommendations: Jason flagged accuracy limitations of text-based search and proposed semantic embedding on skills/competencies; Nitish to deliver unified LMS endpoints (Udemy, LinkedIn, Docebo) in ~2 weeks; cross-functional team (AI + Integrations + Goals + SDET) formed; all technical decisions to freeze by end of June to protect August delivery timeline.

### 2026-06-22 — slack
- **Who:** Lalit Maharana (morning brief)
- **Where:** [Self-DM morning brief](https://betterworks.slack.com/archives/D0B0W25MMV2/p1782095691045329)
- **Summary:** "Rec. Architecture Sync-up" with Jason Zhang (10:00–10:45 PM IST tonight) appears on calendar but conflicts with Lalit/Nellie 1:1 (10:00–11:00 PM); one must be rescheduled — flags a scheduling risk against the end-of-June architecture-freeze deadline established in the Jun 19 LMS sync.

### 2026-06-23 — gmail
- **Who:** Nataliia Savenko (nataliia.savenko@betterworks.com)
- **Where:** Email thread 19ef2f708dabfd0c — "Invitation: PDP: AI Recommendation sync @ Tue Jun 23, 2026 8pm – 8:30pm (IST)"
- **Summary:** Calendar invite to Lalit, Nellie, and Nataliya Kolb for a 30-min AI Recommendation sync; stated purpose is to align on UI visuals and requirements for the scenario where a user has no LMS configured or no relevant courses are available — directly addresses the AI-generated guidance fallback path in AI-203 scope.

### 2026-06-23 — gmail
- **Who:** Nellie LeMonier (nellie.lemonier@betterworks.com via Google Drive)
- **Where:** Email thread 19ef27a7fed85ab6 — "Document shared with you: AI_Usage_Ratings_Report"
- **Summary:** Nellie shared a Google Doc "AI_Usage_Ratings_Report" with Lalit (CC: Jason Zhang, Tejas S); based on Tejas' data pull, Nellie conducted further analysis on AI usage ratings — likely a quality baseline or release readiness input for the recommendations engine.

### 2026-06-23 — gmail
- **Who:** Jason Zhang (jzhang@betterworks.com)
- **Where:** Email thread 19ef051172abdcdc — "Updated invitation: Rec. Architecture Sync-up @ Weekly from 10pm to 10:45pm on Monday (IST)"
- **Summary:** Jason Zhang updated the Rec. Architecture Sync-up to a weekly recurring Monday slot (10–10:45pm IST) — confirms the architecture sync for the recommendations engine is now a standing weekly cadence, resolving the one-time scheduling conflict flagged in the Jun 22 morning brief.

### 2026-06-24 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19ef592c2dbdfe94 — "Meeting assets for Lalit / Nellie 1:1 are ready!"
- **Summary:** Lalit/Nellie 1:1 (Jun 23): Discussed AI recommendation endpoint design for learning plans based on pre-fed user skills/goals context; Nellie flagged need for a new talent-team API to find users with similar skills (Jason Seitz to contact); Lalit proposed 70-20-10 holistic learning model (courses → social → capstone); action items: Lalit to fine-tune AI rec prototype and share with Nellie, and reach out to Jason Seitz on skills API privacy requirements.

### 2026-06-25 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19efe0b21f3eb13c — "Meeting assets for Pankaj <> Lalit Weekly Sync are ready!"
- **Summary:** Zoom summary for Pankaj <> Lalit weekly sync: discussed LMS course catalog architecture (per-customer vs. centralized, with latency/licensing tradeoffs), AI skills matching and assessment provider integration (Darwin Box, Lightcast), skill proficiency validation flow for managers, and self-service prompt management for AI-generated summaries; Pankaj to finalize course catalog approach; Lalit to share Agentic Framework case studies and work on standardizing business entities and custom role permissions.

### 2026-06-29 — slack
- **Who:** Nataliia Savenko / Nitish Devadiga
- **Where:** [#personalised-learning-development-feature](https://betterworks.slack.com/archives/C0B54QF5GR2/p1782732412563249)
- **Summary:** Nataliia shared the full end-to-end flow doc (Confluence) for the recommendations feature, requesting Pankaj review "technical confirmation needed" sections; Nitish confirmed AI+LMS integration side looks good but raised 3 open questions about the downstream goal-creation flow — (1) whether "Save PDP for skill" means goal-skill linking, (2) whether draft goal creation should use a modal rather than a background process, and (3) which goal structure to use when creating goals from selected courses (parent+milestone-per-course vs. parent with all courses). Nataliia confirmed all questions escalated to the goals team in a relevant spike.

### 2026-07-02 — slack
- **Who:** Nitish Devadiga
- **Where:** [#personalised-learning-development-feature](https://betterworks.slack.com/archives/C0B54QF5GR2/p1782978755663329)
- **Summary:** Shared Colab notebook implementing the two-phase LLM course recommendation pipeline (query generation + re-ranking) using unified LMS endpoints (LinkedIn + Udemy on rainforest); tested with Betterworks Gemma (~17 tok/s) and OpenAI GPT-5-nano (50–130 tok/s variable) — results available for team comparison and refinement.

### 2026-07-02 — slack
- **Who:** Nitish Devadiga
- **Where:** [#personalised-learning-development-feature](https://betterworks.slack.com/archives/C0B54QF5GR2/p1782979206171559)
- **Summary:** Posted benchmark results: GPT-5-nano with minimal reasoning = ~6s latency but hallucinates on re-ranking; GPT-5-nano with low reasoning for re-rank only = 13–15s, no hallucination; Gemma 4 = ~30–40s; re-ranking provides noticeable quality uplift; deterministic interleaved overlap with LLM re-rank is <50% — confirms re-ranking is worthwhile.

### 2026-07-02 — gmail
- **Who:** Nataliia Savenko (nataliia.savenko@betterworks.com)
- **Where:** Email thread 19f22de88a9a7f1f — "Invitation: PDP: AI Recommendation Performance and Latency @ Mon Jul 6, 2026 7:30pm–8pm (IST)"
- **Summary:** Nataliia scheduled a cross-functional sync (Nellie, Pankaj, Lalit, Rinku, Nataliya Kolb, Anastasiia Voronina, Nitish) for Mon Jul 6 to review Nitish's LLM spike results and decide on the latency strategy and Summer PDP scope — architecture decision gate now formally calendared.

### 2026-07-02 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f220d476d2e4c5 — "Meeting assets for Pankaj <> Lalit Weekly Sync are ready!"
- **Summary:** Pankaj/Lalit weekly sync: Lalit presented holistic 70-20-10 skill development plan for PDP (formal LMS courses, social/influencer discovery, experiential learning, mentor matching); Pankaj raised liability concerns about recommending specific influencers and questioned value vs. user self-directed search; agreed to tone down social recs, focus on search-term provision and user-led tracking; Pankaj to review with Nitish and potentially schedule a separate call.

### 2026-07-03 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com) — Nellie / Lalit meeting
- **Where:** Email thread 19f23c84c313ab4d — "Meeting assets for Nellie / Lalit are ready!"
- **Summary:** Nellie/Lalit PDP scoping session (Jul 2): V1 scope narrowed to courses + mentor connections only (internal content, no public internet sources); customizable judge prompt for enterprise content guardrails; thumbs up/thumbs down feedback mechanism on AI recommendations. Action items: Lalit to validate recs with CS, start Slack thread with Nellie/Chao/Jay-Z on mentor matching architecture, explore AI-generated recs for leadership/strategy goal types, discuss Connect-with-Mentor feature ownership with JV and Nitesh.

### 2026-07-06 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f3886584065824 — "Meeting assets for Integrations/AI Cross Team Sync are ready!"
- **Summary:** First weekly alignment call for summer projects between the integrations and AI teams; AI-203 shares integration platform infrastructure with AI-201 — this standing sync covers both tracks.

### 2026-07-07 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f3bd87a162d445 — "Meeting assets for Course recommendations are ready!"
- **Summary:** Meeting focused on designing a two-phase AI-powered course recommendation system for an LMS integration; action items and full summary now available in Zoom.

### 2026-07-06 — PDP: AI Recommendation Performance and Latency (zoom)
**Source:** Zoom — "PDP: AI Recommendation Performance and Latency" 2026-07-06 (UUID 9ECD0C03-1234-465A-9883-216AE7462CDA)
**Type:** scope-decision
**Owner-impact:** Nitish, Nellie, Nataliya Kolb, Nataliia Savenko, Pankaj, Rinku, Lalit

Nitish's latency investigation confirmed the two-pass course-recommender (query generation + re-ranking) runs 30–40s end-to-end on Gemma 4, dominated by the ~30s re-ranking pass; GPT-5 Nano hits ~15s but is ruled out for production (not private, variable cost). The team decided to fire the upskilling-steps and course-recommendation requests in parallel on skill selection to mask latency, ship the deterministic SQL-driven mentor-connect step immediately regardless of AI readiness, and build+test the real user experience before pursuing streaming/preprocessing mitigations with the AI team. Preprocessing was judged likely wasteful given the combinatorial skill×level×user space (~1,000 skills/user).

**Implication for ranking:** Reinforces (doesn't change) the MVP-first latency approach already locked on 2026-06-29 — this session supplies the concrete numbers (30–40s, 17 tok/s Gemma 4) and rules out preprocessing as a near-term lever; streaming stays an AI-team follow-up, not a summer blocker.

### 2026-07-06 — Integrations/AI Cross Team Sync (zoom)
**Source:** Zoom — "Integrations/AI Cross Team Sync" 2026-07-06 (UUID FB70D4B2-1D82-4B9E-A8C7-F315DC57F85F)
**Type:** scope-decision
**Owner-impact:** Nellie, Lalit, Nataliya Kolb, Nitish, Jason Zhang, Sagar, Okan, Danish, Pankaj

First Integrations↔AI weekly sync confirmed the MVP plan: parallel AI requests (upskilling steps + course recommendations) on skill selection, ship without preprocessing/streaming first, treat streaming as a V2 phase requiring multi-hop infra work (API gateway, LM Engine, inference server, DevOps), and defer skill-graph to a future phase (Okan's proposal judged not feasible before August). Danish demoed a working webhook gateway MVP for Zoom (events → internal topic); LMS integration confirmed bring-your-own for clients beyond Docebo-internal.

**Implication for ranking:** Formalizes the latency approach as a cross-team commitment (not just an AI-side call) with named owners (Jason on streaming PoC, Lalit/Nitish on mock-data test scenarios); the webhook gateway MVP now existing gives AI-201 a shared dependency to track.

### 2026-07-07 — Course recommendations (zoom)
**Source:** Zoom — "Course recommendations" 2026-07-07 (UUID B183C2AC-EE91-46CE-9741-136FECDB37F2)
**Type:** scope-decision
**Owner-impact:** Nitish, Pankaj, Lalit

Nitish and Lalit confirmed the two-pass pipeline (query generation → re-rank) as the current working approach, with round-robin interleaving used to merge multi-query results into a diverse top-20 set; re-ranking was judged necessary since raw LMS provider ranking surfaces irrelevant courses (e.g., a Snowflake cert for a PM). The team agreed dislike-as-metric is insufficient (conflates latency dissatisfaction with quality) and committed to automating comparative evaluation of two-pass vs. single-pass and per-provider variations rather than deciding manually.

**Implication for ranking:** Adds a concrete automation/eval action item (golden dataset + multi-strategy harness) ahead of committing to one recommendation architecture — worth checking status of before the next PDP scoping decision.

### 2026-07-08 — gmail
- **Who:** Nitish Devadiga (via Zoom AI summary)
- **Where:** Zoom meeting "PDP Stand Up" (email to lalit.maharana@betterworks.com)
- **Summary:** Nitish presented Google Colab work on text processing — likely LLM inference/evaluation for the learning recommendations pipeline.

### 2026-07-08 — slack
- **Who:** Nitish Devadiga
- **Where:** [#personalised-learning-development-feature](https://betterworks.slack.com/archives/C0B54QF5GR2/p1783492209130109)
- **Summary:** Architecture rationale posted against LMS catalog sync: GraphQL migration blocks REST API auth needed for catalog, syncing 7k+ Udemy courses adds infra + periodic embedding jobs, Docebo is internal-only (not useful for real skills). Confirmed two-pass pipeline latency: ~10s query generation + ~30s re-ranking; enrollment status for Udemy deferred to phase 2. Real optimization path is iterative — inference servers, caching, smarter offline re-rank.

### 2026-07-08 — Fake-latency UX pattern adopted to mask AI delay; optimization deferred pending NVIDIA inference release; MVP-first reaffirmed (zoom)
**Source:** Zoom — "PDP Stand Up" 2026-07-08 (UUID 145B3FE9-9CE5-4E7E-AA3D-36FCBEC6205B)
**Type:** scope-decision
**Owner-impact:** Nitish, Sriram CS, Pankaj, Nataliia, Rinku, Harikrishnan

Team adopted a psychological "fake latency" loading pattern to hide the ~10s AI-recommendation delay: show predetermined "Connect with a Mentor" (~2s) and "Take Courses" (~3s) steps first, then surface AI-generated suggestions once ready. Latency optimization (MTP Raptors for Gemma, ~2x speedup; scale-graph approach) is explicitly deferred — the AI team (Jay-Z) is blocked on an upcoming NVIDIA inference-server release and won't prioritize optimization work until then. Sriram reaffirmed the MVP-first sequencing already locked 2026-06-29/07-06: build remaining features now, optimize latency closer to release. Pankaj's completed front-end screen (currently staged in Rainforest) still needs design/product review before further testing to avoid rework.

**Implication for ranking:** No change to the locked MVP-first/latency-fallback strategy, but adds a hard external dependency (NVIDIA release timing, outside Betterworks' control) as the gate on any future latency improvement — worth flagging if Aug 10 Gemma-4 prod date or the release date slips.

### 2026-07-08 — Course-recommendation summer delivery reconfirmed to Nellie; Sagar/Hemant review round committed (zoom)
**Source:** Zoom — "Nellie / Lalit" 2026-07-08 (UUID 01A86199-2B52-4C03-8F03-CBAB29BE3129)
**Type:** commitment
**Owner-impact:** Lalit, Nellie, Mitesh, Sagar, Hemant

Lalit confirmed to Nellie that the PDP/course-recommendation feature remains on track for summer delivery, with Mitesh dedicated to the work and Sagar + Hemant committing to one review round before release. Reported alongside the Zoom-transcript summer confirmation in the same 1:1 (see [[ai-201-meeting-transcripts]]).

**Implication for ranking:** Reaffirms delivery confidence already built up through the 07-06/07-07 architecture and latency-strategy decisions — no new scope or risk, but closes the loop with Nellie on summer commitment.

### 2026-07-09 — slack
- **Who:** Jason Zhang
- **Where:** [#personalised-learning-development-feature](https://betterworks.slack.com/archives/C0B54QF5GR2/p1783554539837789)
- **Summary:** Jason Zhang pushed hard for embeddings-based course retrieval over LLM query generation: confirmed course data (name + description) is retrievable from Udemy/Docebo; argued embeddings sidestep org-categorization unreliability and are deterministic, sub-100ms, and testable — vs. ~35s for the two LLM phases; framed the LLM's role as mapping free-text goals → skills (generative step), not retrieval (similarity step). Proposed adding an embeddings comparison cell to Nitish's spike notebook alongside LLM and interleave baselines + a Docebo sandbox check. Also flagged a hardcoded API key in the Colab notebook that needs rotation before further sharing.

### 2026-07-09 — slack
- **Who:** Rinku Ravi
- **Where:** [#personalised-learning-development-feature](https://betterworks.slack.com/archives/C0B54QF5GR2/p1783575316125339)
- **Summary:** Acknowledged Jason Zhang's embeddings proposal and confirmed Nitish will investigate with JZ.

### 2026-07-09 — PDP proficiency scoring standardized to 3 buckets; vector-search course-catalog deferred to post-launch (zoom)
**Source:** Zoom — "PDP Stand Up" 2026-07-09 (UUID E5DC3E0C-436B-4CBD-A2BC-4869DB98297E)
**Type:** scope-decision
**Owner-impact:** Rinku, Nitish, Sriram, Nataliia, Eden

PDP team standardized proficiency scoring to three fixed buckets (0–33 beginner, 33–66 intermediate, 66–100 advanced) for LLM generation regardless of org-level proficiency-level configuration, keeping the underlying skill score model unchanged (Betterworks 0–100 scale). Team confirmed local course-catalog + vector search (proposed by JC/Daisy to cut latency) is deferred out of v1 due to architectural cost — to be revisited as a post-launch improvement. Full India product/eng team offsite next week (Mon–Fri) means no standups; async updates will substitute.

**Implication for ranking:** vector-search deferral keeps v1 scope contained — no change to summer timeline reconfirmed 2026-07-08; PDP Springboard board (owned by Eden) still not created as of this standup, a minor process risk to watch.

### 2026-07-10 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19f4befdf6e86945 — "Meeting assets for PDP Stand Up are ready!"
- **Summary:** Friday PDP standup recap available; team discussed progress on AI feature development with Jennifer (identity unclear from snippet) — India team offsite week begins Mon Jul 13 so this is the last sync before async mode.

### 2026-07-10 — Skill-graph mentor-recommendation flow scoped for AI hackathon (zoom)
**Source:** Zoom — "Hackathon : Skill graph" 2026-07-10 (UUID 9A5206F6-96F8-4D81-8479-621A6629F6E7)
**Type:** architecture
**Owner-impact:** Lalit, Neetesh Kaushik, Dasharath, Manish Tomar, Tanveer Farooq

Team scoped a hackathon build of mentor recommendations on top of an existing skill-graph/talent-graph database (skills + user-profile nodes, semantic-similarity edges) that Neetesh already has running — the same graph substrate AI-203's mentor-matching plan calls for. Demo flow: user picks a target position → required Lightcast skills extracted → skill gaps identified → mentors ranked per skill (same-level-or-senior only), with no request/approval friction — contact goes straight to a DM or a pre-filled 1:1. Scope is hard-coded to 2–3 demo roles; the hardest open piece is mapping free-text JD descriptions to Lightcast skill IDs via LLM.

**Implication for ranking:** Prototype validates AI-203's "skill graph with semantic embeddings" mentor-matching approach earlier than planned — worth flagging to Nellie as a possible head start on that workstream if the hackathon output is reusable.

### 2026-07-10 — PDP standup: LLM struggles on proficiency differentiation in query generation; re-ranking with LMS course data works better (zoom)
**Source:** Zoom — "PDP Stand Up" 2026-07-10 (UUID 712DE033-C74B-4BC5-B6CB-0BC77DB56C73)
**Type:** risk
**Owner-impact:** Nitish Devadiga, Nataliia Savenko, Pankaj Lohmor

Nitish's updated notebooks show the LLM doesn't reliably differentiate between proficiency levels during query generation (it defaults to base world-knowledge associations, e.g. suggesting advanced React content regardless of learner level), but accuracy improves once results are re-ranked against external LMS (LinkedIn) course data. Team also decided to keep the current skeleton/shimmer loading UI as implemented and add PDP-type goal filters plus edit forms to the goals table; the regular standup converts to a refinement session next week once Pankaj is back from leave.

**Implication for ranking:** Confirms AI-203's hybrid strategy (LLM generation + re-ranking) is the right call — query-generation alone under-performs on proficiency targeting. No new risk to the Aug 10 Gemma-4 date, but query-generation quality may warrant a second look post-launch.

### 2026-07-13 — slack
- **Who:** Lalit Maharana
- **Where:** [DM (self)](https://betterworks.slack.com/archives/D0B0W25MMV2/p1783912048564419)
- **Summary:** Week-of-Jul-13 focus plan allocates T2 (adaptive learning / skill matching) blocks: write spike stories per component (skill graph, pre-processing, runtime generation) (Tue Jul 14), contact Jason Seitz (Talent) re privacy-preserving skill-search API and validate public-content sourcing with CS (Wed Jul 15), and start Slack thread with Nellie/Chao/JV on mentor matching + escalate unassigned mentor-ranking dev owner (Fri Jul 17).

### 2026-07-14 — gmail
- **Who:** Lalit Maharana, Neetesh, Manish, Abhishek, Ayush (via Zoom AI summary)
- **Where:** Zoom meeting assets email → lalit.maharana@betterworks.com (thread 19f5f759db597b6a)
- **Summary:** Talent Graph sync — Neetesh demoed Neo4j + OpenAI-embeddings skill graph (admin-side visualization, profile similarity search, mentor recommendation cards); team aligned on table view over graph view, toggle for user/skill search, exact-match prioritized over similar-match; Lalit action items: update Talent Graph design file and generate synthetic test data; Neetesh: set up local Neo4j env, implement JD→skill extraction for empty positions, add mentor recommendation logic and visual match-score indicators.

### 2026-07-14 — slack
- **Who:** Lalit Maharana
- **Where:** [#temp-hackathon-team](https://betterworks.slack.com/archives/C0BEGEBB7C4/p1784012701159859)
- **Summary:** Lalit posted detailed hackathon implementation spec for Talent Graph — admin org-skill network (skill detail side-panel, ranked similar skills), search talent graph (skill/user toggle, ranked exact+similar matches in table view, succession cards for filled and empty positions), and user-side mentor cards on talent profiles (top-3 similar-skill mentors, Slack/Teams DM action spike); FE scope: table, search, 2× card sets; team (Lalit, Manish, Abhishek, Ayush) to divide implementation.
