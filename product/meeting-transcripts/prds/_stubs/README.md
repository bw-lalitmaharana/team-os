# Stub PRDs

This folder contains **placeholder PRDs** for surface areas that aren't yet promoted to full sibling PRDs. Each stub:

- Names the anticipated capability set (preview only — formalised on promotion)
- Lists the platform contracts it will consume
- Declares the promotion trigger (the 3-of-6 split rule from `PRD-AI-PROCESSING-PIPELINE §14 D-011`)

## Current stubs

| Stub | Surface area | Anticipated caps | Promotion trigger |
|---|---|---|---|
| `goals-ai-surfaces.stub.md` | Goals page AI | 2 | Goals PM independent + ≥4 caps |
| `feedback-ai-surfaces.stub.md` | Feedback page AI | 2 | Performance pod takes ownership |
| `skills-ai-surfaces.stub.md` | Skills/Talent profile AI | 2 | Talent Intelligence pod assigns PM |

## Already promoted (full sibling PRDs)

- `../meetings-ai-surfaces/` — promoted 2026-05-13 (D-011)
- `../connect-layer/` — promoted 2026-05-13 (D-011)

## When to promote a stub

The 3-of-6 rule (matches Cagan / Atlassian / Amazon Working Backwards practice):

1. Distinct primary persona from the platform PRD
2. Distinct pod / DRI
3. ≥4 user-visible capabilities
4. Independent DoD / release cadence
5. Parent doc >30KB or section >8KB
6. Cross-functional partners need to consume only that section

When ≥3 hold for a stub, scaffold a real PRD: `mkdir prds/<slug>/` then run `/write-prd <slug>` and let the prd-agentic skill seed the structure. Log the promotion in this folder's history and in the parent PRD's §14 Decisions Log.
