---
date: 2026-07-15
meeting: "Zoom Meeting"
type: planning
attendees: [Lalit Maharana, Manish Tomar, Abhishek Punj, Ayush Singh]
source: zoom
meeting_uuid: 911AF59A-0973-497B-9582-3AB53FEA38BB
---
# UI / search-filter scope review — 2026-07-15

## Summary
Team locked the scope of the admin/search UI for the skill-graph hackathon build: which filters ship, how results export, which views stay, and how mentor contact works from a talent profile.

## Key decisions
- Filters fixed to: skill, department, location, match-score threshold.
- CSV/table export of search results included in scope.
- Explore Graph view retained alongside the table view (not replaced by it).
- Mentor contact from a talent profile goes out as a Slack DM — no new messaging surface.
- The Claude-Design-generated HTML mockup is confirmed as the implementation basis.

## Action items
- Team: implement UI against the confirmed filter set, export, and DM-contact scope.

## Follow-ups / open questions
- Natural-language search — explicitly deferred, not in scope for this build.
- Improved match-score visualization — explicitly deferred, not in scope for this build.

## Discussion notes
- These deferrals echo the same "future improvements" noted in the 07-14 Talent Graph sync (NL search, clearer score visualization) — this call turned those into an explicit non-scope decision rather than leaving them open.

## Next steps
- Proceed to implementation against the locked filter/export/contact scope; revisit NL search and score visualization in a later phase.
