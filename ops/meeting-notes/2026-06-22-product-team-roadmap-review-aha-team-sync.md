---
date: 2026-06-22
meeting: Product Team Roadmap Review Aha - Team Sync
type: review
attendees: [Eden Owen, Nellie LeMonier, Varnika Garg, Arnav Garg, Neeraj Mohan, Paul Agustin, Rinku, Sharan, Nataliia Savenko, Nataliya Kolb, Viktoriia Bondareva]
source: zoom
meeting_uuid: 95917360977
backfilled: 2026-07-07
---

# Product Team Roadmap Review Aha - Team Sync — 2026-06-22

## Summary
The team reviewed all features targeting a June 30th release, confirmed shipping status, and identified outstanding documentation and feature flag gaps. Most items are on track; a few remain in QA or late development but are expected to close by month-end. A hard deadline of Wednesday the 24th was set for all enablement documentation to support the CS team's PowerPoint update.

## Key decisions
- POC AWS QuickSight Amazon Q marked as not for customer sharing; removed from customer-facing list.
- Ability to hide prior feedback marked as shipped (dated the 20th, aligned with analytics team).
- BullMQ (infrastructure change): dev complete, dated June 30th; will not be shared with customers pending Sudin's confirmation.
- GitHub Next Gen Migration added to the official June release list; on track.
- July and August items deferred — too early to assign accurate dates.

## Action items
- [ ] Varnika — Confirm and update feature flag + enablement docs for goal weights and range goals (due Wed June 24)
- [ ] Arnav — Add feature flag for QuickSight print/save before shipping
- [ ] Sharan — Add all feature flags for NextGen Reports Field Parity
- [ ] Neeraj — Add enablement doc and feature flag for Display ratings; update dependency note for hide prior feedback; align with Sudin on BullMQ details
- [ ] Paul — Confirm performance snapshot status with Pankaj; update enablement doc for conversation answer API
- [ ] Rinku — Move HRIS integration doc from Google Doc to Confluence (template in product channel); complete Azure DevOps doc + feature flag
- [ ] Nataliia — Confirm feature flag and final delivery status for Position Management V1 with Kate/team
- [ ] All owners — Enablement documentation due by Wed June 24 (Eden's morning) for CS PowerPoint update

## Follow-ups / open questions
- Position Management V1 — a few design acceptance tickets remain; feature flag ownership unclear (Nataliia/Kate to confirm).
- Performance Snapshot — status unclear, possibly shipping this week (Paul to confirm with Pankaj).
- Expose conversation answer API endpoint — one ticket in code review; Paul to verify Rainforest status with Sudin.
- Goal weights & range goals (Varnika): in QA, expected by June 30; will notify 1-2 days early if bugs delay.
- Enable print/save of QuickSight dashboard: dev complete, releasing to Publicis and Synopsys first; feature flag to be added.
- NextGen Reports Field Parity with Legacy: dev complete; multiple feature flags to be listed.
- IS HR Admin a default attribute in group creation (Nellie): in QA, dependent on core ship date June 30.
- Display ratings (Neeraj): one ticket in code review; enablement doc and flag to be added.
- Branching questions and conversation templates (Paul/Neeraj): in development, expected done this week; flag to be added by Neeraj.
- BullMQ: Neeraj to discuss with Sudin before finalizing enablement doc and customer-share decision.

## Discussion notes
Shipped items confirmed: Bulk export PDFs for conversations (no flag; AMC/NextGen API auto-routing); Hide feedback content for HR admin (flag + docs in place); Talent profile AI capabilities / Performance Summary redesign (~June 2); Ability to upload files to a conversation; Bulk delete conversation CSV upload; Notification when file loads (HRIS integration; no flag); Azure DevOps integration (recently shipped, docs in progress).

## Next steps
- Eden to follow up Wednesday on outstanding documentation and with Paul on performance snapshot.
- Next release review call to be scheduled closer to end of July for July/August items.
