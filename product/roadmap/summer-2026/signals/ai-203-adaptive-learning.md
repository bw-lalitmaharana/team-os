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
