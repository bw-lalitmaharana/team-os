# Meeting-Transcripts (ENG-79199) — Jira Description Delta, 2026-08-12

**Nothing has been written to Jira, Aha, or Confluence.** Per process, system-of-record writes happen in a refinement call. This folder is review-only.

## What this is — and what it is *not*

This is a **narrow increment**, not a re-run of the 7/27 package.

Earlier today (10:40) `../2026-07-27-meeting-transcripts/RECONCILE-2026-08-12.md` reconciled the 7/27 package forward. Its stated sweep was **"signals through 8/11 + Zoom/Slack sweep through 8/6."** Everything it covers — single AI admin setting (8/4), calendar prerequisite (8/6), rollover-cron state model, confidence-judge non-happy path, dismissal-3× rule, PII and canonical dates still open — is **not repeated here.**

This folder covers the window that reconcile did **not** sweep:

- **2026-08-11 "Meeting Transcripts – Jira Alignment"** (Lalit / Sagar / Hemant, 16:02 IST, 1h05m) — DB schema, API endpoints, UI caps, reconciliation scope
- **2026-08-10 → 08-11 `#meeting-transcript-integration`** — manual-upload vs Zoom consent, single-source lock, Zoom Marketplace submission, P3 list

**Read `RECONCILE-2026-08-12.md` first, then this.**

## Format

Per Lalit's 8/12 direction, changes are written as **appended dated delta blocks** — the existing Jira description body stays intact, and a short block gets pasted underneath. No full rewrites. See `jira-delta-blocks.md`.

**Scope:** existing tickets only. No new tickets proposed.

## Source availability at time of writing

| Source | Status |
|---|---|
| Slack | ✅ swept (channel + threads, 7/26→8/12) |
| Zoom AI meeting summaries | ✅ via Gmail (Zoom `search`/`assets` MCP rejected credentials) |
| Zoom cloud recordings | ◐ only 1 recording in window (Webhook Architecture Walkthrough, 8/10 — not transcript-scope) |
| **Jira (Atlassian MCP)** | ❌ **not authorized this session** |

⚠️ **The Jira live-state caveat matters.** Ticket bodies below were routed using the **7/27 story descriptions** as last-known state. `RECONCILE-2026-08-12.md` §3b claims a live 8/12 verification, but its own header (line 5) says the Atlassian token was expired — those two statements contradict each other, and I could not resolve which is right without Jira access. **Before pasting any block, confirm the ticket body hasn't already absorbed the change.**

## The 6 headline items in this delta

1. **DB schema shape locked** — three areas: pipeline task, prep/recap data, recommendations. Documented by Sagar in new Confluence page `4350935050`.
2. **API surface enumerated** — trigger, get-status, bulk-accept, bulk-decline, meeting-recommendation, recap. **Bulk ops process 4 items at a time.** Trigger endpoint gains `stages` + `force_regeneration`.
3. **Manual upload bypasses Zoom consent** — `transcript_enabled = true` + S3 URL. Sagar explicitly asked that this be recorded for QA/security testing. **Interacts with the three-level consent model and the overdue InfoSec doc.**
4. **Reconciliation is meeting-level, needs to be user-level** — duplicate recommendations across meeting instances for the same user. Noted only; no AC text changed (per direction).
5. **Zoom App Marketplace submission is now live work** — Tanveer raised it 8/11 as a release dependency; long third-party lead time. Makes ENG-83002's Q15 a real gate and reactivates ENG-82987.
6. **UI caps partly settled** — 3 recommendations / 2 goal signals confirmed by Hemant; Sagar pushed for 2 (not 3) on attention flags and recap items. **Left open.**

## Open — needs your call

| # | Decision | Ticket(s) | Why it's open |
|---|---|---|---|
| A | **Attention-flag / recap-item cap: 2 or 3?** | ENG-82996, ENG-82997 | Hemant said 3; Sagar argued 2. Meeting ended without a call. |
| B | **Persist transcript source (manual vs automated)?** | ENG-84148, ENG-82387 | Sagar asked 8/11 15:04 IST. **I could not find an answer in Slack** — the thread ends on his question and a full-text search returns no reply. You said it was answered; if it was in a DM or verbally, tell me where and I'll fold it in. Until then it stays open, because it decides whether the trigger API needs a `source` param beyond `transcript_enabled`. |
| C | **Turn IDs — keep or stay dropped?** | ENG-82387 | Sagar questioned the earlier decision to drop them. Unresolved. |
| D | **Recap carry-forward criteria** | ENG-82997 | Which items persist into the next meeting's recap. Raised, not defined. |
| E | **Summary/blocker sizing basis** | ENG-82997 | Sagar: should key off *processed* transcript length, not raw. Current AC scales by meeting duration. |

Still open from before and **not** re-litigated here: **PII handling (§0.1)** and **canonical release dates (§0.4)** — both on the critical path per reconcile §1.

## Files

| File | What it is |
|---|---|
| `jira-delta-blocks.md` | Paste-ready appended delta blocks, one per ticket |
| `README.md` | This file |
