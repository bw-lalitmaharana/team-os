# Week of May 4 — Synthesis
Sources: Zoom summaries (AI Strategy & Roadmap, Lalit:Nellie 1:1, Architecture Walkthrough), calendar data.

---

## The one thing to know
Lalit joined Betterworks this week (New Hire Orientation: May 4 with Nova Devasia). He has been assigned PM ownership of the **AI Processing Pipeline for Meeting Transcripts** — the flagship AI feature for the summer release. This is a cross-pod feature spanning AI team, Meetings pod, and Integrations pod.

---

## May 4 — Orientation + Sprint Kick-off

- **New Hire Orientation** with Nova Devasia (onboarding).
- **AI Sprint Planning** (Nellie's org) and **App Platform Sprint Planning** (JB's org) both kicked off.
- **AI Strategy & Roadmap** (Nellie presented):
  - Strategic direction: move from HR process automation → intelligence generation / system of actions.
  - Near-term features: conversational intelligence engine, multi-taxonomy skills, MCP server beta.
  - Longer-term: goal outcome prediction, predictive disengagement analysis.
  - **Next steps:** Nellie to update Confluence roadmap pages by end of next week. Tejas to send Nellie SQL query for org settings in production.

---

## May 5 — Ownership assigned

- **Lalit / Tejas 1:1**: Tejas gave Lalit a tour of AI features (goals, feedback, conversations, 1:1s) and access to the Rainforest environment.
- **Lalit : Nellie 1:1** (KEY):
  - Lalit officially assigned PM ownership of **AI Processing Pipeline for Meeting Transcripts** (ENG-79199).
  - **Recall AI rejected**: security concerns (bot joining meetings, recording customer conversations), user friction. Not moving forward.
  - **Decision**: Direct Zoom integration instead. Teams integration feasible but not in scope for summer (Sony wants it but they go live next year).
  - CEO Doug has close relationship with Zoom CEO (from WebEx days) — potential partnership angle.
  - Company's primary pain point: new customer acquisition, not renewals. Doug positioning Betterworks as AI company for VC interest.
  - Releases: 3 cycles/year — spring, summer, winter (no fall).
  - **Lalit's first-month target**: deliver MVP testable in Rainforest.
  - **Key collaborators to connect with**: Varnica (PM, meetings/goals pod), Rinku (PM, integrations pod), Cheryl, Sriram.
  - **Open actions from Nellie**: Schedule JB architecture walkthrough (done May 6), get Lalit Claude access.

- **Lalit's action items from this meeting:**
  - [ ] Review AHA ticket + docs for AI processing pipeline — identify gaps
  - [ ] Break epic into user stories and sub-tasks for summer release
  - [ ] Get Metabase access (reach out to Jay-Z if needed; Tejas knows the tables)
  - [ ] Connect with Varnica and Rinku (key cross-pod PMs)
  - [ ] Review Recall AI POC recording (sent by Nellie to temp meeting Slack channel)
  - [ ] Deliver MVP testable in Rainforest within first month
  - [ ] Finish remaining training modules

---

## May 6 — Architecture deep-dive

- **Architecture Walkthrough** (Nellie + Jason Bilyeu + Lalit):
  - Jason (JB) walked through NextGen evolution: monolith → microservices + API Gateway (Kong).
  - Key services running: Talent API (calibration, meetings), Conversations, Feedback, Recognition, Integrations, Notification Engine. Each has its own Postgres DB.
  - **Routing**: `/services/*` → microservices via gateway; `/api/*` → legacy monolith.
  - **Auth**: API Gateway handles JWT auth; authorization (ABAC) still in monolith — complex, data-dependent.
  - **Event bus**: DB commits trigger events; subscriber services update local tables within seconds (eventual consistency).
  - **Legacy elimination**: monolith stays until 100% of customers on NextGen. Eden + Josh own the login/splash rewrite.
  - **API versioning debate**: V1.5 (additive) vs V2 (full retool). Jason prefers V1.5 for now; V2 needs customer research + unified standards. Skills API decision pending.
  - **MCP strategy**: Two tracks — (1) public MCP for user-facing agentic workflows; (2) internal MCP auto-generated per service from OpenAPI specs via GitHub Actions (AP team could spike in ~1 day).
  - **Lalit asked about LLM/AI service architecture** → Jay-Z (Jason Zhang) has those diagrams. Separate meeting needed.

- **Lalit's action items from this meeting:**
  - [ ] Talk to Jay-Z about LLM/AI service architecture diagrams
  - [ ] Follow API versioning decision for Skills (V1 extend vs V2) — impacts meeting transcript pipeline API design
  - [ ] Advocate for proper versioned public endpoints — avoid building against unstable UI endpoints

---

## Open questions as of May 7

1. Which AI team engineers are allocated to meeting transcripts feature? (Resource assignment pending)
2. Will integrations team do a Zoom integration POC? (Sriram prefers Recall AI — Nellie wants to override)
3. Architecture contracts between pods: data model, API access patterns, state machine for async processing
4. Scalable Zoom integration design: auto-connect meeting transcripts without manual linking
5. LLM/AI service architecture details (Jay-Z has diagrams)
6. Skills API V1 vs V2 decision — impacts pipeline API design
7. Retention/expiry policy for `pending` suggestions users never review

---

## People unlocked this week

| Name | Role | Why relevant |
|------|------|-------------|
| Nova Devasia | Onboarding | Ran new hire orientation |
| Varnica | PM, Meetings/Goals pod | Key collaborator on transcript feature |
| Rinku | PM, Integrations pod | Key collaborator on transcript feature |
| Jay-Z (Jason Zhang) | Data Platform & AI lead | Has LLM/AI architecture diagrams; Metabase access giver |
| Jason Bilyeu (JB) | App Platform lead | Ran architecture walkthrough; cross-pod services tracker |
| Chow | ? | Manages each legacy→NextGen customer migration |
| Eden + Josh | Eng | Own login/splash rewrite (legacy UI elimination) |
| Alex | Eng | Working on authorization service |
