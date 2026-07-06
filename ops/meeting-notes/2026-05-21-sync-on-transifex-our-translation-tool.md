---
date: 2026-05-21
meeting: Sync on Transifex -- Our Translation tool
type: other
attendees: [Lalit Maharana, Eden Owen]
source: zoom
meeting_uuid: DD43369A-DC2F-4AB9-BDEC-3E51474D3882
backfilled: 2026-07-07
---

# Sync on Transifex -- Our Translation tool — 2026-05-21

## Summary
Knowledge-transfer session where Eden walked Lalit through Transifex, Betterworks' third-party translation tool, ahead of eventually handing off ownership to Lalit and Nellie. Betterworks translates the app (project "Haven") into 20–30+ languages via Transifex's AI translation service, paying per word (where each casing/punctuation variant counts as a separate translation, so copy is kept short and reused). Engineers wrap copy in a translation string ("T"); that gets sent to a file read by Transifex, which auto-translates within ~10 minutes. Missing a "T" means the string neither appears in Transifex nor gets translated. Eden explained custom-branding words (e.g., "goal") are handled via variables defined in a GitHub file so they aren't machine-translated; ~90% of customer support tickets are custom-word issues (a wanted custom word, or a word not translating because a variable is missing / was hard-coded over). Eden granted Lalit admin access and will walk through the next few support tickets together, cautioning that translations are critical/high-stakes.

## Key decisions
- No decision to replace Transifex with a generic LLM: it's a stable, tested system with human-validated AI (hundreds of Transifex translators), important for strict international customers (e.g., Publicis) where mistranslations/hallucinations are unacceptable.
- Ownership of Transifex to be handed to Lalit (and Nellie) over time; the next 2–3 support-ticket runs to be done together.

## Action items
- [ ] Eden — Add Lalit to Transifex as admin (done during call).
- [ ] Eden — Walk Lalit through the next few incoming support tickets to demonstrate the diagnosis workflow.

## Discussion notes
- Transifex bills per word; casing/punctuation/formatting variants are each a distinct translation, so copy is kept short and reused.
- Base/default language is English; all others are translated from it.
- Custom-branding words use variables (rendered as "pills"); the variable must stay in both the English default and each translation — never replace it with a hard-coded translation.
- PMs mostly use Transifex for research: each line is a translation string sourced from the code base. If something looks broken, it's usually an engineer not coding the translation string correctly, or a missing/overwritten variable.
- Engineers are expected to always translate and make things accessible; no need to add translation as acceptance criteria (Eden still adds accessibility AC).
- Transifex does not flag where a "T" is missing — it only sees what's sent to it.
- Historical context: a full re-translation effort earlier in the year fixed serious hard-coded errors from prior PMs (AJ, Anthony). An upcoming feature lets customers translate their own custom words, which should reduce the majority of tickets.
- Lalit and Eden realized they'd spoken before in an interview room ~5–6 months prior (December).

## Next steps
- Continue support-ticket triage together for the next few runs before full handoff.
