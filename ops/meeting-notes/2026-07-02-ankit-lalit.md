---
date: 2026-07-02
meeting: Ankit / Lalit
type: 1:1
attendees: [Lalit Maharana, Ankit]
source: zoom
meeting_uuid: 75421E37-9A6A-4D80-B091-DA4A9916C245
backfilled: 2026-07-07
---

# Ankit / Lalit — 2026-07-02

## Summary
Ankit and Lalit synced on team onboarding, current AI feature work, and upcoming technical upgrades. Focus areas: the GenAI model upgrade from Llama to Gemma, AI improvement tickets, and translation service architecture. A tokenizer blocker for the Meeting Summary feature was identified. Ankit also noted the AI training series (run by Bharat until the Bangalore meetup) is useful mainly as a refresher, especially for non-AI-team members.

## Key decisions
- GenAI model upgrade from Llama to Gemma confirmed as an active workstream; deployment and token endpoint already in progress.
- Translation service to be built as a shared AI-powered service covering templates and dynamic content across all modules and languages.
- DB prompts to be migrated (OpenAI → GenAI embedding); hardcoded prompts to be addressed.
- Work organized under two tracks: LLM Prompt improvements and AI improvements (guardrails, validations, etc.).

## Action items
- Lalit: Share translation service documentation / spike details with Ankit.
- Lalit: Proceed with Gemma upgrade deployment and monitor token endpoint metrics.
- Ankit: Resolve tokenizer blocker for Meeting Summary; sync with Lalit once unblocked.
- Ankit: Review AI improvement tickets (empty output guard, completeness truncation, length ratio validation, language match validation, guardrails).
- Ankit: Analyze the initial-launch ticket and log findings; provide ticket names/numbers to Lalit.
- Ankit: Implement the translation service in the conversion tablet setup.

## Follow-ups / open questions
- Tokenizer issue blocking the Meeting Summary feature (Ankit to resolve before proceeding).
- Gemma upgrade metrics/performance to be reviewed post-deployment.
- Translation service scope (dynamic text fields vs. notification templates) needs alignment; whether one service can handle both static template and dynamic input translation.
- Sub-story breakdown under the GenAI upgrade epic to be finalized; ownership split between prompt migration and AI improvements tracks not fully confirmed.

## Discussion notes
- Ankit joined ~1.5 years ago; discussed HRMS modules (time management, payroll, performance management) and backend architecture for summarization.
- Migration from OpenAI to GenAI models (Llama → Gemma), tokenizer issues, DB prompt migration, and preprocessing flow discussed.
- Casual exchange on locations (Ankit from Gujarat, working remotely from Bangalore; Lalit from Bhubaneswar/Odisha, in Hyderabad) and the upcoming meetup.

## Next steps
- Lalit to upgrade/deploy Gemma (Kalia), check token endpoint and metrics; migrate OpenAI → GenAI (Llama → Gemma) with full epic coverage.
