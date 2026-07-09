---
date: 2026-07-09
meeting: Lalit Maharana's Zoom Meeting
type: planning
attendees: [Hemant Kumar, Lalit Maharana, Sagar Bhat, Anuj Pancholi]
source: zoom
meeting_uuid: FCE75A4F-7D35-4338-ABD1-0CEC2715CBAD
---

# Lalit Maharana's Zoom Meeting — 2026-07-09

## Summary
Hemant, Lalit, and Sagar reorganized the Jira ticket structure for the meeting-transcript processing pipeline to better reflect actual pipeline stages.

## Key decisions
- "Read from S3" and "Process Transcript" combined into one ticket.
- Ticket 82390 renamed to "Meeting Recap Generation."
- Agenda Topic Extraction, Goal/Recommendation Extraction, and Summary/Action Item Extraction confirmed as distinct tickets.
- Callback-endpoint ticket renamed to "Update Endpoint."
- Infrastructure/pipeline work folded into the DB Schema Design ticket (282135) rather than split out.
- PII handling stays a standalone ticket for now.

## Action items
- Deep-dive with Anuj on structuring the S3 link/meeting-ID folder for multiple submissions per meeting.

## Follow-ups / open questions
- How to structure the S3 link/meeting-ID folder when a meeting has multiple transcript submissions — same underlying issue as the drop/rejoin transcript-merge open question from earlier the same day.

## Discussion notes
- This ticket reorganization is meant to make the Jira board reflect actual pipeline stages rather than an earlier, less accurate breakdown.

## Next steps
- Anuj to be looped in on the S3-link/meeting-ID folder structure question.
