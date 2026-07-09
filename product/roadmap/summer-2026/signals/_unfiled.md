# Unfiled — no matching feature/keyword set

Decision-bearing signal that doesn't map to an existing `signals/<feature>.md` file. When a matching feature file is created, migrate the entry there and note the move.

## Signals

### 2026-07-08 — Notifications/goals batching deferred to August; Varnika demo + Hung sync are the entry gates (zoom)
**Source:** Zoom — "Nellie / Lalit" 2026-07-08 (UUID 01A86199-2B52-4C03-8F03-CBAB29BE3129)
**Type:** commitment
**Owner-impact:** Lalit, Nellie, Varnika, Hung

Lalit and Nellie agreed the notifications/email-batching work (parity with Legacy goals batching) is deferred to August. Lalit committed to connecting with Varnika the week of the 20th (post India-hackathon) for a Legacy batching demo/walkthrough to scope requirements, then syncing with Hung when he returns from leave (~one week out) to plan implementation. Likely involves configuration changes and possibly new event workflows.

**Implication for ranking:** No Aha/Jira item currently tracks this — worth flagging to Nellie whether it needs one once scope is clearer post-demo, since it's a named commitment with a date (August) but no system-of-record entry yet.

### 2026-07-08 — Auth policy PRs blocked; disabling squares returns 401 for all tenant APIs, must resolve before Auth API release (zoom)
**Source:** Zoom — "OKR Team - Daily Standup" 2026-07-08 (UUID 9093DC61-F910-4628-9444-6B7F26C0E5AC)
**Type:** risk
**Owner-impact:** Victor Chen, Nellie, Jason Bilyeu, Donnie, Ryan

Three pending auth-policy PRs are blocked — disabling "squares" in sysadmin currently returns 401 for all tenant APIs, and this must be resolved before any Auth API release to other environments. Fix scoped to the skills-specific config folder only (not propagated to all tenant APIs), with the same approach to apply later to the succession module. Nellie to schedule a same-day 30-minute review with Victor, Jason, Donnie, Ryan, and JB.

**Implication for ranking:** No Aha/Jira roadmap item tracks this directly — it's an infra/auth risk sitting underneath multiple modules (skills, succession); flag to Nellie if this recurs or blocks a release again.

### 2026-07-09 — Pre-processing DAG running ~11.5 days; goal quality report has no NextGen support (zoom)
**Source:** Zoom — "AI Platform Product Acceptance" 2026-07-09 (UUID 85644A0C-818C-4E67-85E8-EF2383CC16E6)
**Type:** risk
**Owner-impact:** Tejas, Nellie, Jason Zhang, Christina/CS

The AI pre-processing DAG has been running ~11.5 days (full initial load, not delta sync), with a backlog of runs queued; Tejas proposed temporarily dropping frequency from weekly to bi-weekly until it stabilizes, pending Nellie/JZ confirmation. Separately, the existing goal quality report only supports Legacy goals, not NextGen — a gap that will surface as a customer issue once orgs (e.g. Sony) migrate to NextGen and request the report. Nellie to communicate the Legacy-only limitation to CS/Christina and design a self-service UI for the report in the admin reports section, to be built by the AI team using the WA API (Haven-admin first, Legacy support later).

**Implication for ranking:** No current Aha/Jira item tracks the goal-quality-report NextGen gap or a self-service UI — worth raising with Nellie as a potential net-new roadmap item once the ticket is created, since it's customer-facing and has already surfaced via a live customer (Sony).
