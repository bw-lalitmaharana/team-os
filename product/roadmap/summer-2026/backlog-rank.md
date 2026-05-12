# Summer 2026 — Ranked Backlog (AI Team)

**As of:** 2026-05-13 · **Authored by:** Lalit · **Status:** Working ledger — NOT walked through Nellie yet
**Source of truth:** Aha `AI-R-27` (planning) + Jira board 237 (execution). This file is derivative; refresh from `signals/` after each refinement pass.

## Scoring rubric

```
Composite = (NetNewRevenue + Retention + MarketDifferentiation + StrategicAlignment) − Effort
Aha 0–10 scales. Lifts: contractual +5, cross-feature unblocker +3, at-risk/unowned −2.
Tie-breakers: contractual date → cross-pod blocker → revenue tier → effort.
```

## Ranking

| # | Aha | Jira | Feature | Score | Bucket | Owner (Jira) | Sprint pull | Key risk |
|---|---|---|---|---|---|---|---|---|
| 1 | AI-203 | ENG-80931 | AI-Powered Skill-to-Learning Matching (incl. AI-generated guidance v1) | **33** | **P0** | **unassigned** | 0 | No owner; scope just widened |
| 2 | DP-66 | ENG-69839? | Agentic AI Foundation | **31** | **P0** | Nellie | unknown | Jira link unverified |
| 3 | AI-201 | ENG-79199 | Meeting Transcripts | **29** | **P0** | Lalit | 0 | May 31 Rainforest hard date; 3 open scope questions |
| 4 | AI-205 | ENG-75271 | OpenAI → Gemma Embeddings | 20 | **P0 (finish)** | Sagar B | 4 | Already Under Review — ship it |
| 5 | AI-215 | ENG-77042 | Skills API Phase 2 (Synopsis) | 19 | P1 | Nellie | 0 | Powers Adaptive Learning; no pull |
| 6 | DP-76 | ENG-72524 | Techwolf Skills Taxonomy | 19 | P1 | Nellie | 2 | **Possible Synopsys lift → P0** (Q1) |
| 7 | AI-154 | ENG-80932 | Llama → Gemma Generative | 18 | P1 | Jason Z | 1 | Multilingual unlock |
| 8 | AI-200 | ENG-74398 | CI/CD Eval Framework | 17 | P1 | Tejas S | 4 | Under Review |
| 9 | AI-193 | **NONE** | LLM Prompt Management | 16 | P1 | — | — | **No Jira epic — must create** |
| 10 | AI-191 | ENG-70491 | Pre-processing Phase 3 | 15 | P2 | Bhavesh V | 0 | Wrongly fix=Spring; carry-over decision |
| 11 | EMPDVT-90 | ENG-73594 | Performance Summary Redesign | 9 | **P0 (finish)** | Nellie | 7 (mostly Done) | Already Dev Complete — ship it |
| 12 | AI-194 | ENG-72626 | LLM Eval Visualization | 10 | P2 | Nellie | 0 | Aha lacks Jira link |
| 13 | AI-214 | ENG-78553 | MWAA Self-Service Deploy | 7 | P3 | Bhavesh V | 1 | Devops-only; cut unless blocks transcripts deploy |

**Candidates to add (pending Q6 in `open-questions.md`):**
- ENG-73497 AI Usage Tracking → likely **promote to Summer P1** (instruments MCP + AI Assistant adoption)
- ENG-76699 KB RAG Infrastructure → unclear; ask Nellie
- *Public MCP Server* → Confluence brief commits it; no Jira epic surfaced — see Q7
- ENG-76815 MCP Internal → **already shipped 2026-05-06**, status stale; not for ranking

## Capacity check

~15 weeks May 13 → Aug 28 code-ready (≈ 11 weeks to AI-201 hard date May 31).

| Bucket | Effort total | Notes |
|---|---|---|
| P0 ship (5 items: AI-203, DP-66, AI-201, AI-205, EMPDVT-90) | 5+3+5+1+1 = **15** | AI-201 + AI-203 alone are 10 effort points, both with **0 sprint pull** |
| P1 (5 items: AI-215, DP-76, AI-154, AI-200, AI-193) | 3+3+1+3+4 = **14** | All have known owners (or one to create) |
| P2 + P3 | 1+2+2 = **5** | |

**Gating reads:**
- The top 3 P0 items collectively have **0 sprint pull**. AI-201 has the binding May 31 date. **This is the biggest delivery risk.**
- AI-203 widening to include AI-generated content needs an owner before refinement closes.

## Rationale notes (per item, summarized)

- **AI-203 (#1):** Highest Aha composite (proposed 10/8/10/10 −5 with widened scope). Released-brief-named feature ("Adaptive Learning & Upskilling"). Risk = no Jira owner. Score downgrade vs. last pass: 34 → 33 (effort +1 from v1 scope widening).
- **DP-66 (#2):** Maps to "AI in Flow of Work Foundation / MCP" pillar. Existing Aha 10/4/10/10 −3.
- **AI-201 (#3):** Tier A; defends against Lattice AI Meeting Agent. Proposed 9/6/9/10 −5. Architecture decision pending (Q2, tentatively native Zoom).
- **AI-205 (#4):** Existing Aha 1/5/5/10 −1. Already executing well.
- **AI-215 / DP-76 (#5–6):** Both unblocker-lifted (+3). DP-76 may move to P0 if Synopsys-lift confirmed.
- **AI-154 (#7):** Multilingual; existing 2/2/5/10 −1.
- **AI-200 (#8):** Proposed 0/5/3/9 −3, +3 unblocker. Eng productivity safeguard.
- **AI-193 (#9):** Proposed 1/3/4/9 −4, +3 unblocker. **Must create Jira epic.**
- **AI-191 (#10):** Existing 2/1/3/10 −1.
- **EMPDVT-90 (#11):** Low score but Dev Complete — ship-by-default.
- **AI-194 (#12):** Existing 0/0/6/6 −2.
- **AI-214 (#13):** Proposed 0/2/1/6 −2.

## Walkthrough pre-reads for Nellie

1. This file
2. `open-questions.md` — 8 unresolved items
3. `signals/ai-201-meeting-transcripts.md` — for context on May 31 + architecture tensions
4. `signals/ai-203-adaptive-learning.md` — for scope widening decision

## Refresh trigger

Re-run `/sense-backlog Summer 2026` after each refinement call or weekly via `/loop 1w` during the release window.
