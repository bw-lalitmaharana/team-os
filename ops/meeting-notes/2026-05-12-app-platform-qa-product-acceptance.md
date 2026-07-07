---
date: 2026-05-12
meeting: App Platform QA & Product Acceptance
type: review
attendees: [Lalit Maharana, Nellie LeMonier, Sanchit Kanwar]
source: zoom
meeting_uuid: DB6FD850-7EAD-4485-89EF-BC928CD6401B
backfilled: 2026-07-07
---

# App Platform QA & Product Acceptance — 2026-05-12

## Summary
A product acceptance review where Sanchit and Lalit went through tickets with Nellie. They reviewed user impersonation, matrix manager settings, API token management, and UI issues with module names. Sanchit demonstrated file upload and API token operations and identified a file-type validation bug (unsupported formats rejected silently with no error message). A pending ticket requires Okta admin access for Skim testing, to be handled when Emerson/Swetha return. The team agreed to raise a new ticket for the file-validation issue.

Key discussion threads:
- **Intro:** Sanchit (~2 years at Betterworks; integration, meetings/goals, now app platform/UI) and Lalit introduced themselves. Nellie explained the product acceptance / QA review flow.
- **Okta QA:** Requirements/tickets unclear; not urgent, can wait for Emerson's return.
- **Validation / loading:** Validation successful; a streaming feature added; the system now loads all 50 items (previously showed only 20).
- **User impersonation:** Once a user has impersonated another, the option to impersonate again is removed; feature lives under user management when not currently impersonating. Open question whether the Matrix Manager role is hard-coded (Sanchit unsure).
- **Report testing:** Tested report approved by Jason; can move forward. File upload/processing ~1 minute.
- **API tokens:** Walked through generating, copying, and using API tokens for data access; hit some token-format issues. No explicit expiry shown in UI (possible 12-hour backend cutoff). Lalit took over as Nellie left for another call.
- **Ticket status:** Module names CRUD and system user fixes marked done. UI stories flagged for file-type validation and navigation problems (PDF uploads not properly restricted → raise ticket). User-provisioning tickets moved back to QA pending Swetha's return (Mon/Tue) for Okta admin access.

## Action items
- Nellie: Forward the relevant Slack thread about Skim subdomain / Okta access to Sanchit and Lalit.
- Sanchit: Get KT from Emerson (or relevant team member) on the Skim user-provisioning epic and testing instructions once Emerson/Sridhar/Swetha return (targeted Mon/Tue).
- Sanchit: Test the Skim user-provisioning tickets once access/instructions are available; move tickets to appropriate status if QA passes; coordinate with Swetha on return.
- Sanchit: Connect with Victor today on the UI issue (highlight/underline on back navigation); raise a ticket if confirmed.
- Sanchit: Manually verify the file-type validation bug (silent rejection, no error message); raise a ticket if confirmed.
- Sanchit: Discuss with Swetha (Mon/Tue) next steps for testing the Skim epic tickets.

## Follow-ups / open questions
- Is the Matrix Manager role hard-coded?
- Confirm API token expiry behavior (possible 12-hour backend cutoff not surfaced in UI).
