---
date: 2026-07-08
meeting: OKR Team - Daily Standup
type: sync
attendees: [Jason Bilyeu, Nellie LeMonier, Tejas S, Sanchit, Victor Chen, Donnie, Ryan]
source: zoom
meeting_uuid: 9093DC61-F910-4628-9444-6B7F26C0E5AC
---

# OKR Team - Daily Standup — 2026-07-08

## Summary
Daily standup covering two workstreams: (1) MCP smoke-test scoping — the spike was renamed "MCP smoke test" and narrowed to a single example test ("Who Am I" tool) living in the Quality Automation Services repo, and (2) an auth-policy blocker where disabling "squares" in sysadmin currently returns 401 for all tenant APIs, blocking three pending PRs ahead of the Auth API release.

## Key decisions
- MCP smoke tests will live in the Quality Automation Services repo under a new "MCP tests" folder.
- Single example test approach confirmed: the "Who Am I" tool, using a static public API token; dynamic org creation used if already available in the QA suite.
- Auth-policy fix scoped to the skills-specific config folder only (not propagated to all tenant APIs), with the same approach to apply later to the succession module.

## Action items
- JB: Write the example MCP smoke test plus a scheduled GitHub Action.
- Sanchit: Verify whether dynamic org creation is already available in the QA suite.
- Nellie: Post the MCP smoke-test approach to the app-platform Slack channel for Tejas's feedback.
- Nellie: Schedule a same-day 30-minute review on the auth-policy blocker with Victor, Jason, Donnie, Ryan, and JB.

## Follow-ups / open questions
- OAuth flow testing for MCP flagged as likely needing a separate spike given browser-interaction complexity.
- Whether the auth-policy fix approach (skills-config-folder scoping) will need to be replicated for the succession module.

## Discussion notes
- The original MCP testing spike was renamed to "MCP smoke test" to reflect its narrower, more concrete scope.
- Disabling "squares" in sysadmin is currently returning 401 for all tenant APIs — this is blocking three pending auth-policy PRs and must be resolved before any Auth API release to other environments.

## Next steps
- Same-day auth-policy review meeting to be scheduled by Nellie.
- JB to begin writing the MCP smoke test and GitHub Action.
