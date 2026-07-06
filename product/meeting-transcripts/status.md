---
title: Meeting Transcripts — Current Status (living doc)
updated: 2026-06-30
owner: lalit.maharana@betterworks.com
parent_epic: ENG-79199
supersedes: delivery-plan.md (the May-31 plan — kept for history)
---

# Meeting Transcripts — where we are now (refreshed 2026-06-30)

> Single "where are we" snapshot. Jira/Aha are the systems of record; this is the working view. No system writes from sessions (refinement-call policy).

## TL;DR
- ENG-79199 was **fully decomposed into a Jira tree on 2026-06-07** — 3 child epics + 3 spikes + POC + eval gate + ~28 stories. **Everything is still Draft**, almost all unassigned.
- The **May 31 "live in Rainforest" target was missed.** Release now firmed to **~Aug 29, with the solution on pre-prod by Aug 15** (Sriram, 6/1); **Tanveer Farooq owns the delivery plan**, working backwards from those dates. AI inference approach (OPEN-D11) locks ~mid-June.
- Critical path: the **3 spikes must converge on ONE signed-off I/O contract** before any implementation story enters a sprint. POC ENG-82389 must document its outputs before the AI spike can close. **Integration-side stories are also blocked on a new webhook-architecture spike** (Danish, starting wk of 6/9).

## Since 2026-06-08 — June 9–30 refresh (2026-06-30)

> Backfilled 2026-06-30 from Zoom AI-summaries of ~16 sessions. Full dated entries in `roadmap/summer-2026/signals/ai-201-meeting-transcripts.md`. **This section supersedes "Everything is still Draft" in the TL;DR above.**

**The project moved from decomposition → execution.** POC complete and successful (data extraction + source citation + timestamps validated); design aligned across all three pods; implementation started (Hemant + Sagar on DB schema). Dev work is sequenced **July 1 → ~Aug 10** (≈5-day buffer before Aug 15 pre-prod); Aug 29 release still the target. AI Projects Debrief dropped to **monthly** (leadership reads the project as stable).

**Newly locked decisions (June 9–30):**
- **Admin-level Zoom OAuth, one-time per org** — users give in-app consent only; **no per-user Zoom redirect** (Project Plan 6/16). Supersedes any "per-user OAuth" framing.
- **Consent-based per-participant processing** — only consenting participants' transcripts are processed; **future meetings only**, no retroactive; consent flag travels in the Meetings→AI payload (6/16).
- **Summer/Winter scope split locked** (Nellie 1:1 6/10): Summer = Zoom + manual only, **Teams explicitly out**; Phase-2 signal extraction (goals/recognition/skills) becomes its **own Aha feature for Winter**. Parent epic to be **renamed** (drop "pipeline-only" implication).
- **MeetingsPod owns transcript ingestion/preprocessing** incl. speaker resolution + meeting exclusions (not Integrations). Speaker-ID target **90–95%** on email + employee-ID match (Refinement 6/10).
- **AI brief = daily batch 12–24h before the meeting** + manual refresh (Refinement 6/10).
- **MVP scope cuts** (6/11): action-item **due dates out**, **AI-generated notes deferred**, Recognition/Feedback kept in Figma but out of Phase-1 (goals flow only).
- **AI surface design finalized** (6/25): 5 meeting-state tags (one at a time), recap schema (Summary / Blockers≤3 / What-Happened / Follow-ups≤5, duration-scaled caps), prep-brief schema (ARC synthesis + unlabeled Attention-Flags / Goal-Signals bullets), "AI Suggested" header removed. **Figma = source of truth for dev handoff; Claude for flows/prototypes.**
- **Consolidated integration sidebar** (Calendar + Meetings categories) with category-based banner suppression (6/23).
- **Extensible DB schema** — Zoom now; Teams/Slack/Jira/free-text later without rework (6/30). In-house inbound webhook confirmed (Okan; no viable OSS).
- **MCP V2 goals contract** underpins "Create Goal" cards: 4 tools, no bulk, Tier-1; **PATCH-at-service-layer (Emerson) is the gating backend task** (see `roadmap/summer-2026/signals/mcp-internal.md`).
- **Process:** async scrum → **synchronous daily 12pm IST scrum**.

**New / active risks:**
- **Lalit-owned blocker:** finalized **recap/prep key fields** owed to Sagar — gates his prompt engineering (July 2 start) (Estimations 6/30).
- **EOJ technical freeze** on shared integration contracts; transcripts named the **first use case** for the new event-based integration platform → coupling + Danish-webhook bandwidth contention with PDP/LMS (6/19).
- **AI module enable/disable** doesn't reliably suppress AI feature flags — admin-trust risk to fix before GA (6/18).
- **Docebo integration at risk**; **TechWolf licensing** unresolved (gates Phase-2) (Nellie 1:1 6/15).
- Infra setup gaps: Meetings **S3 bucket Terraform**, **EDA-event DB schema**, Hiten's frontend estimates (6/30).

**Ledger gaps (no recorded Zoom assets):** "Meeting Transcript - AI sync" 6/9; "Story pointing ENG-82387" 6/16; "Learning Recommendations" 6/16 — recover from Jira/attendees if needed.

## Jira tree (verified 2026-06-07)

Parent epic **ENG-79199** — AI Processing Pipeline for Meeting Transcripts (Draft, P2, Lalit).

| Child epic | Pod | Owner | Status |
|---|---|---|---|
| ENG-74407 | Integrations — Zoom Connector | Rinku Ravi | Draft |
| ENG-82387 | AI Platform — signal-extraction pipeline | — | Draft |
| ENG-82991 | Meetings — functional & UI changes | — | Draft |

| Spike / gate | Purpose | Owner | Status |
|---|---|---|---|
| ENG-82987 | Integrations spike — Zoom API feasibility, auth, deep-links, ID matching | — | Draft |
| ENG-82135 | AI spike — recommendation architecture, prompts, evidence schema, I/O contract | Sagar Bhat | Draft |
| ENG-82992 | Meetings spike — AI surface contract, lifecycle, state model | — | Draft |
| ENG-82389 | POC — transcript fetch / store / chunk (outputs gate the AI spike) | Hemant Kumar | **In Progress** |
| ENG-83006 | Evaluation framework & quality gates (blocks any capability shipping) | — | Draft |

~28 implementation stories sit under the 3 child epics (all Draft). Decomposition + audit lives in `story-audit.md` — its abstract S-/M-/C-/Z- IDs map onto these ENG stories.

## Scope — Phase 1 (locked)
- **Source:** Zoom only. **Recommendation output:** Goals only. Pre-meeting brief = full minus coaching cards.
- **Input paths (all Phase 1, same pipeline):** Zoom auto-retrieval (primary/required — ADR-D-013), manual upload, copy/paste.
- **Deferred to Phase 2:** coaching cards; Feedback / Recognition / Skills signals; Slack / Teams / other adapters; embedding-similarity + LLM-judge reconciliation tiers; cross-meeting synthesis; push / email / Slack notifications.

## Key locked decisions (full ADRs in repo-root `decisions/`)
- Native Zoom OAuth; **Recall.ai/bot rejected** (ADR-D-001). Automated Zoom is MVP-required, not "if doable" (ADR-D-013).
- Private LLM stack only — LM Engine + LM Proxy, no external API (ADR-D-007). Summaries from BW LLM, not Zoom AI Companion (ADR-D-015).
- Evidence-centric data model; evidence rows → Aurora warehouse (ADR-D-008, ADR-D-014). Clickable source provenance is non-negotiable (ADR-D-008).
- Transcript access is **host-only** via OAuth (ADR-D-019). Zoom app = General App, User-managed (ADR-CD-010 / ADR-D-017). Marketplace review = 8–13 weeks (ADR-D-018 / ADR-ZD-004).
- Admin org enablement is a precondition for user OAuth (ADR-D-016). Disconnect locks evidence, doesn't delete (ADR-CD-002). Reconnect resumes from "now"; back-fill opt-in (ADR-CD-004).
- MVP processes data for the **2 direct participants only** (Daily Catchup 2026-05-28). Z-11 tolerant-1:1 classification (don't auto-decline a 1:1 when a room/AI-bot joins) must NOT expand processing scope.
- Manager brief and report brief are **separate DB records** (persona privacy at data layer); RBAC-filter context before prompt injection.
- Architecture diagram frozen for implementation (Refinement 2026-05-27).
- **Transcript storage = S3 with a TTL, NOT permanent** (Sriram 6/2; 2–6 mo proposed, Anuj to recommend the value, Lalit studying TTL policy). Transcripts are shown in the UI, so they're stored (not re-fetched each time).
- **All transcript sources → S3 first, then LLM Engine APIs** — manual upload and Zoom both route through S3 (Anuj 6/2). Design→dev handoff is via Claude/Claude Code (Harshini 6/2).
- Platform shipped (6/3): PG Bouncer for LLM Engine (fixed connection timeouts); Gemma migration complete + multi-language live.

## Open decisions (detail in `open-questions.md`)
- **OPEN-D11** inference substrate — **RESOLVED for MVP (2026-06-29):** use the **direct LM inference server endpoint** (LM Proxy can't yet do structured/function calling via LangChain); **Gemma 4 replaces Llama in prod by ~Aug 10**; **64K-token context** default (≈1hr meeting, per Hemant's POC). Embeddings/skill-graph deferred to a future-evolution role (mentor matching SQL-first, embeddings later). POC findings (Hemant 6/4): ~60k-token context ≈ 1 hr, 25s latency, 8 prompting techniques, LM-as-judge eval = GPT-5+, temp 0.
- **Inbound webhook architecture** (Okan 6/3: API Gateway → Kafka → microservices, Cloud Events; dual-use Zoom + TechWolf) — NOT locked; Danish spikes a generic webhook framework wk of 6/9; Jason Sites flagged TechWolf pull→push risk (loop in Meher).
- **Transcript TTL value** + **whether users can edit AI recaps** + **calendar-connect consent sufficiency** — all open from June dailies.
- **OPEN-D9** per-signal-type data windows — goals = 1 fiscal year, feedback = 6 mo, recognition = 3 mo (locked); others TBD. Lalit owes Sagar: fiscal-period definition + failed-job re-trigger policy.
- **OPEN-D10 Q-A1** (Jay-Z) — single-transcript vs cross-meeting synthesis; gates cross-meeting / HR-rollup features.

## Lalit's owed PM items (detail in `open-actions.md`)
1. **Visibility-sharing doc** — PM decisions on visibility/sharing of AI-suggested vs user-added items; include one-sentence B-02 forward-pointer (UX Alignment 2026-05-28).
2. **Answers to Sagar** — fiscal-period definition + failed-job re-trigger policy (OPEN-D9).
3. **Child-PRD Confluence sync** — Meetings AI Surfaces / Connect Layer / Zoom Connector all drifted behind Confluence; parent PRD is in sync.

## UX (rulings locked at the 2026-06-03 UX Sync; designer = Harshini Vijay, UX lead = Nataliya Kolb)
- Header shows explicit meeting context (e.g., "Your one-on-one with <name>").
- **AI-suggested + recommended actions = one unified list**, single "Add" button; completed items stay visible/trackable.
- Goal creation opens a separate tab, auto-populates the goal form; the suggestion persists until dismissed/completed.
- "Give Recognition" = an AI-suggested action item, opens in-page (not a new tab).
- Transcript: copy + delete/replace; copy enables sharing. Manual transcript for **past** meetings in progress (~2 weeks to prod; upload + paste).
- AI summary: reload/regenerate confirmed; **editing** AI recaps unresolved. Summer scope = **1:1 only** (team meetings future-proofed for Winter). Harshini + Lalit to document must-have vs nice-to-have.

## People (refreshed from June dailies)
Rinku Ravi (Integrations PM, ENG-74407) · **Harshini Vijay — designer for this feature** (was Gauri in the May plan) · Nataliya Kolb (UX lead/reviewer) · **Tanveer Farooq (project/delivery lead, owns the plan)** · Sagar Bhat, Hemant Kumar, Anuj Pancholi, Danish Sharma (AI/eng) · **Pankaj Lohmor** (principal eng, architecture + embedding POC — surname is *Lohmor*, not "Lomo") · Okan Akbulut (architect, webhook proposal) · Jason Sites (integration architect) · Aryan NJ (embeddings) · Tejas S (AI-platform QA/acceptance) · Varnica/Varnika (Meetings/Goals PM) · Nellie (manager/sponsor) · Sriram CS (eng leadership; was "include until end of May").

## Canonical Confluence pageIds
parent PRD 4280614960 · Meetings AI Surfaces 4281139203 · Connect Layer 4282515524 · Zoom Connector 4282744869.

## Status log
| Date | Change |
|---|---|
| 2026-06-08 | Doc created. Reconciled area against the 2026-06-07 Jira decomposition + May 27–30 recalibration signal. Recorded timeline slip (May 31 → ~Aug), Phase-1 scope lock, OPEN-D9/D10/D11. |
| 2026-06-08 | Folded in the June 1–5 Zoom signal (daily catchups + UX Sync + webhook-arch proposal + Nellie roadmap). Release firmed to Aug 29 / pre-prod Aug 15 (Tanveer owns plan); transcript-TTL + S3-first decisions; new webhook spike (Danish); OPEN-D11 POC findings; designer = Harshini Vijay; Pankaj surname corrected to Lohmor. Full entry in `roadmap/summer-2026/signals/ai-201-meeting-transcripts.md` (2026-06-05). |
| 2026-06-30 | **June 9–30 backfill** from Zoom AI-summaries of ~16 sessions (added the "Since 2026-06-08" section above). Project moved POC→implementation; admin-OAuth + consent-based per-participant processing locked; summer/winter split (Teams out); AI surface design finalized (5 tags, recap/prep schema, Figma=SoT); OPEN-D11 substrate **resolved** (direct LM inference server, Gemma 4 by Aug 10, 64K ctx); MCP V2 goals contract (PATCH gap); dev plan July 1→~Aug 10; debrief→monthly. 11 full entries in `roadmap/summer-2026/signals/ai-201-meeting-transcripts.md`; PDP/learning → `ai-203-adaptive-learning.md`; goals-MCP → `mcp-internal.md`. |
