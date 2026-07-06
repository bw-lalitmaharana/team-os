---
date: 2026-05-21
meeting: Custom roles permissions
type: 1:1
attendees: [Lalit Maharana, Sweta]
source: zoom
meeting_uuid: B83C1F35-4B4F-4438-9DEA-DB8120BD0D4D
backfilled: 2026-07-07
---

# Custom roles permissions — 2026-05-21

## Summary
An introductory + technical session where Sweta walked Lalit through Betterworks' permission and role-management system. Sweta explained how organizations, users, and roles work, including the differences between Super Admin, HR Admin, Admin, and Manager roles, and how access to modules/screens depends on both the user's role and departmental permissions configured in the system admin panel. She covered the recent removal of custom role-creation (CRUD) functionality — replaced with impersonation features as part of recent simplifications — and the current state of the policy engine. Sweta recommended Lalit connect with Raghu and Ellie (Customer Success) for role-permission documentation and review the policy engine repository to understand the system structure. (Also brief intro chat: both are in Hyderabad; Lalit joined ~2 weeks ago, working in App and AI pods; Sweta ~4 years at Betterworks.)

## Key decisions
- Custom CRUD operations for roles have been removed and replaced with impersonation features (recent simplification).

## Action items
- [ ] Lalit — Review the provided documentation and policy engine repository; use AI to summarize/explain the policy engine structure and policies.
- [ ] Lalit — Reach out to Raghu (CS) for documentation on accesses/permissions given to different roles (as documented for client-facing purposes).
- [ ] Lalit — Connect with pod-specific PMs to understand pod-level manager and skip-level manager permissions and current implementation.
- [ ] Sweta — Send Lalit the policy engine repository link.

## Discussion notes
- Users are created with different privilege levels: Super Admin, HR Admin, Admin, None. Access to modules/screens depends on both the user's role and departmental permissions in the system admin panel.
- Sweta demonstrated access via impersonation and covered creating custom fields, groups, and roles.
- Manager permissions are largely hard-coded (managers can see reportees' goals and conversations) but can be restricted via manager or skip-level-manager roles.
- To understand current state across pods, check with CS (general docs) and individual pod managers (specifics).
- Recommended contacts: Raghu (UK/CS) and Ellie for further documentation.

## Next steps
- Lalit to study the policy engine repo and gather role/permission documentation from CS and pod PMs.
