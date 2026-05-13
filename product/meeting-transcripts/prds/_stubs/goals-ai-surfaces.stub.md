---
id: PRD-GOALS-AI-SURFACES
status: stub
parent: PRD-AI-PROCESSING-PIPELINE
promote_when: 3 of 6 split criteria satisfied (distinct persona, distinct pod, ≥4 caps, indep. DoD, section >8KB, distinct cross-fn consumers)
owners:
  goals_pm: varnika.garg@betterworks.com  # Goals/Meetings cross-pod
  pm_owner_platform: lalit.maharana@betterworks.com
---

# PRD-GOALS-AI-SURFACES — Stub

> Placeholder. Promote to a full sibling PRD (under `prds/goals-ai-surfaces/`) when the split decision rule is satisfied. Today only ~2 capabilities anticipated; section size in platform PRD is small. Stays as stub.

## Anticipated capabilities (preview — formalise on promotion)

- **GOAL-CAP-101 — Goal-level AI suggestions on Goals page** — Goal-level suggestions ranked at the top of the user's Goals page; per-goal evidence panel; new-goal proposals from accumulated evidence.
- **GOAL-CAP-102 — Goal admin validation passthrough** — When a user accepts a goal-type suggestion, the payload passes through the org's existing Goals admin validation (scope, type, mandatory attributes) before publish. Consumes platform CAP-007.

## Platform contracts consumed (today)
- CAP-003 `signal_type = goal_progress`
- CAP-005 Reconciliation Framework (links evidence to specific Goal objects)
- CAP-007 Goals admin validation passthrough
- CAP-009 Why-this provenance panel

## When to promote
Promote this stub to a full sibling PRD when **3 or more** of:
1. ≥4 user-visible capabilities
2. Distinct DoD from platform
3. Distinct owner (separate from Meetings PM)
4. Independent release cadence
5. Section in platform PRD grows >8KB
6. Cross-functional consumers (design / GTM / support) need to consume only this section

## Pending decisions for promotion

| Question | Decision owner | Trigger |
|---|---|---|
| Goal suggestion ranking rubric (recency × confidence × type weight) | Goals PM + AI Platform Lead | When capabilities scoped |
| New-goal proposal pattern (auto-create draft vs. suggest only) | Goals PM | Before any Goals AI UX ships |
