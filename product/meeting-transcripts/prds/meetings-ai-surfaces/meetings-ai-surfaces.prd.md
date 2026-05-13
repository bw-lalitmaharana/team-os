---
id: PRD-MEETINGS-AI-SURFACES
title: Meetings Module — AI Surfaces (consumer of AI Pipeline)
status: draft
phase: 1
version: 0.3.0
parent: PRD-AI-PROCESSING-PIPELINE
owners:
  pm_owner: lalit.maharana@betterworks.com
  meetings_pm: varnika.garg@betterworks.com
  design_lead: gauri.thakur@betterworks.com
  exec_sponsor: nellie.lemonier@betterworks.com
  ai_platform_lead: jason.zhang@betterworks.com
  eng_lead_meetings: "[TBD — Meetings pod assignment]"
release:
  season: Summer 2026
  code_ready_date: 2026-08-15
  rainforest_milestone: 2026-05-31
links:
  jira_epic: ENG-79199
  parent_prd: PRD-AI-PROCESSING-PIPELINE
  parent_confluence: "https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097"
  aha_features:
    - MEET-48  # Meetings module 1:1 card, manual input, action items
    - AI-201   # AI processing (consumed)
  related_prds:
    - PRD-CONNECT-LAYER
    - PRD-TRANSCRIPT-INGESTION
a2a:
  agent_card: ./agent-card.json
pulled_at: 2026-05-13T00:00:00Z
sources:
  - type: prd
    ref: PRD-AI-PROCESSING-PIPELINE (platform contracts consumed)
  - type: zoom-transcript
    ref: "2026-05-08 MVP scope alignment — meeting_uuid F6113EF7-3757-491E-B45C-4B1E53D8D31F"
  - type: zoom-transcript
    ref: "2026-05-12 Varnika / Lalit — meeting_uuid D236D5E5-A01C-4D20-91C3-935FF3588D90"
  - type: slack
    ref: "#temp-meeting-transcript-integration — Before/During/After UX framing"
  - type: industry-research
    ref: "Fellow, Granola, Notion AI Meetings, MeetGeek, Tactiq pattern study (2026-05-13)"
---

# Meetings Module — AI Surfaces

> Sibling to PRD-AI-PROCESSING-PIPELINE. Consumer of platform contracts (CAP-001..CAP-009, CAP-011, CAP-013).
> Defines the UX of how AI-driven meeting intelligence is surfaced to end users on the existing Meetings
> module pages (list + per-meeting detail).

## 1. Overview

The Meetings module is the primary surface for AI-driven 1:1 intelligence. Today the module shows a list of past + current + upcoming meetings with calendar + Zoom integration; each meeting has a dedicated detail page with manually-filled agenda, action items, and notes, plus goal-progress mini-cards.

This PRD adds **AI-driven surfaces on top of the existing pages** — without changing the navigation model the user already knows. The list page gains an AI signal feed and a digest rollup; the detail page gains auto-filled agenda items, an auto-filled action item flow with carry-forward reconciliation, a recap of the last 1:1, and a "Before" summary across prior 1:1s with pointed action suggestions. Every AI output is pending until the user confirms, every claim is traceable via the platform's Why-this panel (CAP-009), and incomplete action items thread across recurring meetings as the same task object.

## 1a. Surfaces (current vs. MVP)

```
LIST PAGE                                  DETAIL PAGE (per meeting)
─────────                                  ─────────────────────────
[exists] Past + current + upcoming        [exists] Agenda (manual)
[exists] Calendar + Zoom integration      [exists] Action items (manual)
[exists] Drill-down to detail page        [exists] Notes
                                          [exists] Goal-progress mini-cards
                                                       (MEET-CAP-205)
+ Connect-source banner                   + Auto-filled agenda chips
  (MEET-CAP-103)                            (MEET-CAP-201 — pending state)
+ Signal feed: top 3–5, evidence-backed   + Cross-session "Before" summary
  (MEET-CAP-102)                            + pointed action suggestions
+ Rollup digest of confirmed outputs        (MEET-CAP-202)
  (MEET-CAP-101)                          + Last-meeting recap + action-item
                                            thread (MEET-CAP-203)
                                          + Action item reconciliation:
                                            carry-forwards + AI append,
                                            with add/complete/dismiss
                                            (MEET-CAP-204)
```

**No existing surface is removed or rearranged.** All AI is additive.

## 1b. UX Framing (inherited from parent §1b)

### Before / During / After

| Moment | Surface | Capability |
|---|---|---|
| **Before** the next 1:1 | Detail page "Before this 1:1" summary | MEET-CAP-202 |
| **During** | (Future — not in MVP) | — |
| **After** | Auto-filled agenda + action items + last-meeting recap on next visit | MEET-CAP-201, 203, 204 |

### Review → Refine → Apply

Every AI surface supports the three canonical verbs (parent D-005). Plus dismiss as first-class. No AI suggestion lands on a record without explicit confirmation.

### Patterns adopted (research-validated)

1. **Per-meeting AI is primary; list digest is a rollup of confirmed outputs** (Granola/Notion model). The list digest does not run a separate generation — it aggregates what users have already confirmed on detail pages.
2. **Action items thread across recurring meetings as the same task object** (Fellow pattern) — not "diff new suggestions against open ones." Carry-forwards pre-populate the action-items section first; AI suggestions append underneath as pending chips.
3. **Inline pending chips with accept / edit / dismiss** — no modal, no separate review queue. Edit-before-apply via inline chip controls.
4. ~~Confidence labels on low-trust items~~ — **deferred** (per exec sponsor 2026-05-13: "not needed"). The Why-this panel (platform CAP-009) is the trust mechanism; confidence-label visual treatment was redundant.
5. **Dismissal is a learning signal** — dismissing a class of suggestion reduces its frequency for that user. "Show more" expands the panel without random refill.

### Anti-patterns explicitly rejected

- **Separate "AI review" inbox/queue** — items rot, users don't visit (early Otter mistake).
- **Hard auto-commit of action items** — even when text auto-fills, owner + due date stay pending until confirmed (MeetGeek trust-collapse mistake).
- **Modal review flow** — interrupts the meeting-prep mental model.

## 2. Problem & Rationale

Today the Meetings module is a faithful capture surface but a low-leverage one. Managers fill in agenda items, action items, and notes manually. Nothing carries forward automatically. The connection to the rest of the performance system (goals, feedback, skills) happens only if the manager remembers to log it elsewhere.

The AI pipeline is now producing structured signals from every processed transcript. Without a thoughtful surface, those signals either go nowhere (and the pipeline is wasted) or land as a noisy queue (and the user disengages). The Meetings module is the natural home for the per-meeting AI experience — and is also the right place for the multi-meeting digest, since "multi-meeting" is a meetings-module concern, not a separate module.

## 3. Benefits & Value

### Managers
- Zero-effort agenda + action-item capture for the next 1:1; one-click confirm or dismiss.
- "Before" summary surfaces what was discussed before the meeting starts — no prep required.
- Open action items carry forward automatically; no risk of forgetting follow-ups.

### Employees
- Trust through traceability: every AI claim links to the moment in the meeting that produced it.
- Action items they agreed to don't vanish — the same task threads from meeting to meeting until done.

### Admins / HR
- More consistent signal capture across the org without forcing managers to do extra work.
- Connect rate on the meeting source becomes a leading indicator of feature adoption.

## 4. GTM Messaging

Inherits parent PRD §4 GTM. Module-specific framing:

> **The Meetings page you already use, now with the conversation memory you wish you had.** Last week's commitments carry forward automatically. The agenda fills itself from the transcript, pending your confirmation. And every suggestion links to the exact moment it came from.

## 6. Key Metrics

> **Surface-scope metrics: does this change how managers actually run their 1:1s?** These prove the feature works as a *product*, not just as a model. All `[proposed, awaiting analytics verification]` until `analytics/metrics-definitions.md` lands. Platform-pipeline metrics (acceptance rate, latency) live in `PRD-AI-PROCESSING-PIPELINE` §6.

### Workflow impact

| Metric | Definition | Benchmark | Event |
|---|---|---|---|
| **AI action-item completion lift** ⭐ NORTH STAR | Completion rate of AI-extracted action items vs. manually-created baseline | 1.4–1.8× lift (Fellow/Granola published) | `action_item.completed` w/ `source: ai\|manual` |
| Carry-forward rate | % open action items auto-surfaced in next recurring meeting that get touched (completed/updated/dismissed) | 55–65% (Fellow) | `action_item.carry_forward.actioned` |
| Per-meeting engagement depth | % meetings where user touches ≥2 AI surfaces (summary + agenda + action item + signal) | 40%+ for sticky usage | composite |

### Quality on the surface

| Metric | Definition | Benchmark | Event |
|---|---|---|---|
| Suggestion edit rate | % confirmed suggestions modified before confirm | 20–35% healthy; >60% = bad defaults | `ai.suggestion.edited` |
| Signal-feed dismissal-with-reason rate | % dismissals tagged with reason ("not relevant", "wrong person", "duplicate") | ≥40% capture rate | `signal.dismissed` w/ `reason_code` |
| Summary open rate | % of generated summaries opened within 48h | 50–70% (Tactiq published) | `meeting.summary.opened` |

### Timing

| Metric | Definition | Benchmark | Event |
|---|---|---|---|
| Time-to-first-confirm post-meeting | Median minutes from `meeting.ended` to first AI confirm on that meeting | <30 min = "in flow"; >24h = stale | timestamp delta |

### UX-specific (from §10b mitigations)

| Metric | Definition | Benchmark |
|---|---|---|
| Carry-forward attribution correctness | % carry-forwards correctly threaded (no false positives) | ≥95% (per MPAC quality bar) |
| Why-this panel click-through rate | % suggestions where user opens Why-this | 10–25% target |
| "Report bad evidence" rate | % suggestions flagged | <5% (>5% triggers model review) |

### Open metric gaps

| Gap | Owner | Trigger |
|---|---|---|
| **Baseline for action-item completion in current Meetings module** | Analytics owner + Meetings PM | Before launch — needed for lift comparison |
| Goal-mini-card AI engagement (Phase 2) | Meetings PM + Goals PM | When MEET-CAP-205 enhancement scoped |

## 7. Capabilities

> Each capability has a stable `MEET-CAP-XXX` ID. Acceptance criteria (Phase 2) reference these.
> Platform contracts consumed are noted per capability.

### List page

- **MEET-CAP-101 — List-level digest (rollup) — V2/STRETCH** *(deferred per 2026-05-13 exec decision)* — Read-only rollup view of confirmed AI outputs across the user's recent meetings. Logical grouping (default: recency; filter: group-by-1:1-partner). **Does not generate new content** — aggregates confirmed signals from platform CAP-001/002. Cached per day; manual refresh available. Jira: `[child story TBD — V2]`
- **MEET-CAP-102 — Signal feed (top 3–5) — V2/STRETCH** *(deferred per 2026-05-13 exec decision)* — Evidence-backed signal cards on the list page. Each card has an inline Why-this panel (platform CAP-009), accept/edit/dismiss controls. Confidence labels deferred (exec sponsor 2026-05-13: "review — not needed"). Top 3–5 shown by default; "show more" expands. Dismissals reduce frequency of that class for the user. Consumes platform CAP-003 + CAP-005. Jira: `[child story TBD — V2]`
- **MEET-CAP-103 — Connect-source nudge** — Persistent dismissable banner on list-page top when at least one source is connectable. Empty-state CTA on any meeting card without transcript data. Re-surfaces when a new untranscribed meeting appears. **Never modal.** Consumes PRD-CONNECT-LAYER. Jira: `[child story TBD]`

### Detail page (per meeting)

- **MEET-CAP-201 — Auto-filled agenda chips** — Agenda items extracted from the transcript appear as pending chips on the detail page. User clicks accept (state: `confirmed`), edit (state: `edited_confirmed`), or dismiss. Why-this panel inline per chip. Consumes platform CAP-002 (`signal_type = agenda_item`). Aha: `MEET-48` · Jira: `[child story TBD]`
- **MEET-CAP-202 — Cross-session "Before" summary** — Pre-meeting summary that draws on prior 1:1 transcripts + both participants' open goals + recurring themes. Surfaces pointed action suggestions: "add to agenda", "update goal G-XXX", "log feedback", "log skill observation". Each suggestion is a pending action; one-click route to the right object via Reconciliation (platform CAP-005). Consumes platform CAP-004 + CAP-003. Jira: `[child story TBD]`
- **MEET-CAP-203 — Last-meeting recap + action + agenda item thread** *(scope expanded 2026-05-13: agenda items also thread)* — Compact recap of the most recent 1:1 with this partner. Shows last meeting's summary (platform CAP-001) + the action items + agenda items that came out of it with their current status. Open action items + carryover agenda items thread forward into MEET-CAP-204. Jira: `[child story TBD]`
- **MEET-CAP-204 — Action item + agenda items reconciliation flow** *(scope expanded 2026-05-13: agenda items also reconcile; carry-forward is DEFAULT, not configurable — MD-007)* — Aha: `MEET-48 + AI-201`. Two stacked sections on the detail page:
  1. **Carry-forward**: open action items from prior meetings (same `action_item` object threaded forward). User can mark complete or dismiss.
  2. **New (from transcript)**: AI-suggested action items as pending chips. User can accept, edit, or dismiss. On accept, the item joins the carry-forward stack for the next meeting.
  Owner + due date stay pending until explicit confirmation, even when text auto-fills. Consumes platform CAP-002 + CAP-005. Jira: `[child story TBD]`
- **MEET-CAP-205 — Goal-progress mini-cards (existing, kept)** — Goal cards on the detail page remain as today. Phase 2 enhancement: surface AI-suggested goal updates with one-click route via platform CAP-007 validation passthrough. Jira: `[child story TBD]`

## 7a. Story decomposition (MVP)

| # | Story | MEET-CAPs | Owner | Sequencing |
|---|---|---|---|---|
| M-01 | Threaded action item object across recurring meetings (data model + API) | MEET-CAP-204 foundation | Meetings pod | **Week 1–2 (blocking)** |
| ~~M-02~~ **V2** | List page: signal feed panel — **deferred to V2** (MD-006) | MEET-CAP-102 | Meetings pod + AI Platform | V2 |
| ~~M-03~~ **V2** | List page: rollup digest — **deferred to V2** (MD-006) | MEET-CAP-101 | Meetings pod | V2 |
| M-04 | List page: connect-source banner + empty-state | MEET-CAP-103 | Meetings pod + Connections pod | Week 4–6 |
| M-05 | Detail page: auto-filled agenda chips | MEET-CAP-201 | Meetings pod | Week 5–7 |
| M-06 | Detail page: action item reconciliation flow | MEET-CAP-204 | Meetings pod + AI Platform | Week 5–7 |
| M-07 | Detail page: last-meeting recap | MEET-CAP-203 | Meetings pod | Week 5–6 |
| M-08 | Detail page: cross-session "Before" summary with pointed actions | MEET-CAP-202 | Meetings pod + AI Platform | Week 7–9 |

**Critical path: M-01 → M-06 → M-07 → M-08.** M-04 unblocks adoption; M-02/03 surface the value back on the list page.

## 10. Assumptions, Dependencies & Risks

### Assumptions
- Existing Meetings module page structure (list + detail) is stable; AI surfaces are additive, not a redesign.
- Goal-progress mini-cards (MEET-CAP-205) remain as today; Phase 2 will enhance.
- Calendar + Zoom existing integration remains the source of meeting metadata.

### Dependencies
- **Platform PRD (PRD-AI-PROCESSING-PIPELINE)** — all evidence + signal contracts.
- **PRD-CONNECT-LAYER** — MEET-CAP-103 connect banner consumes the central Connections state.
- **Design specs** — Design lead owns: chip layout, confidence-label visual language, Why-this panel placement, banner/empty-state copy.
- **Action item object schema** — extend existing `action_item` to support threading + status transitions; owned by Meetings pod.
- **Existing meeting-record model** — reuse for `bw-meeting` source in the evidence table.

### Risks
- **Carry-forward visual treatment causes confusion** — users mistake "still open from before" for "new AI suggestion" · Med · Mitigation: explicit visual treatment (sub-heading "From prior meetings" + status badge); user testing in Rainforest.
- **List-page digest is stale** — cached per day, but users expect real-time · Low · Mitigation: manual refresh + last-refreshed timestamp visible.
- **Signal feed competes with the existing detail-page surface** for attention — managers spend time on the list page instead of drilling in · Med · Mitigation: every signal card has a "go to meeting" link; the feed is a router, not a destination.
- **Connect-banner banner-blindness** — users dismiss without connecting · Med · Mitigation: contextual empty-state CTAs on individual meeting cards re-surface the prompt at moments of clear value.

### 10a. Constraints & Invariants (Meetings-specific)

**MUST**
- THE LIST DIGEST (MEET-CAP-101) SHALL be a rollup of confirmed per-meeting outputs only. It SHALL NOT generate new content independently.
- ACTION ITEMS SHALL thread across recurring meetings as a single object; the same `action_item.id` carries forward until `state = done` or `state = dismissed`. **Carry-forward is DEFAULT, not user-configurable** (MD-007).
- AGENDA ITEMS SHALL also thread across recurring meetings — carry-over agenda topics surface on the next meeting's detail page with the same semantics as action items (MD-008).
- AI-suggested action items (MEET-CAP-204) SHALL render as pending chips with owner + due date in pending state, even when text auto-fills.
- EVERY AI SURFACE SHALL render the Why-this panel inline (platform CAP-009).
- THE CONNECT-SOURCE NUDGE SHALL NOT be modal.

**MUST NOT**
- THE MEETINGS MODULE SHALL NOT operate a separate "AI review" inbox or queue.
- THE SYSTEM SHALL NOT hard-commit AI action items to a meeting record without explicit user confirmation.
- THE SIGNAL FEED SHALL NOT refill dismissed slots with random new suggestions; dismissals are a learning signal.

**SHOULD**
- The detail page SHOULD surface carry-forward action items above newly suggested ones for cognitive clarity.
- The list page SHOULD default to recency grouping with a "group by 1:1 partner" filter available.
- Confidence labels SHOULD appear only on items below a threshold (don't label every item — visual noise).

### 10b. Pre-mortem

*It's September 2026. The Meetings AI surfaces shipped but failed adoption. Three plausible failure modes:*

1. **Signal feed felt like a noisy ad surface.** Top 3–5 cards updated unpredictably; users couldn't tell why a card appeared; dismissal didn't seem to reduce future noise. Trust collapsed in week one.
2. **Action item reconciliation visually conflated carry-forwards with AI suggestions.** Managers couldn't tell what was "still open" vs. "new" and started ignoring the list. Mitigation: explicit visual treatment (decided in this PRD §10a SHOULD).
3. **Connect-source banner was banner-blindness in week one.** Users dismissed once and never reconnected; per-meeting empty-state CTAs were too subtle. Adoption ceiling hit at ~30% connected.

*Mitigations: (1) Visible confidence labels + Why-this on every card; instrument dismissal-reduces-frequency from launch. (2) Visual separation between carry-forward and new sections; user testing in Rainforest pre-launch. (3) Re-surface connect prompts on every untranscribed meeting card, not just a single banner.*

## 11. Out of Scope / Known Limitations

### Non-Goals (Phase 1)
- **Real-time "During" meeting AI** — Phase 2 or later. MVP is Before + After only.
- **Group / all-hands / panel meetings** — 1:1s only.
- **Notes-while-meeting AI** — out of scope; only structured signal types (agenda, action, summary) are AI-extracted in MVP.
- **List-page rollup digest (MEET-CAP-101)** — **V2/stretch** (was MVP in v0.2.0; demoted per MD-006).
- **List-page signal feed (MEET-CAP-102)** — **V2/stretch** (was MVP in v0.2.0; demoted per MD-006). Only MEET-CAP-103 (connect-source nudge) ships on the list page in MVP.
- **Confidence labels on suggestions** — deferred per exec sponsor 2026-05-13; Why-this panel is the trust mechanism.
- **Configurable carry-forward of action items** — carry-forward is DEFAULT behavior (MD-007).

### Future Roadmap
- Real-time "During" AI (whisper prompts, live action-item suggestion)
- Cross-1:1 theme detection at the team level (manager dashboard view)
- Multi-participant meeting types (panel, group)
- Editable rollup digest

## 12. Documentation & Resources

- `type: confluence` — **Parent PRD: [Zoom & Teams Transcripts Feature Documentation](https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097)** (strategic / GTM PRFAQ; includes conceptual UI image for Meetings module + Zoom/Teams integration)
- `type: prd` — PRD-AI-PROCESSING-PIPELINE (platform contracts)
- `type: prd` — PRD-CONNECT-LAYER (consumed by MEET-CAP-103)
- `type: jira` — ENG-79199 (Epic)
- `type: aha` — `MEET-48` — Meetings module 1:1 card, manual input, action items
- `type: aha` — `AI-201` — AI processing (consumed platform contract)
- `type: zoom-transcript` — 2026-05-08 MVP scope alignment (uuid F6113EF7-3757-491E-B45C-4B1E53D8D31F)
- `type: zoom-transcript` — 2026-05-12 Varnika / Lalit (uuid D236D5E5-A01C-4D20-91C3-935FF3588D90)
- `type: slack` — #temp-meeting-transcript-integration (Before/During/After framing)
- `type: industry-research` — Fellow, Granola, Notion AI Meetings, MeetGeek, Tactiq pattern study (2026-05-13)
- `type: figma` — `[TBD — Design Lead]`

## §13a Product Acceptance Criteria

- [ ] **MPAC-01** — All `Must Have` AC-IDs across MEET-CAP-101..205 pass automated or manual test
- [ ] **MPAC-02** — Action item object threads across at least 3 recurring meeting instances in eval set
- [ ] **MPAC-03** — Carry-forward vs. new AI suggestions are visually distinct in detail page; user testing confirms 90%+ can tell them apart
- [ ] **MPAC-04** — Why-this panel renders inline on every MEET-CAP that surfaces AI output, with working deep-links (platform CAP-009 contract honoured)
- [ ] **MPAC-05** — Signal feed dismissal reduces same-class suggestion frequency for that user (instrumented; verifiable in metrics)
- [ ] **MPAC-06** — Connect-source banner is persistent + dismissable, not modal; per-meeting empty-state CTAs present on every untranscribed card
- [ ] **MPAC-07** — List-level digest (MEET-CAP-101) is read-only and never triggers an independent AI generation
- [ ] **MPAC-08** — Owner + due date on AI-suggested action items remain in pending state until user confirms, even when text auto-fills
- [ ] **MPAC-09** — Rainforest smoke test of detail-page happy path passes by the Rainforest milestone (target 2026-05-31; **may move pending exec scope-alignment** — see parent PRD §10 Risks)
- [ ] **MPAC-10** — Stakeholder sign-off (resolve via Owners; log in §14): PM Owner, Meetings PM, Design Lead, AI Platform Lead

### Quality bars

| Dimension | Bar |
|---|---|
| Detail-page time to interactive after meeting ends | < 5 min p95 (consumes platform latency) |
| Signal feed render latency | < 500ms p95 |
| Why-this panel deep-link success rate | ≥ 99% |
| Carry-forward action item attribution correctness | ≥ 95% (no false threading) |
| Connect-banner conversion rate (first-time CTR) | ≥ 25% — instrumented from day one |

## §14 Decisions Log

> Append-only. Names appear here (initials) for accountability; body uses roles.

| ID | Date | Decision | Decider (role / initials) | Rationale | Source |
|---|---|---|---|---|---|
| MD-001 | 2026-05-13 | Split Meetings AI surfaces into sibling PRD (this doc) | PM Owner (LM) | Meetings has distinct persona, distinct pod, ≥4 capabilities, independent DoD; parent PRD crossed 30KB; split decision rule satisfied 6/6 | Industry practice (Cagan, Amazon Working Backwards, Atlassian); parent PRD D-011 |
| MD-002 | 2026-05-13 | List digest is a rollup of confirmed outputs; does not run independent generation | PM Owner (LM) | Per Granola/Notion model: per-meeting AI is primary, list is derived | Industry research 2026-05-13 |
| MD-003 | 2026-05-13 | Action items thread across recurring meetings as same object (Fellow pattern) | PM Owner (LM) | Carry-forward semantics; avoids "diff new vs. open" complexity | Industry research 2026-05-13 |
| MD-004 | 2026-05-13 | Connect-source nudge is banner + empty-state, never modal | PM Owner (LM) | Banner-blindness mitigated by per-meeting empty-state CTAs at moments of value | Industry research 2026-05-13 |
| MD-005 | 2026-05-13 | Carry-forward and new AI-suggested action items are visually distinct on detail page | PM Owner (LM) | Cognitive clarity (pre-mortem failure mode #2) | This PRD §10b |
| MD-006 | 2026-05-13 (PM) | **List-page features demoted to V2**: MEET-CAP-101 (rollup digest) + MEET-CAP-102 (signal feed) → V2/stretch. Only MEET-CAP-103 (connect-source nudge) ships on list page in MVP. Detail page is MVP focus. | Exec Sponsor (NL) | "Focus MVP on changes to the details page for meetings, and move list page digest features to stretch/V2" — exec sponsor 2026-05-13 PM | Zoom uuid 7D6A937E-6C54-4362-8AD2-8E16FF3E2A96 (Product Acceptance call) |
| MD-007 | 2026-05-13 (PM) | **Action item carry-forward is DEFAULT, not user-configurable** | Exec Sponsor (NL) | "More features require removing features" — exec sponsor 2026-05-13. Reduces settings surface; matches user mental model that incomplete commitments persist | Product Acceptance call 2026-05-13 PM |
| MD-008 | 2026-05-13 (PM) | **Agenda items also thread across recurring meetings** (not just action items) — MEET-CAP-203 + MEET-CAP-204 scope expanded | Exec Sponsor (NL) + PM Owner (LM) | Symmetric treatment with action items; carry-over agenda topics are a natural continuation of in-progress discussions | Product Acceptance call 2026-05-13 PM; Confluence Meetings page edit |

### Pending decisions

| ID | Question | Decision owner | Deadline |
|---|---|---|---|
| MOPEN-D1 | List page default grouping: recency vs. by-partner vs. by-status | Meetings PM + Design Lead | Before M-03 starts |
| MOPEN-D2 | Rollup digest cache TTL (daily vs. session vs. manual-only) | Meetings PM | Before M-03 starts |
| MOPEN-D3 | Confidence-label threshold (which confidence levels render the label) | Design Lead + AI Platform Lead | Before M-02 ships |
| MOPEN-D4 | Goal mini-card AI enhancement: Phase 1 or Phase 2 | Meetings PM + Goals PM | TBD |
