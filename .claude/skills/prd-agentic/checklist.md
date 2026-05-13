# PRD Agentic — Quality Checklist

Run before declaring a PRD draft complete. **Flag the 3 weakest sections** to the user — never ship silently.

## Inherited from `pmd-template`
- [ ] Header populated: Feature Name, Capability, Release, Code Ready Date
- [ ] No blank sections among the selected phase
- [ ] Phase 1: GTM messaging has Value Prop + Key Messages + Differentiation
- [ ] Phase 1: Benefits segmented (Employees, Managers, Admins minimum)
- [ ] Phase 1: Core Capabilities include Aha!/Jira refs (or explicit `[Link TBD — owner: <name>]`)
- [ ] Phase 2: MoSCoW table present
- [ ] Phase 2: Risks have mitigation or likelihood
- [ ] Phase 2: Out of Scope explicitly names what's deferred

## Agentic additions
- [ ] **Frontmatter complete** — id, status, phase, owners, release, links (Jira, Aha, Figma)
- [ ] **Stable IDs assigned** — every Capability has `CAP-XXX`; every AC has `AC-XXX-Y`
- [ ] **Every capability has ≥1 acceptance criterion** (Phase 2)
- [ ] **AC format**: EARS or Given/When/Then. Plain prose ACs FLAGGED.
- [ ] **Constraints block (§10a) populated** — at least 3 MUST or MUST NOT entries
- [ ] **Pre-mortem (§10b) written** — one paragraph, names a concrete failure mode
- [ ] **Definition of Done (§13)** — every checklist item references an AC-ID, metric, or artifact (no prose)
- [ ] **Typed resources (§12)** — every link has a `type:` prefix
- [ ] **No tech stack in body** — grep for framework / library / language names; push to `design.md` if found
- [ ] **Metrics verified** — every §6 metric exists in `analytics/metrics-definitions.md` or is marked `[unverified]`
- [ ] **agent-card.json emitted** and validates against A2A schema

## Cross-checks against repo
- [ ] Open questions for this domain reviewed (`product/<area>/open-questions.md`) — resolved ones moved to Constraints, unresolved ones flagged in Risks
- [ ] Locked decisions matching this PRD (`decisions/*.md`) reflected in §10a Constraints
- [ ] Meeting notes mentioning this feature cited under §12 (`type: meeting-note`)
- [ ] Slack channels searched (`#temp-*`, `#pod-*`, relevant Group DMs) and high-signal threads cited under §12 (`type: slack`)

## Evidence-traceability checks (added v0.3.0)
- [ ] Every capability that surfaces AI output specifies how its evidence is rendered and clicked (Why-this panel)
- [ ] Every external source mentioned has a deep-link strategy defined (or flagged as TBD per source)
- [ ] Permission-at-click-time rule covered for any external source

## Naming-discipline checks (added v0.5.0)
- [ ] Owners block is role-keyed (PM owner, Eng lead, Design lead, Exec sponsor, AI Platform lead, etc.) with one name per row
- [ ] Decisions Log (§14) exists with at least the load-bearing locked decisions captured (initials + date + source link)
- [ ] **Body sweep**: grep for every first name in the Owners block; each hit is either in (a) Owners block, (b) §14 Decisions Log, or (c) a §12 `type: ...` citation. No name appears in body prose, risk tables, pre-mortem narrative, or capability descriptions.
- [ ] Load-bearing attributions are restated as roles + linked to a §14 entry, not as "X said Y"
- [ ] GTM messaging adopted as team position, not credited to an individual in the body
- [ ] Pending decisions table maintained in §14 with decision owner (role) + deadline

## Weakest-section reporting

After running the checklist, the skill MUST output:

```
WEAKEST SECTIONS (review before sharing):
1. §X — <one-line reason>
2. §Y — <one-line reason>
3. §Z — <one-line reason>
```

Examples of weakness signals: many `[TBD]` markers, no metric verification, single-bullet sections, plain-prose
ACs that should be EARS, empty Constraints block, vague Pre-mortem ("things could go wrong").
