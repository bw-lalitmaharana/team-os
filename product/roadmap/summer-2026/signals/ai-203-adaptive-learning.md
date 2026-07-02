# AI-203 / ENG-80931 — AI-Powered Skill-to-Learning Matching Engine

**Aha:** `AI-203` (Tier E in Aha custom field, but scored highest: 10/8/10/10) · **Jira:** ENG-80931 (Draft, **unassigned**, 0 sprint pull)
**Owner:** Nellie (Aha) / **unassigned in Jira** ← largest delivery risk
**Composite score:** 34 (highest)
**Bucket:** P0

## Signals

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
