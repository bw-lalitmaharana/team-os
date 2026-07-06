---
date: 2026-06-30
meeting: AI Projects Debrief
type: debrief
attendees: [Jason Zhang, Maher Hanafi, Hemant Kumar, Okan Akbulut, Sagar Bhat, Tejas S, Lalit Maharana, Aakansha Srivastava, Ankit Sharma]
source: zoom
meeting_uuid: A63F8BF8-843E-4537-9428-94DC600BC48A
backfilled: 2026-07-07
---

# AI Projects Debrief — 2026-06-30

## Summary
Team debrief on active AI projects. The AI Meeting Transcript feature has reached design alignment across all pods and moved into implementation. Parallel tracks include webhook infrastructure, multilingual skill embeddings, and evaluation framework work. Leadership approved shifting this sync to a monthly cadence given improved project stability.

## Key decisions
- Meeting Transcript feature design is finalized across all pods; implementation has begun.
- Incoming webhook must be built in-house — no viable open-source solution exists for ingesting provider events.
- Sync meeting frequency reduced to monthly as projects are stable and regular stand-ups cover day-to-day needs.

## Action items
- [ ] Hemant / Sagar — Complete DB schema design and begin full implementation of Meeting Transcript feature
- [ ] Okan — Build in-house incoming webhook service to ingest events from providers (Zoom, LinkedIn, etc.) and publish to Kafka
- [ ] Sagar — Port multilingual skills and embeddings to production once QA approves
- [ ] Jason — Finalize Grafana dashboard for Gemma 4; resolve agent runtime streaming approach with team
- [ ] Lalit / Team — Refine roadmap for personalized L&D (course recommendations, learning plans) and skills/people graph for mentorship matching
- [ ] Lalit — Explore Slack bot v2 with agentic capabilities using MCP
- [ ] Jason + Maher — Move this sync to monthly cadence starting next occurrence

## Follow-ups / open questions
- Grafana dashboard for Gemma 4 inference server — in progress.
- QA validation of multilingual skill embeddings on internal environment before production rollout.
- Agent runtime streaming — code changes needed for backend-to-frontend streaming; requires deeper discussion before applying.
- Multilingual skills/embeddings — pending QA sign-off on internal environment before production promotion.

## Discussion notes
- Completed: POC for Meeting Transcript finalized using Gemma model (tested responses with GPT-5 as LLM judge); prompt refinement and API contracts locked. Embedding API deployed across all environments; multilingual skills (7 languages beyond English) generated via Llama and saved to embedding schema on internal environments. Token count API added to centralize model token logic on inference servers (rather than LLM proxy). Benchmark tests fixed after writing-assistant word-count feature caused failures; new dataset created and orphan-record detection workflows deployed on Rainforest and Pluto (daily alerts). 60 hackathon users added to N8N manually (no SMTP); invitation links distributed. Observability tools deployed on Rainforest for tracking agent runtime calls.
- Risk/escalation: DB schema extensibility for Meeting Transcript must support future sources beyond Zoom (Jira, Slack, plain text uploads) — being designed with minimal future changes in mind.
- Lalit's update: meeting transcripts track in implementation; next up is personalized learning & development (course/LMS recommendations, learning plans); team to work on large-scale pre-processing of courses across LMSs and a skills/people graph for mentorship. Phase 2 of performance signals from other sources (Teams, then Slack/Jira) after Zoom integration. Also exploring enhancing the existing Betterworks Slack bot to a v2 with agentic capabilities using MCP.

## Next steps
- Continue Meeting Transcript implementation; move this sync to a monthly cadence.
