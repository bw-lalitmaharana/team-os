---
date: 2026-07-13
meeting: "LMS Integrations Sync: Default Provider for AI Recommendations"
type: sync
attendees: [Nataliya Kolb, Nellie LeMonier, Nataliia Savenko, Jason Zhang]
source: zoom
meeting_uuid: 4CD8C203-E419-45B7-8E95-8A4F1557D2A9
---
# LMS Integrations Sync: Default Provider for AI Recommendations — 2026-07-13

## Summary
The team revisited which LMS should be the default provider for AI course recommendations. Docebo was the original assumption, but research surfaced that neither Docebo nor Udemy cleanly supports pulling individual courses/catalogs via API. Jason Zhang shared his research findings; the group agreed the right first step is building an API-capability matrix for Docebo vs. Udemy before locking a default, and discussed two additional product use cases (private/internal course catalogs, and internal-courses-as-a-competitive-offering) to fold into that evaluation.

## Key decisions
- Build an API-capability matrix (courses, categories, internal-vs-external metadata) comparing Docebo and Udemy before committing to a default LMS provider — no provider decision made yet.
- Lalit to drive the matrix, working with the India AI team (Nitish and others) on the API-capacity research.
- Rinku to be looped in given the cross-team (Integrations) surface area of this work.
- Target: alignment on provider + capabilities by **July 24** (Nataliya cited ~1.5 months to GA as the driver for urgency).
- Frontend/interface work that doesn't depend on the backend provider decision should proceed in parallel rather than wait on the matrix (Jason Zhang's suggestion, agreed by Nataliya).

## Action items
- Lalit (with India AI team): build the Docebo vs. Udemy API-capability matrix.
- Nataliia Savenko: send meeting notes to Rinku and the wider team stating the ask, and schedule review placeholders for when the India team is available.
- India team (Nitish + others): confirm per-vendor API capacity for pulling individual courses/categories, and whether previously-used Udemy sync APIs are still available (earlier answer suggested they are not).

## Follow-ups / open questions
- Can Docebo and/or Udemy actually support pulling in individual courses and catalogs via API? (Conflicting signals — prior integration existed with Udemy but current API access appears unavailable.)
- Would the recommendation workflow support internal/private courses (e.g. an org's own Docebo-hosted leadership courses) the same way it supports external catalog content? Nataliya wants this tested once the AI team engages.
- Should Betterworks position "bring your own LMS" more broadly (Udemy as marketplace option, Docebo for orgs with their own internal course content) as a competitive differentiator?

## Discussion notes
- Original design assumed the whole recommendation pipeline depends on being able to ingest all courses into an embedding-based semantic search — if courses can't be pulled from either vendor at scale, that assumption breaks and the design needs revisiting.
- Jason Zhang recommended building the API-capability matrix first, then approaching whichever vendor(s) have gaps to ask directly about support, rather than guessing.
- Nataliya raised a specific use case from a past client conversation (possibly HelloFresh, unconfirmed) wanting to integrate their own internal/company courses (e.g. org-specific leadership training) into personalized development plans — distinct from marketplace-style Udemy content.
- The existing integration is with Docebo; Udemy integration would need to be newly evaluated.

## Next steps
- Lalit and India AI team build the capability matrix; Nataliia sends the ask to Rinku/wider team; alignment target July 24.
