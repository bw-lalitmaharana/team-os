---
date: 2026-05-29
meeting: Multi-language skills
type: architecture
attendees: [Jason Sites, Jason Zhang, Sagar Bhat, Cheau-Long Ng, Kate Malcolm, Lalit Maharana]
source: zoom
meeting_uuid: D6D2AC3B-62F2-4DF3-9C5C-B51C93F484AA
backfilled: 2026-07-07
---

# Multi-language skills — 2026-05-29

## Summary
Working session on how to support multi-language (internationalized) skills across the platform, and how the AI team's skills data relates to the Talent API's source of truth. Sagar set up the meeting to discuss having AI-derived skills in the Talent DB schema. Jason Sites clarified the architecture: the old ChromaDB setup in Normalization API is being retired; skills live only under the `talent` public schema (replicated into the data warehouse via DMS), while Gemma and OpenAI embeddings per skill ID live under a separate `embedding` schema (currently English locale only). The core question is how to support additional languages, given that the upstream taxonomy vendor (Lightcast) is ingested in English only under the current free contract. Kate joined mid-way and confirmed Lightcast does not translate in the free API tier. The group aligned that any multi-language translation should be done upstream in Talent API (so it replicates downstream to the AI/data-warehouse side), and that AI-based "Betterworks translation" of skill name + description is the likely path vs. paying Lightcast (six figures) for official locales.

## Key decisions
- Retire the old ChromaDB implementation in Normalization API entirely.
- Skills remain the single source of truth under `talent` public schema; the AI side consumes a warehouse replication of that data (avoids syncing across two systems).
- Do translations/multi-language support UPSTREAM in Talent API so it flows downstream to the AI/embedding side — not just downstream in the AI layer.
- Only skill name and description need translation (taxonomy data is stored as vendor JSON with the ID at top level).
- Locale fallback: region-specific locales supported, falling back to the generic language (e.g., en-US → en) when the specific locale isn't in the DB.
- Immediate step: dump JZ's already-translated seven languages into the skill/locale tables (keyed by Lightcast ID, matched against valid IDs in Talent API), then rebuild embeddings (moving from OpenAI to self-hosted Gemma embeddings).
- Do NOT pay Lightcast for their (now ~55-locale) translations; use in-house AI translation instead — final call is a business/product decision.

## Discussion notes
- Current model support limits languages: today running on Llama with 7 languages (English, Portuguese, French, "French India"/Thai, German, etc.); moving to Gemma, which can support the ~32 platform languages.
- Lightcast: contract is English-only taxonomy; they now appear to support ~55 locales but only in paid API tiers. Kate confirmed via prior Lightcast contact (Tyler/Austin) that translations aren't in the free tier. TechWolf is English-only and very expensive (~$1–3M over three years).
- Lightcast skill names contain many proper nouns (Microsoft, AutoCAD) — translation is nuanced (descriptions largely pulled from Wikipedia).
- Talent API skill sync is significantly out of date: production is likely ~1–1.5 years behind Lightcast (Kate: they're at v9.44, ~304 skills added recently; ~2,000+ skills missing). Import code is robust (applies version deltas), but there is no periodic trigger (RunDeck-style job) in place.
- Schema limitation: the current table assumes a single taxonomy vendor (only Lightcast version tracked) — needs refactor to support multiple vendors (e.g., add a taxonomy-provider column) before TechWolf.
- On removals, Betterworks deprecates (taxonomy_status) rather than deletes; standard record status (active/archived/deleted) plus audit fields on every table.
- Lightcast IDs are stable/versioned; Betterworks wraps them with its own generated UUIDv7 primary keys, which differ across environments.
- Sagar working on version 9.22 translations; Talent API at ~9.42/9.44.

## Action items
- [ ] Sagar — Write scripts to put the translated skills into the `talent` schema; match Lightcast IDs against still-valid IDs in Talent API; regenerate translated skills afresh for the seven languages, then dump per locale + generated UUID.
- [ ] Sagar — Get the PR/script reviewed by Jason Sites before dumping in (JZ to provide OpenAI key for translation).
- [ ] Jason Sites — Review JZ/Sagar's translation code/approach; help with running Talent API (Docker) and architecture questions.
- [ ] Jason Sites & Cheau-Long (Chao) — Discuss implementing periodic (e.g., monthly) Lightcast sync and how to translate newly-ingested skills; also plan refactor of the taxonomy table to support multiple vendors (TechWolf).
- [ ] Team — Schedule a follow-up with Kate (and other talent-team members) next week to align the AI-side skills work with the talent team for a cohesive plan.

## Next steps
- Begin by dumping the existing 7-language translations into the skill/locale tables on Rainforest, then rebuild embeddings on self-hosted Gemma.
