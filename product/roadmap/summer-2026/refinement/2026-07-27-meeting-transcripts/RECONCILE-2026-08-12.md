# Reconcile — ENG-79199 package vs. latest updates (2026-08-12)

Updates the 2026-07-27 package with decisions since. **Nothing written to Jira/Aha/Confluence.**
**Source of truth:** team-os `signals/ai-201-meeting-transcripts.md` (current through 2026-08-11) + Zoom/Slack sweep through 2026-08-06.
**⚠️ Not yet re-verified live:** direct Jira/Confluence state — the Atlassian connector token is expired (re-auth via `/mcp`). Jira facts below are **secondhand from the ledger's daily Jira/Gmail notification sweeps**, reliable but to be confirmed against Jira once reconnected.

---

## 1. Status of the 5 blocking decisions (§0 of the package)

| # | Item | 7/27 status | **Now (8/12)** |
|---|---|---|---|
| 0.2 | **Meeting state model** | OPEN (state-machine vs cron) | ✅ **RESOLVED = rollover-cron.** Pipeline triggers on a rollover cron **2–5 min after a new meeting instance is created** (Zoom walkthrough 8/6); **"one active upcoming meeting at a time"** — prep suggestions surface only for the immediate next instance, and only after the preceding meeting completes (Hiten/Lalit 7/28). The ENG-82991 state-machine mandate is superseded. |
| 0.5 | **Non-happy (no-transcript) path** | OPEN (separate schema vs fallback) | ✅ **RESOLVED = confidence-judge fallback** (not a separate schema). A confidence-scoring judge (**threshold ~0.85**) suppresses low-quality prep/recap output and falls back to a defined state (8/6 walkthrough). Follows Hemant's 7/22 eval (28% of real meetings had all 3 insight sections empty). |
| 0.3 | **Coaching cards / item-notes phase** | OPEN (P1 vs P2) | ✅ **Settled as P2.** `status.md` still lists coaching cards under "Deferred to Phase 2"; no in-window entry promotes them. Downgrade from "blocking decision" to "confirmed P2." |
| 0.1 | **PII handling** | OPEN (ignore vs mask) | 🔴 **STILL OPEN — and now higher-risk.** The conflicting spike **ENG-82135 closed "Done" (7/27) without recording a mask-vs-ignore decision.** Eval-gate reconciliation (recall ≥0.90 / FP ≤0.05 in ENG-83006) is unaddressed. Feature is now **live on Rainforest** → this is a compliance gap, not a paper one. **Still needs a call.** |
| 0.4 | **Canonical release dates** | OPEN (3 conflicting sets) | 🟠 **STILL UNRECONCILED, but converging.** Most concrete signal: the live PRFAQ (4247257097, updated 8/11) now states **Code-Ready Aug 26 2026** — aligns with Tanveer's Aug 26 prod. Feature **deployed to Rainforest ~Aug 3–5** (matches the ~Aug 7–10 RF target); flag on for the whole RF env (8/5, dev-stage/mock data). Ship gated by **Nellie on NYU/Devon blessing** (8/6). `status.md` still shows stale pre-prod Aug 15 / release Aug 29. **fixVersions verified still empty across the whole tree (8/12).** First external demo: Aug 8 (Nataliya). |

**Net:** 2 of 5 resolved (state model, non-happy path), 1 settled (coaching = P2). **2 still open — PII and canonical dates — and both are now the critical path.** PII is a live compliance risk; dates block fixVersion + external commitments.

---

## 2. New decisions since 7/27 — fold into the package

**Admin settings / enablement (major — 8/4):**
- **Single AI admin setting, not three.** Accordion UI, header **"1:1s: AI based Insights"**; sysadmin flag **`meetings_insights`** (Jira org-setting flag `ENG-85171_meetings_ai_insights_orgsetting`). Three sub-feature identifiers are passed **only** in the like/dislike feedback API — not independently toggleable.
- The setting **gates AI inference only** (prep / recap / recommendations / close suggestions). **Transcript tab, Zoom connect, and calendar side panel are always visible**, independent of the flag.
- **"1:1 AI Meeting Summary" (legacy) and "AI-based Insights" are mutually exclusive** — enabling one disables the other (8/4, reconfirmed at 8/6 walkthrough).

**Connect / consent flow:**
- **Calendar connection is a prerequisite for Zoom connect** — the Zoom button is disabled until a Google/Outlook calendar is linked (8/6). Open **Q18** (Anuj): are transcripts associated to 1:1s via the **calendar service only**? If yes, connecting Zoom without a calendar must prompt calendar connect (gates ENG-82994 AC17).
- **Series-level transcript opt-out toggle** to be added (Nellie 8/7) — still P2 for build, but now an explicit design ask.
- Final **UI copy** for transcript states agreed (8/10): Zoom-connected = "Your transcript will be available after the meeting ends. You can also upload or paste a transcript."; no-Zoom = "You can upload or paste a transcript after the meeting ends."

**Behavior:**
- **Dismissed recommendations re-surface up to 3×, then suppressed** (threshold to revisit) (8/6).
- **MVP = one Zoom transcript per 1:1;** multi-transcript handling deferred (8/10) — confirms the P2 item.

**Scope reaffirmed (not new, but now explicit — Sriram/Holly 8/4–8/5):** Summer = **1:1s only** (team meetings tracked separately as MEET-52); transcript data flows to **agenda items, action items, and goals only**; **feedback & recognition generation are OUT**; **Zoom is the sole source.**

**New P2 / deferred items logged:** like/dislike feedback on suggestions; recognition & feedback in recommendations; dept/group-level AI enablement; goal-side-panel modal; AI-processing-ready notification.

**Terminology still open:** "Transcripts" vs "AI Transcripts" tab name (Harshini 7/28) — pending Paul/Nataliya.

**Follow-on eng:** HTML→Markdown conversion for LLM input (llm-engine PR #603); Meeting Summary shared notes is the first use case; FS/PS/Skills flagged follow-on (8/6).

---

## 3. Jira execution deltas (secondhand via ledger — confirm on reconnect)

| Ticket | Change | Date |
|---|---|---|
| **ENG-82135** AI Recommendation Architecture (spike) | → **Done** (but PII decision not recorded — see 0.1) | 7/27 |
| **ENG-85171** Admin Setting for New Meetings AI Insights | → **Code Review**; org-setting flag set | 8/7 |
| **ENG-82397** AI suggestions & completions – UI | broadened to unified suggestions+completions; **AI completions split into new story ENG-86085** (In Progress); now Ready For QA | 8/7–8/10 |
| **ENG-82390** Meeting Recap Generation | → **Ready for Development**; Hemant co-assignee w/ Sagar | 8/11 |
| **ENG-84147** Infra: Refresh · **ENG-84148** API contract & I/O | → **In Progress** | 8/7 |
| **ENG-83005** Prep · **ENG-83004** Goal Signal · +84147/84148 | **Sagar Bhat reassigned self, replacing Hemant** on core pipeline subtasks | 8/7 |
| **ENG-82994** Connect Zoom UX | consent-flow commit **merged 8/3 (broke E2E)**; PR to be **split** | 8/3–8/7 |
| New build items: **ENG-85195** "Deploy Gemma 4 to Prod" (Draft), **ENG-86085** AI Completions (In Progress), **ENG-85841** Zoom Transcript Ingestion, **ENG-85691** Trigger AI Processing–Upload, **ENG-85716/85719** transcript formatting/HTML→text; new **ENG-85201** epic "Meeting Summary in Conversations" (+ ENG-85194); **ENG-85446** NYU timeout fix (Done) | created | 7/27–8/11 |

Structural items from the 7/27 package **still NOT done** (verified live 8/12): ENG-79199 **rename** (title unchanged, epic body untouched since 6/10), **fixVersions** (empty on all 29 tree issues + parent), and the parent↔child-epic hierarchy link. Spike closures **PARTIAL**: ENG-82135 Done, ENG-82992 Done, ENG-82999 Done — **only ENG-82987 (Zoom Marketplace/API feasibility) is still In Progress** (unchanged since 6/23, 0 comments).

---

## 3b. Live Jira/Confluence verification (8/12) — did the 7/27 proposals land?

Atlassian reconnected; verified directly. **Of the eleven 7/27 proposed changes, only the spike closures partially landed. Everything else is still not done.**

| 7/27 proposed change | Live status (8/12) |
|---|---|
| Rename ENG-79199 (drop "Pipeline") | ❌ NOT DONE — title unchanged; epic body untouched since 6/10 |
| Set fixVersions across tree | ❌ NOT DONE — empty on all 29 changed issues + parent + every fetched key |
| Close/verify the 3 spikes | ◐ PARTIAL — ENG-82135 ✅, ENG-82992 ✅, ENG-82999 ✅; **ENG-82987 still In Progress** |
| Resolve PII conflict | ❌ NOT DONE — ENG-82393 still Ready-for-Refinement, unassigned, 0 comments since 6/22, still mandates full masking + legal sign-off; ENG-82135 (Done) body still says "ignore PII." Contradiction intact. |
| Reconcile meeting-state model | ❌ NOT DONE in Jira — decision is rollover-cron, but **ENG-82991 epic body still says "formal state machine, cron-driven close"**; only post-7/27 note on ENG-82992 is Anuj "It's a spike" (7/28) |
| New story: consent architecture | ❌ No new build story (only Xray test cases ENG-86018→86041); build sits on pre-existing **ENG-82994** (In QA) |
| New story: no-transcript/confidence-judge | ❌ NONE created (decision made, not ticketed) |
| New story: per-instance sensitive flag | ❌ NONE |
| New story: AI-rec acknowledgment | ❌ No dedicated story (ENG-86085 adjacent) |
| New story: InfoSec gate | ❌ NONE |
| Update the 4 Confluence PRDs | ❌ All 4 untouched since June (see below) |

**Landed anyway (not on the 7/27 list):** single AI admin setting **ENG-85171** (In QA), Gemma-4 deploy **ENG-85195** (Draft), AI-completions split **ENG-86085** (In Progress). The tree has moved hard into **QA** — ENG-83000/83001/82994/85171 In QA; 82996/82997/82397/84414/83003 Ready-for-QA.

**Confluence — the living doc has MOVED off the 4 PRDs:**
- The 4 canonical PRDs (4280614960 / 4281139203 / 4282515524 / 4282744869) are **all frozen since June** — none edited since 7/27.
- The **live doc is PRFAQ `4247257097`** ("Zoom & Teams Transcripts Feature Documentation"), rewritten **2026-08-11 by Nataliya Kolb**: dual-path (Zoom API + manual), **Code-Ready target Aug 26 2026**, and it now carries the consent content (User Permission/Consent/Per-Meeting Exclusion + GDPR erasure cascade). New eng page **`4350935050` "AI Meeting Transcript: DB Schema"** (Sagar, ~8/11).
- **Nellie's requested enablement/personalization doc → still NOT FOUND.** **InfoSec consent doc → still NOT FOUND** (PRDs list Security/Legal review as "[TBD]").
- **Implication for the package:** the `confluence-redlines.md` / `confluence-ready-blocks.html` targeting the 4 PRDs are still valid, but the team's actual surface is now the **PRFAQ 4247257097** — redline that too, and note its **Aug 26 code-ready** as the most concrete date signal (aligns with Tanveer's Aug 26 prod).

**Data-quality flags to raise:** ENG-84026 and ENG-85446 are marked **Done** but their latest comments (Satish Tripathi, 8/6) note unresolved follow-ups; **ENG-85171** has an 8/11 QA "needs attention" (PrepCard error-state may fire even with the org flag disabled).

## 4. New risks / gates (post-7/27)

- 🔴 **Zoom-integration / transcript webhook PR unmerged and "not approvable"** — needs rework + a confirmed owner (Integrations vs Data Platform). **Biggest release risk** — blocks end-to-end RF testing.
- 🔴 **InfoSec consent doc still overdue** (~34 days as of 8/12) — Lalit owes Brian Jacobs. The `infosec-consent-doc.md` in this folder is ready to send; it is now **more urgent because the feature is already on Rainforest.**
- 🟠 **ENG-82994 consent-flow commit broke E2E** across Conversation/AI/Goals/Integration pods (8/3) — failing tests unresolved.
- 🟠 **llm-engine Rainforest deployment breakage (8/5)** traced to transcript demo changes.
- 🟠 **Nellie wants a Confluence enablement doc** (personalization/enablement logic) — doesn't exist yet; Lalit owes it.
- 🟠 **AI-settings toggle UX** flagged confusing by Nellie (either/or legacy-vs-new) — open UX decision.
- 🟡 **Danish Sharma on PTO 8/7**; one transcripts engineer down — coverage risk mid-release.

---

## 5. What changed in the package files

- `jira-ready-descriptions.md` — §0.2 and §0.5 ⚠️ OPEN markers updated to **RESOLVED** (rollover-cron; confidence judge). Added the **single AI admin setting** decision and **calendar-prerequisite** to the ENG-82991 / ENG-74407 blocks. PII (§0.1) left ⚠️ OPEN with a sharper compliance note.
- `confluence-ready-blocks.html` — Meetings AI Surfaces block updated: rollover-cron generation trigger, single admin toggle + mutual-exclusivity, calendar-prereq, dismissal-3× rule; non-happy path noted as confidence-judge.
- `infosec-consent-doc.md` — unchanged content; **urgency raised** (feature live on RF). Still the fastest overdue item to clear.
- `README.md` — points here.

## 6. Recommended next moves
1. **Close PII (0.1) and lock dates (0.4)** — the only two blockers left; both are now on the critical path (PII is a live RF compliance gap; dates gate fixVersion + the Aug 8 external demo commitments).
2. **Send the InfoSec consent doc to Brian Jacobs today** — it's drafted and ~34 days overdue.
3. **Reconnect Atlassian (`/mcp`)** so I can confirm the Jira/Confluence deltas and finalize the "already-landed vs still-to-do" list.
4. Land the rest in the next refinement call per process (rename, fixVersions, new tickets for AI-completions + consent architecture + confidence-judge, spike closures).
