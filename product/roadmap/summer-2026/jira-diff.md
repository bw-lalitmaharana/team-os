# Summer 2026 — Aha ↔ Jira Reconciliation Diff

**As of:** 2026-05-13 · **Action policy:** No direct writes to Jira/Aha — all changes land in refinement call. This file is the checklist.

## A. Missing `fixVersion="Summer 2026"` in Jira

Currently set: **only ENG-73594.**

| Aha | Jira | Current fix | Action |
|---|---|---|---|
| AI-201 | ENG-79199 | (none) | Set fixVersion="Summer 2026" |
| AI-203 | ENG-80931 | (none) | Set fixVersion="Summer 2026" |
| AI-205 | ENG-75271 | (none) | Set fixVersion="Summer 2026" |
| AI-200 | ENG-74398 | (none) | Set fixVersion="Summer 2026" |
| AI-215 | ENG-77042 | (none) | Set fixVersion="Summer 2026" |
| AI-154 | ENG-80932 | (none) | Set fixVersion="Summer 2026" |
| AI-214 | ENG-78553 | (none) | Set fixVersion="Summer 2026" |
| DP-76 | ENG-72524 | (none) | Set fixVersion="Summer 2026" |
| AI-191 | ENG-70491 | **Spring 2026** | Decide: replace with Summer 2026, or accept carry-over (Q5) |
| AI-194 | ENG-72626 | (none) | Set fixVersion="Summer 2026" after linking (see C) |

## B. Missing Jira epic (Aha-only)

| Aha | Title | Action |
|---|---|---|
| AI-193 | LLM Prompt Management | **Create new ENG epic.** Owner TBD (Nellie?). Link bidirectionally with AI-193. Set fixVersion="Summer 2026". |
| — | Public MCP Server *(Confluence commits)* | **Investigate** whether epic exists under another name; if not, create. (Q7) |

## C. Missing Aha→Jira link (Jira epic exists but Aha description doesn't reference it)

| Aha | Jira | Action |
|---|---|---|
| DP-66 Agentic AI Foundation | ENG-69839 (Nellie's "Agentic AI Tools") *— unverified* | Verify mapping in refinement (Q4). Then add Jira link to Aha description. |
| AI-194 LLM Eval Visualization | ENG-72626 "AI Platform \| Automate & Visualize LLM Evaluations" | Add Jira link to Aha description. |

## D. Stale Jira status / metadata

| Jira | Issue | Action |
|---|---|---|
| ENG-76815 | "MCP - Internal Version" still **Draft** despite shipped 2026-05-06 across all 4 internal envs | Transition to Done. Update Aha equivalent if exists. |
| ENG-80931 (AI-203) | **No assignee**, no sprint pull — highest-scored Aha item | Assign owner in refinement. |
| ENG-79199 (AI-201) | Draft, 0 sprint pull, but has **May 31 Rainforest hard date** | Pull into next sprint; break into stories. |
| All AI epics | Priority = **P2** uniformly despite Aha tier gradient | Promote P0 group (AI-201, AI-203, DP-66, AI-205, EMPDVT-90) to P1. Reflect tier in Jira. |

## E. Aha score gaps (no `score_facts` populated)

Affects rank calculation — proposed values from `backlog-rank.md` rationale must be confirmed by Nellie:

- AI-201 Meeting Transcripts — proposed 9/6/9/10 −5
- AI-193 LLM Prompt Management — proposed 1/3/4/9 −4
- AI-200 CI/CD Eval — proposed 0/5/3/9 −3
- AI-214 MWAA — proposed 0/2/1/6 −2
- AI-215 Skills API Phase 2 — proposed 3/4/4/8 −3
- DP-76 Techwolf — proposed 2/4/4/9 −3

## F. Aha ownership staleness

Anthony Mitchell departed; Aha `AI-R-27.owner = Anthony Mitchell` and several feature `assigned_to_user` references are stale. Action: reassign in Aha to Nellie (release-level) and current feature owners (feature-level).

## G. Items in Nellie's broader Jira list not in AI-R-27 — Summer candidates

Awaiting Q6 in `open-questions.md`:

| Jira | Title | Likely Summer? |
|---|---|---|
| ENG-73497 | AI Usage Tracking | **Yes (P1)** — needed to instrument MCP + Assistant adoption |
| ENG-76699 | Knowledge Base RAG Infrastructure | Unclear — ask Nellie |
| ENG-69839 | Agentic AI Tools | Yes if DP-66 maps here (Q4) |
| ENG-76815 | MCP Internal | **Already shipped** — see D |

## Summary counts

- **10** epics need fixVersion set
- **1** new epic to create (AI-193) + 1 to investigate (Public MCP)
- **2** Aha→Jira links to add
- **1** Jira status to transition to Done
- **1** unassigned high-priority epic to assign
- **6** Aha features need score backfill
- **4** Nellie-portfolio items to triage into/out of Summer
