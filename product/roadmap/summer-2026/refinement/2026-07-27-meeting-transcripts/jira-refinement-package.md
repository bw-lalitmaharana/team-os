# Jira Refinement Package — ENG-79199 (AI Meeting Transcripts)

**Prepared:** 2026-07-27 · **Author:** Lalit (drafted by Claude) · **Status:** DRAFT — to land in a refinement call. Nothing here has been written to Jira.
**Source of truth:** team-os `product/roadmap/summer-2026/signals/ai-201-meeting-transcripts.md` (current to 2026-07-27).
**Process rule:** all Jira writes happen collectively in the refinement call. This doc is the agenda + the diff.

---

## 0. Resolve FIRST — these gate the AC rewrites and the fixVersion set

| # | Decision needed | Conflict today | Owner |
|---|---|---|---|
| 0.1 | **PII handling** | AI spike ENG-82135 says *"ignore PII (no action)"*; parent epic constraint, ENG-82393 (PII handling), and eval gate ENG-83006 (recall ≥0.90, FP ≤0.05) all require masking/detection. Pick one. | Lalit + Sagar |
| 0.2 | **Meeting state model** | ENG-82991 mandates a formal state machine + 24h/cron close; spike ENG-82992 concludes "no stored state field, no hardcoded timer, hang off rollover cron." | Anuj + Meetings |
| 0.3 | **Coaching cards & item-level notes phase** | Parent = "brief minus coaching cards" + item-notes P2; AI epic = "lightweight coaching_brief" in P1; ENG-82991 = item-notes in P1. | Lalit |
| 0.4 | **Canonical release dates** | Memory: Aug 29 ship / Aug 15 pre-prod. Lalit 7/23: Aug 7 RF / Aug 14 Champagne / Aug 21–24 prod. Tanveer 7/24: Aug 10 RF / Aug 19 Champagne / Aug 26 prod. Interim UI slip (7/20) to end-of-July. **Cannot set fixVersion until locked.** | Lalit + Tanveer + Nellie |
| 0.5 | **Non-happy (no-transcript) path** | 7/22 eval: full 5-section output not fillable (28% all-empty). Separate schema vs confidence-bar/error-state fallback — undecided. | Lalit + Hemant |

---

## 1. Epic renames & description rewrites

### ENG-79199 — Parent epic  *(In Progress, last touched 6/10)*
- **Rename:** drop "Pipeline" framing (pending since 6/10 Nellie 1:1). Proposed: *"AI-Powered 1:1 Meetings — Zoom Transcripts, Prep, Recap & Goal Signals (Phase 1)."*
- **Add:** consent architecture (three-level, §4.3), InfoSec review as a release gate, storage model (S3 + TTL — *TTL value OPEN, Anuj to recommend*), Aug release timeline + fixVersion.
- **Reconcile:** coaching-cards & item-notes phase (per 0.3) so parent and children agree.
- **Fix version-drift:** parent references child CAP-206/207 that don't exist in the live child PRDs.

### ENG-82387 — AI Signal Extraction  *(In Progress, 6/23)* — **major rewrite**
- **Reversal 1 (7/7):** Recommendations use **structured meeting data only — not the transcript.** Remove transcript-driven recs language.
- **Reversal 2 (7/7):** **Reconciliation is a routine task, not a standalone capability/step.** Demote the reconciliation CAP.
- **Resolved (6/29, OPEN-D11):** inference = **direct LM inference endpoint** (LM Proxy can't do structured/function calling via LangChain); **Gemma 4 replaces Llama by ~Aug 10**; **64K-token context** default. Remove "Option B vs C — TBD in spike."
- **Add NFRs:** extensible multi-source schema (series+instance IDs, source enum, content hash to avoid reprocessing); **HPA horizontal scaling for ~1,600 concurrent / ~400 simultaneous transcripts.**
- **Add generation logic:** upcoming → Prep+Recap+Recs; past-with-new-transcript → **Recap only**. Recap **persona-agnostic**; Prep+Recs **persona-specific**.

### ENG-74407 — Zoom Connector  *(In Progress, 6/17)*
- **Ownership:** webhook gateway now owned by **India/AI team** (not Integrations, 7/8); built as a **shared platform component** (spike ENG-82678 → Done); **JB + JZ mandatory PR reviewers + InfoSec gate before merge.**
- **Consent:** admin-level **org OAuth, one-time per org — no per-user Zoom redirect** (6/16).
- **Timeline:** replace "Summer GA" with canonical dates (0.4).

### ENG-82991 — Functional & UI Changes  *(In Progress, updated 7/27)*
- **Reconcile with spike ENG-82992** (per 0.2): remove/replace the state-machine + 24h-timer mandate.
- **Fix phase conflict:** item-level notes — align to whatever 0.3 decides.
- **Add:** transcript validation ACs (§3), finalized surface schemas (§3), "AI Suggested" header removed.

---

## 2. Structural fixes

- **Set fixVersions on all 44 issues** (currently empty on every issue → no release encoded anywhere). Blocked on 0.4.
- **Fix parent↔child-epic hierarchy:** ENG-74407 / ENG-82387 / ENG-82991 are not linked to ENG-79199 by a queryable parent/Epic-Link field (only in a description table / Advanced-Roadmaps link). Repair so the tree resolves in JQL and roadmaps.
- **Re-home ENG-82392 "AI – DB Migrations"** — currently a direct child of the epic, contradicting "no implementation stories under this epic." Move under ENG-82387.
- **Move integration stories → MeetingsPod epic** (MeetingsPod owns ingestion/preprocessing + speaker resolution per 6/10; pending ~29 days).
- **Verify ENG-82390 three-way split status** — ledger (7/9) says Agenda-Topic / Goal-Rec / Summary-Action-Item kept as distinct tickets; Slack says the split "was never applied." Confirm live state. (Callback→"Update Endpoint" = ENG-84148 and S3-read+process merge = ENG-84092 appear already done.)
- **Epic title of ENG-82387** references "Pipeline" wording too — align with the parent rename.

## 3. Existing-story edits (map decisions → tickets)

| Decision (date) | Ticket(s) | Edit |
|---|---|---|
| Transcript validation: MIME vtt/txt, ≤5 MB, valid VTT speaker tags → BW users (7/1) | ENG-82991 / ENG-83000 (Manual Upload) / ENG-82999 (parsing spike) | Add as AC |
| Generation + refresh semantics (7/1, 7/2, 7/27): per-component independent refresh, partial-failure handling | ENG-83005 (Prep), ENG-82390 (Recap), ENG-83488 (Recs), ENG-82997/82996 (UI cards) | Add AC |
| Surface schemas locked (6/25): 5 state tags, recap Summary/Blockers≤3/What-Happened/Follow-ups≤5 (duration-scaled), prep ARC+Attention+Goal Signals; header removed | ENG-82993, ENG-82997, ENG-82996, ENG-82995 | Update AC to match locked schema |
| Consent flag rides Meetings→AI payload; per-participant, future-only, no retroactive (6/16) | ENG-82989 (exclusion/governance), ENG-82387 | Add AC |
| Multi-segment / drop-rejoin: each segment = separate transcript, pipeline merges (7/9) | ENG-82430 (retrieval), ENG-82387 | Add AC |
| Manual-upload default state; Zoom precedence w/ dropdown; soft delete; multi-file upload (7/8, 7/9) | ENG-83000, ENG-82998 (transcript tab) | Add AC |
| Two suggestion types (create / update-close) w/ entity IDs for UI grouping (6/16) | ENG-82416 (goal rec surface), ENG-82397 | Add AC |
| Confidence-threshold cutoff for AI display DEFERRED to real data (7/9) | ENG-83006 (eval gate) | Note deferral in AC |

## 4. New stories to create

1. **No-transcript flow — dedicated schema + confidence-bar/error-state fallback.** *(Blocked on 0.5.)* Under ENG-82387.
2. **Consent architecture (three-level: org / user via Connect Apps panel / series-level checkbox default-ON opt-out).** Under ENG-74407 / ENG-82991.
3. **Per-instance "sensitive" flag** — stored, never sent to AI; flagging post-ingestion regenerates recap/prep without it (AI feasibility pending). *(P2 — see §5.)*
4. **AI-recommendation acknowledgment tracking** (schema change, 7/27). Under ENG-82387.
5. **InfoSec-review release gate** — consent doc → Brian Jacobs approval blocks release. Link as blocker on ENG-79199.
6. **Multi-segment transcript reconciliation** (if not folded into ENG-82430).

## 5. Deferrals to encode (label P2 / Winter)

- **P2 (post-MVP, still summer):** series-level consent checkbox, per-instance sensitivity flag, multiple-transcript upload, AI insights from multiple transcripts.
- **Winter:** Teams source; Phase-2 signal extraction (recognition / skills / feedback → its own Aha feature); prep-recap / new pre-processing features; TechWolf integration (post-summer, coordinate via Integrations roadmap in Aha).

## 6. Process-gate call-out (not an edit)

All three spikes — **ENG-82135, ENG-82987, ENG-82992** — are still **In Progress**, yet implementation stories are already In Progress / Code Review / Ready-for-QA (e.g., ENG-82994, ENG-84414). This violates the parent's "spikes sign off + I/O contract signed before implementation" gate. ENG-82135's I/O contract was due 6/16 (~6 weeks overdue). Decide in refinement: close the spikes formally or re-baseline the gate.
