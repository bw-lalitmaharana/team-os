---
name: prd-agentic
description: >
  Draft a Betterworks PRD as a Markdown source-of-truth file that is friendly to both developers and AI agents
  (A2A-discoverable). Wraps the canonical `pmd-template` skill — preserves the Betterworks 12-section, two-phase
  structure verbatim — and layers an "agentic" envelope on top: YAML frontmatter, stable IDs (CAP/US/AC), EARS-form
  acceptance criteria, a Constraints & Invariants block, a Pre-mortem, a Definition of Done, and a sibling
  `agent-card.json` for A2A. Trigger when the user asks to write, draft, generate, or scaffold a PRD / product
  requirements doc / feature spec inside the team-os repo. Also trigger on "agentic PRD", "PRD for ENG-XXXXX",
  "spec for <feature>", or when the user says "write PRD".
---

# PRD Agentic Skill

Produces a Markdown PRD that is the **source of truth** (committed to git, fed to coding agents, A2A-addressable),
plus on demand an HTML render for Confluence paste (via the existing `pmd-template` skill).

> **Does not modify** the `pmd-template` skill. This skill *wraps* it. Section numbering, two-phase split, GTM
> structure, MoSCoW, audience-segmented benefits — all preserved.

---

## What this skill adds on top of `pmd-template`

1. **YAML frontmatter** — stable PRD id, status, owners, Jira epic, Aha! initiative, Figma, related PRDs.
2. **Stable IDs** — `CAP-XXX` for capabilities, `US-XXX` for user stories, `AC-XXX-Y` for acceptance criteria.
   These are A2A-addressable anchors.
3. **EARS-form acceptance criteria** preferred (`WHEN <trigger>, THE SYSTEM SHALL <behavior>`). Given/When/Then
   accepted. Plain prose ACs are flagged by the checklist.
4. **Constraints & Invariants (§10a)** — RFC-2119 MUST / MUST NOT list. Where LLMs would otherwise hallucinate.
5. **Pre-mortem (§10b)** — one paragraph imagining the failure mode (Shreyas Doshi).
6. **Definition of Done (§13)** — verifiable predicates each referencing AC IDs.
7. **Typed resources** in §12 — `type: jira | aha | figma | dashboard | prd | meeting-note | slack | zoom-transcript`.
8. **A2A agent-card** — sibling `agent-card.json` describing the PRD as an A2A skill (per a2a-protocol.org).
9. **No HOW rule** — tech stack / framework names belong in `design.md`, not the PRD. Checklist flags violations.
10. **Phase-gate enforcement** — refuses to draft §8–§12 until §1–§7 are reviewed (matches Betterworks Phase 1/2
    split and Spec-Driven Development convention).
11. **Naming discipline** (added v0.3.0 after the ai-processing-pipeline v0.5.0 sweep): names appear in metadata
    only — Owners block and Decisions Log (§14). The body uses **roles** ("PM owner", "AI Platform lead",
    "Exec sponsor"). See "Naming convention" section below for the operating rule and rationale.
12. **Decisions Log (§14)** — append-only dated record of locked decisions with named decider, rationale, and
    source link. The one place naming an individual is appropriate, because accountability is the point.

---

## Step 1: Pre-flight context gathering (automatic)

Before asking the user anything, gather what's already known:

1. **Aha! MCP** — pull the initiative + features + child requirements for the feature area. Seed §7 capabilities
   and §12 resources.
2. **Atlassian MCP** — pull the Jira epic + child stories. Seed candidate `CAP-XXX` and `AC-XXX-Y` drafts.
3. **Repo files**:
   - `product/<area>/CLAUDE.md`, `delivery-plan.md`, `open-questions.md`, `open-actions.md` → seed §2 Problem,
     §10 Risks, §11 Out of Scope
   - `ops/meeting-notes/*.md` filtered to the feature → seed §2 Problem, §4 GTM rationale, §10 Risks
   - `knowledge/<domain>/rules.md` + `knowledge.md` → seed §10 Assumptions and §10a Constraints
   - `analytics/metrics-definitions.md` → seed §6 Metrics (CLAUDE.md house rule: never hallucinate metrics)
   - `decisions/*.md` matching the feature → seed §10a Constraints (locked decisions become invariants)
4. **Slack pre-flight** (added v0.3.0 after the ai-processing-pipeline run missed Paul's GTM framing and Nataliya's design ask): search `#temp-*` working channels, `#pod-*` engineering channels, and design Group DMs mentioning the feature or owner. High-signal items live in Slack that never make it to meeting notes.
5. **Summarize** what's known vs. what's missing. Then ask the user **only the gaps**.

---

## Step 2: Identify the phase

Same as `pmd-template`:
- Phase 1 only (pre-dev, §1–7)
- Phase 2 only (requirements, §8–12)
- Both

Default: if feature is pre-development, draft Phase 1 only. **Phase 2 is phase-gated** behind human review of
Phase 1.

---

## Step 3: Draft from `template.md`

Use the local `template.md` in this skill folder. It is the Markdown analogue of `pmd-template`'s HTML body, with
the agentic additions woven in at the right section numbers (10a, 10b, 13).

**Writing voice** (inherited from `pmd-template`):
- Phase 1: compelling, strategic, for sales reps and leadership
- Phase 2: precise, execution-ready, for engineering and design

**ID assignment**:
- Walk §7 capabilities top-down → assign `CAP-001`, `CAP-002`, …
- For each capability, list user stories `US-001` (scoped to its capability)
- Under each US, list acceptance criteria `AC-001-1`, `AC-001-2`, …
- IDs are stable across revisions. Never renumber. To deprecate, mark `status: deprecated` in frontmatter
  per-section block.

**EARS templates**:
- Ubiquitous: `THE SYSTEM SHALL <behavior>`
- Event-driven: `WHEN <trigger>, THE SYSTEM SHALL <behavior>`
- State-driven: `WHILE <state>, THE SYSTEM SHALL <behavior>`
- Unwanted behavior: `IF <condition> THEN THE SYSTEM SHALL <behavior>`
- Optional feature: `WHERE <feature is included>, THE SYSTEM SHALL <behavior>`

---

## Step 4: Output

Write three sibling files into `product/<area>/prds/<slug>/`:

1. `<slug>.prd.md` — source of truth (commit this)
2. `agent-card.json` — A2A discovery document (commit this)
3. `<slug>.prd.html` — generated on demand by Step 5 (gitignored or committed, user's choice)

`<slug>` is kebab-case of the feature name (e.g. `transcripts-ai-pipeline`).

---

## Step 5: HTML render (optional, on demand)

Only when user asks for Confluence paste. Invoke `pmd-template` skill passing the populated section content from
the `.prd.md`. The pmd-template skill produces the styled HTML using its own CSS. **Do not duplicate the HTML
template here** — that file remains owned by `pmd-template`.

If `pmd-template`'s output path (`/mnt/user-data/outputs/`) is not writable in this environment, redirect output
to `product/<area>/prds/<slug>/<slug>.prd.html`.

---

## Step 6: Quality checklist

Run `checklist.md` before declaring done. Surface the **3 weakest sections** to the user — never ship silently.

---

## Step 7: Knowledge loop (team-os convention)

After PRD ships:
- New rules surfaced (e.g. "all transcript features MUST honor user-level opt-out") → append to
  `knowledge/<domain>/rules.md`
- Locked decisions (Constraints block) → log to `decisions/YYYY-MM-DD-<slug>.md`
- Update `knowledge/INDEX.md` if a new domain was created

---

## A2A agent-card structure

The sibling `agent-card.json` follows the A2A protocol skill-card shape (a2a-protocol.org):

```json
{
  "name": "prd-<slug>",
  "description": "<feature one-liner>",
  "url": "<repo-url-or-confluence-url>/<slug>.prd.md",
  "version": "<semver>",
  "capabilities": {
    "streaming": false,
    "pushNotifications": false,
    "stateTransitionHistory": false
  },
  "skills": [
    {
      "id": "get-capability",
      "description": "Return a capability section by CAP-ID",
      "inputSchema": { "type": "object", "properties": { "cap_id": { "type": "string" } }, "required": ["cap_id"] }
    },
    {
      "id": "get-acceptance-criteria",
      "description": "Return all AC-IDs for a capability, optionally filtered by MoSCoW class",
      "inputSchema": { "type": "object", "properties": { "cap_id": { "type": "string" }, "moscow": { "type": "string", "enum": ["must","should","could","wont"] } } }
    },
    {
      "id": "get-definition-of-done",
      "description": "Return the checklist of verifiable predicates"
    }
  ],
  "sections": [
    { "anchor": "#cap-001", "type": "capability", "id": "CAP-001" }
  ]
}
```

Static v1: this file is hand-emitted at draft time. No live endpoint. Peer agents fetch the JSON + the MD via git
or Confluence URL and resolve anchors deterministically.

---

## Naming convention (durable docs vs. working notes)

Industry practice (Atlassian Confluence templates, Google design-doc culture, Marty Cagan/SVPG, AWS PR/FAQ,
Lenny's PRD round-ups) converges on:

> **Names belong in metadata. Roles belong in the body.**

### Operating rule

A specific person's name appears in this PRD **at most twice**:

1. Once in the **Owners block** (frontmatter `owners:` table, keyed by role).
2. Once in the **Decisions Log (§14)** if they were the decider on a logged decision.

Everywhere else in the body, use the role: "PM owner", "AI Platform lead", "Exec sponsor", "Cross-pod PM
(Meetings/Goals)", "Design lead", etc. Names resolve to the Owners block.

### Why

- **Staffing drift** — PRDs live 12–36 months. Inline "Jason is X" is wrong by Q3 and no one updates it.
- **Attribution drift** — "Paul said X" loses context; six months later it reads as a mandate when it was a
  hallway comment.
- **Political surface** — naming people on decisions creates blame/credit conflicts at review time.
- **GDPR / DSAR exposure** — employee names are personal data. PRDs are corporate docs; if someone files a
  DSAR or leaves under contested terms, every page mentioning them is in scope.
- **LLM-indexed Confluence** — these names now leak into every internal AI assistant's retrieval. Different
  artifact than a Slack thread.

### Where naming IS appropriate

- **Owners block** (metadata layer)
- **Decisions Log §14** (accountability layer; named decider with initials + date + source link)
- **§12 Resources source captions** (e.g. `type: zoom-transcript — 2026-05-08 Lalit + Gauri meeting`) —
  these are citation metadata, not attribution
- **Slack permalinks / Zoom UUIDs / Jira issue keys** — the link itself resolves to a named human; that's
  authentic and load-bearing

### Where naming is NOT appropriate (sweep these before publish)

- Body prose ("Lalit drives", "Nellie said", "Varnika owns") → use the role
- Risk/dependency tables crediting individuals → role + "see Owners block"
- Pre-mortem narrative → role
- GTM message attribution → adopt as team position, log origin in §14

### Decisions Log template

```markdown
## §14 Decisions Log

| ID | Date | Decision | Decider (role / initials) | Rationale | Source |
|---|---|---|---|---|---|
| D-001 | YYYY-MM-DD | <one-line decision> | <role> (XX) | <one-line why> | <link> |

### Pending decisions (open, owners assigned)
| ID | Question | Decision owner | Deadline |
```

Append-only; supersession noted explicitly ("supersedes D-NNN"). Use initials, not full names, in the
Decider column — the Owners block resolves them.

### Skill workflow: name → role sweep

When drafting (Step 3) or revising:
1. Write naturally first. Names will appear in the draft — that's fine.
2. **Before declaring done (Step 6 checklist)**: grep the body for the first names of every person in the
   Owners block. Every hit must be either (a) in Owners, (b) in §14 Decisions Log, or (c) inside a `type:`
   citation in §12. Else replace with the role.
3. Capture every load-bearing attributed decision as a §14 entry while sweeping — don't lose the context,
   just relocate it.

## Tips (inherited + new)

- **Phase 1 is strategy, Phase 2 is execution** (from pmd-template).
- **Problem before solution** — section 2 must land before §3 onward is credible.
- **No tech stack** — if you find yourself naming a library, push it to a sibling `design.md`.
- **EARS is for ambiguity, not bureaucracy** — if an AC is obvious in plain English, EARS-ify it only if an LLM
  could plausibly misread it.
- **Pre-mortem honestly** — leadership respects honest scoping (pmd-template tip, reinforced).
- **Flag the weakest sections** — never ship silently.
