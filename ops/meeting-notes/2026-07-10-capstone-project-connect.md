---
date: 2026-07-10
meeting: Capstone Project Connect
type: sync
attendees: [Paul Agustin, Varnika Garg, Lalit Maharana, Gauri Thakur, Sharan]
source: zoom
meeting_uuid: ED663B99-252E-4FBB-9F76-0296416CFFE8
---
# Capstone Project Connect — 2026-07-10

## Summary
The team met to discuss progress on their "Manager Copilot" capstone project, which analyzes engagement and Betterworks data to give managers insights and coaching recommendations. Sharan presented a flowchart for identifying top engagement drivers and levers affecting team performance; Lalit shared his vision for an AI layer serving as a sensor, memory historian, and writing assistant to generate personalized coaching recommendations. The team agreed to build a workable prototype for next Thursday's presentation — Paul Agustin will create a local database using sample data from Sharan and Lalit, and Gauri will update UI mockups to include more fields based on today's discussion.

## Key decisions
- Prototype scope: a local, standalone proof-of-concept (not integrated into Betterworks repos) demonstrating one manager with multiple direct reports representing different archetypes.
- Engagement data gate: the demo org will simulate one running frequent surveys so engagement data counts as "fresh" and isn't excluded by the freshness formula.
- Goals data gate: only goals checked in within the last 21 days are considered; thresholds are hard-coded but adjustable.
- Team-level vs. individual signals: engagement data is surfaced at team level only (anonymity threshold); all other signals (goals, feedback, recognition, flight risk) are per direct report.
- Three AI roles defined: Sensor (extract signals from qualitative data), Historian (build persistent memory/persona per employee), Writing Assistant (draft 1:1 prep content).
- The memory/persona layer is treated as PII — GDPR compliance requires giving employees visibility into what's stored.
- One-on-one notes aren't currently exposed via API; the team will take creative liberty with agenda/notes data for the prototype and flag it as a future endpoint request if the project advances.

## Action items
- Gauri: update mockups/designs based on today's discussion and the documents from Sharan and Lalit.
- Lalit: add his files to the zip before Sharan shares it with Paul Agustin.
- Paul Agustin: build a local database and mock up the prototype using the shared data, focused on a clickable prototype for next Thursday's presentation.
- Sharan: share the zip file (CSV + Python files) with Paul Agustin; connect with Gauri on team engagement data details for the UI.
- Team: coordinate over Slack for next steps and a possible weekend connect if needed.

## Follow-ups / open questions
- Final UI treatment (coaching cards vs. homepage integration) still to be determined.
- Whether the one-on-one notes endpoint gap needs a real API request if the project moves beyond capstone.

## Discussion notes
- Bangalore meetup travel: Varnika (from Delhi, ~3hr flight) and Lalit (from Hyderabad, ~1.5hr flight) are flying in Sunday to avoid Monday-morning travel; no presentation slot on the calendar yet per Paul Agustin.
- Sharan walked through a flowchart: analyze team-level engagement data + Betterworks data to identify top engagement drivers/issues per manager and direct report, summarize with AI, and generate draft 1:1 topics plus flight-risk assessment.
- Lalit presented his three-layer AI model (sensor / historian / writing assistant) for building personalized employee profiles from feedback, recognition comments, and 1:1 notes.
- Paul Agustin confirmed the memory-layer/user-profile direction is good for performance and token usage; proposed building a local database in his existing Pluto environment to simulate Betterworks/Engage data (feedback, conversations, recognition) mirroring real data for the demo.
- Gauri presented updated mockups showing the feature on the homepage with employee cards.

## Next steps
- Sharan and Paul Agustin sync on data structure/storage; Paul builds local DB and starts wiring the clickable prototype.
- Gauri updates mockups per today's discussion.
- Target: clickable prototype ready for Thursday's presentation.
