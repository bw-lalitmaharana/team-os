---
date: 2026-06-03
meeting: Inbound webhook architecture proposal
type: architecture
attendees: [Nellie, Okan (Ocon), Jason Sites, Danish, Pankaj]
source: zoom
meeting_uuid: 1175D559-FF84-4613-9A3D-8E15DA07B16B
backfilled: 2026-07-07
---

# Inbound webhook architecture proposal — 2026-06-03

## Summary
The meeting focused on architecting inbound webhooks as a reusable solution for multiple integration needs, including Zoom transcript ingestion and a Tech Wolf integration for customer Synopsis. Okan presented a proposed architecture where webhooks from vendors (e.g., Zoom, Google Calendar) are received through the API gateway and published to Kafka for processing by microservices, using cloud events as the industry-standard format. Jason Sites raised concerns about becoming dependent on vendor systems rather than maintaining control through direct API endpoints, and emphasized coordination with Meher regarding the Tech Wolf project scope change. Danish shared his experience implementing webhook frameworks for LMS integrations (LinkedIn Learning, Docebo, Udemy) and offered to spike on the proposed solution. The team discussed authentication challenges across vendors and whether to build a new microservice or leverage existing open-source frameworks.

## Key decisions
- Build a reusable inbound-webhook solution rather than siloed per-integration implementations.
- Continue using the current API authentication method rather than implementing new auth mechanisms; handle vendor specifics (Basic Auth, OAuth2, custom headers with expiring tokens) as needed. Zoom supports both basic and OAuth-based auth.
- Spike to assess feasibility for the summer release, potentially serving both TechWolf and Zoom needs; evaluate building from scratch vs. mature open-source frameworks.
- New webhook service to sit between the API gateway and Kafka, handling auth and rate limiting (inbound) and concurrency/retry logic (outbound).
- Coordinate naming with the App Platform team to avoid confusion between inbound and outbound webhook engines/services.

## Action items
- [ ] Danish — Spike on building/evaluating a generic webhook integration solution, including support for different vendor auth mechanisms (Basic Auth, OAuth2); report on feasibility for the summer release and integration with Zoom and TechWolf
- [ ] Nellie — Draft a spike story (requirements + acceptance criteria) and assign it to Danish
- [ ] Nellie — Summarize meeting notes and share with all attendees
- [ ] Nellie — Review past discussions/relevant info on webhook integrations and share as needed
- [ ] Okan (Ocon) — Provide input/recommendations on open-source frameworks/tools for webhook handling to support Danish's spike
- [ ] Okan & Nellie — Follow up with Meher this week to review/align on the inbound webhook architecture, especially the change in integration approach for TechWolf
- [ ] Nellie & Okan — Coordinate with App Platform team on naming/architecture to avoid inbound/outbound webhook engine confusion

## Follow-ups / open questions
- Risk of using webhooks/cloud events as the communication standard between vendors, and dependency on vendor systems vs. exposing direct endpoints (fundamental change from the original Phase 2 plan for TechWolf).
- Whether to build a global BetterWorks solution or adopt a mature open-source product for handling incoming events.
- Authentication coverage: which vendor auth types to support (OAuth2 required by some vendors; LinkedIn Learning, Docebo differ).

## Discussion notes
- Okan's architecture: listen to events from Zoom / Google Calendar → publish to internal Kafka → microservices process. TechWolf events would come through the Talent API with Kafka integration.
- Jason Sites clarified he had not previously worked on a webhook engine (focused on the talent system for the past two years); flagged a major cross-engineering risk and stressed ensuring Meher understands it.
- Danish described the existing generic webhook framework for LMS integrations using OAuth-based auth handling vendor-specific events.
- Pankaj noted Zoom's flexibility with basic and OAuth auth; custom headers with expiring tokens need special handling.
- Nellie mentioned a spike on a new dispatcher for outbound topics and proposed the Integration team work on the API Gateway for inbound topics.

## Next steps
- Nellie to create the spike story and assign to Danish; Okan to advise on open-source options.
- Nellie + Okan to sync with Meher this week to align on the TechWolf approach change.
