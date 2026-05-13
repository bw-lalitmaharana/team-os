# Architecture — Observations

## NextGen system (from JB walkthrough, May 6)
- [2026-05-06] Routing: `/services/*` → microservices via Kong API Gateway; `/api/*` → legacy monolith
- [2026-05-06] Authentication at API Gateway (JWT); authorization (ABAC) still in monolith — complex, data-dependent
- [2026-05-06] Each microservice has its own Postgres DB; many use Redis for caching
- [2026-05-06] Event bus: DB commits trigger events, subscriber services update local tables within seconds (eventual consistency)
- [2026-05-06] Services: Talent API (calibration, meetings), Conversations, Feedback, Recognition, Integrations, Notification Engine
- [2026-05-06] Legacy UI elimination pending — Eden + Josh own login/splash rewrite; monolith deleted only after 100% NextGen customer migration
- [2026-05-06] LLM/AI service architecture diagrams held by Jay-Z (Jason Zhang) — not yet seen
- [2026-05-06] API versioning debate: V1.5 (additive, JB preference) vs V2 (full retool). Decision pending; Skills API is the forcing function
- [2026-05-06] MCP strategy: (1) public MCP for user-facing agentic workflows; (2) internal MCP auto-generated per service from OpenAPI specs (AP team ~1 day spike)
- [2026-05-06] Internal services can call each other directly without going through gateway

## Meeting Transcripts — architecture constraints (from Sriram 1:1, May 7)
- [2026-05-07] Problem 1 (data ingestion from 3rd party) is a platform-level component — must be architected right; zero compromise; will become reusable pattern
- [2026-05-07] Problem 2 (AI inference + UI) — can iterate fast; dirty code acceptable initially
- [2026-05-07] Three repos being made AI-native (operable via agents): Rekognition, Meetings, Prasanna's homepage backend
- [2026-05-07] SDLC transformation lead: Pankaj Lomo (Principal Engineer, India)
