---
date: 2026-05-28
meeting: Lalit / Sriram
type: 1:1
attendees: [Lalit Maharana, Sriram CS]
source: zoom
meeting_uuid: 7143CC97-9E71-4995-9091-EE2A094FD0E3
backfilled: 2026-07-07
---

# Lalit / Sriram — 2026-05-28

## Summary
1:1 between Lalit and Sriram CS (held in Sriram's personal meeting room; some connectivity drops). Covered an upcoming team offsite, the meeting-transcript project status, an AI implementation strategy, the reusable data-flow architecture, and upcoming product/design AI training. (No AI summary or notes were captured for this instance; the following is drawn from the meeting transcript.)

Key discussion threads:
- **Team offsite:** Being planned by Noah (Nova) within an allocated budget; likely Bangalore since ~10 attendees wouldn't need to travel (most economical air travel), with accommodation trade-offs balancing flight costs. Team historically spends 10-20% under budget. Lalit to pass any good property recommendations to Noah.
- **Meeting-transcript project status:** On track. Pankaj and Anuj have put together the architecture; the contract with the AI team is expected to come through this week. Significant refinement done on the story involving engineers, design, and everyone together. Pankaj/Anuj may use AI in the implementation as they move to demo/workflow.
- **AI implementation strategy:** Sriram advised mapping out which parts can be done (nearly) completely by AI vs. which shouldn't be handed to AI straight away. Front-end is a good AI candidate: with rough front-end requirements (no full design/prototype needed), you can get a whole prototype ready in a single call. Mahesh demonstrated Claude Design + Claude Code last week — get prototypes to decent shape and involve developers at that point, avoiding a separate "convert prototype to UI" phase. Lalit noted design is already using Claude Design (with Harshini and Gauri) to produce prototypes, then converting to Vue/TypeScript.
- **Architecture (three microservices):** AI service, meeting service, and integration service. The data-flow pattern — fetch data from a third-party source, feed it into the AI system, process, and expose it to an internal consumer (meetings today; any pod later) — should be generalized: any external data source, any internal consumer. Same architecture will serve the LMS integration for personalized learning/development programs. Lalit confirmed the PRD already anticipates more sources and touch points on the same pipeline. Sriram framed this pipeline as capable of driving Betterworks' 2027 product strategy (mixing internal + external context for recommendations, e.g., a homepage populated with recommended actions).
- **Timeline:** Plan from the end date. In the next 1-2 weeks, get planning done so the feature is in pre-prod by mid-August, with demos to CS/sales; aim for pre-prod (fall back to Rainforest if needed). Full effort targeted within the summer.
- **Scale & latency:** Must handle hundreds/thousands of users recording multiple transcripts per day; validate load in the POC so scale isn't discovered late. Users tolerate expected/communicated delays (e.g., "transcript ready 5-10 min after the meeting"), but intensive processing shouldn't cause delays elsewhere.
- **Architecture depth & training:** Lalit to understand the architecture in depth with Pankaj/Anuj; conversations expected between Danish and Latif. Product+designer AI training being scheduled soon with an external hands-on trainer to help build agents; Sriram working with Natalia on OKRs so PMs and designers are all expected to build something as part of the training. Lalit intends to use the training as an opportunity to do some POCs.

## Action items
- Lalit: Pass any good offsite property recommendations to Noah (Nova).
- Lalit: Discuss AI-in-implementation plans with Pankaj and Anuj in advance; involve Tanveer.
- Lalit: Work toward an AI implementation strategy mapping AI-suitable vs. not-yet-AI parts of the new architecture.
- Lalit: Understand the architecture in depth with Pankaj/Anuj; coordinate the Danish/Latif conversations.
- Sriram: Follow up with Anuj on planning from the end date so the feature is in pre-prod by mid-August.
- Sriram: Have the team reach out to Lalit for offsite planning if needed.

## Follow-ups / open questions
- Final offsite location and budget (Noah leading).
- Confirming the AI-team contract expected this week.
