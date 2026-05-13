# Lalit / Sriram 1:1 — May 7, 2026
Sriram CS = SVP Engineering. Bi-weekly cadence going forward.

---

## Key context from Sriram

### Four engineering initiatives running right now

1. **SDLC Transformation** — Pankaj Lomo (Principal Engineer, India) driving. Three repos being made AI-native (operable via agents, minimal code): Rekognition, Meetings, Prasanna's homepage backend. Set up recurring time with Pankaj — he has broad company influence.

2. **QA Transformation** — Tejas driving. Shift from SDETs owning quality → PMs + EMs enabling SDETs to own quality metrics. PMs must include QAs early, get test cases reviewed before dev starts. Attitude change needed — developers should feel "ashamed" if QA reports defects.

3. **Product Transformation / BetterAsk** — Paul Augustine, Rinku, Nitish building "Better Ask": a Slack bot for PMs (answering questions, getting tasks done). Based on PM interviews already conducted. Also: PM AI training program in progress (internal vs external budget TBD in ~2 weeks).

4. **Design Transformation** — Austin, Harshini, Gauri (designers), Mahesh (dev). Goal: PM + Designer + Dev on a half-day call → working Haven front-end prototype (dirty code, uses our Haven framework, not just HTML/CSS). Then generate all other artifacts (user stories, acceptance criteria, test cases) from that working prototype. Tools being tested: paper.design, Google Stitch.

### Meeting Transcripts — Sriram's framing

**Two separate problems — decouple them:**
- Problem 1: Getting transcript data from external source (vendor vs. native integration) — decision pending
- Problem 2: Processing stored data and exposing it to Betterworks modules (AI inference, action items, goals)

**Sriram's strong view:**
- Problem 1 (data ingestion) is a **platform-level component** — must be architected properly, zero compromise. This will become a repeatable pattern for pulling 3rd party data into Betterworks.
- Problem 2 (AI inference layer, front end) — can move fast, "slightly shitty code is fine," iterate rapidly.
- Don't wait for Problem 1 to start Problem 2. Copy-paste transcript data manually for the POC. Decouple.

**Vendor vs native debate:**
- Sriram: prefers vendor (doesn't want to own transcript fetching — "not our business")
- Nellie: prefers native Zoom integration (security concerns with bots)
- Sriram's take: neither of them has ultimate skin in the game. Lalit, Anuj, Danish, Rinku do. **Drive the decision yourself, unbiased.** Decision must be made by end of May.

**Engineers: Anuj and Danish**
- Exceptional system design engineers, but naturally pessimistic and methodical
- Their instinct: "this will take 4–5 months"
- Push back on timeline. Pull in Pankaj when stuck.
- They're learning where to compromise vs. where not to

**Key action Sriram wants:** Prototype workshop — 3–4 hours with Anuj, Danish, Gauri. Start from Nellie's existing prototypes. Goal: working Haven prototype with dynamic action items (each action item has a button to create a goal / update a conversation / etc.).

**Include Sriram** in meetings transcript discussions for the next 2–3 weeks until key decisions are made.

### Release timeline
- Summer release: feature-complete by **August**, announcements in **September**
- What's going out in summer: talent module, meeting transcript, new mobile app, LMS, integrations, personalized development plans, adaptive learning
- **May = make the decision + prototype.** Only 4 months total. May will be gone before we know it.

### India-US coordination
- No issues. Meetings transcript feature is **purely India-driven**.

---

## Action items

### Immediate (this week)

| # | Action | Who to contact |
|---|--------|---------------|
| 1 | Set up recurring meeting with **Pankaj Lomo** (Principal Engineer) | Search "Pankaj" on Slack |
| 2 | Connect with **Anuj and Danish** (engineers on meetings transcript) | Sriram directed; get intro via Rinku/Nellie |
| 3 | Get Nellie's **existing prototypes** for meetings transcript feature | Nellie |
| 4 | Study existing decisions: Recall AI POC recording + Nellie's analysis doc | Already in temp Slack channel |

### This sprint (by end of May)

| # | Action | Notes |
|---|--------|-------|
| 5 | **Drive vendor vs native decision** — evaluate unbiased, include Sriram in discussion | Decision deadline: end of May |
| 6 | **Host prototype workshop** (3–4 hrs): Anuj + Danish + Gauri + you | Use Nellie's prototype as base; target: working Haven prototype with dynamic action items |
| 7 | Connect with **Rinku** (integrations PM) | Critical for both transcript feature and BetterAsk context |
| 8 | Connect with **Paul Augustine + Nitish** | Better Ask / PM transformation context |
| 9 | Push back on Anuj + Danish timeline estimates | Their instinct will be 4–5 months; challenge with Pankaj's help if needed |
| 10 | Get **GitHub access** sorted and start using it actively | Sriram explicitly asked for this |

### People to meet (new from this conversation)

| Name | Role | Priority |
|------|------|---------|
| Pankaj Lomo | Principal Engineer, India (SDLC + AI-native repos) | HIGH — recurring meeting |
| Anuj | Engineer, meetings transcript | HIGH — your dev team |
| Danish | Engineer, meetings transcript | HIGH — your dev team |
| Gauri | Designer (in your team) | HIGH — design workshop |
| Paul Augustine | Product transformation / BetterAsk | MED |
| Nitish | Product transformation / BetterAsk | MED |
| Austin | Designer, design transformation | MED |
| Harshini | Designer, design transformation | MED |
| Mahesh | Developer, design transformation | LOW |

---

## Key decisions to make by end of May

1. **Vendor vs. native Zoom integration** for transcript data ingestion — Lalit owns this call
2. **Architecture of data pipeline** (platform component — high standards required)
3. **Timeline and phasing** — decouple data ingestion from AI processing layer

## Sriram's working style notes
- Bi-weekly 1:1, but reach out any time if stuck
- Include him in meetings transcript decisions until end of May, then he steps back
- Wants PMs to use AI visibly — "scare" the team productively with what's possible
