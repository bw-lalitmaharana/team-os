---
date: 2026-08-13
meeting: PDP Stand Up
type: sync
attendees: [Nataliia Savenko, Rinku, Harikrishnan S, Pankaj Lohmor, Sanchit Kanwar, Saurabh Pandey]
source: zoom
meeting_uuid: 8F7C50BC-1027-4BAC-BA71-E51CB7EE97A3
---
# PDP Stand Up — 2026-08-13

## Summary
The team held a QA/status meeting to discuss progress on development tickets and address technical implementation questions. Harikrishnan reported 90% completion on the Kill Data Spanner ticket; Pankaj raised a PR for manual goal creation and addressed bugs raised by Ari. Saurabh gave updates on front-end changes for PDP goal flows and pending permission-related logic. Nataliia and Saurabh had an extended discussion about permission requirements and ownership settings for skill-centered goals, including the impersonation-mode feature. The team also discussed privacy settings, goal-completion notifications, and the need for further product decisions on certain features before implementation can be completed.

## Key decisions
- Keep PDP goals editable and allow ownership changes (pending confirmation with Himanshu on impersonation-mode behavior).
- Categories and types fields default to null values initially; users populate them during the edit flow.
- Add hyperlinks in both the goals UI and email notifications directing users to update skill levels when a goal is completed.
- No technical blockers from the tech side on the discussed features; implementation of smaller updates proceeds while final decisions on broader changes (privacy config) are pending.

## Action items
- **Harikrishnan:** Complete remaining design checks and wrap up the Kill Data Spanner ticket today.
- **Nataliia:** Review bugs and product/design acceptance with Anastasia in an hour, leave comments in tickets; ask Varnika to share info on existing goal-completion notification emails.
- **Pankaj:** Ask Farooq to review the PR for manual goal creation; ask Saurabh to review PRs for bugs raised by Ari; send a separate meeting invite to discuss the feature toggle/flag with Jason.
- **Saurabh:** Raise a PR for front-end changes on scope misalignment of child goals (with tests); pick up the RT ticket (old description field) next Monday; add Pankaj to the feature-toggle call; confirm with Himanshu (Talent team) on the impersonation-mode workflow for PDP goals; add a privacy column to the existing sheet for developmental goals; merge PRs for scope placement, goal creation with developmental scope, and non-PDP goals flow by Monday; share screenshots of existing goal-completion notification emails with Nataliia; move the two in-progress tickets (goal-form layout, standardized scope field) to code review today.

## Follow-ups / open questions
- Final confirmation from Varnika and Nataliia on privacy-configuration requirements before implementation proceeds — Saurabh is uncertain of the specific privacy options intended.
- Jason has reservations about the current feature-toggle/flag implementation approach in the Talent API — separate call planned to resolve.
- Confirmation from Himanshu on the impersonation-mode workflow for PDP goals still pending.

## Discussion notes
- Pankaj noted Nitish is on leave, so Farooq will review the manual-goal-creation PR instead.
- Team briefly mentioned a previous call with the Bolts team; no further detail discussed.
- Saurabh: only one remaining ticket to implement after the permission-related issues, plus a pending spike on PDP goal creation when the goals module is disabled.
- Pankaj and Saurabh requested to join a meeting about aspiration notes and PDPNet's future plans — Nataliia agreed; Pankaj to send a separate invite.
- Nataliia noted US-based team members would be available over the weekend if issues arise; work expected complete by Monday.
- Current email notifications are primarily check-in reminders, not goal-completion notifications — Saurabh will check the codebase and share screenshots of existing notifications.

## Next steps
- Saurabh to merge scope-placement / developmental-scope / non-PDP-goals-flow PRs by Monday, pending Pankaj's approval.
- Pankaj to schedule the feature-toggle discussion call with Jason.
- Saurabh to confirm impersonation-mode behavior with Himanshu, and follow up with Nataliia on privacy-column and notification-screenshot asks.
