---
id: PRD-AI-PROCESSING-PIPELINE
title: AI Processing Pipeline for Meeting Transcripts — Phase 1
status: draft
phase: 1
version: 0.8.0
owners:
  # Single source of truth for names. Body references roles only — names resolve through this block.
  pm_owner: lalit.maharana@betterworks.com
  eng_lead_pipeline: "[TBD — pending AI Engineering leadership assignment]"
  ai_platform_lead: jason.zhang@betterworks.com
  design_lead: gauri.thakur@betterworks.com
  exec_sponsor: nellie.lemonier@betterworks.com
  cross_pod_pm_meetings_goals: varnika.garg@betterworks.com
  cross_pod_pm_integrations: rinku@betterworks.com
  principal_eng_escalation: pankaj.lohmor@betterworks.com
  app_platform_lead: jason.bilyeu@betterworks.com
release:
  season: Summer 2026
  release_theme: "AI in the Flow of Work"
  classification: "Level A — Revenue Creator (per parent Confluence + Aha! AI-201)"
  code_ready_date: 2026-08-15
  rainforest_milestone: 2026-05-31  # target; may move post exec scope-alignment
  early_access:
    cohort: "Innovation Partner Program — Summer 2026"
    individual_clients: "[TBD — Sales to confirm cohort participants]"
links:
  jira_epic: ENG-79199
  aha_initiative: AI-201  # AI Processing / Conversation Intelligence (Level A)
  aha_features:
    - AI-201   # AI processing layer (summary, signals, coaching prompts)
    - MEET-48  # Meetings module (1:1 card, manual input, action items)
    - INT-181  # Microsoft Teams OAuth + Graph API transcript retrieval
    - INT-185  # Zoom OAuth + Cloud Recording API transcript retrieval
  aha_ideas:
    - INT-I-110  # Sales request: meeting transcript integration (High Priority)
    - AI-I-52    # Sales request: AI-driven performance insights from meetings
  parent_confluence: "https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097"
  figma: "[TBD — Design Lead, pending VPN]"
  confluence: "[TBD]"
  related_prds:
    - PRD-MEETINGS-AI-SURFACES  # consumer surfaces — split out v0.6.0
    - PRD-CONNECT-LAYER          # auth/consent — split out v0.6.0
    - "[PRD-TRANSCRIPT-INGESTION — Integrations pod]"
    - "[PRD-CONNECT-LAYER — TBD owner, cross-platform auth]"
a2a:
  agent_card: ./agent-card.json
pulled_at: 2026-05-13T00:00:00Z
sources:
  - type: jira
    ref: ENG-79199
  - type: meeting-note
    ref: ops/meeting-notes/2026-05-04-week-synthesis.md
  - type: meeting-note
    ref: ops/meeting-notes/2026-05-07-lalit-sriram.md
  - type: zoom-transcript
    ref: "2026-05-08 MVP scope alignment (Lalit + Gauri + Nellie) — meeting_uuid F6113EF7-3757-491E-B45C-4B1E53D8D31F"
  - type: zoom-transcript
    ref: "2026-05-08 Gauri / Lalit intro — meeting_uuid 5C80334B-5A25-4D36-B67A-EB44F1CC65A1"
  - type: zoom-transcript
    ref: "2026-05-11 AI Platform Architecture Walkthrough (Jason Zhang) — meeting_uuid 9988F4F9-4D28-407C-868E-DB1052ADCED9"
  - type: zoom-transcript
    ref: "2026-05-12 Varnika / Lalit — meeting_uuid D236D5E5-A01C-4D20-91C3-935FF3588D90"
  - type: slack
    ref: "#temp-meeting-transcript-integration — Nellie's Apr 28/30 framing"
  - type: slack
    ref: "Design Group DM (Paul, Sarah, Austine, Nataliya, Nellie, Lalit) — May 12 GTM + UX directional asks"
  - type: slack
    ref: "#pod-ai-platform — PR #512 / ENG-78223 (peer + manager conversations now in AI features)"
---

# AI Processing Pipeline for Meeting Transcripts: Phase 1 — Why It Matters

## Index / Navigation

> **Parent Confluence PRFAQ**: [Zoom & Teams Transcripts Feature Documentation](https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097) (strategic / GTM)
> **Sibling PRDs**: [`PRD-MEETINGS-AI-SURFACES`](../meetings-ai-surfaces/meetings-ai-surfaces.prd.md) · [`PRD-CONNECT-LAYER`](../connect-layer/connect-layer.prd.md)
> **Trio index**: [`INDEX.md`](../INDEX.md) · **Stubs**: [`_stubs/`](../_stubs/)

| Section | What's in it |
|---|---|
| §1 Overview | One-paragraph framing of the platform layer |
| §1a Architecture & Data Model | System flow diagram, `evidence` schema, polymorphic-FK vs property-graph decision |
| §1b UX Framing | Before/During/After, Review→Refine→Apply, Why-this panel, module-native surfacing |
| §1c Connect Layer | Reference to `PRD-CONNECT-LAYER` + platform contract retained |
| §2 Problem & Rationale | Legacy limitations, customer pain points, why Betterworks |
| §3 Benefits & Value | Per-audience |
| §4 GTM Messaging | Value prop, key messages, differentiation |
| §5 Competition | Alternatives table |
| §6 Key Metrics | Pipeline health, model quality, latency, North Star |
| §6a Open Metric Gaps | Items needing analytics-owner resolution |
| §7 Core Capabilities | CAP-001 .. CAP-011 (platform); CAP-012/013 references to sibling PRDs |
| §7a Story Decomposition | Platform-scope stories (S-01..S-15); surface stories in child PRDs |
| §10 Assumptions / Dependencies / Risks | Plus §10a Constraints, §10b Pre-mortem |
| §11 Out of Scope / Future Roadmap | Non-goals, MVP Stretch, future items |
| §12 Documentation & Resources | Parent Confluence, Aha! IDs, Jira, Slack, Zoom transcripts |
| §13a Product Acceptance Criteria | PAC-01..PAC-20 + quality bars |
| §13 Definition of Done | Phase 2 placeholder |
| §14 Decisions Log | D-001..D-016 (append-only, named decider with initials) |

---


<!-- ============================================================== -->
<!-- PHASE 1 — Why It Matters                                       -->
<!-- ============================================================== -->

## 1. Overview

**Release theme: "AI in the Flow of Work"** (Summer 2026). **Classification: Level A — Revenue Creator** (parent Confluence; Aha! AI-201). **MVP ingestion path: automated Zoom transcript retrieval** (manual paste is a demo-only fallback, not the goal — per 2026-05-13 exec decision D-013).

Betterworks is closing **the gap between conversations and work**. Today the highest-signal performance events — 1:1 conversations — happen outside the performance record. They live in private notes, follow-up emails, or memory. Three months later, at review time, the manager reconstructs from scratch.

This PRD describes an **evidence-centric AI layer** that ingests signals from external sources (starting with Zoom transcripts), links them to the user's existing Betterworks objects — Goals, Meetings, Feedback, Skills — and surfaces module-native suggestions that the user can **review, refine, and apply** in one click. The destination is what makes this different from generic note-takers: every suggestion is bound to a Betterworks object, every claim is traceable to a clickable source, and every action is augmentative — the AI surfaces, the human decides.

The architecture is multi-source from day one. Transcripts is the first source. Slack, Jira, HubSpot, and Salesforce follow on the same evidence framework. Intelligence compounds over time as evidence accumulates across the user's objects.

## 1a. Architecture & Data Model

### Top-level flow

```
SOURCES (extensible)
┌────────────┬───────────┬────────┬─────────┬────────────┬────────┐
│ Zoom/Teams │ Slack     │ Jira   │ HubSpot │ Salesforce │ Manual │
│ transcripts│ DMs+chans │ issues │ records │  opps      │ paste  │
└─────┬──────┴─────┬─────┴───┬────┴────┬────┴─────┬──────┴────┬───┘
      ▼
┌────────────────────────────────────────┐
│  Source Adapter Framework (CAP-011)    │
│  per adapter: auth, fetch, perm-check, │
│  deep-link builder                     │
└──────────────┬─────────────────────────┘
               ▼
┌────────────────────────────────────────┐
│  Signal Extractor (AI Platform)        │
│  LM Engine + LM Proxy (existing)       │
│  → typed signals + confidence          │
└──────────────┬─────────────────────────┘
               ▼
┌────────────────────────────────────────┐
│  Evidence rows written (CAP-009)       │
│  user_id, source, source_ref_url,      │
│  observed_at, speaker_user_id,         │
│  signal_type, confidence;              │
│  object_type = NULL initially          │
└──────────────┬─────────────────────────┘
               ▼
┌────────────────────────────────────────┐
│  Reconciliation Framework (CAP-005)    │
│  Per-type cascade:                     │
│    1. Rule / entity match              │
│    2. Embedding similarity (per-type)  │
│    3. LLM judge on ambiguous band      │
│  → populates object_type + object_id   │
│    link_method recorded for audit      │
└──────────────┬─────────────────────────┘
               ▼
┌─────────────────┬───────────────────┬──────────────────┬──────────────┐
▼                 ▼                   ▼                  ▼              ▼
Goals page        Feedback page      Skills page        Meetings page   [Cross-module
─ goal-level      ─ pre-filled       ─ skill            ─ agenda items   digest —
  suggestions       drafts bound       evidence          ─ topic summary  deferred]
─ per-goal          to user's        ─ endorsement      ─ action items
  evidence panel    allowed            suggestions       (MUST per
─ new goal          templates                            Meetings pod)
  proposals       ─ one-click "log"  Every suggestion carries an
                                     evidence panel — "Why this?" —
                                     with clickable source links
                                     (CAP-009)
```

### Evidence schema (canonical)

```
evidence(
  id              uuid pk,
  user_id         fk users          -- traceability: every evidence belongs to a user
  source_system   enum (zoom|teams|slack|jira|hubspot|salesforce|manual|bw-meeting),
  source_ref_id   text              -- zoom meeting_uuid, slack ts, jira key, etc.
  source_ref_url  text              -- clickable deep link (with ms-offset for media)
  source_internal bool              -- true=link within Betterworks; false=external
  observed_at     timestamptz       -- when it happened in the source system
  ingested_at     timestamptz       -- when we processed it
  speaker_user_id fk users nullable -- attribution; raw label kept when unresolved
  excerpt_text    text              -- the quote / message / comment
  excerpt_ts_start int              -- ms offset (media) or null
  excerpt_ts_end   int
  signal_type     enum (action_item|agenda_item|topic_summary|goal_progress|
                       feedback_moment|skill_demo|coaching_theme),
  payload         jsonb             -- structured signal-specific fields
  confidence      numeric(3,2)      -- extractor confidence
  source_trust    numeric(3,2)      -- per-tenant configurable
  redacted        bool              -- CAP-008 exclusion: row exists, content hidden
  object_type     enum (goal|meeting|feedback|skill|action_item) nullable,
  object_id       text nullable     -- polymorphic FK (filled by reconciliation)
  link_confidence numeric(3,2),
  link_method     enum (rule|embedding|llm-judge|manual)
)
```

Indexes: `(user_id, object_type, object_id, observed_at desc)` covering index for the "Why this?" panel; partial index per `object_type`.

### Polymorphic FK vs. Property Graph — decision matrix

| Dimension | Polymorphic FK in Postgres (Gong's pattern) | Property Graph (Neo4j / Glean's Work Graph) |
|---|---|---|
| **Operational complexity** | Single DB; team already runs Postgres/Aurora | New infra; specialised ops knowledge |
| **Query: "all evidence for object X"** | One indexed lookup, very fast | Traversal — fast but requires graph engine |
| **Query: "shortest path between two objects via shared evidence"** | Multi-join, awkward | Native, this is graph's superpower |
| **Schema evolution** | Add columns; jsonb absorbs variation | Add labels/properties freely |
| **Permission model integration** | Native — Postgres RLS + Betterworks ACL stays in one place | Separate auth layer to maintain |
| **Scale at 5–10M evidence rows/year, 100k–1M users** | Comfortable; standard pattern | Overkill |
| **Cross-object reasoning (e.g. "skills cluster across meetings")** | Possible via CTE + materialised views; not graph-native | Native |
| **Cost** | $0 incremental | New license + team |
| **Industry analogue at our scale** | Gong, Salesforce (Activity → Entity polymorphic FK) | Glean, Microsoft Graph |

**Decision (v0.3.0): Polymorphic FK in Postgres.** Mirror to a graph view (Neo4j or PG recursive CTEs) only if/when cross-object reasoning becomes a product feature. This matches what Gong runs at multiples of our scale.

## 1b. UX Framing

### Three moments

> Framing established 2026-04-30 (see Decisions Log §14, D-002).

| Moment | What the AI does | What the user does |
|---|---|---|
| **Before** the 1:1 | Surface coaching prompts, recurring themes, open goals on both sides | Review prep; mark relevant items |
| **During** the 1:1 | (Future) inline assist | — |
| **After** the 1:1 | Process transcript → emit signals → attach evidence to objects → surface module-native suggestions | **Review → Refine → Apply** |

### Canonical user verbs

> Design requirement, established 2026-05-12 (Decisions Log §14, D-005).

Every AI suggestion supports exactly three actions:
- **Review** — read it with its evidence
- **Refine** — edit before applying (state: `edited_confirmed`)
- **Apply** — confirm (state: `confirmed`), data flows to the Betterworks record

Dismissing is also a first-class action (state: `dismissed`).

### "Why this?" panel — non-negotiable

Every AI suggestion renders inline with an evidence list. Each evidence row shows:
- Source icon (Zoom/Teams/Slack/Jira/etc.) + clickable deep link
- Speaker avatar + name (or raw label if unresolved)
- Timestamp
- Excerpt quote
- "Report bad evidence" affordance

The link click resolves through a permission check (see §10a). Inline by default; hover-collapsed if needed for density. **Design team action**: Design lead to specify the exact layout, density rules, and the report-bad-evidence flow as part of the next design pass.

### Module-native surfacing (not a global queue)

- **Goals page** — goal-level suggestions ranked at the top; per-goal evidence panel; new-goal proposals
- **Feedback page** — pre-filled drafts bound to the user's allowed templates (CAP-010); one-click log
- **Skills page** — skill demonstration evidence; endorsement suggestions
- **Meetings page** — agenda items + topic summary + action items (MUST per Meetings pod)

A cross-module digest is **deferred to a later phase** (see §11 Roadmap note). When it ships, it will be a read-only digest (top-3 + "show more") that links into each module — never an action surface.

## 1c. Connect Layer → see `PRD-CONNECT-LAYER`

The cross-platform auth + consent layer has moved to its own sibling PRD: **`PRD-CONNECT-LAYER`** (`../connect-layer/connect-layer.prd.md`). It owns touchpoints, consent model, OAuth flow, revoke matrix, retention policy, and the CONN-CAP capability decomposition.

**Platform contract this PRD retains**: evidence rows are written only after the user has an active connection (`state = connected`); disconnect propagates to evidence (`locked = true`); hard-delete cascades after the 30-day grace.

## 2. Problem & Rationale

### Legacy Limitations
- 1:1 conversations are the highest-signal performance event and the lowest-instrumented — content lives in private docs, Slack threads, or memory.
- Manual capture is inconsistent; signal is lost between conversation and performance record.
- Existing transcription tools (Otter, Fireflies, Zoom AI Companion) summarise but do not route content into a performance system.
- Cross-platform signal is fragmented: a goal-progress moment in Slack, a skill demo in a Jira comment, an action item in a 1:1 — no single thread connects them to the employee's record.

### Customer Pain Points
- Managers re-discover the same coaching themes meeting after meeting because nothing carries forward.
- Employees leave 1:1s without a clear record of agreed actions; follow-through is unverifiable.
- HR teams can't see talent signals (skill demos, development needs, feedback moments) surfacing in real time.
- Performance reviews are reconstructions, not records.

### Why Betterworks
Betterworks already owns the destination systems — goals, anytime feedback, talent profile, skills — that meeting content should flow into. We can close the loop between conversation and performance record without asking the customer to bolt on another point tool. Every output is bound to a Betterworks object, traceable to source, and confirmed by the user before it lands on the record.

## 3. Benefits & Value

### Employees
- Action items captured automatically; less follow-up friction with their manager.
- Skills and growth themes surfaced as evidence on their talent profile.
- Positive feedback moments preserved instead of disappearing into a Slack thread.
- **Connect once** to their meeting platform; the rest is automatic.
- **Trust through traceability** — every AI suggestion shows exactly which moment in which meeting produced it.

### Managers
- Pre-meeting coaching prompts that draw on past 1:1s, open goals, recurring themes — zero prep effort.
- Suggestions queued for one-click confirmation after the meeting; no separate note-taking workflow.
- Coaching themes tracked across sessions — patterns surface that a manager wouldn't otherwise notice.

### Admins / HR / Leaders
- Performance signals flow into goals, feedback, and skills workflows without users having to remember to log them.
- Skills taxonomy and talent profiles populate organically.
- Lower cost to operate the program — fewer trainings on "remember to log feedback."

### CHRO / CEO / CFO
- Performance enablement becomes a continuous signal stream rather than an annual artifact.

## 4. GTM Messaging

### Core Value Proposition

> Turn **every conversation, message, and ticket** into **structured performance signal** — so **managers and HR** can **act on real-time evidence instead of reconstructing it quarterly**.

### Key Messages

1. **The story isn't about AI. It's about the gap between conversations and work.** Managers already have the 1:1s; the conversations are happening. The problem is that nothing from those conversations makes it into the performance record. *What you discussed last Tuesday becomes what you're working on this week, and the evidence for what you recognize and assess at end of quarter.* (Adopted as team GTM position 2026-05-12 — Decisions Log D-006.)
2. **Connect once. Intelligence compounds over time.** Every meeting, every Slack thread, every Jira comment adds evidence to the right object on the user's record. The system gets sharper the longer it runs.
3. **AI augments managers; it doesn't act on their behalf.** Nothing reaches the performance record without explicit user confirmation. The AI surfaces; the human decides.
4. **Every claim is traceable.** Click any suggestion's "Why this?" to jump to the exact moment in the source meeting, Slack message, or Jira ticket. Trust is built on transparent provenance — not magic.

### Differentiation
Others (Otter, Fireflies, Zoom AI Companion, Lattice's free-form AI) do **summarisation** → We do **multi-source evidence linked to the performance record with mandatory human confirmation and clickable provenance** → Why it matters: **the signal arrives in the system that drives reviews, raises, and growth — and the user can verify every claim**.

## 5. Existing Alternatives & Competition

| Alternative | Who / What | Limitation |
|---|---|---|
| Manual note-taking | Google Doc / Notion / Betterworks agenda | Inconsistent, no routing, no provenance |
| Generic AI note-takers | Otter, Fireflies, Granola, Zoom AI Companion | Produces summary; no performance-system routing; no template-bound output |
| Free-form AI feedback | Lattice AI feedback assistant | Ignores org competency framework / templates (industry anti-pattern) |
| Native Zoom AI Companion | Zoom | Stops at summary; data stays in Zoom |
| Recall AI (bot ingestion) | Recall AI | Rejected 2026-04-28 by exec sponsor: "6 people = 6 bots in a meeting — poor UX." Plus security + customer friction. (Decisions Log D-001.) |
| Sales-intelligence analogues | Gong, Clari | Evidence-to-object pattern is the right model — but they only do CRM. We do performance. |
| Survey-based feedback | Lattice, 15Five, Culture Amp | Captures sentiment; misses the actual conversation content |

## 6. Key Metrics & Revenue Drivers

> **Platform-scope metrics: pipeline health, model quality, trust.** Surface-engagement metrics live in the consumer PRDs (`PRD-MEETINGS-AI-SURFACES` §6, `PRD-CONNECT-LAYER` §6). All metrics marked `[proposed, awaiting analytics verification]` until `analytics/metrics-definitions.md` is updated.

### Adoption (platform usage)

| Metric | Definition | Benchmark | Event |
|---|---|---|---|
| Pipeline coverage rate | % of eligible inputs producing ≥1 suggestion | 80–95% (Gong ~92%) | `ai.pipeline.completed` w/ `suggestion_count` |
| Eligible inputs ingested / week | Volume metric — denominator for everything else | trend up | `ai.pipeline.invoked` |

### Quality (model output)

| Metric | Definition | Benchmark | Event |
|---|---|---|---|
| **Suggestion acceptance rate** ⭐ | % confirmed (vs. dismissed/edited/ignored) | 30–60% (Copilot 26–35%; Gong tuned 40–60%) | `ai.suggestion.confirmed` |
| Edit-distance on accept | Levenshtein/token-diff between suggested and confirmed text | <15% = trust-grade; >40% = users rewriting | `ai.suggestion.confirmed.edit_distance_pct` |
| Eval-set regression score | Offline precision/recall vs. golden set per release | No regression >2pp release-over-release | offline run, dashboarded |
| Hallucination / trust-flag rate | % suggestions flagged by users + % blocked by LM Proxy guardrails | <2% | `ai.suggestion.flagged`, `ai.proxy.guardrail.blocked` |

### Efficiency (latency)

| Metric | Definition | Benchmark | Event |
|---|---|---|---|
| Pipeline P95 latency | Input received → suggestion available | <5 min (per §10a SHOULD); <20s for summary alone | `ai.pipeline.stage.duration_ms` |
| Time-to-confirm (TTC) median | Suggestion rendered → user action | <10s scannable; >45s = cognitive load | `ai.suggestion.rendered` → `.actioned` delta |

### North Star (cross-PRD, watched daily for first 30 days post-launch)

1. **End-to-end Connect → First AI Confirm conversion** (lives in `PRD-CONNECT-LAYER` §6) — proves whole pipeline works for real users.
2. **AI Action-Item Completion Lift** (lives in `PRD-MEETINGS-AI-SURFACES` §6) — proves feature changes work behaviour.
3. **Suggestion Acceptance Rate** (this PRD ⭐ above) — daily proxy for model trust.

### Revenue / ARR
- Performance Enablement tier retention `[unverified; needs sales-led modelling]`
- Deal influence in evaluation cycles `[unverified; needs sales-led modelling]`

## 6a. Open Metric Gaps

| Gap | Owner | Trigger to resolve |
|---|---|---|
| **Baseline for action-item completion in current Meetings module** | Analytics owner + Meetings PM | Before launch — needed for "1.4–1.8× lift" comparison (PRD-MEETINGS-AI-SURFACES §6) |
| **Revenue/ARR attribution model** | Sales + PM owner | Before exec readout post-launch |
| **Eval-set golden corpus** | AI Platform lead + PM owner | Before S-04 (signal extraction) ships — gates Quality.regression-score |
| **`analytics/metrics-definitions.md` entries** | PM owner + Analytics | Before any metric ships in a dashboard |

## 7. Core Capabilities

> Each capability has a stable `CAP-XXX` ID. Acceptance criteria (Phase 2 §9) reference these.

### Meetings module anchoring

The Meetings module is a first-class home for AI features in this PRD. Per-meeting and across-meeting AI surfaces live there:

| Surface | Per-meeting page | Across-meetings digest (new, CAP-013) |
|---|---|---|
| Summary | CAP-001 | Themes across N recent meetings |
| Action items (suggested) | CAP-002 → routes to action_item objects | Open / overdue list across meetings |
| Agenda items (suggested for this meeting) | CAP-002 | — |
| "Before your next 1:1" prep | CAP-004 (multi-session retrieval) | — |
| Why-this panel | CAP-009, inline on every suggestion | CAP-009, inline |

The Meetings module surfaces AI suggestions natively; signals also flow into Goals / Feedback / Skills modules via Reconciliation (CAP-005). One evidence row can power multiple module surfaces — that's the whole point of the evidence-centric model.

### UI / Front-End
*Owned by Meetings pod + Connections pod — cross-PRD references.*

### Back-End (AI Platform — this PRD)

- **CAP-001 — Meeting Summary Generation** — Accept raw transcript → return structured `topic_summary` + agenda-item evidence. **Betterworks-owned LLM generation; does not rely on Zoom AI Companion's native summary** (different intent, different user base, different downstream routing). Degrades gracefully for sparse content. Aha: `AI-201` · Jira: `[child story TBD]`
- **CAP-002 — Action Item & Discussion Topic Extraction** — Emit `action_item` and `agenda_item` evidence with owner attribution where speaker-map permits. **MUST per Meetings pod requirement**. Aha: `AI-201 + MEET-48` · Jira: `[child story TBD]`
- **CAP-003 — Performance Signal Extraction** — Emit signals across five types: `skill_demo`, `goal_progress`, `feedback_moment` (positive + constructive), `coaching_theme`. Each routes to a downstream Betterworks object via Reconciliation (CAP-005). Aha: `AI-201` · Jira: `[child story TBD]`
- **CAP-004 — Pre-Meeting Coaching Prompts** — Generate "Before"-moment talking points for the next 1:1, drawing on prior evidence and both participants' open goals. Multi-session retrieval over the evidence table. Architecturally distinct — uses AWS MWAA preprocess. Aha: `AI-201` · Jira: `[child story TBD]`
- **CAP-005 — Reconciliation Framework** *(personalisation layer, expanded from dedup)* — Links new evidence to the user's existing objects (Goal, Meeting, Feedback, Skill). Per-type cascade: rules/entity-match → embedding similarity (per-type thresholds 0.88–0.92) → LLM-as-judge on the ambiguous band. Outputs `object_type`, `object_id`, `link_method`, `link_confidence`. Persists `dedup_decision` for audit and threshold tuning. **Multi-source ready** — transcripts is one input; same framework handles Slack/Jira/CRM signals later. Established 2026-05-08 (Decisions Log D-003). Jira: `[child story TBD]`
- **CAP-006 — Module-Native Surfacing** *(replaces global Suggestions Queue)* — Per-module ranking and rendering:
  - Goals page: goal-level suggestions ranked top; per-goal evidence panel; new-goal proposals
  - Feedback page: pre-filled draft list (via CAP-010); one-click log
  - Skills page: skill evidence + endorsement suggestions
  - Meetings page: agenda items + topic summary + action items per meeting
  - No global queue. Ranking: `0.4·confidence + 0.25·type_prior + 0.2·exp(-age_days/half_life) + 0.15·user_type_accept_rate`; half-life 3–7 days per type. Auto-expire after 14 days (state: `stale`).
- **CAP-007 — Org-Level Validation Passthrough for Goal Suggestions** — Accepted goal suggestions pass through the org's Goals admin validation (scope, type, mandatory attributes) before publish. AI does not bypass governance.
- **CAP-008 — Per-User Meeting & Source Exclusion Filter** — User can mark specific meetings (or future: Slack channels, Jira projects) as excluded from ingestion. Existing evidence rows from excluded sources are marked `redacted=true`, retained for audit but hidden in UI.
- **CAP-009 — Evidence Provenance & Traceability** — Every evidence row carries `source_system`, `source_ref_url` (clickable deep link with media timestamp where applicable), `speaker_user_id` (or raw label), `observed_at`, `excerpt_text`. Permission-checked at click time — if the viewer lacks source access, the link is disabled but excerpt + speaker + timestamp remain visible. "Why this?" panel renders inline on every suggestion. Includes "Report bad evidence" affordance.
- **CAP-010 — Template-Bound Feedback Pre-fill** — Slot-fills the user's allowed feedback templates from accumulated evidence. Schema: `feedback_draft(template_id, slot_values jsonb, evidence_ids[])`. LLM SHALL NOT emit feedback as free-form prose outside a template (anti-Lattice pattern). One-click "log" copies slot values into the real feedback record. **Open issue (D-013 follow-up)**: handling when user has no allowed feedback template — proposal is draft-state feedback object pending template assignment; *to be discussed with Feedback (Performance) pod*.
- **CAP-011 — Source Adapter Framework** — Pluggable adapter contract: `authenticate(user) → token`; `fetch(user, since) → raw_payload[]`; `permission_check(viewer, evidence) → bool`; `build_deep_link(evidence) → url`. **MVP**: automated Zoom transcript ingestion (via Cloud Recording API + webhook) is required (D-013). Manual paste path retained as a demo-only safety net. **Ownership**: Integrations pod owns Zoom adapter delivery; **AI Platform Lead absorbs ownership** if Integrations pod cannot deliver in the Summer window (per 2026-05-13 exec decision). **Stretch**: Teams adapter (good-to-have if Zoom lands early). Roadmap: Slack, Jira, HubSpot, Salesforce. Schema is multi-source from day one.
- **CAP-012 → `PRD-CONNECT-LAYER`** (CONN-CAP-001..006). Platform contract: evidence rows are only written when `connection.state = connected`; revoke propagates to `evidence.locked = true`; hard-delete cascades after the 30-day grace. See §14 D-011.
- **CAP-013 → `PRD-MEETINGS-AI-SURFACES`** (MEET-CAP-101 list-level digest, MEET-CAP-202 "Before" cross-session summary, MEET-CAP-203 last-meeting recap). Platform contract: each consumes summaries from CAP-001 + signals from CAP-002/003/004. See §14 D-011.

### Admin Configuration
*Owned by Integrations + Platform — see ENG-79199 "Out of Scope" block.*

---

## 7a. Story Decomposition (Platform-scope only)

> Platform stories below cover the AI pipeline + Reconciliation Framework + Source Adapter contract. Consumer-surface stories (M-01..M-08, C-01..C-07) live in `PRD-MEETINGS-AI-SURFACES` §7a and `PRD-CONNECT-LAYER` §7a respectively. MVP target: Rainforest-testable May 31, feature-complete August 2026.

### MVP — Summer 2026 (must ship)

| # | Story | Caps covered | Owner | Sequencing |
|---|---|---|---|---|
| **S-01** | **Canonical evidence schema** — Aurora table + write API + indexes | foundation for all | AI Platform | **Week 1–2 (blocking)** |
| **S-02** | **Source adapter contract** — interface only; spec committed | CAP-011 | PM Owner + Integrations PM | Week 2 (blocking) |
| **S-03** | **Manual transcript ingestion adapter** | CAP-011 | AI Platform | Week 3–4 |
| **S-04** | **AI signal extraction — single-pass** (summary + action items + agenda items + feedback/skill/goal/coaching signals) | CAP-001, CAP-002, CAP-003 | AI Platform | Week 3–6 |
| **S-05** | **Reconciliation framework v1** — rule + embedding cascade (LLM-judge deferred to S-13) | CAP-005 | AI Platform | Week 4–6 |
| **S-06** | **Module-native surfacing — Meetings page** (per-meeting summary, action items, agenda items) | CAP-006 (Meetings), CAP-001, CAP-002 | Meetings pod | Week 5–7 |
| **S-07** | **Why-this panel + clickable deep-links** — Zoom timestamp + Betterworks meeting record only | CAP-009 | Meetings pod + AI Platform | Week 5–7 |
| **S-08** | **4-state model + pending writes + retention defaults** | foundation | AI Platform | Week 4–5 |
| **S-09** | **Per-meeting exclusion filter (CAP-008 MVP scope)** — Zoom meetings only | CAP-008 | Integrations + Meetings | Week 6 |
| ~~S-10~~ | ~~Connect Layer foundation~~ → **moved to `PRD-CONNECT-LAYER` (C-01..C-06)** | — | Connections pod | child PRD |
| ~~S-11~~ | ~~Multi-meeting digest~~ → **moved to `PRD-MEETINGS-AI-SURFACES` (M-03/M-07/M-08)** | — | Meetings pod | child PRD |
| **S-12** | **Rainforest smoke + evaluation harness** — 10–15 sample transcripts, per-capability thresholds | DoD | PM Owner + AI Platform | Week 4 onward |
| **S-13 (stretch)** | LLM-judge tier of reconciliation cascade | CAP-005 | AI Platform | Week 8–10 |
| **S-14 (stretch)** | Template-bound feedback pre-fill — one template | CAP-010 | AI Platform + Performance pod | Week 8–10 |
| **S-15 (stretch)** | Goal suggestions on Goals page | CAP-006 (Goals), CAP-007 | AI Platform + Goals pod | Week 9–11 |

### Future (post-Summer 2026 — explicitly out of MVP)

| Story | Caps | Trigger to start |
|---|---|---|
| Zoom automated ingestion (vendor-vs-native decision resolved) | CAP-011 (Zoom auto) | After D1 decision |
| Teams adapter | CAP-011 | Customer demand (Sony) |
| Slack adapter | CAP-011 | Phase 2 |
| Jira / HubSpot / Salesforce adapters | CAP-011 | Customer-driven |
| CAP-004 full multi-session retrieval w/ MWAA preprocess | CAP-004 | After S-04 ships |
| Outbox + CDC + SSE delivery upgrade | infra | When 3s-poll cost hurts |
| Learned ranking model | CAP-006 | ≥50k labeled accept/dismiss events |
| Per-signal-type connect granularity | CAP-012 | Customer-driven |
| Admin "auto-confirm" policies for trusted signal types | new | Phase 3 |
| Live A2A endpoint | a2a | Second agent needs it |
| Multi-language transcript support | CAP-001 | Customer-driven |
| Cross-org skills clustering | new | Phase 3 |

### Story dependency graph (critical path)

```
S-01 (evidence schema) ──┬─► S-04 (extraction) ──► S-05 (reconciliation) ──┬─► S-06 (Meetings surfacing)
                         │                                                  │
                         └─► S-02 (adapter contract) ──► S-03 (manual ingest)│
                                                                            └─► S-07 (Why-this) ──► S-11 (digest)
                                                                            
S-08 (state model) ──► S-09 (exclusion) ──► S-10 (Connect Layer)
S-12 (eval) runs in parallel from Week 4
```

**Critical path: S-01 → S-04 → S-05 → S-06 → S-11.** Other stories parallelise; S-01 + S-02 are the Week-1/Week-2 unblock priority.

<!-- ============================================================== -->
<!-- PHASE 2 — Product Requirements — GATED                          -->
<!-- ============================================================== -->

> **Phase 2 is gated** behind sign-off on §1–§7a. To be drafted after Phase 1 review.

## 10. Assumptions, Dependencies & Risks

### Assumptions
- Pipeline engineering resources allocated at sufficient capacity (pending AI engineering leadership + exec sponsor confirmation).
- Private LLM stack (Llama 3.1 8B → Gemma 4) on AWS EC2 GPU via EKS, fronted by LM Engine + LM Proxy with 20-category guardrails, is the inference substrate (confirmed 2026-05-11 by AI Platform lead).
- Async-poll pattern used today for Skills (post-and-poll-DB-3s) is the working delivery model; outbox + CDC + SSE is a v2 upgrade.
- Pre-meeting Coaching Prompts (CAP-004) can leverage AWS MWAA scheduled preprocessing.
- Customers will accept opt-in transcript processing with clear consent UX (no contractual blockers expected).
- Manual copy-paste path is acceptable for MVP — automated ingestion is not required for the Rainforest demo to exec sponsor and AI engineering leadership.
- Goals pod admin validation framework (CAP-007) can be invoked as a passthrough without modification (confirmed 2026-05-12 by Meetings/Goals PM).
- `llm-engine` PR #512 (ENG-78223) establishes the precedent for conversation-context flow — CAP-003/004 build on this, not greenfield.

### Dependencies
- **Evidence schema** (canonical `evidence` table in Aurora) — PM owner drives; consumed by all four module pods. **Highest-priority pre-implementation dependency.**
- **Adapter contract specification** — PM owner + Integrations PM co-own; locks the shape that future adapters (Slack, Jira, etc.) inherit. MVP only implements Zoom + Manual but contract must support the rest.
- **Speaker-to-Betterworks-user-ID resolution** — owned by Integrations pod.
- **Open goals data at inference time** — owned by Goals/Performance pod; blocks CAP-004.
- **Anytime 360 Feedback schema stability** — owned by Performance pod; blocks CAP-003 routing + CAP-010 template binding.
- **Feedback template enumeration API** — needs to list a user's allowed templates for CAP-010 slot-filling.
- **Skills taxonomy stability** — owned by Talent Intelligence pod.
- **Goals admin validation framework** (CAP-007 passthrough) — owned by Goals pod.
- **Meetings pod UI for per-module surfacing + Why-this panel** — owned by Meetings pod; blocks end-to-end test.
- **Design specs for Why-this panel + connect-layer touchpoints** — owned by Design lead (action: layout, density, report-bad-evidence flow, connect prompts in module pages).
- **Connect Layer UI** — central Connections page + per-module prompts — cross-PRD (PRD-CONNECT-LAYER, owner TBD).
- **Deep-link URL builders per provider** — Zoom timestamp deep-link (`?t=`), Slack permalink format, Jira browse URL, etc. Each small but needs verification per source.
- **LM Engine + LM Proxy integration** — owned by AI Platform lead; known available per 2026-05-11.
- **Aha! customer-request scan** — Meetings/Goals PM sharing findings.

### Risks / Areas to Monitor
- **Rainforest milestone (2026-05-31) vs. current story sequencing** *(NEW v0.7.0)* · Likelihood: **High** · Several stories (S-04, S-06, M-02..M-08, C-03..C-06) are scheduled Week 5+ which lands after May 31. Exec sponsor (per 2026-05-13 alignment) accepts that the Rainforest date may need to move pending scope review rather than cutting scope. Mitigation: PM owner books exec scope-alignment meeting in Week 2; until then, treat May 31 as a target, not a frozen commitment. No silent scope cuts.
- **Zoom API integration delivery risk** *(escalated v0.8.0)* · Likelihood: **High** · Per 2026-05-13 exec decision, Zoom API ingestion is **MVP required** (was "MVP if doable" in v0.7.0). Ownership fallback: AI Platform Lead absorbs the work if Integrations pod cannot deliver in the Summer window. Manual paste demoted to demo-only safety net (not customer fallback). Mitigation: Integrations capability spec due Thursday 2026-05-15; AI Platform Lead identified as fallback owner; PM owner tracks via §10b Pre-mortem mode #5.
- **Integrations pod pushing Recall AI over native Zoom POC** *(NEW v0.8.0)* · Likelihood: **Med** · Process risk flagged by exec sponsor 2026-05-13. Recall AI was rejected 2026-04-28 (D-001); the current Integrations approach is misaligned with that decision. Mitigation: PM owner re-state D-001 + D-013 in the Thursday capability-spec meeting; escalation path via Principal Eng per Owners block.
- **Engineer-estimated 4–5 month timeline vs. summer deadline** · Likelihood: **High** · Mitigation: Flagged by AI engineering leadership 2026-05-07; principal-eng escalation path defined in Owners block; Problem 1/2 decoupling.
- **Evidence schema unresolved across four module pods (Goals, Feedback, Skills, Meetings)** · Likelihood: **Med** · Mitigation: PM owner drives canonical schema sign-off Week 2; one source of truth.
- **Evidence trust collapse from early bad attributions** *(NEW v0.3.0)* · Likelihood: **Med** · Mitigation: ship Why-this panel + clickable links on day 1; "Report bad evidence" button from launch; per-source trust scoring tunable.
- **Connect-layer adoption friction** *(NEW v0.3.0)* — users don't connect their meeting platform, feature value collapses · Likelihood: **Med** · Mitigation: per-module inline prompts at moments of clear value ("see action items from your last 1:1: connect Zoom"); first-run guided connect.
- **Reconciliation produces wrong object-links** · Likelihood: **Med** · Mitigation: persist `link_method` + `link_confidence`; user can re-link via Why-this panel; tune thresholds from real labels.
- **Vendor vs. native Zoom decision (D1) slips past May 31** · Likelihood: **Med** · Mitigation: Manual MVP unaffected; only blocks Phase 2 ingestion.
- **Processing architecture (D2) chosen before evaluation framework exists** · Likelihood: **Med** · Mitigation: minimal eval harness Week 2 with 5–10 sample transcripts.
- **Pending-suggestion retention policy (D5)** · Likelihood: **Low** · Mitigation: 30-day default; revise post-feedback.
- **AI hallucination on sparse content** · Likelihood: **Med** · Mitigation: confidence threshold suppression; LM Proxy 20-category guardrails.
- **Customer compliance / consent concerns at rollout** · Likelihood: **Med** · Mitigation: explicit per-app OAuth scopes; per-meeting exclusion (CAP-008); data governance design pre-launch.
- **Gemma 4 latency regression** · Likelihood: **Low** · Mitigation: stay on Llama 3.1 8B for MVP; migrate post-TensorRT support.

### 10a. Constraints & Invariants

> **RFC-2119 binding.** LOCKED. Coding agents and downstream PRDs must not violate. Source-cited.

**MUST**
- **THE SYSTEM SHALL store evidence as a first-class entity** linked to a user (`user_id`), a source (`source_system + source_ref_id + source_ref_url`), an observation timestamp, and (after reconciliation) an object (`object_type + object_id`). (Source: D-008.)
- **THE SYSTEM SHALL render every evidence row with a clickable deep link to its source** — internal (Betterworks meeting record) or external (Zoom timestamp deep-link, Slack permalink, Jira issue URL, CRM record URL). (Source: D-008.)
- **THE SYSTEM SHALL perform a permission check at click time** for external sources; if the viewer lacks access, the link is disabled but excerpt + speaker + timestamp remain visible. Never hide the existence of evidence.
- **THE SYSTEM SHALL attribute every evidence row to a `speaker_user_id` when resolvable**; unresolved speakers render with their raw source label (not falsely attributed).
- **THE SYSTEM SHALL pre-fill feedback drafts into the user's existing allowed templates** (`template_id + slot_values + evidence_ids[]`); the LLM SHALL NOT emit feedback as free-form prose outside a template. (Anti-Lattice pattern.)
- **THE SYSTEM SHALL surface AI suggestions per-module on the relevant module page.** No global Suggestions Queue. Any cross-module overview is a read-only digest (CAP-013 in MVP scope).
- **THE SYSTEM SHALL pass any accepted goal-type suggestion through the org's existing Goals admin validation** before publishing. (Source: D-004.)
- **THE SYSTEM SHALL route all LLM inference through the LM Engine + LM Proxy** with 20-category guardrail checks. (Source: D-007.)
- **THE SYSTEM SHALL honour per-user meeting / source exclusion** (CAP-008): excluded rows are kept with `redacted=true` for audit, not deleted.
- **THE SYSTEM SHALL require an explicit user-driven connect per external source** before ingestion. Connect is per-app, revocable, with explicit OAuth scopes.
- **THE SYSTEM SHALL write all AI-generated output in a `pending` state.** No output writes to performance records without explicit user confirmation.
- **THE SYSTEM SHALL support the four-state model**: `pending`, `confirmed`, `dismissed`, `edited_confirmed`. Plus `stale` after 14 days of inactivity.
- **THE AI PLATFORM SHALL accept input only via a documented payload contract** including: transcript text (or source-equivalent), speaker-to-Betterworks-user-ID mapping, participant user IDs and roles, observation date/time, source identifier.
- **THE SYSTEM SHALL be feature-complete by August 2026** for the summer release.

**MUST NOT**
- **THE SYSTEM SHALL NOT operate a global suggestions queue.** Surfacing is per-module.
- **THE SYSTEM SHALL NOT emit feedback as free-form prose outside a user's allowed template.**
- **THE SYSTEM SHALL NOT use bot-based meeting recording.** ("6 people = 6 bots — poor UX." — Decisions Log D-001.)
- **THE SYSTEM SHALL NOT take action on the user's behalf.** Augment, not act.
- **THE SYSTEM SHALL NOT ingest from a source the user has not connected.** Connect is the prerequisite.
- **THE SYSTEM SHALL NOT block AI processing (Problem 2) on the ingestion pipeline (Problem 1).** Manual paste keeps MVP shippable.
- **THE SYSTEM SHALL NOT write any AI suggestion to a performance record without `state ∈ {confirmed, edited_confirmed}`.**
- **THE SYSTEM SHALL NOT process meeting types other than 1:1 in MVP.**
- **THE SYSTEM SHALL NOT call external LLM providers from the inference path.** Private LLM stack only.
- **THE SYSTEM SHALL NOT name a specific LLM model version in user-facing copy or PRD body.**

**SHOULD**
- THE SYSTEM SHOULD return outputs within 5 minutes of transcript availability; sub-20s for summary generation.
- THE SYSTEM SHOULD use the async-poll pattern (3-second DB poll) for MVP, matching the existing Skills flow; outbox + CDC + SSE is a v2 upgrade.
- THE SYSTEM SHOULD surface unresolved-speaker action items rather than suppress them.
- THE SYSTEM SHOULD expose a confidence score on every output.
- THE SYSTEM SHOULD apply per-type half-life decay to ranking (3–7 days for action items; longer for skill demos).
- THE SYSTEM SHOULD allow per-tenant configuration of source trust weights (default: native meeting > Slack > Jira comment > CRM note).
- THE SYSTEM SHOULD persist `evidence_ids[]` on every suggestion and render the Why-this panel inline.

### 10b. Pre-mortem

*It's September 2026. The feature shipped but failed. Five plausible failure modes — the PM owner should treat each as a Week-2/Week-3 unblock priority:*

1. **Schema fracture.** The canonical `evidence` table contract was not signed off across four module pods (Goals, Feedback, Skills, Meetings); each built against an assumed shape; July integration exposed mismatches; refactor consumed the customer-validation window.
2. **Bad ranking.** The module-native ranking rubric shipped without a calibrated half-life; managers saw stale or noisy suggestions on first open; "augment" read as "annoy."
3. **Evidence trust collapsed.** A few high-profile false attributions (wrong speaker, hallucinated quote, broken deep-link to Zoom) destroyed manager trust early. Users stopped clicking suggestions because they couldn't verify provenance.
4. **Connect-layer adoption stalled.** Users didn't connect their meeting platform — feature looked empty; value never compounded. Per-module connect prompts at the moment of value were either missing or skipped.
5. **Zoom API didn't ship + scope/timeline negotiation slipped** *(escalated v0.8.0)*. Rainforest milestone (May 31) held as a date; Integrations pod couldn't deliver Zoom adapter; AI Platform Lead fallback was triggered too late; team shipped manual-paste-only demo that exec sponsor explicitly called "a non-starter for adoption." Mitigation: PM owner books exec scope-alignment Week 2 (concrete proposal: move date or trim non-Zoom scope); Integrations capability spec due Thursday 2026-05-15; AI Platform Lead fallback ownership formalized in writing.

*Mitigations: (1) PM owner drives evidence-schema sign-off in Week 2 with all four pod leads, written contract committed before any pod builds. (2) Calibrate ranking against 10–15 sample user histories in Rainforest before customer rollout. (3) Ship Why-this panel + clickable links + "Report bad evidence" on day 1, not v2. (4) Design lead specifies in-module connect prompts that surface at moments of value, not as a one-time onboarding ask.*

## 11. Out of Scope / Known Limitations

### Non-Goals (explicit, Phase 1)
- **No global Suggestions Queue.** Per-module surfacing only.
- **No free-form AI feedback emission.** Template-bound (CAP-010) only.
- **No autonomous action on behalf of the user.** Augment, not act.
- **UI for transcript paste, suggestion rendering, confirmation flows** — owned by Meetings pod.
- **Admin controls and data governance UI** — owned by Integrations + Platform.
- **Writing confirmed suggestions to performance records** — owned by destination pod (downstream of `pending` writes).
- **Meeting types other than 1:1** — group, all-hands, panel deferred.
- **Multi-source ingestion (Slack/Jira/HubSpot/Salesforce)** — adapter contract designed in v1; only transcript adapter ships in MVP.
- **Goal suggestions as a primary MVP capability** — stretch target only; Phase 1 prioritises meeting-level suggestions.

### MVP Stretch (in scope if bandwidth permits — per 2026-05-13 exec decision, refined this round)
- **Microsoft Teams API ingestion path** — **good-to-have stretch**. In scope only if Zoom API lands early enough to free Integrations capacity. Aha! INT-181.

> **Note**: Zoom API ingestion is no longer "stretch" — it is **MVP required** (see D-013, CAP-011, §10a MUST). Manual paste path is retained as a demo-only safety net.

### Future Roadmap Items
- ~~Cross-module digest~~ → **reframed as CAP-013 Multi-Meeting Digest, lives in the Meetings module, in MVP scope.** (Updated 2026-05-13.)
- **Live A2A endpoint** — static `agent-card.json` only in v1.
- Slack / Jira / HubSpot / Salesforce adapters (post-Summer 2026).
- Multi-language transcript support.
- Cross-meeting theme detection at org level.
- Admin-level "auto-confirm" policies for trusted signal types.
- Per-signal-type connect granularity (Phase 2 stretch).
- Outbox + CDC + SSE upgrade replacing 3-second poll.
- Learned ranking model (after ≥50k labeled accept/dismiss events).

### Migration Considerations
- No existing data to migrate (greenfield).
- Customers with existing 3rd-party transcription: opt-in positioning; GTM communications plan.

## 12. Documentation & Resources

- `type: confluence` — **Parent PRD: [Zoom & Teams Transcripts Feature Documentation](https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097)** (last updated 2026-05-04). High-level strategic / GTM PRFAQ; the trio (this PRD + sibling PRDs) is the operational decomposition.
- `type: jira` — `ENG-79199` — AI Processing Pipeline for Meeting Transcripts (Epic)
- `type: jira` — `ENG-78223` — peer + manager conversations in AI features (precedent for CAP-003/004)
- `type: aha` — `AI-201` — AI Processing / Conversation Intelligence (Level A — Revenue Creator)
- `type: aha` — `MEET-48` — Meetings module 1:1 card, manual input, action items
- `type: aha` — `INT-181` — Microsoft Teams OAuth + Graph API transcript retrieval
- `type: aha` — `INT-185` — Zoom OAuth + Cloud Recording API transcript retrieval
- `type: aha-idea` — `INT-I-110` — Sales-requested customer idea (High Priority): meeting transcript integration
- `type: aha-idea` — `AI-I-52` — Sales-requested customer idea: AI-driven performance insights from meetings
- `type: meeting-note` — `ops/meeting-notes/2026-05-04-week-synthesis.md`
- `type: meeting-note` — `ops/meeting-notes/2026-05-07-lalit-sriram.md`
- `type: zoom-transcript` — 2026-05-08 Lalit + Gauri + Nellie "MVP scope alignment" — meeting_uuid `F6113EF7-3757-491E-B45C-4B1E53D8D31F`
- `type: zoom-transcript` — 2026-05-08 Lalit + Gauri intro — meeting_uuid `5C80334B-5A25-4D36-B67A-EB44F1CC65A1`
- `type: zoom-transcript` — 2026-05-11 Architecture Walkthrough w/ Jason Zhang — meeting_uuid `9988F4F9-4D28-407C-868E-DB1052ADCED9`
- `type: zoom-transcript` — 2026-05-12 Varnika / Lalit — meeting_uuid `D236D5E5-A01C-4D20-91C3-935FF3588D90`
- `type: slack` — `#temp-meeting-transcript-integration` — Nellie's framing (Apr 28: bot-rejection rationale; Apr 30: Before/During/After UX; May 4: brainstorm recording share)
- `type: slack` — Design Group DM (Paul, Sarah, Austine, Nataliya, Nellie, Lalit) — May 12 (Paul's GTM framing; Nataliya's design ask: review→refine→apply)
- `type: slack` — `#pod-ai-platform` — PR #512 / ENG-78223 (existing conversation-context flow)
- `type: github` — `BetterWorks/llm-engine` PR #512 — substrate for CAP-003/004
- `type: repo-doc` — `product/meeting-transcripts/delivery-plan.md`
- `type: repo-doc` — `product/meeting-transcripts/open-questions.md`
- `type: repo-doc` — `knowledge/architecture/knowledge.md`
- `type: aha` — `[TBD — Meetings/Goals PM scanning]`
- `type: figma` — `[TBD — Design Lead, pending VPN; design action: Why-this panel layout + connect-prompt placements]`
- `type: confluence` — `[TBD]`
- `type: dashboard` — `[TBD — analytics has no metrics defined yet]`
- `type: prd` — `[TBD — PRD-TRANSCRIPT-INGESTION (Integrations pod)]`
- `type: prd` — `[TBD — PRD-MEETINGS-CONFIRMATION-UI (Meetings pod)]`
- `type: prd` — `[TBD — PRD-CONNECT-LAYER (owner TBD)]`

---

## §13a Product Acceptance Criteria (Phase 1)

> These are the *product-level* conditions for declaring Phase 1 ready to ship — distinct from per-AC EARS criteria (Phase 2 §9). Inherits ENG-79199 epic-level acceptance criteria and adds PRD-specific ones grounded in the §10a Constraints.

### Inherited from ENG-79199 (Jira epic)
- [ ] **PAC-01** — All four MVP AI capabilities return structured output matching the agreed input/output schema
- [ ] **PAC-02** — No AI output is written to any Betterworks record without explicit user confirmation
- [ ] **PAC-03** — Processing architecture (unified vs. multi-pass) documented and agreed before implementation
- [ ] **PAC-04** — Evaluation framework with defined test corpus and acceptance thresholds in place before code review
- [ ] **PAC-05** — Edge-case behaviour (sparse content, unresolved speakers, unsupported language) defined and tested
- [ ] **PAC-06** — Input/output contract signed off by Meetings pod + AI platform leads before either team begins implementation

### Added at PRD level (v0.4.0)
- [ ] **PAC-07** — Canonical `evidence` table schema (§1a) signed off by **all four module pod leads** (Goals, Feedback, Skills, Meetings) and committed to repo before S-04 starts
- [ ] **PAC-08** — Source adapter contract (CAP-011) committed; the Zoom + Manual adapters implement it; the contract supports Slack/Jira/HubSpot/Salesforce without schema changes
- [ ] **PAC-09** — Every AI suggestion in the UI renders a Why-this panel inline with **clickable, permission-checked deep links** to source evidence (Zoom timestamp deep-link + Betterworks meeting record minimum for MVP)
- [ ] **PAC-10** — Connect Layer ships per `PRD-CONNECT-LAYER` §13a CPAC-01..10. Platform-side: evidence rows respect `connection.state`; disconnect propagates to `evidence.locked=true`; hard-delete cascades after the 30-day grace.
- [ ] **PAC-11** — Per-meeting exclusion (CAP-008) creates `redacted=true` rows kept for audit, not deleted; UI hides redacted content but the row remains queryable in admin tooling
- [ ] **PAC-12** — Module-native surfacing live for MVP — owned by surface PRDs (Meetings: see PRD-MEETINGS-AI-SURFACES §13a MPAC-01..10). Goals / Feedback / Skills surfacing is stretch.
- [ ] **PAC-13** — No global Suggestions Queue surface exists in the UI (constraint check)
- [ ] **PAC-14** — Feedback emission (if shipped — stretch S-14) is template-bound only; no free-form feedback prose path exists
- [ ] **PAC-15** — All inference runs through LM Engine + LM Proxy with 20-category guardrails (architecture-review checkpoint)
- [ ] **PAC-16** — No bot-based meeting recording in the codebase (architecture-review checkpoint)
- [ ] **PAC-17** — Rainforest smoke test passes for **automated Zoom ingestion happy path** (D-013 MVP commit) for Exec Sponsor + AI Engineering leadership review by the Rainforest milestone (target 2026-05-31; **may move pending exec scope-alignment** — see §10 Risks). Manual paste path is the demo-only safety net.
- [ ] **PAC-18** — "Report bad evidence" affordance instrumented from day 1 of customer rollout, with metrics flowing to a dashboard
- [ ] **PAC-19** — Data retention policy implemented per CAP-012 defaults (90d pending, 180d locked, 90d dismissed) and tunable per tenant
- [ ] **PAC-20** — Stakeholder sign-off captured (resolve names via Owners block; log in §14): PM Owner, Eng Lead (Pipeline), Design Lead, Exec Sponsor, Cross-pod PM (Meetings/Goals), AI Platform Lead, Principal Eng (escalation)

### Quality bars (measurable, MVP-grade)

| Dimension | Bar |
|---|---|
| Latency (transcript ready → suggestions visible) | < 5 minutes p95 |
| Summary generation latency (per CAP-001) | < 20 seconds p95 |
| Reconciliation link confidence on "Must Have" types | ≥ 0.85 mean on eval set |
| Why-this deep-link success rate (clicks resolving correctly) | ≥ 99% |
| Connect Layer success rate (Zoom OAuth flow) | ≥ 95% |
| Per-source trust scoring | Tunable per tenant; defaults shipped |

## §14 Decisions Log

> Dated record of locked decisions. **This is the one place in the doc where naming an individual is appropriate** — accountability is the point. Initials used for the named decider (resolve via Owners block); full source linked. Append-only; supersession noted explicitly.

| ID | Date | Decision | Decider (role / initials) | Rationale | Source |
|---|---|---|---|---|---|
| D-001 | 2026-04-28 | Recall.ai (bot-based ingestion) rejected as Zoom/Teams ingestion path | Exec Sponsor (NL) | "6 attendees = 6 bots — poor UX." Plus security review concerns; customer-friction risk. | Slack `#temp-meeting-transcript-integration` |
| D-002 | 2026-04-30 | Adopt Before / During / After UX framing for AI moments in 1:1s | Exec Sponsor (NL) | Forces feature into the user's existing workflow rather than a separate AI surface | Slack `#temp-meeting-transcript-integration` |
| D-003 | 2026-05-08 | Adopt centralised suggestion architecture: evidence-centric, reconciliation framework, per-user data | Exec Sponsor (NL) + PM Owner (LM) + Design Lead (GT) | Cross-module consistency without duplicating UI; reconciliation prevents duplicate suggestions across surfaces | Zoom uuid `F6113EF7-3757-491E-B45C-4B1E53D8D31F` |
| D-004 | 2026-05-12 | Goal suggestions must pass through the org's existing Goals admin validation (CAP-007 passthrough) | Cross-pod PM Meetings/Goals (VG) | AI must not bypass governance; Goals pod validation framework is authoritative | Zoom uuid `D236D5E5-A01C-4D20-91C3-935FF3588D90` |
| D-005 | 2026-05-12 | Phase 1 scope locked to Meetings module; Goal suggestions = stretch only | Cross-pod PM Meetings/Goals (VG) + PM Owner (LM) | Decouple from Goals to protect summer release; canonical user verbs (review → refine → apply) adopted as design language | Zoom uuid `D236D5E5-A01C-4D20-91C3-935FF3588D90` |
| D-006 | 2026-05-12 | "Gap between conversations and work" adopted as canonical GTM framing | Cross-functional design Group DM | Stronger than "AI for HR"; centres the customer problem | Slack design Group DM |
| D-007 | 2026-05-11 | All inference routes through LM Engine + LM Proxy with 20-category guardrails; private LLM stack only | AI Platform Lead (JZ) | Existing Skills-normalisation infra; meets customer-security commitment | Zoom uuid `9988F4F9-4D28-407C-868E-DB1052ADCED9` |
| D-008 | 2026-05-13 | Evidence-centric data model + clickable source provenance as non-negotiable | PM Owner (LM) | Trust is built through traceability (industry benchmark: Gong's deal timeline); polymorphic FK in Postgres chosen over property graph for operational fit | This PRD §1a |
| D-009 | 2026-05-13 | Multi-meeting digest scoped into MVP as a Meetings-module feature (CAP-013) | PM Owner (LM) | Meetings is the natural home for across-meeting digest; replaces previously-deferred "cross-module digest" | This PRD §1b, §7 |
| D-010 | 2026-05-13 | Names in PRD body replaced with roles; this Decisions Log is the accountability layer | PM Owner (LM) | Reduces staffing-drift, attribution-drift, GDPR/DSAR surface, and political ambiguity in a durable artifact | Industry practice (Atlassian / SVPG / Google design-doc convention) |
| D-011 | 2026-05-13 | PRD split — `PRD-MEETINGS-AI-SURFACES` and `PRD-CONNECT-LAYER` promoted to sibling PRDs; this doc reduced to platform scope (contracts, capabilities, SLAs) | PM Owner (LM) | Both children satisfied ≥3 of 6 split criteria (distinct persona, distinct pod, ≥4 caps, indep. DoD, section >8KB, distinct cross-fn consumers). Parent was >60KB. Matches Amazon multi-customer-PRFAQ pattern. CAP-012 detail moves to PRD-CONNECT-LAYER; CAP-013 + Meetings-anchoring moves to PRD-MEETINGS-AI-SURFACES. | Industry research (Cagan / Amazon Working Backwards / Atlassian PRD-vs-spec) |
| D-012 | 2026-05-13 (AM) | (a) Zoom API ingestion: from Phase-2-deferred → **MVP if doable**; manual paste remains MVP fallback. (b) Microsoft Teams ingestion: from MUST-NOT-Summer-2026 → **good-to-have stretch** (in scope if Zoom lands early). (c) Backfill from parent Confluence applied: release theme ("AI in the Flow of Work"), Level A Revenue Creator classification, Aha! IDs (AI-201, MEET-48, INT-181, INT-185, INT-I-110, AI-I-52), Innovation Partner Program early-access cohort. | Exec Sponsor (NL) | Aligns trio with the high-level parent Confluence PRFAQ; preserves the AI-in-the-Flow-of-Work positioning; raises ingestion ambition for Summer 2026 while keeping the manual fallback. | Exec alignment 2026-05-13 AM; parent Confluence (pageId 4247257097) |
| D-013 | 2026-05-13 (PM) | **SUPERSEDES D-012(a):** Zoom API ingestion is **MVP required** (not "if doable"). Manual paste demoted from "MVP fallback" → demo-only safety net. AI Platform Lead absorbs adapter ownership if Integrations pod cannot deliver in the Summer window. | Exec Sponsor (NL) | "Manual upload is a non-starter for adoption" — exec sponsor 2026-05-13 PM. Automated ingestion is the product commitment. | Zoom uuid 7D6A937E-6C54-4362-8AD2-8E16FF3E2A96 (Product Acceptance call) |
| D-014 | 2026-05-13 (PM) | Evidence rows write to **data warehouse (Aurora)** for cross-pod access + reporting; NOT siloed in pod DBs | AI Platform Lead (JZ) + Exec Sponsor (NL) | Cross-pod consumers (Goals/Feedback/Skills/Meetings) + analytics reporting layer need shared access; data warehouse is the right tier | Product Acceptance call 2026-05-13 PM |
| D-015 | 2026-05-13 (PM) | CAP-001 generates summaries from **raw transcripts via Betterworks LLM stack**; does NOT use Zoom AI Companion's native summaries | Exec Sponsor (NL) + PM Owner (LM) | Different intent (performance signal vs. general summary); different user base; different downstream routing (Betterworks objects, not generic notes) | Product Acceptance call 2026-05-13 PM |
| D-016 | 2026-05-13 (PM) | **Admin-level org enablement is a precondition** for user-level OAuth connect to any source | Exec Sponsor (NL) | Matches Lattice/Workday tenant-scoped integration patterns; reduces blanket-consent risk; enterprise sales requirement | Product Acceptance call 2026-05-13 PM |

### Pending decisions (open, owners assigned)

| ID | Question | Decision owner | Deadline |
|---|---|---|---|
| OPEN-D1 | Vendor vs. native Zoom integration path (Phase 2 ingestion) | PM Owner + Cross-pod PM Integrations | 2026-05-31 |
| OPEN-D2 | Processing architecture: unified vs. multi-pass | AI Platform Lead + PM Owner | Before Week 2 workshop |
| OPEN-D3 | Eng allocation (lead + capacity) for Pipeline track | AI Engineering Leadership + Exec Sponsor | Week 1 |
| OPEN-D4 | Skills API V1.5-extend vs. V2-retool | App Platform Lead + Exec Sponsor | TBD — affects API design |
| OPEN-D5 | Retention policy: 90 / 180 days default — confirm with Platform pod | PM Owner + Platform pod lead | Before Rainforest deploy |

---

## §13 Definition of Done — Phase 2 (placeholder)

> Phase 2 artifact; references AC-IDs to be created in Phase 2 drafting. Scaffold:

- [ ] All `Must Have` AC-IDs across CAP-001 through CAP-012 pass automated or manual test
- [ ] Canonical `evidence` schema committed to repo and signed off by all four module pod leads
- [ ] Source adapter contract specified; Zoom + Manual adapters implemented
- [ ] Evaluation harness with ≥10 representative transcripts; per-capability acceptance thresholds met
- [ ] `pending → confirmed | dismissed | edited_confirmed | stale` state model implemented and end-to-end tested
- [ ] Retention policy for unreviewed `pending` suggestions documented and enforced
- [ ] No-bot guarantee verified at architecture-review checkpoint
- [ ] Why-this panel renders inline on every suggestion with working deep-links + permission checks
- [ ] "Report bad evidence" affordance instrumented and metrics flowing
- [ ] Connect Layer: central page live; per-module prompts gated correctly
- [ ] Feedback drafts bound to template_id; no free-form emission in production
- [ ] Module-native surfacing live on Goals + Feedback + Skills + Meetings pages
- [ ] Rainforest smoke test passes for manual-input happy path (May 31 MVP milestone)
- [ ] Stakeholders signed off (resolve names via Owners block; log sign-offs in §14): PM Owner, Eng Lead (Pipeline), Design Lead, Exec Sponsor, Cross-pod PM (Meetings/Goals)
