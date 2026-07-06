---
date: 2026-06-02
meeting: Sagar / Lalit - General Catchup
type: catchup
attendees: [Lalit Maharana, Sagar Bhat]
source: zoom
meeting_uuid: 85141A8F-EC10-42F2-8E7D-FDD34DE46EC1
backfilled: 2026-07-07
---

# Sagar / Lalit - General Catchup — 2026-06-02

## Summary
Lalit and Sagar discussed priorities for AI feature development, focusing on establishing the data-pipeline foundation for meeting-transcript processing. They reviewed existing tasks — migrating OpenAI to Gemma embedding service, prompt versioning, and the meeting-transcription system — and Sagar's current workload (skills translation to other languages, prompt management). They agreed to prioritize the meeting-transcription pipeline as the foundation, with Lalit co-owning the AI pod alongside Nellie. Plan to connect with JZ later that evening on architecture/priorities and coordinate with Hemant and Bhavesh for implementation.

## Key decisions
- Prioritize the meeting-transcript pipeline as the foundation for the week (data flow, storage structure, retrieval for AI summarization).
- Lalit and Sagar to co-own the AI pod; Lalit leads AI tasks while coordinating with Nellie and JZ.
- Similarity search: use Postgres with cosine similarity for now (embeddings may improve some edge cases but are a later step).
- Prompt/meta-prompt storage: lean toward saving in DB for easier versioning and testing; org-specific custom prompts would go in a separate org-settings table (future); confirm meta-prompt approach with JZ.
- Hemant and Bhavesh available to support implementation.

## Discussion notes
- Sagar's plate: ~18 tasks across platform work, pod-specific integrations, and AI meeting transcripts; skills translation to other languages is a priority (needs JZ to rank vs. transcript work).
- AI skills multilingual: converting AI skills from English to other languages, saving under the talent schema.
- Embedding API isolation: normalization and embedding services were coupled; testing/deploy pending.
- Lightcast taxonomy language support ticket to start in parallel.
- AWS MEAP env-level JSON as a safeguard; Phase 1 done (OpenAI/Mistral), Phase 2 (Meta) not fully implemented; uncertainty whether LLM proxy is still needed. TechWolf integration and translation touched on.
- Plan to connect with JZ in the evening (or share doc async) and reconnect with Hemant/Bhavesh in the second half to walk through the pipeline and extension for other modules.

## Action items
- [ ] Lalit — Check with Bhavesh regarding pre-processing of AI features.
- [ ] Sagar — Prioritize between transcript-pipeline work and the OpenAI → embedding-Gemma migration; confirm with JZ if needed.
- [ ] Sagar — Prepare a rough sketch/diagram of the meeting-transcript pipeline architecture and share with JZ for review.
- [ ] Sagar — Set up a call with Hemant and Bhavesh in the second half to walk through the pipeline and extension for other modules.
- [ ] Sagar — Share a list of questions with JZ on prompt management and meta prompts (incl. whether to save meta prompts in DB or use directly with Gemma).
- [ ] Sagar — Complete testing and deployment of the embedding-API isolation work.
- [ ] Sagar — Start the Lightcast taxonomy language-support ticket in parallel.
- [ ] Sagar — Review and close / comment on open tickets created by JZ.

## Next steps
- Connect with JZ in the evening to discuss the plan (or share the doc async); reconnect with the team in the second half to walk through the pipeline; share follow-up questions with Lalit.
