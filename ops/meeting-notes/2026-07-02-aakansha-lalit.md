---
date: 2026-07-02
meeting: Aakansha / Lalit
type: 1:1
attendees: [Lalit Maharana, Aakansha]
source: zoom
meeting_uuid: D4EBC860-73B8-48AF-916E-C91F79F7788A
backfilled: 2026-07-07
---

# Aakansha / Lalit — 2026-07-02

## Summary
Project status 1:1. June was hectic but productive, with the hackathon as the standout highlight. Work progressed smoothly with no major blockers, though a tokenizer-related architectural decision caused rework. July planning covers prompt management, performance summary, skills voucher, and translation features. The hackathon-to-production path still needs to be figured out.

## Key decisions
- Tokenizer placement: move token counting/limiting logic from the LLM engine to the proxy layer (lesson learned after rework).
- Review bottleneck mitigation: pre-assign tickets to Tejas and Riya to avoid code-review pile-ups.
- Translation feature: handled as a language-support addition in the ZRA feature; secondary languages added via MI.
- Prompt management scoped as a near-term ticket; customers will eventually be able to modify prompts.
- Gemma upgrade and OpenAI → Gemini embedding migration identified as upcoming pipeline work.

## Action items
- Aakansha: Pre-validate architectural decisions (spike/documentation) before implementation to reduce rework risk.
- Aakansha: Continue messaging in channel (not just calls) for async unblocking; follow up with Lalit next day / in scrum.
- Lalit: Send translation service details / spike for language support.
- Lalit: Consolidate and reply to the optimized-SMB message to unblock the sector.
- Lalit: Detail documentation for spikes further in the impact/planning phase.
- Lalit: Work on prompt management, AI improvements (edge cases/generations), Gemma upgrade, AI processing pipeline for meeting transcripts, skill-to-learning matching engine, CICD framework for AI benchmarking, and Agentic AI Foundation POC.
- Team: Figure out the production rollout path for hackathon output.
- Tejas / Riya: Pre-assigned as ticket reviewers to reduce bottleneck.

## Follow-ups / open questions
- Path from hackathon prototype to production not yet defined.
- Calibration agent POC scope and hackathon topic selection still being evaluated.
- New team member's two remaining tickets pending; local testing across all microservices is the key challenge.
- July/August summer commitments and production timelines to be confirmed.

## Discussion notes
- Positive: hackathon prep/execution recognized as June's high point; Aakansha proactively recruited team members and drove participation.
- Pipeline work ran smoothly — clear tickets, quick clarifications, no significant blockers; testing (esp. microservices) requires additional effort.
- Constructive: more upfront architectural discussion needed before implementation to avoid mid-sprint reversals; code-review slowdowns from too many tickets stacking simultaneously.

## Next steps
- Continue via scrum calls and offline check-ins; no explicit next 1:1 scheduled.
