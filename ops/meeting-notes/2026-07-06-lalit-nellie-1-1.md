---
date: 2026-07-06
meeting: Lalit / Nellie 1:1
type: 1:1
attendees: [Lalit Maharana, Nellie LeMonier]
source: zoom
meeting_uuid: 22045743-D219-45C6-AA3D-E13DB53C05F1
backfilled: 2026-07-07
---

# Lalit / Nellie 1:1 — 2026-07-06

## Summary
Nellie and Lalit worked through tactical items and goal-setting for the AI/platform projects. They aligned on three areas: routing the meeting-transcript feature through InfoSec review, clarifying ownership of the inbound webhook framework, and assigning yearly goals in Betterworks. Lalit will lead outreach to Brian Jacobs (Head of InfoSec) and drive delivery oversight for AI-specific features. Goal assignments were updated live, with a follow-up session scheduled to complete the exercise.

## Key decisions
- InfoSec review process: document consent/wording on Confluence, then send to Brian Jacobs (Head of InfoSec) for review before summer release; schedule a walkthrough with the architect and Lalit; Nellie to be included. Same process previously used for MCP.
- Slackbot story: Lalit owns it; will showcase on the Fortnightly AI Projects call once ready.
- Webhook ownership: AI-specific features (meeting transcripts, TechWolf integration, PDP) must be covered by the inbound webhook framework, regardless of which team builds it.
- Goal assignment: "Deliver platform and AI components" goal transferred to Lalit in Betterworks; Nellie retains oversight on foundational items (guardrails, agentic architecture).
- Bangalore PM/Designer slot: team will demo existing working projects (~10 min each) plus Lalit will present a customer-discovery AI tool built from Gong transcripts; sessions to be recorded.

## Action items
- Lalit: reach out to Brian Jacobs — share Confluence feature documentation + consent wording; schedule a walkthrough with the architect (include Nellie).
- Lalit: organize and prepare demos for the PM/designers session in Bangalore, including the customer-discovery AI feature (Gong transcripts) and projects from Prasad's session.
- Lalit: get clarity on inbound webhook framework ownership and delivery — confirm what the integration team will deliver and ensure AI feature needs (meeting transcripts, PDP, TechWolf) are covered.
- Lalit: connect with Lori Howell (Ripple lead developer) to understand the Ripple/Slackbot bot's LLM/endpoint architecture; follow up with JB on internal REST endpoints and how the Slackbot can invoke them.
- Lalit: drive the next cross-functional call — introduce the problem statement for "JZ" based on Natalia's request; walk through the prototype.
- Nellie: schedule a follow-up 1:1 (next day) to complete goal-setting in Betterworks.

## Follow-ups / open questions
- Clarity needed on who owns webhook delivery going forward — integration team vs Okan's spike vs AI team.
- Danish's webhook implementation needs a sync with Okan, then a review with broader technical leads.
- Additional goals session needed — backlog refinement goal may have been closed prematurely.

## Discussion notes
- User consent review: Lalit needs legal/compliance input on consent wording and implementation; Nellie routed this to Brian Jacobs (InfoSec), who must approve before the summer release.
- Bangalore demo planning: upcoming in-person session; each team gets a ~10-minute slot to demo working projects, including PM-specific workflows and the Gong-based customer-discovery AI tool.
- Hackathon/talent ranking: Lalit's hackathon project is an AI ranking algorithm for employee talent profiles, applicable to both successor recommendations and mentor recommendations.
- Ripple/Slackbot: Nellie explained the current bot architecture can call internal services and endpoints (talent, goals, etc.); these are private APIs, not public. JB has discussed developing LLM tools and internal REST endpoints in parallel. Slackbot assessed as potentially more useful than AI chat as a standalone surface; both surfaces should coexist.
- Feedback: Nellie noted usability issues in the Betterworks goals UI — unexpected scroll jumps and lost position after adding milestones; flagged as UI/redirect usability bugs. She suggested adding individual milestones to goals as an exercise to better understand the product.
- Webhook framework: Danish implemented the security piece; Okan is working on a related spike. To be reviewed with the technical team for alignment. Nellie raised concern about engineers having enough work and the need to refine the platform backlog (deferred).

## Next steps
- Nellie to schedule the follow-up goal-setting 1:1 (next day).
- Lalit to begin InfoSec outreach and webhook-ownership clarification, and to drive the next cross-functional call.
