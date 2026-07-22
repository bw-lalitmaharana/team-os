---
date: 2026-07-21
meeting: Sync on Pre-processing Performance & Feedback Summaries
type: sync
attendees: [Nellie LeMonier, Bhavesh Vaviya, Lalit Maharana, Tejas S, Jason Zhang]
source: zoom
meeting_uuid: 70A6DFDA-2186-4B31-BB98-E68BCB02E5EB
---
# Sync on Pre-processing Performance & Feedback Summaries — 2026-07-21

## Summary
The meeting focused on refining tickets and planning for the summer release, particularly around pre-processing and fiscal year handling. Nellie, Bhavesh, Lalit, Tejas, and Jason discussed whether to implement retries for input above word limits, ultimately deciding to improve accuracy and provide user feedback instead. They talked about how fiscal year transitions affect data buckets and filters, considering both automatic and manual rollover options. The team also reviewed issues with conversation data fetching, where incorrect filters caused inaccurate performance summaries and goal assist data, and discussed a fix involving clearing old records and repopulating with correct data. Additionally, they considered simplifying skill recommendation filters and ensuring pre-processing aligns with fiscal year changes.

## Key decisions
- Drop retry logic for inputs above the word limit; instead improve accuracy/quality when input exceeds the limit by up to 50%, and notify the user rather than retrying.
- One-on-one pre-processing/summary stays available as long as admin settings are off; new pre-processing features like "prep recap" are postponed to winter.
- Fiscal year handling: pursue automatic FY conversion for data buckets with an optional manual-override/close feature, scoped to the specific features implementing it (not platform-wide).
- Conversations API bug (owner-ID/peer-ID filters pulling incorrect manager-reportee data into Performance Summary and Goal Assist): fix via a new ticket that deletes affected prior-fiscal-year records and lets pre-processing repopulate correct data going forward.
- Consider dropping skill filters from recommendation search in favor of a pre-processed bucket approach (up to ~180 days) to reduce processing load.

## Action items
- **Bhavesh:** Implement the change to not retry and instead improve quality/accuracy above the word limit; coordinate with Lalit on the UI notification.
- **Bhavesh:** Investigate the current implementation of fiscal year handling in pre-processing and provide feedback by tomorrow.
- **Lalit:** Massage the wording for the message shown when input is above 50% of the word limit and update the acceptance criteria accordingly.
- **Nellie:** Write up user stories for fiscal year transition handling and date-range filters for the summer release.
- **Tejas:** Research and gather customer-reported bugs/issues related to fiscal year and pre-processing; send the list to Nellie.
- **Tejas:** Create a new ticket to track clearing previous-fiscal-year data from the database for Performance Summary and Goal Assist; comment on it by tomorrow.
- **Bhavesh & Tejas:** Connect tomorrow to discuss the approach for clearing previous fiscal-year data and repopulating via pre-processing.

## Follow-ups / open questions
- Final bucket size for the pre-processed date-range approach (up to 180 days) not yet decided.
- Whether the fiscal-year manual-close functionality should extend beyond the specific features currently in scope.

## Discussion notes
- Nellie discussed the summer release roadmap and sought clarification on one-on-one pre-processing features; Lalit explained current behavior stays as-is while admin settings are off, with prep recap and similar features postponed to winter.
- Nellie proposed automatic FY conversion with optional manual override so orgs can keep data in the current FY bucket when needed; Tejas clarified the manual-close functionality would only affect specific features implementing it, not the whole Betterworks platform.
- Bhavesh and Nellie discussed how FY changes affect data ranges across Betterworks — org settings define quarterly/annual filter periods, but the system doesn't auto-update ranges when a new fiscal year begins; Bhavesh suggested fixing the root cause in one place rather than many, but Nellie noted the current system only defines when fiscal years end, not when new ones start.
- Nellie and Bhavesh discussed the toggle-based filter system possibly being too resource-intensive for large datasets, favoring a pre-processed bucket approach instead.
- Nellie and Bhavesh confirmed they are not currently pre-processing for this use case but would need to if the time-period bucket changes; Tejas will compile existing bugs/customer issues so Nellie can group them under a single epic.
- Tejas explained the conversations-API bug in detail: both owner-ID and peer-ID filters were causing performance summary and goal assist data to include incorrect manager-reportee conversations.

## Next steps
- Bhavesh and Tejas to sync tomorrow on the fiscal-year data clearing/repopulation approach.
- Nellie to write up fiscal-year/date-range user stories.
- Tejas to file the new conversations-API fix ticket and share the customer-bug list with Nellie for epic grouping.
