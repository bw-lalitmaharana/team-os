---
date: 2026-06-23
meeting: Meetings AI
type: design
attendees: [Harshini Vijay, Varnika Garg, Lalit Maharana]
source: zoom
meeting_uuid: 95BEC3FA-BC62-40E0-999B-CEA13EBDCD3B
backfilled: 2026-07-07
---

# Meetings AI — 2026-06-23

## Summary
The team aligned on a unified sidebar design to house all app integrations (calendar and meetings), replacing the existing calendar-only approach. Banner logic, consent screens, and in-meeting integration flows were discussed and largely approved. A related spike on the Goals module may influence how goal creation is handled inline vs. via redirect.

## Key decisions
- Sidebar consolidation: a single sidebar houses all integrations, categorized by type (Calendar: Google/Outlook; Meetings: Zoom, future Teams).
- Banner logic: banner disappears dynamically — once at least one app per category (calendar OR meetings) is connected, that category's banner is suppressed; not tied to a single app.
- Redundant banner removed: the duplicate nudge banner on the right side of the meeting screen will be removed; one banner is sufficient.
- In-meeting banner retained: the connect-apps banner stays inside individual meeting views to catch users who missed it on the main page, with potential removal after adoption matures.
- Zoom auth flow: Zoom connection uses an internal consent screen first, then redirects to Zoom's admin-level authorization page; no user-level OAuth flow.
- Icon scaling: current multi-icon display is acceptable for now (up to ~4-5 apps); truncation (e.g., "+2") to be addressed when app count grows.

## Action items
- [ ] Harshini — Update Figma designs: tweak Zoom flows, add Google Calendar current designs to sidebar, remove redundant right-side banner
- [ ] Harshini — Share updated designs with the team once tweaks are complete
- [ ] Harshini — Grant edit access in Figma for HTML export (completed during call)
- [ ] Lalit/Harshini — Discuss new sidebar approach with devs in tomorrow's scrum
- [ ] Varnika — Check with Anuj on consent screen requirement for Google Calendar and prior consent-related questions
- [ ] Varnika — Update team after dev spike on Goals inline creation concludes

## Follow-ups / open questions
- Whether a consent screen should be added before Google Calendar authorization (for consistency with Zoom flow and to address prior legal/policy questions) — to be checked with Anuj.
- Goals inline creation vs. redirect: dev spike in progress; outcome determines whether goal creation opens in a sidebar/drawer within the module or redirects to the Goals module.
- Exact text/copy for the "connect apps" banner and consent screens — current language is liked but needs a formal review.

## Discussion notes
- Varnika shared an update from a meeting with Nataliia: PDP (Personalized Development Plans) from Talent Profile has a similar goal-creation flow. Nataliia prefers not redirecting users to the goals module but creating/editing goals from a sidebar/drawer within the module. A spike ticket for Goals will be picked up next sprint to assess feasibility; if reusable within timeline scope, this pattern would be adopted, otherwise redirect to goals module. Anuj is lead for goals and meetings-goals and has been briefed.
- HTML export: designs can be exported as standalone HTML (individual files) via the share/three-dots options; edit access needed for the option to appear.

## Next steps
- Walk developers through the approach in tomorrow's scrum; existing Google flow may change to the new sidebar.
