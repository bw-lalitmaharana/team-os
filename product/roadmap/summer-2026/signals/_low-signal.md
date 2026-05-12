# Items with thin or no Slack signal (as of 2026-05-13)

Captured here so we know what's *not* surfacing externally — useful negative-space signal during refinement.

| Aha | Jira | Notes |
|---|---|---|
| AI-205 OpenAI→Gemma Embeddings | ENG-75271 | Under Review, near-ship. No Slack chatter — likely because it's an internal infra swap that's already executing well. |
| AI-154 Llama→Gemma Generative | ENG-80932 | Draft, Jason Z assigned. No Slack signal under that keyword set. Worth a direct ask to Jay-Z. |
| AI-200 CI/CD Eval Framework | ENG-74398 | Under Review, Tejas S driving 4 sprint items. No PM-level Slack chatter — engineering-internal. |
| AI-193 LLM Prompt Management | **NONE** | Aha-only. No Jira epic, no Slack signal — risk that this is unfunded. **Create Jira; ask Nellie if real.** |
| AI-194 LLM Eval Visualization | ENG-72626 (unlinked in Aha) | Nellie's list shows it Under Review. Likely actively worked but unmapped. **Link Aha→Jira.** |
| AI-191 Pre-processing Phase 3 | ENG-70491 | Currently fix=Spring 2026; under review. Decide carry-over vs Summer commit. |
| AI-214 MWAA Self-Service | ENG-78553 | Spike in flight. Devops-only; low priority unless blocks transcripts deploy. |
| EMPDVT-90 Perf Summary Redesign | ENG-73594 | Dev Complete in Aha, 7 mostly-Done sprint items. Ship it. |
| DP-66 Agentic AI Foundation | ENG-69839? (unverified) | High Aha score (31), no clear Jira link in Aha description. **Verify before walkthrough.** |
| AI-215 Skills API Phase 2 | ENG-77042 | Nellie owns, Draft, no sprint pull. Powers Adaptive Learning + PDP. |

**Action:** when any of these surfaces in Slack/meetings, promote the entry to its own `signals/<feature>.md`.
