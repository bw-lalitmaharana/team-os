---
date: 2026-07-03
meeting: Bhavesh / Lalit
type: 1:1
attendees: [Lalit Maharana, Bhavesh]
source: zoom
meeting_uuid: 625A6CF0-BBDD-4287-8B07-5FFC1A1B8100
backfilled: 2026-07-07
---

# Bhavesh / Lalit — 2026-07-03

## Summary
Technical discussion on AI/ML projects: MWA (Machine Wisdom Assistant) upgrades, translation services, and infrastructure improvements. Covered platform stability, retry mechanisms for different error types, and better error handling. Bhavesh expressed interest in Agentic framework integration and infrastructure/inference optimization; Lalit emphasized maintaining clear direction and avoiding scope creep. Translation service architecture, prompt management, performance summaries, and meeting-transcript processing were also discussed.

## Key decisions
- Standardize retry functionality across features: utility-based retries handling distinct error types (connection, ingestion, server timeout) with a max of three retries, rather than blind retries.
- Translation service to use a single point of contact (Betterworks Translation Service / LLM Proxy) handling translations across all modules; AI-powered service processing one input language into up to 31 languages.
- NextGen language support: static dictionaries for keyword translation, AI-powered dynamic text where static falls short.
- Prompts to be customizable, supported by OpenAI or Mistral; prompt version visibility configurable for public/private goals.

## Action items
- Bhavesh: Reach out to the AWS team for support on MWA stability and deployment issues.
- Bhavesh: Debug the retries / word-limit issue and determine if it's a DevOps issue.
- Bhavesh: Explore and contribute to infrastructure and inference optimization, including the Agentic framework inclusion POC.
- Bhavesh: Work on the AI-powered translation service for dynamic content as part of the Jemma/Gemma upgrade.
- Bhavesh: Provide architecture support for the learning recommendations project with Nitesh.
- Bhavesh: Implement self-service repo deployment for the MWA baking service.
- Lalit: Talk to Jay-Z about the Agentic POC.
- Hemant + Sagar: Work on the AI preprocessing pipeline for meeting transcripts.

## Follow-ups / open questions
- Generation constraints and prompt logs not visible in New Relic for performance summary.
- Audit reports and missing KRs for clients.
- Architecture-related discussion with Sagar planned for later.

## Discussion notes
- Focus on router track / PI improvements while keeping clear dividing lines to avoid missing key aspects.
- Phase 3 completed; discussion of handling low-priority MWA stability/deployment tickets and full upgrade with translations as the target.
- Also touched normalization service migration into the talent service, course recommendations, and documentation of pain points.

## Next steps
- Prioritize translations; follow up on Agentic POC and architecture discussion with Sagar.
