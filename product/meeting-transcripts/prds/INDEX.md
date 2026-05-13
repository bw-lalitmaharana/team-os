# PRD trio — index

> Navigation for the AI Processing Pipeline epic (ENG-79199). Parent PRFAQ in Confluence; operational decomposition in this folder.

## Strategic source-of-truth

- **Parent Confluence PRFAQ**: [Zoom & Teams Transcripts Feature Documentation](https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4247257097) (exec / GTM / Sales)

## The trio (engineering / design / analytics)

| PRD | Role | Version | Key contracts | Confluence |
|---|---|---|---|---|
| **`ai-processing-pipeline/`** | Platform | v0.8.0 | CAP-001..CAP-011 (extraction, reconciliation, evidence schema, provenance, adapter framework) | [Confluence](https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4280614960) |
| **`meetings-ai-surfaces/`** | Consumer surface | v0.3.0 | MEET-CAP-101..205 (list page nudge + detail page) | [Confluence](https://betterworks.atlassian.net/wiki/spaces/PMD/pages/4281139203) |
| **`connect-layer/`** | Consumer surface | v0.3.0 | CONN-CAP-001..006 (Zoom OAuth, modal, revoke, retention, admin enablement) | [TBD — to be published] |

Each PRD folder contains:
- `*.prd.md` — source of truth (markdown)
- `*.prd.html` — render artifact (paste into Confluence)
- `agent-card.json` — A2A discovery (anchors, capabilities, skills)

## Stubs (promote when 3-of-6 split rule satisfied)

- `_stubs/goals-ai-surfaces.stub.md` — Goals AI surfaces (2 caps anticipated)
- `_stubs/feedback-ai-surfaces.stub.md` — Feedback AI surfaces (depends on Feedback pod alignment)
- `_stubs/skills-ai-surfaces.stub.md` — Skills AI surfaces (depends on Talent Intelligence pod)
- `_stubs/README.md` — promotion criteria

## Reading order

**For execs / GTM**: Read the parent Confluence PRFAQ. The trio is operational detail.

**For engineering**:
1. Platform `ai-processing-pipeline/` §1a Architecture & Data Model → understand the evidence model
2. Platform §7 Capabilities → what the AI layer provides
3. Pick your surface: Meetings (`meetings-ai-surfaces/`) or Connect (`connect-layer/`) — depending on which pod you're in
4. Platform §7a Stories + your surface PRD's §7a — work breakdown

**For design**:
1. Platform §1b UX Framing (Before / During / After, Review → Refine → Apply, Why-this panel) — the shared design language
2. Meetings `meetings-ai-surfaces/` §1a Surfaces (current vs. MVP) + §7 Capabilities
3. Connect `connect-layer/` §1b Touchpoints

**For analytics**:
1. Platform §6 Key Metrics — platform-scope (acceptance rate, latency, eval regression)
2. Meetings §6 — surface metrics (completion lift, carry-forward, signal-feed dismissal)
3. Connect §6 — funnel metrics (CTA → first AI confirm)
4. Cross-PRD §6a Open Metric Gaps — what needs analytics-owner sign-off

## Cross-PRD navigation

- Decisions Log (every locked decision dated + named-decider): `<each PRD>/§14`
- Open decisions tracker: `<each PRD>/§14 Pending decisions table`
- Action notes: `../../ops/action-notes/`
- Knowledge loop: `../../knowledge/<domain>/`

## Versioning convention

Bumped per substantive change. Patch bumps are silent; minor bumps land in §14.

| Version pattern | Means |
|---|---|
| v0.X.0 (platform) | Major operational restructure (split, capability add/remove, MUST changes) |
| v0.X.0 (children) | Mirrors platform v0.X or independent surface change |
| Parent Confluence | Versioned by Confluence; updated by Exec Sponsor on locked decisions |
