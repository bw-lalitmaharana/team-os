---
date: 2026-06-16
meeting: AI Projects Debrief
type: debrief
attendees: [Jason Zhang, Maher Hanafi, Sagar Bhat, Tejas S, Bhavesh Vaviya, Aakansha Srivastava, Riya Malik, Prasanna Poojary, Lalit Maharana]
source: zoom
meeting_uuid: DB2BD344-0701-46C2-9C86-D48F689CB172
backfilled: 2026-07-07
---

# AI Projects Debrief — 2026-06-16

## Summary
Round-robin standup / debrief across the AI pod, with Jason Zhang driving and Maher Hanafi joining partway through for a quick debrief before the AI Engineering Lab meeting. Updates spanned feedback summary / writing assistant (Gemma integration), pre-processing pipeline runs, observability/traceability tooling, skills taxonomy translation and embeddings, the AI meeting-transcript feature, and cost optimization of the QA test agent. (No AI-generated summary was available for this meeting; notes are drawn from the transcript.)

## Discussion notes
- **Aakansha** — Deployed feedback summary changes to Rainforest; hit an issue resolved by removing Tokenizer from Gemma; PG Bouncer changes blocked local testing so tested via branch — now working, QA unblocked for feedback summary. While testing the writing assistant via branch, found a goal-quality-assist bug (not in the original story scope); created a new subtask. Working on Gemma (GMR4) implementation for feedback summary and goal assist; PR raised that morning, awaiting approval.
- **Bhavesh** — Half the day in the meeting-transcript story-pointing session; walked Ria through word-limit ordering changes for the feedback writing assistant prompt and asked her to prepare metrics (headroom % vs. input word count) on Rainforest. Debugged a local PG-vector / primary-DB pointing issue with Sagar; will fix his local first, then help unblock the rest of the team. Started replicating the word-limit change with the Gemma prompt. Pre-processing: Champagne and Pluto complete; ProdUS reached the second (AI generation) stage for the first time after resolving the out-of-memory kill / memory-spike issue.
- **Jason (JZ)** — Deploying observability and traceability tooling with DevOps (ECR repo, S3 buckets, many components); worked with Henry to get the ECR repo done. Building an internal MCP server (Talend API service) — chatted with the Talend team who already have tooling/prototype; PR up but on hold (red flag) pending an internal architecture discussion with the app platform team. Continuing on the agent framework proof of concept.
- **Sagar** — Added translated skills to TalentDB (now 7 languages) via OpenAI-generated translations; computed delta between Lightcast 9.22 (previously translated) and 9.32 (talent team's version) — ~10 revisions — and loaded into Rainforest DB. Next step: generate corresponding embeddings under the embedding schema across all environments via a Rundeck job. Removed the normalization-API dependency for skills (merged to master) — the LLM engine now hits the embedding API directly; plan to extend this pattern to all services. Expects production release across all environments by tomorrow / day-after; investigating a post-merge failure on Rainforest. Also gave a high-level walkthrough of the AI meeting-transcript feature and confirmed the POC (data extraction, source citation, timestamp calc) was successful.
- **Tejas** — Cost-optimizing the QA/test (Claude) agent: stood up an Ollama server (Python) running Qwen 2.5 14B; cost for 10 test cases dropped from ~$2.8 to ~$0.75 (~180K Claude tokens, down from >200–220K). Delegated side tasks (analysis, PR fetching, report writing, hook triggers) to Ollama while retaining Claude for orchestration/execution (switched Claude Sonnet → Haiku). Claude/Playwright still required because the agent relies on live browser interaction and DOM snapshots (cannot migrate to n8n for that reason). Requested usage metrics from Maher.
- **Riya** — Testing Gemma model integration for AI features (writing assistant, feedback conversation, goals writing assistant; feedback summary to be tested today). Completed automation coverage for all integrated AI features in the CI/CD pipeline under the Haven repo.
- **Prasanna** — Mostly meetings/discussions on the AI side plus some Engage-side AI development (scripts). AI training plan kicks off Monday (start of next week, not tomorrow — correction to Sagar's earlier note).
- **Lalit** — Two summer focus areas from the product side: meeting-transcript summary (in good shape) and learning recommendations (next to pick up). Confirmed the meeting-transcript work is on track — a broader planning/story-sizing discussion happened that day and is roughly halfway done, keeping the team in a good place for the next 6–8 weeks; no alarms.

## Follow-ups / open questions
- JZ ↔ Sagar (offline): whether embeddings for the same taxonomy words are identical across environments, so they can be generated once and reused rather than regenerated per environment.
- JZ ↔ Tejas (offline): explore running the test-agent workflow on a self-hosted agent framework connected to Gemma instead of Claude.
- JZ flagged infra readiness for the meeting-transcript feature (Terraform, S3 buckets to store transcripts) — start early rather than last minute, as DevOps is busy. Sagar noted most infra heavy lifting sits with the Meetings pod (they pass an S3 transcript URL to AI), but agreed to move early.

## Next steps
- AI org-wide training to begin Monday (start of next week), 1 hour each morning IST.
- AI pod to raise any blockers to Maher for help; share the actual plan of action for the meeting-transcript feature from the next call onward.
- Team moving to the AI Engineering Lab meeting immediately after.
