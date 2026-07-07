---
date: 2026-07-07
meeting: Meetings AI Jira Realignment
type: design
attendees: [Hemant Kumar, Lalit Maharana]
source: zoom
meeting_uuid: 05F5F260-81F1-4BBC-8993-F70275DAF83E
---

# Meetings AI Jira Realignment — 2026-07-07

## Summary
Hemant and Lalit designed consent-based rules for generating meeting recaps and prep documents. A clear happy-flow was defined for full-consent scenarios, and edge cases (partial consent, unplanned participants, retroactive consent) were scoped. The team agreed to deprioritize transcript-based recommendations in favor of structured meeting data (notes, agenda, action items) as the primary source for recap and prep generation.

## Key decisions
- Full consent rule: all participants must have consented for a transcript-derived recap to be generated; if any participant hasn't consented, the transcript is excluded from the recap.
- Notes and agenda items (shared notes, action items) are generated implicitly and are not gated by transcript consent.
- Unplanned third-party joins a meeting → entire recap is discarded, since the third party may have shared sensitive content.
- Retroactive consent: no backfill; AI features apply from the consent date forward only.
- Consent revoked after generation: past artifacts are retained; only future generation is halted (InfoSec check to be confirmed).
- Recommendations will no longer rely on the transcript; structured meeting data only.
- Sensitivity flag being considered at series or instance level to optionally exclude specific meetings from AI processing.
- Reconciliation moved from a separate task to a routine task; no standalone reconciliation step.

## Action items
- Lalit: conduct an InfoSec check on consent revocation and artifact retention this week (separate conversation).
- Hemant: implement unified transcript parsing logic — noise removal, speaker filtering by consent status — as a prerequisite for downstream generation tasks.
- Team: define a minimum input threshold/scoring model to determine when data is sufficient for quality output.
- Team: validate the happy-flow POC (both parties consented) before implementing edge-case handling.
- Team: spike on edge cases, estimated at 7–9 days of effort.

## Follow-ups / open questions
- InfoSec review on consent revocation and artifact retention policy.
- Minimum data threshold required to generate a meaningful recap/prep (scoring model to evaluate input quality vs. output quality).
- Handling of deleted/replaced transcripts post-generation: user nudged to refresh, regenerate, or delete.
- Sensitivity flag design: series-level vs. instance-level consent granularity.
- Cold start scenario: no agenda, no prior action items — how to handle open-ended prompts.
- Data gaps: how much incomplete data is acceptable before generation is suppressed.
- Group meeting consent: any single non-consenting participant triggers the same exclusion logic as one-on-one.

## Discussion notes
- Brief connection issue at the start of the meeting; Sagar did not join.
- Happy-flow scenario: if both participants in a one-on-one or group setting have consented, full transcripts and shared notes can be transferred to the database.
- Private vs. shared notes: explored differentiation in the context of PrepMe transcripts, including recommendations based on transcripts, input-area issues, and language translation; touched on personalized preparation and consent for reporting/action items.
- Meeting summary guidelines: recaps should only be shared if all participants have consented; transcripts should not be used directly for recaps.
- Third-party scenario: discussed an external one-on-one meeting with two consented participants where an additional unconsented third party joined — resolved as full recap discard, framed partly around detecting potential third-party "hackers" in meetings.
- Recap content requirements: should summarize agenda topics, action items, and updates on what was discussed/changed (additions, removals, edits) during the meeting.
- Attention flags: proposed using existing data to fine-tune agenda topics and action items; team may try implementing this rather than waiting for a complete happy-flow POC.
- Unified processing system: one task per user for specific functions (recap, recommendations, prep); Hemant working on noise removal and transcript parsing as part of this unified approach.
- Skeletal framework: covers consent and error handling for edge cases; reconciliation integrated as a routine task rather than separated; recommendations/data access via APIs seen as straightforward.

## Next steps
- Hemant and Lalit to work through remaining edge cases (no consent, no transcript, data gaps) for recap/prep generation.
- Lalit to raise consent revocation and transcript deletion/replacement scenarios with InfoSec this week.
