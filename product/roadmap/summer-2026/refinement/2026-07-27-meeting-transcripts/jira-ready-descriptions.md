# Jira — Copy-Paste-Ready Descriptions & Stories

**Prepared 2026-07-27 · DRAFT — paste in the refinement call, not before.**
Grounded in team-os `signals/ai-201-meeting-transcripts.md` (to 2026-07-27). `⚠️ OPEN` = do not paste as decided until resolved (see §0 of `jira-refinement-package.md`).
Format: paste each block into the Jira description editor (markdown paste renders headings/bullets/checkboxes).

---

## EPIC — ENG-79199  (rename + replace description)

**New title:** `AI-Powered 1:1 Meetings — Zoom Transcripts, Prep, Recap & Goal Signals (Phase 1)`

**Description:**

**Goal.** For a Betterworks 1:1, generate a private pre-meeting Prep brief; after the meeting, ingest the Zoom transcript (or a manual upload/paste) and produce an AI Recap + Goal recommendations. No AI output reaches a performance record without explicit user confirmation.

**Phase-1 scope (locked).** Zoom is the sole automated source (+ manual upload/paste); Goals is the sole recommendation output; 2 direct 1:1 participants only; native Zoom OAuth, no bot recording (ADR-D-001); private LLM stack only (LM Engine, direct inference endpoint — no external APIs).

**Architecture (current, post-July).**
- Recommendations are derived from **structured meeting data only — not the transcript** (7/7).
- Reconciliation is a **routine task**, not a standalone step (7/7).
- Inference: direct LM inference endpoint; **Gemma 4 replaces Llama by ~Aug 10**; 64K-token context (OPEN-D11 resolved 6/29).
- Storage: all sources route through **S3 → LM Engine**; raw transcript persisted in S3 with a TTL. ⚠️ OPEN — TTL value (2–6 mo proposed, Anuj to recommend).

**Consent (locked 7/7–7/21).** Three-level (org / user via Connect Apps panel / series checkbox default-ON opt-out); default opt-in with opt-out for Zoom + manual; full participant consent required for a transcript-derived recap; third-party join discards the recap; revoke halts future gen, retains past.

**Release gates.** Spikes + I/O contract signed before implementation; **InfoSec review (Brian Jacobs)**; webhook PR needs JB + JZ review.

**Out of Phase 1.** Teams (Winter); recognition/skills/feedback extraction (own Winter feature); prep-recap/pre-processing (Winter); TechWolf (post-summer). P2 (post-MVP, summer): series-level consent checkbox, per-instance sensitivity flag, multi-transcript upload, multi-transcript insights.

**Cross-refs.** Child epics ENG-74407 (Zoom Connector), ENG-82387 (AI Signal Extraction), ENG-82991 (Functional & UI). No implementation stories directly under this epic.

**Timeline / fixVersion.** ⚠️ OPEN — set once §0.4 dates are canonical.

---

## EPIC — ENG-82387  (replace description — major rewrite)

**Description:**

**Scope.** AI signal-extraction for Phase-1: from a 1:1 transcript + structured meeting data, produce Prep brief, Recap, and Goal recommendations via the private LLM stack.

**Inputs / outputs.**
- Recommendations use **structured meeting data only (not the transcript)** (7/7).
- AI emits **two suggestion types — create / update-close** — each with entity IDs for UI grouping (6/16).
- Generation logic: upcoming meeting → **Prep + Recap + Recs**; past meeting with a new transcript → **Recap only** (refresh Prep/Recs if feasible) (7/1).
- Refresh semantics: **Recap = persona-agnostic** (refreshes for all at once); **Prep + Recs = persona-specific** (refresh only requesting user) (7/2).

**Inference.** Direct LM inference endpoint (LM Proxy can't do structured/function calling via LangChain); Gemma 4 by ~Aug 10; 64K context. *(Removes prior "Option B vs C — TBD in spike.")*

**Reconciliation.** Routine task within extraction — **not a standalone capability/step** (7/7).

**Data model / NFRs.**
- Extensible multi-source schema (Zoom now; Teams/Slack/Jira/free-text later without rework) with **series + instance IDs, transcript-source enum, content hash** to avoid reprocessing (6/30, 7/2).
- **Horizontal scaling (HPA)** for ~1,600 concurrent participants / ~400 simultaneous transcripts (6/16).
- Multi-segment: each recording segment = a separate transcript; pipeline reconciles segments per meeting (7/9).

**PII.** ⚠️ OPEN — reconcile with eval gate ENG-83006 (recall ≥0.90) vs spike ENG-82135; resolve before AC is final.

**No-transcript (non-happy) flow.** ⚠️ OPEN — eval (7/22) shows the full 5-section output isn't reliably fillable (28% all-empty); dedicated schema vs confidence-bar/error-state fallback undecided.

---

## EPIC — ENG-74407  (edit description)

Append / update:
- **Ownership:** inbound webhook gateway is owned by the **India/AI team** (not Integrations, 7/8); built as a **shared platform component** (spike ENG-82678 → Done); **JB (App Platform) + JZ (AI/Data Platform) mandatory PR reviewers + InfoSec sign-off before merge.**
- **Zoom auth:** admin-level **org OAuth, one-time per org — no per-user Zoom redirect** (6/16).
- **Ingestion ownership:** transcript ingestion/preprocessing + speaker resolution owned by **MeetingsPod** (6/10); speaker-ID accuracy target **90–95%** on email + employee-ID match.
- **Timeline:** replace "Summer GA" with canonical dates (§0.4).

---

## EPIC — ENG-82991  (edit description)

- **Meeting state model:** ⚠️ OPEN — reconcile with spike ENG-82992 ("no stored state field, no hardcoded 24h timer, hang generation off the rollover cron"). Remove the formal state-machine + 24h-timer mandate pending §0.2.
- **Item-level notes phase:** ⚠️ align to §0.3 (parent lists as P2).
- **Surface schemas (locked 6/25):** 5 meeting-state tags (one shown at a time); recap = Summary / Blockers (≤3) / What-Happened / Follow-ups (≤5), duration-scaled; prep = ARC Synthesis + Attention Flags + Goal Signals; **"AI Suggested" header removed.**
- **Transcript validation (add AC below).**

---

## EXISTING-STORY AC to append (paste under Acceptance Criteria)

**ENG-83000 Manual Transcript Upload / ENG-82999 parsing spike / ENG-82991:**
- [ ] Accept MIME `text/vtt` and `text/plain` only; reject others with a user-facing error.
- [ ] Reject files > 5 MB.
- [ ] Require valid VTT with speaker tags; every unique speaker tag must map to a Betterworks user.
- [ ] Manual upload is the default state; when Zoom is connected, Zoom takes precedence (multiple Zoom transcripts selectable via dropdown).
- [ ] Delete = soft delete. Multi-file upload supported; upload/paste available before and after meeting end.

**ENG-82390 Meeting Recap Generation / ENG-83005 Prep / ENG-83488 Recs:**
- [ ] Recap refreshes persona-agnostically (all participants at once); Prep + Recommendations refresh only the requesting user.
- [ ] Independent refresh per component (Meeting-level and Prep-Summary).
- [ ] Partial-failure handling: if one component fails, others still render; failed component shows a defined error state.

**ENG-82989 Per-meeting exclusion & data governance / ENG-82387:**
- [ ] Consent flag rides the Meetings → AI payload; per-participant; future meetings only; no retroactive processing.
- [ ] Recap generated only if all participants consented; a non-consenter excludes the transcript; unplanned third-party join discards the recap.

**ENG-83006 Evaluation framework:**
- [ ] Confidence-threshold cutoff for AI-output display is DEFERRED until real-data quality is observed (7/9) — track as a follow-up, not a launch AC.
- [ ] ⚠️ Reconcile PII thresholds (recall ≥0.90, FP ≤0.05) with the pipeline's PII decision (§0.1).

---

## NEW STORIES to create

### Consent architecture (three-level)  — under ENG-74407 / ENG-82991
**Description:** Implement org + user (Connect Apps side panel) + series ("Sync meeting transcripts" checkbox, default ON, per-series opt-out) consent. Existing series get a Connect banner + confirmation pop-up.
**AC:** [ ] Org enablement precondition enforced. [ ] User panel covers all future series. [ ] Series checkbox default ON, opt-out honored end-to-end. [ ] Consent state propagated to AI payload.
*(Series checkbox = P2; ship after core ingestion + AI insights.)*

### No-transcript flow — dedicated output schema + fallback  — under ENG-82387  ⚠️ blocked on §0.5
**Description:** Define a schema for the non-happy (no-consent / no-transcript) flow that fills only reliably-available sections (what_happened, follow_ups) and surfaces a confidence-bar/error-state fallback for the rest, per the 7/22 eval.
**AC:** [ ] Non-happy schema defined & documented. [ ] Judge confidence bar drives show vs error-state. [ ] No silent degradation.

### Per-instance "sensitive" flag  — under ENG-82991  (P2)
**Description:** Store a per-instance sensitive flag; never send flagged instances to AI; flagging post-ingestion regenerates recap/prep without that instance (AI feasibility pending).
**AC:** [ ] Flag stored, never transmitted to AI. [ ] Post-ingestion flag triggers regeneration without the instance.

### AI-recommendation acknowledgment tracking  — under ENG-82387
**Description:** Schema change to track acknowledgment/action on AI recommendations for future analytics (7/27).
**AC:** [ ] Schema supports per-recommendation ack state. [ ] Ack captured from the UI surface.

### InfoSec review gate  — link as blocker on ENG-79199
**Description:** Consent & data-handling doc → Brian Jacobs review is a summer-release gate. See `infosec-consent-doc.md`.
**AC:** [ ] Doc published to Confluence. [ ] InfoSec sign-off recorded before release.

### Multi-segment transcript reconciliation  — under ENG-82387 (or fold into ENG-82430)
**Description:** Merge multiple recording segments (and drop/rejoin cases) into one meeting's transcript for processing.
**AC:** [ ] Segments reconciled into a single transcript per meeting. [ ] Host reassignment not required if ≥1 participant remains.
