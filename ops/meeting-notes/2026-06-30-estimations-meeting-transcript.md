---
date: 2026-06-30
meeting: Estimations | Meeting Transcript
type: planning
attendees: [Anuj Pancholi, Danish Sharma, Hemant Kumar, Hiten Khuman, Lalit Maharana, Sagar Bhat, Tanveer Farooq]
source: zoom
meeting_uuid: 2B037EA4-56C3-477C-942A-0C8240FA88AC
backfilled: 2026-07-07
---

# Estimations | Meeting Transcript — 2026-06-30

## Summary
The team reviewed task statuses and estimated timelines for the Zoom integration and AI-powered meeting prep feature, targeting development completion by ~August 10. Work spans three areas: Meetings service (Anuj/Hiten), Webhook Gateway/Auth Proxy (Danish), and LLM Engine/AI Ingestion (Sagar/Hemant). No major blockers were identified that would threaten the August release, though several tasks carry inter-team dependencies.

## Key decisions
- EDA listener + Auth Proxy OAuth events: merge the Zoom configuration task into the existing listener task; estimated 2 days.
- Transcript fetching + validation/reconciliation: include speaker reconciliation and edge-case handling in the same task; estimated 3 days starting July 1.
- Webhook Gateway: not a hard blocker — Danish will share standardized event schema within 1-2 days so Anuj can write consumption logic independently.
- Response format (Markdown vs. JSON): explore content-type header approach (client specifies format); JSON remains default to avoid AI-generated markdown rendering inconsistencies.
- Recap refresh: individual per-instance refresh (not unified), with manual refresh supported; old recaps may go stale but users control updates.
- Existing meeting summary: both old summary and new recap/prep will coexist; new feature gated by org-level enablement flag; deprecation deferred post-release.
- Email/push notification for transcript processing: kept as a task but will not block release; requires a spike on LLM Engine notification infrastructure.

## Action items
- [ ] Lalit — Share finalized recap/prep key fields (data points) to unblock Sagar's prompt engineering — today if possible
- [ ] Anuj — Contact Emerson for Terraform/S3 bucket setup guidance
- [ ] Anuj + Hiten — Finalize DB schema for EDA event storage — today
- [ ] All teams — Map Jira stories to planning sheet; flag missing coverage by tomorrow's scrum
- [ ] Tanveer — Confirm QA resource assignment
- [ ] Danish — Share standardized event schema with Anuj within 1-2 days
- [ ] Sagar + Lalit — Review recap key fields offline immediately after the call

## Follow-ups / open questions
- Hiten's frontend tasks: estimates deferred; Anuj to pair with Hiten; sync scheduled for tomorrow morning.
- Org-level feature flag storage location (Meetings DB vs. Core DB): engineering decision pending.
- Jira story mapping: each team to map existing stories to the planning sheet and flag gaps by tomorrow's scrum.
- QA ownership: Tanveer to confirm dedicated QA; builders own quality first, with a secondary review round post-dev.
- Notification/email spike: assigned after all primary tasks complete.

## Discussion notes
- Completed: Auth Proxy Zoom OAuth handler PR merged to main; Zoom Meeting ID -> Series mapping in code review (effectively ready); EDA listener (one event) working locally, second event pending Danish's publish.
- Blockers: recap/prep key fields not finalized (Lalit to share breakdown); Meetings S3 bucket missing (Anuj to consult Emerson); DB schema for EDA event storage (Anuj + Hiten to finalize today).

Task timeline summary:

| Task | Owner | Est. | Start |
|------|-------|------|-------|
| EDA listener + OAuth events | Hiten | 2 days | July 1 |
| Transcript fetch + reconciliation | Anuj | 3 days | July 1 |
| Zoom entity mapping (transcript->series/instance) | Anuj | 1 day | After above |
| Webhook Gateway service | Danish | ~9 days | In progress (target ~July 10) |
| Publish integration-toggled event (Auth Proxy) | Danish | 1 day | In progress |
| Process transcript + read from S3 | Hemant | 2 days | July 1 |
| Generate recap/prep | Sagar | 2 days | July 2 |
| Pull goals data | Hemant | 1 day | July 3 |
| Pull call center/other data | Sagar | 2-3 days | July 6 |
| Reconciliation logic | Sagar | 2 days | ~July 10 |
| Refresh logic | Sagar | 2-3 days | After July 20 |
| GET APIs (recap, prep) | Hemant | 2 days | ~July 6 |
| GET Recommendations API | Sagar | 2 days | TBD |
| Update recommendation status API | Hemant/Sagar | TBD | After July 20 |

## Next steps
- Finalize recap/prep key fields and DB schema today; map Jira stories by tomorrow's scrum; target dev completion ~August 10.
