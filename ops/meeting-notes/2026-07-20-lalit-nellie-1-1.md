---
date: 2026-07-20
meeting: Lalit / Nellie 1:1
type: 1:1
attendees: [Nellie LeMonier, Lalit Maharana]
source: zoom
meeting_uuid: B6EF1C50-F3E9-4118-92BC-BCCC98B81B35
---
# Lalit / Nellie 1:1 — 2026-07-20

## Summary
Lalit and Nellie's regular status check-in, covering goal/notification tracking, hackathon follow-through, several in-flight projects (webhooks, LMS course recommendations, Zoom transcripts), and ongoing AI pre-processing/performance-summary issues. Nellie had been tagging items in Aha/Jira and flagged several features at risk against the August code-complete deadline, including email batching.

## Key decisions
- Email/notification batching is an at-risk item for code-complete in August; Lalit will document how Legacy batch notifications work (for parity) before further scoping.
- Global webhook engine needs to be confirmed as tracked in AHA, with a request to add the TechWolf integration to the integrations roadmap.
- Danish to walk JB and Ocon through the webhooks PR once JB returns next week.
- Zoom transcripts feature targeting a working version by end of July; consent documentation (including admin perspective) still needs to be finalized before Brian's review.
- Additional friction (a pre-rollover notification) will be added before automatic year-closure in AI pre-processing/performance summaries, since the automatic switch isn't working reliably and users need a way to fall back to manual mode.

## Action items
- **Lalit:** Meet with Veronica tomorrow to understand Legacy batch notifications and document requirements in a Confluence draft.
- **Lalit:** Catch up with Nitish/Natalia on the AI-powered course-recommendation POC status, focusing on scale and latency.
- **Lalit:** Check with Danish that the global webhook engine is tracked in AHA; request TechWolf integration be added to the roadmap.
- **Lalit:** Arrange for Danish to walk JB and Ocon through the webhooks PR when JB returns next week.
- **Lalit:** Prepare a document for Brian on the Zoom transcripts feature (including consent implementation) and request his review.
- **Lalit:** Work with Nellie to document how consent works for Zoom transcripts, including the admin perspective.
- **Nellie:** Work with Bhavesh to fix AI pre-processing issues, specifically automatic year-rollover of performance cycles.

## Follow-ups / open questions
- Whether Brian has been looped in on the Zoom transcripts consent documentation yet (not resolved in this meeting).
- Overall project health check Nellie raised at the end of the Works Analytics Framework discussion — answer not captured.
- Automatic year-rollover is still not switching correctly for at least two customers in production; fix status to be tracked with Bhavesh.

## Discussion notes
- Brief personal catch-up: Nellie recovering from a minor yoga-retreat injury; Lalit found a recent event useful for networking with writers.
- Hackathon: Lalit noted the team successfully figured out the "skill graph" (transcribed as "scale graph"), reusable in PDP; Nellie wants to re-review project recordings since presentations went by quickly; JB was absent that week.
- Nellie discussed Chao's work on a "better works analytics framework" with an MCP layer (four stages, including a SkillMentor tool for mentor recommendations) — team currently only has course recommendations implemented, not the mentor feature.
- Natasha/Nitish have a working POC generating recommendations from LMS courses; latency is the open concern.
- Nellie shared a PM template and scheduled a walkthrough with JB to fill out summer-release sections, including how consent works for admins connecting to Zoom.
- Nellie explained the current pre-processing system doesn't auto-detect year-end transitions; she's added both automatic and manual closure controls, but automatic switching isn't working for at least two customers.

## Next steps
- Lalit to complete the Veronica walkthrough and webhook/TechWolf roadmap follow-ups this week.
- Lalit to close the loop with Brian on transcripts consent documentation.
- Nellie and Bhavesh to continue investigating the pre-processing rollover fix.
