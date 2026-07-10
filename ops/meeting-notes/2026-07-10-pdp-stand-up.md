---
date: 2026-07-10
meeting: PDP Stand Up
type: sync
attendees: [Harikrishnan S, Nitish Devadiga, Nataliia Savenko, Pankaj Lohmor, Lalit Maharana]
source: zoom
meeting_uuid: 712DE033-C74B-4BC5-B6CB-0BC77DB56C73
---
# PDP Stand Up — 2026-07-10

## Summary
Friday standup on AI feature development (Jennifer absent; Pankaj taking time off the following week). Nataliia reported continuing work on user-story placeholders pending Saurabh's document, and is drafting feature-boundary documentation ahead of a Monday meeting on the LMS-provider default. Nitish presented updated notebooks showing the LLM struggles to differentiate proficiency levels during query generation but performs better in the re-ranking phase using external LinkedIn course data. Pankaj covered UI changes (removing a "ground" from UI sections, re-adding checkboxes to steps) and implementation details on skeleton components and feature flags. Team also flagged a need for Jira labels for feature identification and confirmed a refinement session when Pankaj is back from leave.

## Key decisions
- Keep the skeleton (shimmering-effect) loading design for the AI component as already implemented.
- Add filters for PDP-type goals to the goals table, and confirm edit forms will be available for milestones and goals.
- Replace next week's regular standup slot with a refinement session while Pankaj is on leave; Nataliia to set it up.
- No system-level architect exists at Betterworks — separate pods have their own architects who coordinate via regular sync meetings (context for how cross-pod decisions get made).

## Action items
- Nataliia: wait for Saurabh's user-story placeholder document (EOD) and use it as reference for backlog fulfillment; draft the feature-boundaries document and set up a small-group meeting Monday on the LMS-provider default; review Nitish's updated notebooks and follow up if needed; check Nitish's text-recommendation notebook and give feedback; populate the user-story placeholder with the final goals-table view (filter + edit-form functionality); set up the refinement session for the week Nitish/Pankaj are back.
- Nitish: add a comparison of raw LMS-provider output (search by skill name + level) to the proficiency-comparison notebook; add non-technical-skill examples (e.g. product management, finance) to the text-recommendation notebook.
- Pankaj: keep the skeleton/shimmer design for the AI component as implemented.

## Follow-ups / open questions
- Whether the raw LMS-provider output outperforms the current query-generation approach — comparison not yet completed; Nitish proposed using a larger LLM as judge for evaluation.
- Need for testing across categories beyond programming (e.g. product management, finance).
- Board-creation status for a separate team's Meetings Transcripts feature — unclear if a vote is needed since that team tracks by epic rather than by vote.

## Discussion notes
- Nataliia requested specific Jira labels to identify feature-related tickets more easily.
- Nitish's proficiency-level analysis: the LLM tends to recommend similar next-steps regardless of stated proficiency (e.g. surfacing advanced React content by default) due to base world-knowledge associations; query-generation alone isn't reliable for level-targeting, but combining LLM query generation with re-ranking against LinkedIn course data produces materially better results.
- Nitish explained LLM next-token-prediction mechanics to the group; Nataliia noted she must analyze documents independently (without AI tools) due to Betterworks permission restrictions, and asked for the text-recommendation doc to be shared in chat, plus more business/product-management-oriented examples rather than only technical ones.
- Pankaj confirmed he already merged code for the UI changes discussed (removed "ground" from UI sections, re-added checkboxes to steps); implementation details to be walked through via screen-share after the meeting.
- Nataliia confirmed a colleague (Anastasia) added a separate variant path in the first end-to-end flow.

## Next steps
- Nataliia sets up Monday's small-group LMS-provider meeting and next week's refinement session (replacing standup).
- Nitish extends the proficiency-comparison and text-recommendation notebooks per today's asks.
