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

### 2026-07-10 — Manager Copilot capstone: engagement + Betterworks data pipeline scoped, prototype due next Thursday (zoom)
**Source:** Zoom — "Capstone Project Connect" 2026-07-10 (UUID ED663B99-252E-4FBB-9F76-0296416CFFE8)
**Type:** scope-decision
**Owner-impact:** Lalit, Sharan, Gauri Thakur, Paul Agustin, Varnika Garg

Team locked scope for a standalone "Manager Copilot" proof-of-concept (personal capstone project, not a Summer roadmap item): one manager plus several direct reports with synthetic engagement/goals/feedback/recognition data, an AI layer split into three roles (sensor / historian / writing-assistant) to generate coaching recommendations, and a homepage-card UI (Gauri). Flagged that the persona/memory layer is PII and needs GDPR-visibility for employees if it goes beyond prototype. Paul will stand up a local DB; target is a clickable prototype for next Thursday's presentation.

**Implication for ranking:** Not a roadmap item — personal/capstone exploration — but the sensor/historian/writing-assistant AI-layer pattern and the PII/GDPR flag on memory layers may be reusable if a coaching-copilot concept is later pitched into Summer/Fall planning.

### 2026-07-10 — Manager Copilot capstone: inference-layer schedule + Saturday sync to finalize flow before handoff to design/backend (zoom)
**Source:** Zoom — "Zoom Meeting" 2026-07-10 (UUID CAC219E0-BC74-4646-BE0D-F3C2554B6DDC)
**Type:** commitment
**Owner-impact:** Lalit, Sharan, Gauri Thakur, Paul Agustin

Follow-on 1:1 between Lalit and Sharan on the same Manager Copilot capstone: agreed the persona-extraction pipeline (persona sheets → synthetic check-ins/1:1 notes → evidence extraction → core-persona objects) will run on a schedule or on a data-change trigger. Lalit committed to reviewing the eval step (step 5) and bringing an integration proposal to a short Saturday sync with Sharan, after which the finalized flow hands off to Gauri (design) and Paul (backend/DB).

**Implication for ranking:** Same as above — personal/capstone scope, no roadmap item. No action needed unless the concept later gets pitched as a real feature.

### 2026-07-13 — BetterBrain demo: internal Guru replacement, feedback loop and MCP exposure raised as open questions (zoom)
**Source:** Zoom — "BetterBrain Demo" 2026-07-13 (UUID E6883F55-1A7F-4997-8768-B0641A214260)
**Type:** commitment
**Owner-impact:** Paul Agustin, Balram Agnihotri, Nitish Devadiga, Sweta Kande (engineering support ask)

Paul Agustin demoed BetterBrain, a Codex-scheduled pipeline that scrapes Aha, Confluence, and Slack (#product/#support/#engage-product) daily into versioned "product knowledge records" (JSON, with confidence scores and tracked contradictions/open questions), replacing an unconfigured Guru agent that had been giving wrong/bloated answers. Sweta asked whether a thumbs-up/down feedback loop could feed back into confidence scoring; Paul agreed it's wanted and referenced work Balram has been doing toward a native Slack agent front-end (dropping Guru as the UI). Paul is open to handing off/pairing on the repo and floated exposing BetterBrain via MCP as a future customer-facing support agent. Sweta is steering SE1/SE2 engineers toward this as an AI-impact project.

**Implication for ranking:** Not a Summer 2026 roadmap item — internal tooling — but worth watching: an MCP-exposed BetterBrain-as-support-agent would sit adjacent to the MCP-internal work in [[mcp-internal]] if it ever gets customer-facing scope.
