# Confluence / PRD Redlines — ENG-79199 (AI Meeting Transcripts)

**Prepared:** 2026-07-27 · **Status:** DRAFT — proposed content changes, nothing published to Confluence.
**Source of truth:** team-os signals ledger (current to 2026-07-27). **Open items are marked `⚠️ OPEN`** — do not publish those as decided.

> **Freshness note:** all 4 pages show "modified" Jun 10–12, but the change is a structural bulk touch; the *content* is May-vintage. The only genuinely June work is 4 "Research Notes" pages (6/15) that were never folded into the PRDs — harvest them before rewriting.

---

## PAGE PRIORITY ORDER

| Order | Page | pageId | Why first |
|---|---|---|---|
| 🔴 P0 | Connect Layer | 4282515524 | Owns consent/OAuth — the biggest July change; also unblocks the InfoSec doc |
| 🔴 P0 | Zoom Connector | 4282744869 | Worst offender — overdue open decisions, storage still "persist vs discard" |
| 🟠 P1 | Meetings AI Surfaces | 4281139203 | Persona/refresh model, finalized schemas, header removal |
| 🟠 P1 | Parent PRD | 4280614960 | Reversals, storage, timeline, child-CAP version drift |
| 🟡 P2 | Repo PRD trio (v0.8.0) | — | Front-matter + reversals |

---

## 🔴 Connect Layer (4282515524)

**Replace the retention/consent sections with the July-locked model:**

- **Three-level consent (LOCKED 7/8):**
  1. **Org** — admin enables Betterworks Zoom app once per org (no per-user Zoom redirect).
  2. **User** — global "Connect Apps" side panel; covers all future series.
  3. **Series** — "Sync meeting transcripts" checkbox, **default ON, per-series opt-out**. *(Series checkbox itself is P2-deferred until core ingestion + AI insights ship.)*
- **Default posture (7/21):** opt-in with user opt-out; **same for Zoom AND manual uploads.**
- **Consent gating (LOCKED 7/7):** full participant consent required for any transcript-derived **recap**; any non-consenter excludes the transcript; **notes / agenda / action items are NOT consent-gated**; **unplanned third-party join discards the entire recap**; retroactive consent = **no backfill**; **revoked consent halts future generation but retains past artifacts** (pending InfoSec).
- **Sensitive flag:** per-instance "sensitive" flag stored, **never sent to AI**; flag applied post-ingestion → recap/prep regenerated without it (AI feasibility pending). *(P2.)*
- **Existing series:** Connect banner + confirmation pop-up (not a full re-flow).
- **Ownership/gates:** webhook = shared platform component owned by India/AI team; **JB + JZ reviewers + InfoSec sign-off before merge.**
- **Remove/replace stale:** the 90/180/90-day Aurora-only retention defaults; the assumption "Zoom scopes pre-approved, no marketplace review delays" (invalidated — 8–13 wk review); May-31 dates.
- **⚠️ OPEN:** transcript raw-storage = S3 + TTL (value not finalized — Anuj to recommend, 2–6 mo proposed); Zoom-vs-manual upload race condition; exact revoke/retention final wording (pending InfoSec).

## 🔴 Zoom Connector (4282744869)

- **Storage:** replace ZD-002/ZOPEN-D2 "persist vs process-and-discard (open)" with the current direction: **all sources route through S3 first, then LM Engine; raw transcript persisted in S3 with a TTL.** ⚠️ **OPEN — TTL value not locked.**
- **Dates:** remove Rainforest 2026-05-31 and Marketplace-submission 2026-06-09 (both ~7 wks overdue); ZOPEN-D4 is self-labeled "OVERDUE." Insert canonical dates once 0.4 is resolved.
- **Consent/admin:** admin-org one-time OAuth; three-level consent (cross-link Connect Layer).
- **Keep (still valid):** native Zoom / no-bot (ADR-D-001, strongest statement here); MVP = exactly 2 participants; Zoom-only source.
- **Multi-segment:** each recording segment = separate transcript; host reassignment not required if ≥1 participant remains — pipeline reconciles segments.

## 🟠 Meetings AI Surfaces (4281139203)

- **Persona/generation model (supersedes "one shared brief" AND the old "separate manager/report records" framing):**
  - Upcoming meeting → Prep + Recap + Recommendations; past meeting with new transcript → **Recap only**.
  - **Recap = persona-agnostic** (refreshes for all participants at once); **Prep + Recommendations = persona-specific** (refresh only the requesting user).
  - Independent per-component refresh (Meeting-level and Prep-Summary); partial-failure handling.
- **Finalized surface schemas (LOCKED 6/25):** 5 meeting-state tags (one shown at a time); **recap** = Summary / Blockers (≤3) / What-Happened / Follow-ups (≤5), duration-scaled caps; **prep** = ARC Synthesis + Attention Flags + Goal Signals; **"AI Suggested" header REMOVED.**
- **Scope:** Phase-1 = **Goals signal only** (recognition/feedback/skills → Winter). Keep this — it's the crispest statement in the set.
- **Handoff:** Figma = source of truth for dev handoff; Claude = flows/prototypes only (6/25).
- **Version drift:** page is v0.3.0 while parent claims v0.6.0 with CAP-206/207 — reconcile the numbering.

## 🟠 Parent PRD (4280614960)

- **Reversals (7/7):** recommendations from **structured meeting data only** (not transcript); **reconciliation = routine task**, not a core CAP.
- **Inference (6/29):** direct LM inference endpoint; Gemma 4 by ~Aug 10; 64K context.
- **Storage:** add the S3+TTL raw layer and "all sources route S3 → LM Engine" flow (currently Aurora-evidence-only). ⚠️ TTL value OPEN.
- **Timeline:** remove May-31 Rainforest / PAC-17 target; insert canonical dates.
- **Coaching cards / item-notes:** make parent consistent with children (per Jira 0.3).
- **Version drift:** fix references to child CAP-206/207 that don't exist in live children.

## 🟡 Repo PRD trio (`ai-processing-pipeline` v0.8.0 + `meetings-ai-surfaces` + `connect-layer`)

Frozen 2026-05-13. Checklist:
- Front-matter: `design_lead: gauri.thakur` → **Harshini Vijay**; `eng_lead_pipeline: [TBD]` → fill; `rainforest_milestone: 2026-05-31` → canonical dates; drop Teams `INT-181` as in-scope (Teams = Winter).
- Body: apply the two 7/7 reversals; publish `connect-layer` (still "[TBD — to be published]" in the index — the consent model lives there).
- After sync, **rebuild `product/roadmap/summer-2026/jira-diff.md`** (dated 5/13, predates the whole 6/7 decomposition) from the ledger.

---

## Cross-cutting: what stays TRUE across all pages (do not "correct")
Native Zoom OAuth / no bot (Recall.ai rejected); private LLM stack only (LM Engine + LM Proxy, no external APIs); Phase-1 Zoom-only source + Goals-only output; MVP = 2 direct participants only.
