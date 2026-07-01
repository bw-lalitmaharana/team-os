---
id: ADR-D-010
status: accepted
date: 2026-05-13
deciders: PM Owner (LM)
related_prd: PRD-AI-PROCESSING-PIPELINE (applies to all trio PRDs)
---

# ADR-D-010 — Names in PRD body replaced with roles; Decisions Log is the accountability layer

## Context
PRDs are durable artifacts (12–36 month lifespan). Inline naming of individuals ("Jason is the eng lead", "Nellie said X") creates four problems: (1) staffing drift — wrong by Q3 and rarely updated; (2) attribution drift — hallway comments read as mandates six months later; (3) political surface — naming on decisions creates blame/credit conflicts; (4) GDPR/DSAR exposure — employee names in corporate docs are personal data. Industry practice (Atlassian Confluence templates, Google design-doc culture, Marty Cagan/SVPG, AWS PR/FAQ) converges on: **names in metadata, roles in body**.

## Decision
A specific person's name appears in a PRD at most **twice**: (1) in the Owners block (frontmatter, keyed by role); (2) in the Decisions Log (§14, now extracted to `/decisions/ADR-*`) if they were the decider on a logged decision. Everywhere else in the body, use the role: "PM owner", "AI Platform lead", "Exec sponsor", etc. Citation metadata (Slack permalinks, Zoom UUIDs, Jira issue keys) is exempt — those links resolve to people authentically.

## Consequences
- Body sweep at every PRD revision: grep for first names in Owners block; replace with roles unless in Owners or Decisions Log.
- ADR decider field uses initials (resolve via Owners block).
- Staffing changes update Owners block only — body stays current.
- Reduces blame/credit politics in PRD review.
- Pairs with later ADR-D-020 (story-driven spine restructure) which moves decisions to `/decisions/` entirely.

## Source
- Industry practice (Atlassian / SVPG / Google design-doc / AWS PR/FAQ / Lenny's PRD round-ups) 2026-05-13
- PRD-AI-PROCESSING-PIPELINE v0.3.0 introduced; all trio PRDs apply
