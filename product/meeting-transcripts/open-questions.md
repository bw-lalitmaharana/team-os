# Open Questions & Decisions — Meetings Transcripts Feature

> Reconciled 2026-06-08. The original D1–D5 (May framing) are all **resolved** — see "Resolved" below with their ADRs. Genuinely-open items are tracked first. Decision history lives in repo-root `decisions/` (50+ ADRs).

## Active decisions (unresolved)

### OPEN-D11: Inference substrate — raw-text vs embeddings ✅ RESOLVED for MVP (2026-06-29)
**Status:** **RESOLVED for MVP** (Rec. Architecture Sync-up 2026-06-29) — use the **direct LM inference server endpoint** (LM Proxy can't yet do structured/function calling via LangChain), **Gemma 4 in prod by ~Aug 10**, **64K context** default. Embeddings/skill-graph deferred to a future-evolution role (mentor matching SQL-first, embeddings later). _History below was: Open — advancing; eng targeting ~mid-June off a POC._
**Question:** Cross-entity matching on **raw text + LLM API** vs **vector embeddings via a new Embedding API service** (scales better, heavier setup; CPU-light embeddings under consideration vs Gemini).
**MVP path (6/1–6/4):** **live API calls to the goal service (raw-text + LLM)** — acknowledged as not scalable past MVP. Embedding track runs in parallel: Sagar + Pankaj + **Aryan NJ**; Pankaj has Rainforest embedding-server creds; AI team calls existing data sources rather than storing vectors initially.
**POC findings (Hemant, 6/4):** ~60k-token context ≈ 1 hr of meeting; 25s inference latency; 8 prompting techniques tested; next = generate action items/summaries from real transcripts + **LM-as-judge** eval (judge = GPT-5+, temp 0, per Tejas/Okan).
**Owner:** AI Platform (Sagar / Pankaj / Hemant / Aryan) + Lalit. **Do not bake into PRD constraints until resolved.**

### OPEN-D12: Inbound webhook architecture (Integrations)
**Status:** **Direction locked (2026-06-30)** — build **in-house**; Okan's spike found no viable OSS. Service ingests provider events (Zoom/LinkedIn/etc.) → Kafka; now a **dual-use dependency** for PDP/LMS too (6/19), ~9-day build targeting ~July 10. Open sub-item: routing = single `account_id` URL vs per-org URL (see Q12). _History below was: proposed 2026-06-03 (Okan), NOT locked._
**Proposal:** API Gateway → Kafka → microservices, Cloud Events format; dual-use for Zoom transcript ingestion AND TechWolf/Synopsis.
**Risk (Jason Sites):** flips TechWolf from pull-API to vendor-push — a Phase-2 plan change; loop in Meher. Per-vendor auth varies (Basic / OAuth2 / custom) — unresolved.
**Outcome:** Danish to **spike a generic webhook integration framework** (Nellie drafts the spike story + AC); starts wk of 6/9. **Integration-side stories are blocked until this spike completes.** Coordinate naming (inbound vs outbound webhook engine) with App Platform.
**Owner:** Integrations (Danish, Okan) + Nellie.

### OPEN-D9: Per-signal-type data-staleness windows
**Status:** Partially locked.
**Locked (from Lalit's processing doc, confirmed Daily Catchup 2026-05-29):** goals = **1 fiscal year**, feedback = **6 months**, recognition = **3 months**. Other signal types (skill_demo, coaching_theme, action-item / agenda-item carry-forward) TBD.
**Open sub-questions Lalit owes Sagar:** (a) fiscal-period definition for the goals window; (b) data-staleness re-trigger policy when a pre-processing/embedding job fails.
**Owner:** AI Platform + Lalit.

### OPEN-D10 (Q-A1): Single-transcript vs cross-meeting synthesis
**Status:** Open — unresolved across all recent meetings.
**Question:** Does v1 inference operate per-transcript, or synthesize across the last N meetings? Gates the right-rail Recommendations panel and any cross-meeting / HR-talent-rollup feature (research item B-04).
**Owner:** Jay-Z (Jason Zhang) + Lalit.

## Resolved decisions (May framing → ADR)

| Was | Resolution | ADR / source |
|---|---|---|
| **D1** Vendor vs native Zoom | **Native Zoom OAuth.** Recall.ai/bot rejected; automated Zoom is MVP-required (not "if doable"); manual paste is a demo/secondary input path. | ADR-D-001, ADR-D-013, ADR-CD-005 |
| **D2** Processing architecture (unified vs multi-pass) | Evidence-centric, centralized architecture + reconciliation framework; architecture diagram **frozen for implementation** (Refinement 2026-05-27). | ADR-D-003, ADR-D-008 |
| **D3** I/O schema (cross-pod contract) | Becomes the **single signed-off I/O contract** that the 3 spikes (ENG-82987 / ENG-82135 / ENG-82992) must converge on before any story enters a sprint. | parent epic ENG-79199; ADR-D-008 |
| **D4** API versioning | Folded into the AI spike's I/O contract (versioned v1 endpoints, signed off by all pod leads). | parent epic ENG-79199 |
| **D5** Retention policy for pending suggestions | Reframed as **per-signal-type windows** — see OPEN-D9 (goals 1-FY / feedback 6-mo / recognition 3-mo locked). | OPEN-D9; Refinement 2026-05-27 |
| **CD1** Recall.ai | Rejected — bot joins customer meetings (security) + user friction. | ADR-D-001 |

## Open technical questions

| # | Question | Who to ask | Status |
|---|----------|-----------|--------|
| Q1 | LLM/AI service architecture — how AI platform fits into NextGen | Jay-Z | Largely covered by frozen arch diagram (2026-05-27); detail in AI spike |
| Q2 | Engineer allocation to this feature | Sriram / Nellie | Resolved — Anuj, Danish, Sagar, Hemant, Pankaj engaged |
| Q3 | What BW data is available at inference time (RBAC-filtered) | AI team + Goals pod | Open — context-injection scope = OPEN-D9 windows + RBAC filter |
| Q4 | Speaker attribution → BW user IDs (incl. same-name disambiguation) | Integrations pod (Rinku) | In Integrations spike ENG-82987 / story ENG-82430 |
| Q5 | Event-bus schema for async processing state machine | JB / Pankaj | In AI spike; EDA/Kafka CDC noted for embedding updates |
| Q6 | Zoom transcript API format + Zoom↔BW instance correlation | Integrations POC (Anuj/Pankaj) | Partial — double-encoded meeting ID confirmed; missed-instance handling is a new Zoom Connector requirement (recalibration §I.3) |
| Q7 | Transcript storage **TTL value** (2–6 mo proposed) | Anuj (recommend) + Lalit (policy) | Open — decided storage = S3 w/ TTL (6/2); value TBD |
| Q8 | Can users **edit** AI-generated recaps (not just regenerate)? | Harshini + Lalit | Open — recap refresh is per-instance/manual; old recaps may go stale (6/30); editability still unresolved |
| Q9 | Is calendar-connect consent sufficient for the privacy ask (UEFA-type)? | Sriram / Legal | Sriram says yes (standard practice); no formal sign-off recorded |
| Q10 | Meeting-series → Zoom-event mapping edge cases | Anuj (documenting) | Open — gates calendar-service code; PR up, blocked on review |
| Q11 | Keep or drop the "tags" feature (Claude-recommended in designs)? | Harshini + team | Open — value-add questioned at UX Sync 6/3 |
| Q12 | Webhook routing — single Betterworks-wide URL (via `account_id`) vs per-org URL | Pankaj + Danish (offline) | Open (Project Plan 6/16); gates integration impl |
| Q13 | Goal creation from AI card — inline drawer vs redirect to Goals page | Varnica (dev spike) | Open; API shape (inline form, platform-wide) confirmed (6/23, 6/25) |
| Q14 | Org-level feature-flag storage — Meetings DB vs Core DB | Eng | Open (Estimations 6/30) |
| Q15 | Does prod GA require Zoom Marketplace app approval, or does OAuth redirect suffice? | Anuj | Open (Project Plan 6/16) |
| Q16 | Module disable doesn't reliably suppress AI feature flags (sys-admin save restores them) | AI team + Eden UI | Open — **GA-blocking** quality item (6/18) |
| Q17 | How is an AI recommendation persisted into a development goal without information loss? | AI team + Varnica | Open — deferred from MVP (PDP 6/23); V2 design hole |
