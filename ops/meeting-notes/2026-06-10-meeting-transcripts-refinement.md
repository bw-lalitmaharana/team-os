---
date: 2026-06-10
meeting: Meeting Transcripts - Refinement
type: refinement
attendees: [Lalit Maharana, Danish, Anuj, Sagar Bhat, Hemant Kumar, Akshay, Harshini Vijay, Tanveer]
source: zoom
meeting_uuid: [B47492F3-960B-4616-BCD3-114A9520E312, C2CEC681-7F9E-4DAF-924D-F9136080FD11]
backfilled: 2026-07-07
---

# Meeting Transcripts - Refinement — 2026-06-10

## Summary
Two refinement sessions on the same day to review and refine the Epic 7 stories for the meeting-transcript integration project, covering integration, AI, and meetings pods. Lalit led the team through the stories one by one to reach a contract sign-off before implementation. Topics included spike tickets for auth-proxy / webhook-gateway architecture, OAuth consent flows, transcript processing, S3 storage and naming conventions, speaker identity resolution, PII handling, the reconciliation framework, and the timing of AI brief generation. Danish detailed the two-part spike (internal architecture first, then provider-specific Zoom integration); Anuj covered Zoom's native webhook behavior and account- vs user-level OAuth; Sagar covered AI processing, PII, and story pointing. The team decided on an account-level Zoom app (with per-user consent), daily batch brief generation, and agreed to document decisions in a shared doc; review continued the next day.

## Key decisions
- Use account-level (admin) Zoom app access with a consent button on the meeting screen rather than user-level OAuth, to avoid privacy issues and reduce complexity/gateway overhead. Three Zoom API calls needed (admin token, participant API, transcript download URL) all work with the same admin access token; maintain individual user consent for transcript downloads. Admin-level enablement lives in both org settings and the third-party integration page; OAuth flow controlled via the meetings page only when enabled at org level.
- Move toward an event-driven architecture between auth-proxy and the meetings team (rather than static endpoints) for scalability. Speaker identity resolution handled at the meetings-team level (not integration level), potentially with AI; target 90–95% accuracy, using email and employee ID as common identifiers.
- Meeting exclusions managed at the meetings-service level, not the integration squad (OAuth and webhooks are separate).
- Transcript processing occurs once daily for upcoming meetings within a one-day window; AI briefs generated 12–24 hours before the next meeting via a daily cron; manual refresh available for more frequent updates.
- AI processing (evidence schema): use a multi-pass approach (not single-shot) due to post-processing and similarity search; some work already done by Hemant. Reconciliation framework prevents duplicate items using initial rule/query-based matching, with embeddings later. PII handling included in prompts (acknowledged may miss some due to trial-and-error).
- Phase 1 focuses on goals; feedback and recognition skills are Phase 2. Focus on one inference at a time rather than splitting attention.
- Story points: integration spike = 4; AI processing work = 3.
- Move to async Scrum for now (updates in the channel), reconvening for occasional in-person discussions.
- Harshini creating a few key Figma screens as the styling source of truth for developers (exact kitchen-sink components not available); Claude designs to be shared with Anuj.

## Action items
- [ ] Danish — Complete part 1 of the spike (webhook-gateway / auth-proxy internal architecture, trade-offs, non-functional requirements) by Friday; share for review within ~2 days
- [ ] Danish — Start part 2 of the spike: Zoom feasibility of integrating into the webhook-gateway service by Wednesday; address integration-specific questions
- [ ] Danish — Ensure admin-level Zoom integration enablement in the user-admin third-party integrations page (and system-admin page if required), coordinating with Sagar on settings visibility
- [ ] Anuj — Study/document Zoom native webhook behavior for user-managed vs account-level apps (edge cases: hosts/non-hosts, OAuth flows); include in the spike
- [ ] Anuj — Prepare and share access to an S3 bucket with sample transcripts, including folder structure and file-naming conventions (series ID, meeting ID, date), by end of week
- [ ] Anuj — Finish the meeting spike by Monday, latest Tuesday
- [ ] Anuj — Spike alternative approaches for triggering auto-rollover and brief generation to reduce support issues; propose best implementation
- [ ] Anuj — Set up a daily cron to trigger brief generation 12–24h before upcoming meetings (limited to next-day meetings)
- [ ] Anuj — Update acceptance criteria for meeting exclusion and admin/user controls for transcript processing (coordinate with meetings team)
- [ ] Anuj — Start a Google Doc / Confluence to capture spike answers and decisions; assign dependencies to Danish and Sagar
- [ ] Sagar — Test AI workflow using the provided S3 bucket + transcript files; feedback on folder structure/naming
- [ ] Sagar — Provide the endpoint to Anuj/meetings for delta sync or brief regeneration if needed
- [ ] Sagar — Ensure org- and user-level settings for AI feature + OAuth in appropriate admin pages; confirm settings flow with Danish
- [ ] Sagar — Answer remaining questions in spike ticket 82389 and document them
- [ ] Sagar — Set up a meeting with the meetings team to agree on the AI payload response format (this week or next)
- [ ] Lalit — Review/finalize epic-level schema and acceptance criteria (data handling, retention, user/admin controls) after spike outcomes
- [ ] Lalit — Share Claude design links/screenshots with Anuj after discussing with Harshini and Varnika
- [ ] Tanveer — Implement async Scrum updates for now; re-evaluate if a call is needed later
- [ ] All — Reconnect tomorrow to continue refinement of remaining stories (Akshay to share updates/links)

## Follow-ups / open questions
- Whether admin OAuth tokens can fetch/download transcripts (raised by Danish, not fully resolved).
- Mapping Betterworks user IDs to speaker identifiers in transcript files (name mismatches, conference-room logins, different email types).
- Account-level approach produces extra events that need to be rejected/filtered.
- Meeting lifecycle contracts, front-end rendering requirements, and edge cases — some details need discussion with Pankaj.

## Discussion notes
- Danish: AuthenProxy supports both admin- and user-based integrations; choice depends on data scope (Jira example favored user-level to avoid sharing admin tokens). API gateway needs to be built from scratch.
- Two integration methods considered (expose endpoint vs event-driven); event-driven chosen for scalability.
- AI input/output: pre- and post-meeting summaries, action-item extraction, agenda topics, goal signal extraction; Phase 2 adds coaching cards.
- Latency: fetching from S3 is straightforward; user-visible speed depends on S3 pull time.
- POC/spec review needs US-team input; Anuj requested Claude design docs; Harshini confirmed designs are largely finalized and shareable.

## Next steps
- Reconvene the next day to cover remaining stories and reach contract sign-off; document answers in the shared Confluence doc; then begin implementation per team, starting with pipeline infrastructure.
