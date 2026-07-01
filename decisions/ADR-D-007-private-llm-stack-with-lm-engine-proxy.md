---
id: ADR-D-007
status: accepted
date: 2026-05-11
deciders: AI Platform Lead (JZ)
related_prd: PRD-AI-PROCESSING-PIPELINE
---

# ADR-D-007 — All inference through LM Engine + LM Proxy; private LLM stack only

## Context
Two inference paths considered: (a) external LLM providers (OpenAI, Anthropic) via API — fastest path, lowest infra cost, but customer-security commitments around data exfiltration prohibit it for transcript content; (b) private LLM stack on Betterworks-owned infra (Llama 3.1 8B → Gemma 4 on AWS EC2 GPU via EKS) fronted by LM Engine + LM Proxy with 20-category content guardrails — slower to set up, but already exists for Skills normalization, meets security commitments, and reuses proven precedent (`llm-engine` PR #512 / ENG-78223).

## Decision
All inference for this feature SHALL route through **LM Engine + LM Proxy** with 20-category guardrails. **Private LLM stack only.** No external LLM provider calls from the inference path. Specific model version (Llama 3.1 8B for MVP; Gemma 4 post-TensorRT support) is implementation detail, not surfaced in user-facing copy or PRD body.

## Consequences
- Meets customer-security commitments for transcript content.
- Reuses existing infra (LM Engine, LM Proxy) — no new procurement.
- 20-category guardrail checks every output (hallucination + safety + content-policy).
- Latency budget: <20s for summary; <5 min p95 end-to-end (CAP-001 / PRD §5 SHOULD).
- Model versioning is an internal concern; no PRD body mention (constraint in §5 MUST NOT).
- Builds on `llm-engine` PR #512 (ENG-78223) conversation-context flow precedent.

## Source
- Zoom uuid 9988F4F9-4D28-407C-868E-DB1052ADCED9 (Architecture walkthrough w/ Jason Zhang, 2026-05-11)
- PRD-AI-PROCESSING-PIPELINE §5 MUST + MUST NOT
