# Meetings Transcripts Integration — May 31 Delivery Plan

**Personal goal:** Working end-to-end in Rainforest by May 31.
**Stakeholder framing:** "MVP testable in Rainforest within first month" (Nellie) + "Decision + prototype" (Sriram). This plan delivers both and goes one step further.

## The core strategy

Decouple the two problems Sriram named:

| Problem | Owner | Timeline |
|---------|-------|----------|
| **Problem 1:** Getting transcript data in (vendor vs. native Zoom API) | Rinku + Integrations | Decision by May 31; build June–July |
| **Problem 2:** AI processing pipeline + UI (what we DO with the data) | Lalit + Anuj + Danish | **Build NOW with manual input — live by May 31** |

Manual copy-paste transcript = valid input for MVP. Don't wait for Problem 1 to ship Problem 2.

---

## Week 1: May 7–11 — Align & Anchor

**Goal:** All the right people aligned, unknowns closed, Problem 2 unblocked.

| Day | Action |
|-----|--------|
| Thu May 7 | Cheryl 1:1 (tonight) + App Platform Backlog Refinement |
| Fri May 8 | Set up recurring with Pankaj Lomo (search "Pankaj" on Slack) |
| Fri May 8 | Reach out to Anuj, Danish — intro ask, brief them on your approach |
| Fri May 8 | Reach out to Gauri (designer in your team) — schedule design workshop |
| Fri May 8 | Reach out to Rinku — intro + Problem 1 framing |
| Fri May 8 | Get Nellie's existing Haven prototypes |
| Mon May 11 | Watch Recall AI POC recording + Nellie's analysis doc |
| Mon May 11 | Review ENG-79199 epic — identify gaps for user stories |
| By May 11 | Have vendor vs native options framed with POC plan |

**Week 1 exit criteria:**
- [ ] Recurring set up with Pankaj
- [ ] Anuj + Danish + Gauri + Rinku introduced and briefed
- [ ] Nellie's prototypes in hand
- [ ] Vendor vs native framed (not decided — that comes from POC evidence)
- [ ] ENG-79199 broken into user stories draft

---

## Week 2: May 12–18 — Prototype Workshop

**Goal:** Working Haven prototype with manual transcript → dynamic action items in UI.

| Action | Owner | Notes |
|--------|-------|-------|
| Host 3–4 hr workshop: Anuj + Danish + Gauri + you | Lalit (facilitate) | Start from Nellie's prototypes; use Haven framework |
| Target output: Haven prototype with action items list | Anuj + Danish | Each item has "Create goal" / "Update conversation" button |
| Manual input path: user can paste transcript text | Anuj + Danish | No Zoom API needed yet — just a textarea |
| AI inference POC: transcript text → structured output | AI team | Even if rough — what does the extraction look like? |
| Check in with Pankaj on architecture | Lalit + Pankaj | Validate the data model before we go too far |

**Week 2 exit criteria:**
- [ ] Workshop done — Haven prototype exists
- [ ] Manual input path (copy-paste) works
- [ ] AI extraction returns structured action items from transcript text
- [ ] Architecture reviewed with Pankaj

---

## Week 3: May 19–25 — Connect the Dots

**Goal:** End-to-end flow working. Transcript → AI → UI. Deploy to Rainforest.

| Action | Owner | Notes |
|--------|-------|-------|
| Wire AI processing output to Haven UI | Anuj + Danish | Structured output from AI → renders in UI |
| Each action item gets Betterworks integration button | Meetings pod (Varnica) | "Create goal" / "Update 1:1" / "Send feedback" |
| Deploy to Rainforest | Anuj + Danish | Even if some parts stubbed |
| Finalize vendor vs native decision | Lalit + Sriram + Rinku | You have POC evidence now — call it |
| Include Sriram in decision call | Lalit | He asked to be included until end of May |

**Week 3 exit criteria:**
- [ ] End-to-end flow: paste transcript → AI extracts → action items appear in UI
- [ ] Running in Rainforest
- [ ] Vendor vs native decision made and logged in decisions/

---

## Week 4: May 26–31 — Ship & Validate

**Goal:** Testable, demo-ready in Rainforest. Nellie + Sriram sign off.

| Action | Owner |
|--------|-------|
| Demo to Nellie — "MVP in Rainforest" delivery | Lalit |
| Demo to Sriram — show decision made + working prototype | Lalit |
| Document what's live vs stubbed | Lalit |
| Write June plan: Problem 1 (automated ingestion) track | Lalit |
| Update ENG-79199 status in Jira | Lalit |

**Week 4 exit criteria:**
- [ ] Nellie sign-off on MVP
- [ ] Sriram sign-off on decision + prototype
- [ ] June plan drafted (automated ingestion track)
- [ ] ENG-79199 updated in Jira

---

## What "live by May 31" means (and doesn't mean)

**In scope:**
- User pastes meeting transcript manually
- AI extracts action items, goals signals, discussion topics
- Structured output displayed in Betterworks UI (Haven)
- Each item has integration buttons (create goal, update 1:1, etc.)
- Working in Rainforest

**Out of scope (June–July):**
- Automated Zoom transcript ingestion (Problem 1)
- Teams integration
- Production deployment
- Admin controls

---

## Open decisions to track

See `open-questions.md` for full decision log.

| Decision | Deadline | Owner |
|----------|----------|-------|
| Vendor vs native Zoom integration | May 31 | Lalit (drive), Sriram (include) |
| Processing architecture: unified vs multi-pass | Before Week 2 workshop | AI team + Lalit |
| Input/output schema (contract between pods) | Before Week 2 workshop | Lalit + Meetings pod |
| Retention policy for pending suggestions | Before Rainforest deploy | Lalit + Platform pod |
