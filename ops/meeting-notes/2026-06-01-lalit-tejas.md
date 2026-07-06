---
date: 2026-06-01
meeting: Lalit / Tejas
type: 1:1
attendees: [Lalit Maharana, Tejas S]
source: zoom
meeting_uuid: 662C61BB-F714-4B64-AB90-D0FF64CD54B0
backfilled: 2026-07-07
---

# Lalit / Tejas — 2026-06-01

## Summary
Detailed backlog / epic walkthrough (~1 hour) between Lalit and Tejas, in continuation of the prior week's discussion with JZ and Nellie on team productivity and outcomes. Tejas walked Lalit through the AI pod's epics, current sprint, on-deck, and backlog tickets — where each stands and what to prioritize, clean up, or close. Key running themes: enhanced pre-processing (Phase 2 near release, Phase 3 planned), prompt management (DB-based, meta prompts), the Meta-Llama → Gemma migration across AI services, OpenAI → embedding-Gemma migration for normalization/skills, the Lightcast → TechWolf taxonomy move, translation-service spike, and the need for a data-creation automation epic and AI usage tracking.

## Key decisions
- Create a new epic "Data creation automation" (Lalit to create) — restructure Akansha's earlier AI-based data-creation framework, which is not scalable/user-friendly and currently non-working.
- Meta-Llama → Gemma migration is the direction; add a Gemma story per AI feature; add a separate Gemma story for Guardrails (safety, bias, PIA checks — likely Akansha).
- OpenAI stays as a third-party backup; Mistral is deprecated/sunsetted; Meta, Mistral, Gemma are self-hosted.
- Prompt-versioning foundation is complete (in DB for OpenAI/Mistral, extended to meta prompts); pick up remaining tickets when prioritized (discuss in sprint planning).
- Prioritize releasing pre-processing Phase 2 to prod before Phase 3 (skills + meeting-summary pre-processing + data cleanup — low priority).
- Pull the AI-features latency ticket (direct endpoints → internal API endpoints) into the current sprint; no one is currently working on it.
- Keep the board clean — mark many stale tickets Done / Won't-do / Duplicate / Never (Ria to help replicate and clean up).
- Move the "meeting transcripts → recommendation" ticket's due date forward (Lalit owns; created by Lalit).
- No AI usage tracking exists today; leadership (Daisy, Bharat, Ian, Sean, JZ) said it's OK for now (unlimited AI calls); a usage/audit report would likely become its own epic.

## Discussion notes
- Pre-processing: worked on ~1.5–2 years; Phase 1 added pre-processing as a job; Phase 2 adds Delta feature (processes data added between runs); minor infra issues on Dev1/Champagne, redeploy to internal expected next day.
- Total AI services universe: 7 AI services + 1 Guardrail. Calibration has no AI feature.
- Translation-service spike: replacing Transifex with an independent translation service for static UI-template text; dynamic text still needed. Open questions remain.
- Upgrade to Gemma 4: JZ deployed Gemma 4.2 dev; add prompts per feature; Guardrail needs separate tasks (safety, bias, AI submodules).
- Skills/taxonomy: Okan running a TechWolf spike; placeholder tickets pending until spike completes; Okan and Chao actively working. Normalization service currently used only by skills; plan to move it into Talent.
- OpenAI → embedding-Gemma migration (Sagar): normalization + embedding services were coupled on deploy; work long in code review; after deploy, need a pipeline to remove manual embedding generation (est. 3–5 days; blocker is quality/performance validation).
- Latency root cause (via DevOps): AI features were calling goals/conversations/feedback (and calibration) via direct endpoints instead of internal API endpoints — fixing this should reduce latency (this is a duplicate of the DevOps refactor-frontend-calls ticket).
- Disable-admin bug: disabling an AI feature in the admin module didn't disable it at the DB/backend level (caused a conflict for one org) — new ticket to sync DB on disable.
- Data-integrity issue on org deletion (e.g., org 699): WarehouseDB (AI) vs. MasterDB conflict — check with JZ/Sagar (Bharat had prior context).
- Feedback-summary issue when data spans >2 years: assigned to Nellie, who needs time to think of an approach.
- AI-platform improvements largely done/stable: GPU sizing, TensorRT (done for Meta; Gemma doesn't support TensorRT yet), autoscaling, Grafana dashboard (JZ). Pluto is stable.
- Agentic AI: LearningLLM / MCP → chatbot work is "phase zero," driven by Nellie with JZ/JB; POCs run via notebook; not yet finalized.
- Likely moving this week: Gemma upgrade, pre-processing Phase 2, field performance-summary redesign (behind a flag).
- "No skills / no data" empty-state UX has a disconnect — Lalit to think about improving.

## Action items
- [ ] Lalit — Create the "Data creation automation" epic and move Tejas's related stories under it.
- [ ] Lalit — Move the meeting-transcripts → recommendation ticket's due date forward.
- [ ] Lalit — Think through the "no skills / no data" empty-state UX and propose an improvement.
- [ ] Lalit & Tejas — Discuss prompt-management prioritization in sprint planning.
- [ ] Tejas — Pull the AI-features latency ticket (direct → internal endpoints) into the current sprint and prioritize.
- [ ] Tejas — Add Gemma stories for each AI feature and a separate Gemma story for Guardrails.
- [ ] Tejas / Ria — Clean up the board: replicate and close/mark stale tickets (Done / Won't-do / Duplicate / Never).
- [ ] Tejas — Check with Bhavesh on the overdue DevOps "release LLM tags" ticket (likely already released).
- [ ] Tejas — Follow up with JZ/Sagar on the data-integrity (org-deletion Warehouse vs. Master) ticket and the Lightcast skills POC assigned to JZ.
- [ ] Sagar — Complete deploy of the OpenAI → embedding-Gemma migration; then build a pipeline to remove manual embedding generation.
