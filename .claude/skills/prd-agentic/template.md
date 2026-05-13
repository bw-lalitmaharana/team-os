---
id: PRD-<SLUG>
title: <Feature Name> — <Capability Name>
status: draft  # draft | in-review | approved | shipped | deprecated
phase: 1  # 1 = Why It Matters, 2 = Product Requirements, 12 = both
version: 0.1.0
owners:
  pm: lalit.maharana@betterworks.com
  eng_lead: <email>
  design: <email>
  exec_sponsor: nellie.lemonier@betterworks.com
release:
  season: <Summer|Fall|Winter|Spring> <YYYY>
  code_ready_date: <YYYY-MM-DD>
  early_access:
    - client: <name>
      commitment_date: <YYYY-MM-DD>
links:
  jira_epic: <ENG-XXXXX>
  aha_initiative: <AHA-XXX>
  aha_features: [<AHA-XXX>, <AHA-XXX>]
  figma: <url>
  confluence: <url>
  related_prds: [<PRD-SLUG>]
a2a:
  agent_card: ./agent-card.json
---

# <Feature Name>: <Capability Name>

<!-- ============================================================== -->
<!-- PHASE 1 — Why It Matters                                       -->
<!-- ============================================================== -->

## 1. Overview
*3–5 sentences. What → Who → Where in the ecosystem.*

## 2. Problem & Rationale

### Legacy Limitations
- 

### Customer Pain Points
- 

### Why Betterworks
*1–2 sentences.*

## 3. Benefits & Value

### Employees
- 

### Managers
- 

### Admins / HR / Leaders
- 

<!-- Optional: CHRO / CEO / CFO — include only if relevant -->

## 4. GTM Messaging

### Core Value Proposition
> Turn **<input>** into **<outcome>** — so **<persona>** can **<business impact>**.

### Key Messages
1. **<Theme>** — Traditional approach: <...>. We enable: <...>.
2. **<Theme>** — Traditional approach: <...>. We enable: <...>.
3. **<Theme>** — Traditional approach: <...>. We enable: <...>.

### Differentiation
Others do **<X>** → We do **<Y>** → Why it matters: **<Z>**.

## 5. Existing Alternatives & Competition

| Alternative | Who / What | Limitation |
|---|---|---|
|  |  |  |

## 6. Key Metrics & Revenue Drivers

> Verify each metric against `analytics/metrics-definitions.md`. Do not invent metrics.

### Adoption
- 

### Efficiency
- 

### Quality
- 

### Revenue / ARR
- 

## 7. Core Capabilities

> Each capability gets a stable `CAP-XXX` ID. Acceptance criteria live in §9 (Phase 2) and reference these IDs.

### UI / Front-End
- **CAP-001** — <Capability> — Aha: <AHA-XXX> · Jira: <ENG-XXXXX>
- **CAP-002** — <Capability> — Aha: <AHA-XXX> · Jira: <ENG-XXXXX>

### Back-End
- **CAP-101** — <Capability> — Aha: <AHA-XXX> · Jira: <ENG-XXXXX>

### Admin Configuration
- **CAP-201** — <Capability> — Aha: <AHA-XXX> · Jira: <ENG-XXXXX>

<!-- ============================================================== -->
<!-- PHASE 2 — Product Requirements  (gated: do not draft until §1–7 reviewed) -->
<!-- ============================================================== -->

## 8. What's Changed / What's New

### New Workflows
- 

### UI / UX Changes
- 

### Backend / Behavioral Changes
- 

## 9. How It Works

### Setup & Enablement
1. 

### User Flow
1. 

### Admin Configuration
1. 

### Permissions & Visibility
- 

### Acceptance Criteria (EARS or Given/When/Then)

> Format: `AC-<CAP>-<N>`. Prefer EARS. Given/When/Then accepted. Plain prose is flagged by the checklist.

#### CAP-001 — <Capability name>
- **AC-001-1** — WHEN <trigger>, THE SYSTEM SHALL <behavior>.
- **AC-001-2** — WHILE <state>, THE SYSTEM SHALL <behavior>.
- **AC-001-3** — IF <condition> THEN THE SYSTEM SHALL <behavior>.

#### CAP-002 — <Capability name>
- **AC-002-1** — Given <precondition>, When <action>, Then <result>.

### MoSCoW

| Capability | Class | Notes |
|---|---|---|
| **CAP-001** | **Must Have** |  |
| **CAP-002** | Should Have |  |
| **CAP-101** | Could Have |  |
| **CAP-201** | Won't Have (this release) |  |

## 10. Assumptions, Dependencies & Risks

### 10. Assumptions
- 

### 10. Dependencies
- 

### 10. Risks / Areas to Monitor
- **Risk:** <description> · **Likelihood:** Low/Med/High · **Mitigation:** <plan>

### 10a. Constraints & Invariants

> RFC-2119 binding. These are LOCKED. Anything below is a contract, not a preference. Coding agents must not
> violate. If a constraint needs to change, log a decision in `/decisions/` and update this section.

**MUST**
- 

**MUST NOT**
- 

**SHOULD**
- 

### 10b. Pre-mortem
*One paragraph: "It's <future date>. This feature has failed. The most likely reason is ..."*

## 11. Out of Scope / Known Limitations

### Non-Goals (explicit)
- 

### Future Roadmap Items
- 

### Migration Considerations
- 

## 12. Documentation & Resources

> Typed links so downstream agents can fetch deterministically.

- `type: figma` — <url>
- `type: confluence` — <url>
- `type: jira` — <url>
- `type: aha` — <url>
- `type: dashboard` — <url>
- `type: meeting-note` — `ops/meeting-notes/<file>.md`
- `type: prd` — `product/<area>/prds/<related-slug>/<related-slug>.prd.md`

## §14 Decisions Log

> Append-only. The one place naming an individual is appropriate; body uses roles, this section names the decider.
> Use initials in the Decider column; the Owners block resolves them.

| ID | Date | Decision | Decider (role / initials) | Rationale | Source |
|---|---|---|---|---|---|
| D-001 | YYYY-MM-DD | <one-line decision> | <role> (XX) | <one-line why> | <link to Slack / Zoom / meeting note> |

### Pending decisions (open, owners assigned)

| ID | Question | Decision owner (role) | Deadline |
|---|---|---|---|
| OPEN-D1 | <question> | <role> | <date> |

## 13. Definition of Done

> Verifiable predicates only. Each item must reference an AC-ID, a metric, or a checkable artifact. No prose.

- [ ] All `Must Have` AC-IDs pass automated or manual test (list: AC-001-1, AC-001-2, …)
- [ ] Figma frames implemented and reviewed (link)
- [ ] Metric `<name>` instrumented and visible in `<dashboard>`
- [ ] Aha! feature status = Released; Jira epic resolved
- [ ] PRD §10a Constraints validated in code review
- [ ] Rainforest smoke test passes for end-to-end happy path
- [ ] Stakeholders signed off: PM, Eng Lead, Design, Exec Sponsor
