---
date: 2026-06-16
meeting: Sagar / Tejas
type: sync
attendees: [Sagar Bhat, Tejas S, Lalit Maharana]
source: zoom
meeting_uuid: 79613348-47EA-4E88-A2BF-D3235E9B5D87
backfilled: 2026-07-07
---

# Sagar / Tejas — 2026-06-16

## Summary
The team diagnosed a parsing error in the skill discovery pipeline that was blocking embedding API calls, and aligned on a plan to sync admin feature flags with graceful error handling for end users. A JSON parsing error from LLM output prevented the pipeline from reaching the embedding API stage — the embedding API was never actually being called. The broader discussion centered on the tight coupling between three interdependent admin flag levels (system admin → org admin → module-level AI) and how to surface meaningful error states to users when a module is disabled.

## Key decisions
- Skill pipeline failure root cause: JSON parsing error from LLM output prevented reaching the embedding API stage; embedding API was never being called.
- DB cleanup scope: delete from both `skill_requests` and corresponding `skills` tables using cascade, or manual deletion in sequence.
- Admin flag sync: system admin flags and AI admin flags should be kept in sync automatically on save — when a module is disabled in system admin, corresponding AI settings should auto-disable.
- Error handling approach: instead of a generic "something went wrong" for all failures, show a specific message (e.g. "your module is turned off") when the cause is an admin config flag being disabled.
- Page refresh on save: on saving admin settings, trigger a page reload to fetch latest settings; to be coordinated with the platform team.
- Goals module guard: add a flag check before data fetch calls so that if a module is not enabled, the UI shows "data not available" rather than erroring out.

## Follow-ups / open questions
- Whether the page refresh on admin save should be owned by the AI team or delegated to the platform team.
- Deeper architectural discussion needed on whether the AI settings admin page is necessary, or if AI toggles should move directly into respective module pages.
- Embedding API not logging request IDs — Sagar to verify whether request ID is captured in New Relic logs; DB logging not currently implemented for embedding API.
- 500 error on regenerate when flag is off — even after flag sync, end users with stale open tabs will still hit errors; requires graceful messaging rather than a technical fix.

## Discussion notes
Root causes identified:
- Parsing error: LLM response was not properly parsed into JSON, causing skill extraction to fail silently and the embedding API to be skipped entirely.
- Missing backend flag checks: AI features were shipped without backend flag guards due to lack of PM prioritization over 3–6 months; repeated deferrals in favor of feature releases.
- Tight coupling between admin levels: three interdependent flag levels (system admin → org admin → module-level AI) create 8 combinations, only 1 of which (all three ON) results in successful summary generation.

## Action items
- [ ] Sagar — Investigate parsing error in skill extraction; review logs for JSON response handling; verify request ID capture in embedding API New Relic logs.
- [ ] Sagar — Add improved logging to embedding API service for error tracking.
- [ ] Tejas — Add flag guard for Goals module before data fetch calls.
- [ ] Tejas — Prepare documentation of all failure states and corresponding error messages (2–3 days; currently prioritizing TechWolf).
- [ ] Tejas / Lalit — Update tickets to include error-state handling for all 7 failure combinations of the three admin flag levels.
- [ ] Lalit — Add screenshots to ticket for admin flag sync behavior to clarify expected behavior for the developer picking it up.
