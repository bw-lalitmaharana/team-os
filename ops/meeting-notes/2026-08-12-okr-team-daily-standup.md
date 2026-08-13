---
date: 2026-08-12
meeting: OKR Team - Daily Standup
type: sync
attendees: [Hung Truong, Abhishek Punj, Aleksandr Riazanov, Victor Chen, Nellie LeMonier, Jason Bilyeu, Eden Owen, Lalit Maharana]
source: zoom
meeting_uuid: 45912EB3-A271-411B-9C34-83AA66C130BE
---
# OKR Team - Daily Standup — 2026-08-12

## Summary
The standup covered three main areas: Victor's pending PRs for custom roles and authorization, Hung's ongoing SAML debugging across multiple tickets, and a decision to fix a long-standing timezone-update bug scoped specifically to impersonation scenarios. A fix for the timezone issue was agreed and can be implemented quickly. A conference call with a customer is planned to diagnose SAML configuration issues directly.

## Key decisions
- **Timezone bug fix (85092):** Only fix the impersonation scenario — do not update a user's blank timezone when an impersonator is logged in; retain existing behavior for regular user self-login.
- **Manager display-name sync:** Treat manager fields as read-only during user sync; manager-record updates should come in via their own user update, not as a side effect of another user's update.
- **SAML customer call:** Proceed with a live conference call with the customer (Spartanburg) rather than continuing async troubleshooting; use a SAML Chrome extension to collect XML/JSON for diagnosis.
- **Cache version bump required:** Any contract change to the `call` repository requires bumping the cache version so the authorization service picks up the correct version.

## Action items
- Victor: awaiting review on PRs for custom-roles support (PR40 air business areas) across the authorization and Haven admin UI repositories.
- Abhishek: moved bug ticket 85045 to product acceptance.
- Hung: performed on-demand provisioning tests for ticket 84262, surfacing two issues (manager field handling; asymmetric PATCH/POST data shape in the SCIM implementation) — to continue debugging.
- Aleksandr: fix in progress for the integration-test CI issue (see blockers).

## Follow-ups / open questions
- Whether the manager-field/SCIM PATCH-vs-POST data-shape issue (ticket 84262) needs a broader fix beyond the immediate provisioning test.

## Discussion notes
- Integration test CI issue: the transition service loads policies from `main` branch instead of the current branch during CI runs — fix in progress (Aleksandr).
- Schema migration for custom business entities needs review (owner not fully specified in this segment).
- SAML debugging has spanned multiple tickets; moving to a live customer call is intended to accelerate diagnosis versus continued async back-and-forth.

## Next steps
- Live SAML conference call with the Spartanburg customer, using the SAML Chrome extension to collect diagnostic data.
- Victor's custom-roles/authorization PRs to go through review.
- Aleksandr to land the CI policy-loading fix.
