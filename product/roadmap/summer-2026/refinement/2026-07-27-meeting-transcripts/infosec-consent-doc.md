# Consent & Data-Handling Design — AI-Powered 1:1 Meetings (Zoom Transcripts)

**For:** Brian Jacobs (Head of InfoSec) · **From:** Lalit Maharana (PM) · **Date:** 2026-07-27
**Status:** DRAFT for InfoSec review — **not published.** Release gate: summer 2026 launch is blocked pending this review.
**Related:** Jira ENG-79199 · Confluence Connect Layer 4282515524 / Zoom Connector 4282744869

> **⚠️ Overdue & now urgent (as of 2026-08-12):** owed to InfoSec since ~7/9 (~34 days). The feature is **already deployed to Rainforest** (~Aug 3–5), so the review is no longer ahead of build — send this now. Content below is unchanged from 7/27 and still accurate; §6 (storage/TTL) and §7 (PII) remain the open items needing your steer.

---

## 1. What the feature does
For a Betterworks 1:1 meeting, the product (a) generates a pre-meeting **Prep brief**, (b) after the meeting ingests the **Zoom transcript** (or a manually uploaded/pasted one), and (c) produces an **AI Recap** + **Goal recommendations**. No AI output reaches a performance record without explicit user confirmation.

## 2. Data scope (locked)
- **Participants:** MVP processes data for the **two direct 1:1 participants only.** Any non-human participant (room system, AI bot) or 3rd+ human causes the event to be handled per §5; no 3rd-party data enters the pipeline.
- **Sources:** Zoom (native user-consented OAuth) + manual upload/paste. **No bot-based recording** (Recall.ai rejected, ADR-D-001).
- **Inference:** **private LLM stack only** — Betterworks LM Engine, direct inference endpoint. **No external LLM API calls.**

## 3. Consent model (locked 7/7 → 7/8 → 7/21)
Three levels:
1. **Org** — admin enables the Betterworks Zoom app once per org.
2. **User** — global "Connect Apps" side panel; covers all future series.
3. **Series** — "Sync meeting transcripts" checkbox, **default ON with per-series opt-out.** *(Series checkbox ships P2.)*

**Default posture:** opt-in with user opt-out, applied identically to Zoom and manual uploads. Rationale: Zoom does not itself require authorization to share transcripts, but because performance conversations are sensitive, Betterworks defaults to "yes" with an explicit opt-out.

## 4. Transcript-derived output rules (locked 7/7)
- **Full participant consent required** for any transcript-derived **Recap**. If any participant has not consented, that transcript is **excluded**.
- **Not consent-gated:** meeting notes, agenda, action items (structured meeting data).
- **Unplanned third-party join → the entire recap is discarded.**
- **Retroactive consent → no backfill** of past meetings.
- **Revoked consent →** future generation halts; **past artifacts retained** (⚠️ final retention wording pending your input).

## 5. Sensitivity & exclusion controls
- **Per-instance "sensitive" flag** — stored, **never sent to AI.** If applied post-ingestion, the recap/prep is regenerated without that instance (AI feasibility pending). *(P2.)*
- Per-meeting exclusion / data-governance controls (ENG-82989).

## 6. Storage & retention  ⚠️ OPEN — needs InfoSec input
- **Direction:** all transcript sources route through **S3 first**, then to the LM Engine. Raw transcript persisted in **S3 with a TTL** (**value not finalized** — 2–6 months proposed; Anuj to recommend). Evidence rows in Aurora.
- **For review:** appropriate TTL for raw transcripts of performance conversations; encryption-at-rest/in-transit posture; access-control boundaries; deletion on disconnect/revoke.

## 7. PII handling  ⚠️ OPEN — internal conflict to resolve
The eval gate (ENG-83006) targets PII detection **recall ≥0.90, FP ≤0.05**; the AI spike (ENG-82135) currently proposes deferring PII masking. **This must be reconciled before review sign-off.** Seeking your bar for what PII handling is required for launch.

## 8. Reviewers & gates
- **This InfoSec review** = summer-release gate.
- Webhook gateway PR requires **JB (App Platform) + JZ (AI/Data Platform)** review + InfoSec sign-off before merge.

## 9. Open items I'd like your steer on
1. Raw-transcript TTL for performance-conversation data (§6).
2. Required PII-handling bar for launch (§7).
3. Revoke/retention final policy — retain-past vs purge (§4).
4. Anything in the third-party-join discard / manual-upload paths that needs a stronger control.
