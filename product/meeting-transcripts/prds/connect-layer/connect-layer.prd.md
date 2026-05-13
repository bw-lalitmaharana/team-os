---
id: PRD-CONNECT-LAYER
title: Cross-Platform Connect Layer (user-driven auth + consent)
status: draft
phase: 1
version: 0.3.0
parent: PRD-AI-PROCESSING-PIPELINE
owners:
  pm_owner: lalit.maharana@betterworks.com
  exec_sponsor: nellie.lemonier@betterworks.com
  integrations_pm: rinku@betterworks.com
  design_lead: gauri.thakur@betterworks.com
  eng_lead_connections: "[TBD — Connections pod assignment]"
  security_review: "[TBD — Security pod sign-off required]"
  legal_review: "[TBD — Legal/Privacy review required]"
release:
  season: Summer 2026
  release_theme: "AI in the Flow of Work"
  code_ready_date: 2026-08-15
  rainforest_milestone: 2026-05-31  # target; may move pending exec scope-alignment
links:
  jira_epic: ENG-79199
  parent_prd: PRD-AI-PROCESSING-PIPELINE
  parent_confluence: "https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097"
  aha_features:
    - INT-185  # Zoom OAuth + Cloud Recording API
    - INT-181  # Microsoft Teams OAuth + Graph API
  related_prds:
    - PRD-MEETINGS-AI-SURFACES
    - PRD-TRANSCRIPT-INGESTION
a2a:
  agent_card: ./agent-card.json
pulled_at: 2026-05-13T00:00:00Z
sources:
  - type: prd
    ref: PRD-AI-PROCESSING-PIPELINE §1c, CAP-012, revoke matrix
---

# Cross-Platform Connect Layer

> Sibling to PRD-AI-PROCESSING-PIPELINE. Defines the user-driven auth + consent model for connecting external
> sources (Zoom in MVP; Teams/Slack/Jira/HubSpot/Salesforce in future). The platform PRD owns the data model;
> this PRD owns the user-facing connect flow, the central Connections page, per-module touchpoints, revoke
> semantics, and the retention/redaction policy.

## 1. Overview

The AI pipeline can only ingest from sources the user has explicitly connected. The Connect Layer is the surface where that happens — a central Connections page in user settings plus contextual nudges in the modules that benefit from each source. Connect is **per user, per app, one time** with explicit OAuth scopes. Disconnecting halts ingestion but preserves existing evidence under retention policy. Hard deletion requires an explicit user (or admin) request.

This is the gate that turns the AI pipeline from a feature into a habit: connect once, intelligence compounds over time.

## 1a. Architecture & Data Model

### Connection state machine

```
                connect (OAuth flow + scope grant)
   not_connected ────────────────────────────────► connected
                                                       │
                  token refresh failure                │
                          ◄────────────────────────────┤
       expired                                         │
          │  reconnect                                 │
          └────────────────────────────────►          │
                                                       │
                  user disconnects                     │
                          ◄────────────────────────────┤
       revoked (locked, retention clock starts)        │
          │  reconnect                                 │
          └────────────────────────────────►          │
                                                       │
                  hard-delete request                  │
                          ◄────────────────────────────┘
       deleted (retention grace → cascade purge)
```

### Connection record schema

```
connection(
  id              uuid pk,
  user_id         fk users,
  source_system   enum (zoom|teams|slack|jira|hubspot|salesforce),
  state           enum (not_connected|connected|expired|revoked|deleted),
  oauth_token     encrypted,
  oauth_refresh   encrypted,
  scopes_granted  text[],
  connected_at    timestamptz,
  state_changed_at timestamptz,
  retention_clock_start timestamptz nullable,  -- set on revoke; controls cascade
  hard_delete_requested_at timestamptz nullable
)
```

Joins one-to-many with `evidence.source_system` (platform PRD §1a). State transitions propagate to platform evidence rows (e.g. `revoked` flips evidence to `locked=true`).

### Revoke matrix (canonical, inherited from platform CAP-012)

| Action | Ingestion | Evidence | Suggestions | UX copy |
|---|---|---|---|---|
| User disconnects | Halts immediately | Soft-lock (`locked=true`); kept visible | Pending remain reviewable until stale | "Disconnected. Your existing evidence stays visible. We won't ingest new data." |
| Token expires | Halts | Untouched, fully visible | Untouched | "Connection expired. Reconnect to keep evidence flowing." |
| User reconnects | Resumes from "now" | Locked rows unlocked; new rows append | Unchanged | "Reconnected. [Back-fill last 30 days?]" |
| User requests data deletion | Halts + initiates delete | Hard-delete after 30-day grace; cascade | Derived suggestions dismissed | "Your data from <source> will be deleted within 30 days. Confirmed suggestions on your record are kept." |
| Admin disables org-wide | Halts for all | Bulk soft-lock | Pending remain reviewable | Admin notice + per-user banner |
| Tenant offboarding | Halts everything | Hard-delete per MSA (30/60/90d) | Cascade delete | Admin-driven; out of scope |

### Retention policy defaults (tunable per tenant)

- Pending evidence not yet acted on: **90 days** → auto-archive
- Locked evidence (post-disconnect): **180 days** retained for explainability, then hard-delete
- Dismissed evidence: **90 days** for undo, then hard-delete

**Decision rule: Disconnect locks, doesn't delete. Delete requires explicit user/admin action. Retention reaps over time. Audit/explainability beats aggressive deletion except on explicit erasure request.**

## 1b. UX Framing

### Touchpoints

| Touchpoint | Purpose | When shown |
|---|---|---|
| **Central Connections page** (user settings) | One-stop view: status per app, connect, reconnect, revoke | Always available |
| **Per-module inline prompt** | "Connect Zoom to surface action items from your 1:1s" (Meetings); equivalents on Goals/Feedback/Skills as sources emerge | Only when source is not yet connected and module would benefit |
| **First-run onboarding** (optional) | Guided connect for highest-leverage source(s) | New users only |
| **Reconnect banner** | Surfaced on relevant module pages when state = `expired` | Until reconnected or dismissed |

### Consent model

- **Granular per app** — connecting Zoom does not implicitly connect Teams.
- **Always revocable** — user can disconnect at any time.
- **Per-source meeting exclusion (CAP-008 from platform)** layered on top of connect — user can connect Zoom AND exclude specific meetings.
- **Per-signal-type connect granularity** is **Phase 2 stretch** — MVP is all-or-nothing per source.

### Anti-patterns rejected

- **Admin-pushed connect** — connect is user-driven; admins enable the integration but cannot connect on a user's behalf.
- **Modal connect demand** — never block the user with a modal; CTAs are inline, dismissable.
- **Hidden disconnect** — revoke must be one click from the Connections page.

## 6. Key Metrics

> **Funnel + integration-health metrics.** These prove users *can* and *do* turn the feature on. All `[proposed, awaiting analytics verification]`. Platform-pipeline metrics in `PRD-AI-PROCESSING-PIPELINE` §6; surface engagement in `PRD-MEETINGS-AI-SURFACES` §6.

### Connect funnel

| Stage | Metric | Benchmark | Event |
|---|---|---|---|
| 1 | CTA click rate (per visit) | volume metric | `connect.cta_clicked` |
| 2 | OAuth consent granted / CTA clicked | 70% | `oauth.consent_granted` |
| 3 | Callback success / consent granted | 85% | `oauth.callback_success` |
| 4 | First ingestion / callback success | 90% | `ingestion.first_success` |
| 5 | First AI confirm / first ingestion | 75% | `ai.first_confirm` |
| **End-to-end** | **CTA → first AI confirm** ⭐ NORTH STAR | 30–35% (Slack/B2B SaaS benchmark) | composite |

### Health

| Metric | Definition | Benchmark | Event |
|---|---|---|---|
| Time-to-First-Value (TTFV) | Connect success → first AI suggestion shown | <10 min for async sources | timestamp delta |
| Token refresh success rate | Successful refresh / attempts | >99% (HubSpot benchmark); <97% = scope drift | `oauth.token.refresh.result` |
| Ingestion error rate by cause | Bucketed: auth / rate-limit / schema / empty | <1% auth, <3% total | `ingestion.failed` w/ `error_class` |

### Trust / retention

| Metric | Definition | Benchmark | Event |
|---|---|---|---|
| 30-day disconnect/revoke rate | % connected users who revoke within 30 days | <5% healthy; >15% = trust/value problem | `connect.revoked` w/ `source: user\|provider\|admin` |
| 60-day reconnect rate | % revoked users who reconnect | 20–30% recoverable; near 0 = permanent churn | `connect.reconnected` |
| Connected-but-silent rate (7d) | % connected accounts with 0 ingestions in 7 days | <10%; diagnoses scope misconfigs / dormant users | composite |

### Open metric gaps

| Gap | Owner | Trigger |
|---|---|---|
| Zoom OAuth funnel baselines (industry benchmarks are Slack-app derived) | Analytics owner + Integrations PM | After 30 days of real Zoom OAuth traffic |
| Per-source trust score impact on engagement (Phase 2) | PM owner + Analytics | When second adapter ships |

## 7. Capabilities

### Integration Layer Capability Spec (for Integrations pod — Thursday 2026-05-15 deliverable)

> Capability breakdown to align Integrations pod sprint planning. Required from Integrations pod for Zoom adapter delivery (per D-013 / CD-006 / CD-007 / CD-008).

| Layer | Capability | Owner | MVP / Stretch |
|---|---|---|---|
| **Admin auth** | Org-level OAuth app registration (Zoom Marketplace app, scopes pre-approved) | Integrations | MVP |
| **Admin auth** | Admin console toggle: enable/disable Zoom integration org-wide (CONN-CAP-006) | Integrations + Admin pod | MVP |
| **User auth** | Per-user OAuth consent flow triggered from Meetings page modal (CONN-CAP-001a + CONN-CAP-003) | Integrations + Meetings pod | MVP |
| **User auth** | Token storage encrypted at rest; refresh handled transparently | Integrations | MVP |
| **User auth** | Revoke flow propagating to evidence `locked=true` (CONN-CAP-004) | Integrations + AI Platform | MVP |
| **Transcript fetch** | Webhook-triggered fetch from Zoom Cloud Recording API on `recording.transcript_completed` | Integrations | MVP |
| **Transcript fetch** | Speaker-to-Betterworks-user-ID resolution from Zoom participant metadata | Integrations | MVP |
| **Transcript fetch** | Backfill last 30 days on reconnect (opt-in) | Integrations | MVP |
| **Customer docs** | Zoom Marketplace app listing copy + admin enablement guide | Integrations + GTM | MVP |
| **Customer docs** | Per-user "Connect Zoom" flow guide (modal screenshots) | Design Lead + Integrations | MVP |
| **Customer setup** | Zoom plan requirements (Pro/Business/Enterprise + Cloud Recording + Audio Transcription enabled) — pre-flight check + clear error states | Integrations | MVP |
| **Customer setup** | Eligible-meeting filter (1:1s only; group meetings out of scope for MVP) | Integrations | MVP |
| **Teams parity** | Teams OAuth + Microsoft Graph transcript retrieval (mirror of Zoom path) | Integrations | MVP Stretch |
| **Observability** | Connect funnel metrics instrumented from day one (CTA → consent → callback → first ingestion → first AI confirm) | Integrations + Analytics | MVP |
| **Observability** | Token-refresh-success-rate dashboard (target ≥99%) | Integrations + Platform | MVP |

**Ownership fallback (per D-013)**: If Integrations pod cannot deliver the MVP rows above in the Summer window, the AI Platform Lead absorbs the work. Decision deadline: Week 2 of the Summer window.



- **CONN-CAP-001 — Central Connections page — V2/STRETCH** *(deferred per 2026-05-13 exec decision, CD-007)* — User-settings page listing all available integrations with current state. Connect, reconnect, revoke per app. Shows last-connected timestamp + scopes granted. **Replaced in MVP by CONN-CAP-001a (modal).**
- **CONN-CAP-001a — Zoom connect modal (MVP)** *(NEW v0.3.0, per CD-007)* — Lightweight modal triggered from the Meetings page (and from CONN-CAP-002 banner) when a user clicks "Connect Zoom". Handles OAuth consent flow, scope display, and connection-state confirmation. No separate Settings page in MVP. Once connected, the modal closes; subsequent revoke/reconnect flows route through the same modal via banner trigger. Owns: connect, scope grant, OAuth completion. Does NOT own: list of all integrations (that's the V2 Connections page).
- **CONN-CAP-002 — Per-module inline connect prompts** — Banner-style prompts in **Meetings module only** (Phase 1); Goals/Feedback/Skills (Phase 2) when relevant source is not connected. Dismissable. Re-surfaces on per-card empty states. Triggers CONN-CAP-001a modal on click.
- **CONN-CAP-003 — OAuth flow per source** — **Zoom OAuth is MVP (per 2026-05-13 exec decision: Zoom API ingestion = MVP if doable)**; Teams OAuth is good-to-have stretch (CD-006). Each source has its own scope list. Token storage encrypted; refresh handled transparently. Aha: `INT-185` (Zoom), `INT-181` (Teams).
- **CONN-CAP-004 — Revoke + retention lifecycle** — Soft-lock on disconnect; retention clock; cascade on hard-delete request. Implements the revoke matrix (§1a).
- **CONN-CAP-005 — Reconnect with optional back-fill** — Default: resume from "now". Opt-in: back-fill last 30 days.
- **CONN-CAP-006 — Admin org-wide enable + disable** *(scope expanded 2026-05-13 per CD-008)* — **Admin enablement is a precondition for user-level OAuth connect** (not just a kill-switch). The integration must be enabled at the org level by an admin before any user in that org can OAuth-connect. Admin can also disable (bulk soft-lock). Admin still CANNOT connect on a user's behalf. Surfaces: admin console toggle per integration; user-facing banner copy adapts ("Your admin needs to enable Zoom integration first" → "Connect Zoom").

## 7a. Story decomposition (MVP)

| # | Story | CONN-CAPs | Owner | Sequencing |
|---|---|---|---|---|
| C-01 | Connection state machine + schema (Aurora) | foundation | Connections pod | **Week 1–2 (blocking)** |
| C-02 | Zoom OAuth flow end-to-end (connect, refresh, scope validation) | CONN-CAP-003 | Connections pod | Week 2–4 |
| C-03a | Zoom connect modal triggered from Meetings page (MVP) | CONN-CAP-001a | Connections pod + Meetings pod + Design Lead | Week 3–5 |
| ~~C-03~~ **V2** | Central Connections page (full settings surface) — **deferred to V2** per CD-007 | CONN-CAP-001 | Connections pod + Design Lead | V2 |
| C-04 | Per-module Meetings banner + empty-state | CONN-CAP-002 | Connections pod + Meetings pod | Week 4–6 |
| C-05 | Revoke + retention lifecycle (soft-lock, clock, cascade) | CONN-CAP-004 | Connections pod + AI Platform | Week 4–6 |
| C-06 | Reconnect with opt-in back-fill | CONN-CAP-005 | Connections pod | Week 6–7 |
| C-07 (stretch) | Admin org-wide enable/disable | CONN-CAP-006 | Connections pod + Admin pod | Week 7–9 |

**Critical path: C-01 → C-02 → C-03 → C-04.** Without C-04, the Meetings AI surfaces have no path to value.

## 10. Assumptions, Dependencies & Risks

### Assumptions
- Zoom OAuth app provisioned and scopes pre-approved by Zoom; no marketplace review delays.
- Encrypted token storage available in existing Betterworks platform infrastructure.
- Customers willing to accept user-driven connect with explicit OAuth scopes; no contractual blockers.

### Dependencies
- **Security review** of OAuth scope list + token storage — owned by Security pod; blocks production launch.
- **Legal/Privacy review** of consent copy + revoke matrix — owned by Legal; blocks production launch.
- **AI Pipeline platform PRD** — evidence schema must support `locked=true` state and cascade-on-delete semantics.
- **Meetings module** — CONN-CAP-002 banner placement requires Meetings pod cooperation.

### Risks
- **OAuth scope creep** during Zoom review → expanded scopes feel invasive · Med · Mitigation: scope to minimum (recording read only); document each scope's purpose.
- **Token refresh failures cause silent ingestion stops** · Med · Mitigation: state machine surfaces `expired` as visible banner; user-facing copy explicit.
- **GDPR/DSAR ambiguity on "locked" evidence** · Med · Mitigation: Legal sign-off on retention defaults pre-launch; admin tooling to query locked evidence for DSAR responses.
- **Banner blindness** — users dismiss without connecting · Med · Mitigation: per-card empty-state CTAs (designed with Design Lead) re-surface at value moments.

### 10a. Constraints & Invariants

**MUST**
- THE SYSTEM SHALL require explicit user-driven OAuth consent before any ingestion from a source.
- THE SYSTEM SHALL store OAuth tokens encrypted at rest.
- THE SYSTEM SHALL support revoke at any time from the Connections page.
- DISCONNECT SHALL soft-lock evidence (set `locked=true`); SHALL NOT hard-delete.
- HARD-DELETE SHALL require an explicit user (or admin) request and SHALL respect the 30-day grace period.
- THE SYSTEM SHALL log every state transition (connect, disconnect, reconnect, delete) with timestamp + actor.

**MUST NOT**
- ADMINS SHALL NOT be able to connect a source on a user's behalf.
- THE CONNECT FLOW SHALL NOT be modal or otherwise block the user from continuing other work.
- DISCONNECT SHALL NOT delete evidence as a side effect.

**SHOULD**
- The Connections page SHOULD show last-connected timestamp + granted scopes for transparency.
- Reconnect SHOULD default to "resume from now" with opt-in back-fill, not auto-back-fill.

### 10b. Pre-mortem

*It's September 2026. Connect Layer shipped but failed adoption. Most plausible failure: connect rate ceilinged at ~30% because the central Connections page was buried in user settings and per-module banners were dismissed once and forgotten. Users never connected → AI pipeline ran on empty input → feature appeared broken. Mitigation: pair every untranscribed meeting card with an inline empty-state CTA; track connect-from-Meetings as a primary funnel metric; first-run onboarding for new users post-feature-enablement.*

## 11. Out of Scope / Known Limitations

### Non-Goals (Phase 1)
- **Per-signal-type connect granularity** — Phase 2 stretch.
- **Slack / Jira / HubSpot / Salesforce adapters** — MVP is Zoom (with Teams as good-to-have stretch); the rest are Phase 2.
- **Admin-driven SSO-style bulk connect** — explicit non-goal; user-driven only.

### MVP Stretch (per 2026-05-13 exec decision)
- **Microsoft Teams OAuth** (INT-181) — good-to-have if Zoom path lands early enough to free Integrations capacity. Aligned with parent Confluence PRFAQ which lists Teams as Path A.

### Future Roadmap
- **Central Connections page (CONN-CAP-001)** — full settings surface listing all integrations. V2/stretch. MVP uses the modal triggered from Meetings page (CONN-CAP-001a) instead.
- Slack, Jira, HubSpot, Salesforce adapters (one PRD per family or grouped)
- Per-signal-type granular consent
- Audit log surface for admins (DSAR support)
- Bulk-revoke from admin console

## 12. Documentation & Resources

- `type: confluence` — **Parent PRD: [Zoom & Teams Transcripts Feature Documentation](https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097)** (strategic / GTM PRFAQ)
- `type: prd` — PRD-AI-PROCESSING-PIPELINE (platform contracts)
- `type: prd` — PRD-MEETINGS-AI-SURFACES (consumer of CONN-CAP-002)
- `type: jira` — ENG-79199 (Epic)
- `type: aha` — `INT-185` — Zoom OAuth + Cloud Recording API
- `type: aha` — `INT-181` — Microsoft Teams OAuth + Graph API (stretch)
- `type: zoom-developer` — Zoom OAuth scope documentation
- `type: figma` — `[TBD — Design Lead: Connections page + per-module banner specs]`
- `type: security-doc` — `[TBD — Security pod scope review]`
- `type: legal-doc` — `[TBD — Privacy/Legal consent copy review]`

## §13a Product Acceptance Criteria

- [ ] **CPAC-01** — Zoom OAuth flow end-to-end works in Rainforest (connect, token refresh, scope validation)
- [ ] **CPAC-02** — Zoom connect modal (CONN-CAP-001a) renders from Meetings page; connect / revoke actions work via modal. (Central Connections page deferred to V2 per CD-007.)
- [ ] **CPAC-03** — Per-module Meetings banner appears when `state ≠ connected` and source would benefit; dismissable. Banner triggers CONN-CAP-001a modal on click. Adapts copy when admin has not yet enabled the integration (per CD-008).
- [ ] **CPAC-04** — Revoke flow soft-locks evidence per the §1a revoke matrix; no hard-delete on disconnect
- [ ] **CPAC-05** — Reconnect defaults to "resume from now"; opt-in back-fill works
- [ ] **CPAC-06** — All state transitions logged with timestamp + actor
- [ ] **CPAC-07** — Security review sign-off on OAuth scopes + token storage
- [ ] **CPAC-08** — Legal/Privacy review sign-off on consent copy + revoke matrix
- [ ] **CPAC-09** — Retention policy enforced per defaults (90d pending, 180d locked, 90d dismissed); tunable per tenant
- [ ] **CPAC-10** — Connect-from-Meetings funnel metric instrumented from day one

### Quality bars

| Dimension | Bar |
|---|---|
| Zoom OAuth flow success rate | ≥ 95% |
| Token refresh success rate | ≥ 99% |
| Connect-rate ceiling (% of active users) | ≥ 50% within 30 days post-launch (target — instrumented) |
| Time from disconnect → ingestion halt | < 60 seconds |
| State transition log completeness | 100% |

## §14 Decisions Log

| ID | Date | Decision | Decider (role / initials) | Rationale | Source |
|---|---|---|---|---|---|
| CD-001 | 2026-05-13 | Split Connect Layer into sibling PRD (this doc) | PM Owner (LM) | Distinct pod, distinct security/legal review path, ≥4 capabilities, independent DoD; split rule satisfied 5/6 | Parent PRD D-011 |
| CD-002 | 2026-05-13 | Disconnect locks evidence; does not delete | PM Owner (LM) | Audit + explainability beat aggressive deletion; matches Gong / Microsoft Graph practice | Industry research 2026-05-13 |
| CD-003 | 2026-05-13 | Connect is user-driven; admins cannot connect on user's behalf | PM Owner (LM) | Per-user OAuth scopes; matches security best practice; reduces blanket-consent risk | This PRD §10a |
| CD-004 | 2026-05-13 | Reconnect resumes from "now" by default; back-fill is opt-in | PM Owner (LM) | Avoids surprise reprocessing; user controls the historical scope | This PRD §1a |
| CD-005 | 2026-05-13 | Zoom OAuth only in MVP; adapter contract from platform CAP-011 supports future sources | PM Owner (LM) + Integrations PM (R) | Decouple from Phase 2 ingestion decision (vendor vs. native Zoom auto) | Parent PRD §11 |
| CD-006 | 2026-05-13 | Teams OAuth upgraded from "deferred past Summer 2026" → **good-to-have stretch in MVP** | Exec Sponsor (NL) | Aligns Connect Layer with parent Confluence PRFAQ which lists Teams as Path A; in scope only if Zoom lands early enough to free Integrations capacity | Exec alignment 2026-05-13; parent Confluence (pageId 4247257097) |
| CD-007 | 2026-05-13 (PM) | **MVP ships Zoom connect modal (CONN-CAP-001a) triggered from Meetings page; full central Connections page (CONN-CAP-001) deferred to V2** | Exec Sponsor (NL) | Reduces MVP scope; users connect at the moment of value (Meetings page) rather than navigating to a separate settings surface. Full Connections page becomes useful when there are multiple sources to manage (Slack/Jira/etc.) — not yet relevant in MVP. | Product Acceptance call 2026-05-13 PM |
| CD-008 | 2026-05-13 (PM) | **Admin org-level enablement is a precondition** for user-level OAuth connect (CONN-CAP-006 scope expanded) | Exec Sponsor (NL) | Enterprise sales requirement; matches Lattice/Workday tenant-scoped integration patterns; reduces blanket-consent risk; admin can gate adoption pace | Product Acceptance call 2026-05-13 PM |

### Pending decisions

| ID | Question | Decision owner | Deadline |
|---|---|---|---|
| COPEN-D1 | Default OAuth scope list for Zoom (recording-read vs. broader) | PM Owner + Security pod | Before C-02 |
| COPEN-D2 | Connections page IA: own page or sub-tab of existing Settings | Design Lead + Meetings PM | Before C-03 |
| COPEN-D3 | First-run onboarding: guided connect or post-login banner | Design Lead + Meetings PM | Before launch |
| COPEN-D4 | Retention policy defaults: 90/180/90d — Platform pod sign-off | PM Owner + Platform pod lead | Before Rainforest deploy |
