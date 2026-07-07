---
date: 2026-05-18
meeting: App Platform - Sprint Planning
type: planning
attendees: [Jason Bilyeu, Nellie LeMonier, Victor Chen, Eden Owen, Aleksandr Riazanov]
source: zoom
meeting_uuid: 5A2359D4-E83E-40B2-B372-B5087768C346
backfilled: 2026-07-07
---

# App Platform - Sprint Planning — 2026-05-18

## Summary
App platform sprint planning (Sprint 286). The team triaged in-progress and carry-over work, groomed a logo-deletion AC, discussed a branded-URL / SSO edge case for password-only users, and pulled monthly-ops and fuzzy-search tickets into the sprint. (No AI summary or notes were captured for this instance; the following is drawn from the meeting transcript.)

Key discussion threads:
- **Logo deletion behavior:** Debated the confusing UX of showing a default logo after a user deletes their logo. Agreed to rename the action to "restore to default" (still delete-then-save under the hood; deleting the override logo resets the level to default).
- **Carry-over / QA backlog:** ~40-45 points carrying over, much of it stuck in QA for a while. Reviewed in-progress items across Victor and Alex; several stale tickets closed (e.g., an item marked "good to close" back on April 23; a completed SAML token update). Reminder to mark abandoned tickets as "never" since product tracks those metrics with CS.
- **Release tagging hygiene:** Eden and Nellie pushed back on engineers tagging tickets "N/A" for release version — it makes release notes very hard. Asked the team to put actual release versions or use the official "Release not required" tag; Eden may send another notice to engineering.
- **Story 2 / Story 4:** Victor confirmed these can move to production acceptance after QA-env testing (a power ticket moved to the UI team; StoryForce power ticket completed).
- **Branded URL + password users (SSO edge case):** For orgs with mixed login types (e.g., Sony ~5%, Publicis ~3% password-only), password users can't use the branded URL but their password-reset email link would point there. JB unsure it works; likely broken for that population. Decided a testing ticket plus a follow-up story is needed; prefer to wait for Emerson's return to look at it. Nellie and Eden may test it themselves rather than wait on the QA backlog.
- **Custom content notification epic:** Hung did some work but something isn't functioning on Rainforest (possibly an event-processor issue, not UI). Victor to investigate and post to Slack; ticket left "Ready for QA"; a QA/DA ticket held until the fix lands.
- **Sprint fill:** Moved monthly-ops review tickets and the "add AND/OR support to fuzzy search" ticket into Sprint 286 (relevant since Brian is about to work on search across the app). JB took the monthly-ops tickets. Expect to pull in more mid-sprint (Kanban-style).

## Key decisions
- Rename logo "delete" to "restore to default" (delete override logo on save → level resets to default).
- Enforce release-version tagging: use real versions or the official "Release not required" tag, not "N/A".
- Move Story 2 and Story 4 to production acceptance.
- Wait for Emerson's return to address the branded-URL / password-user SSO issue.
- Pull monthly-ops and fuzzy-search tickets into Sprint 286.

## Action items
- Victor: Investigate the custom-content notification issue on Rainforest (suspected event-processor), post findings to Slack; take Story 2 / Story 4 to production acceptance.
- Victor: Fix release tags from history (uppercase "Release not required") for accurate tagging.
- Nellie & Eden: Test the branded-URL password-reset flow for password-only users; create a follow-up story to handle it properly.
- Eden: Possibly send another notice to all of engineering about release-version tagging.
- JB: Own the monthly-ops review tickets pulled into the sprint.

## Follow-ups / open questions
- Does the branded-URL password-reset email flow work for password-only users in mixed-login orgs? (Suspected broken; needs testing, ideally with Emerson.)
- Root cause of the custom-content notification failure on Rainforest.
