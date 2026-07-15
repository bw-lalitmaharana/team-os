---
date: 2026-07-15
meeting: "Zoom Meeting"
type: planning
attendees: [Dasharath, Lalit Maharana, Neetesh Kaushik]
source: zoom
meeting_uuid: 385CD5A3-396A-40BD-9E55-279641FA42BF
---
# Demo data-population planning — 2026-07-15

## Summary
Team planned how to populate realistic demo data for the skill-graph hackathon build, given no production pipeline exists yet to assign skills to talent profiles.

## Key decisions
- Local environment: stand up Postgres + Neo4j.
- Population approach: a Python script that bypasses the Talent API and writes directly to the database (using an OpenAI key) to assign role-relevant skills to profiles.
- Random or blanket skill assignment explicitly rejected as not credible for a demo.
- Incumbent/position-level skill assignment deferred until after core skill population is complete.

## Action items
- Dasharath / Lalit: prepare the population script and inputs.
- Neetesh Kaushik: run the script against the local Postgres + Neo4j setup.

## Follow-ups / open questions
- Incumbent/position skill assignment — not yet scoped, picked up after skills population lands.

## Discussion notes
- This data-population approach is demo-only tooling (direct DB writes, bypassing the Talent API) and is not intended as a production data path.

## Next steps
- Prepare and run the population script; then scope incumbent/position skill assignment.
