---
date: 2026-07-01
meeting: Zoom Meeting
type: 1:1
attendees: [Lalit Maharana, Tejas S]
source: zoom
meeting_uuid: 22A7F82E-9B87-4333-B481-105C24A5B44A
backfilled: 2026-07-07
---

# Zoom Meeting — 2026-07-01

(1:1 between Lalit and Tejas reviewing AI-platform tickets on product/design acceptance.)

## Summary
Tejas walked Lalit through two main areas: (1) the Gemma embedding migration replacing OpenAI for skill embeddings, now deployed to internal and ready for production; and (2) writing-assistant word-limit support, including a new LLM golden dataset version and UI changes, pending design and DA acceptance.

## Key decisions
- Embedding vendor: migrated from OpenAI (text-embedding-3-large) to self-hosted Gemma (300M model) for skill embeddings; vendor selection (OpenAI or Google) is configurable per org in Generative AI Settings (vendor choice only, not model).
- Skill language expansion: embeddings now support 8 languages (English + 7 additional AI-supported languages), up from English only.
- Production release: embedding changes are ready to deploy; existing tickets will be retained to track the deployment (deadline was part of the ticket).
- Writing assistant UI: new design surfaces the rephrasing component to users while still notifying them of the word limit; the LLM response honors the word count set by the feedback template.

## Action items
- Lalit: Coordinate with Gauri for DA (design acceptance) on the new LLM golden dataset — pending 3 days.
- Lalit: Confirm production deployment of the embedding migration and close the tickets.
- Lalit: Get UI designs ready for the writing-assistant word-limit feature.
- Sagar: Automate the Rundeck pipeline (ticket already assigned) for scheduled/bi-weekly embedding job triggers.
- Okan: Follow-up ticket for the webhook spike already created.

## Follow-ups / open questions
- Rundeck pipeline automation schedule (weekly vs. bi-weekly) not yet finalized.

## Discussion notes
- Embedding workflow: two Rundeck jobs — "populate" (translates each skill into the 8 languages and stores in TalentDB/warehouse DB) and "keep in sync" (populates the secondary DB used by Talent API). Populate takes ~20-30 min per language, ~3 hours total for 7 languages. The job is run at deploy time so users access already-embedded translated skills; no wait at query time.
- New LLM Golden Dataset v1.4 created with 300 records (100 each for test/train/validation) including the word-limit attribute. Benchmark failures caused by the word-count-limit prompt were fixed.
- Legacy UI updated to show the writing-assistant component (previously hidden) with word-limit enforcement; a separate ticket exists for Haven.
- Goal quality report request from Sony: JZ already shared with Christina via a separate drive; considered done.

## Next steps
- Friday 1:1: retrospective on June and planning for upcoming delays/sprint.
