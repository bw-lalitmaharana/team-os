# EMPDVT-90 / ENG-73594 — Performance Summary Redesign

**Aha:** `EMPDVT-90` · **Jira:** ENG-73594 (Dev Complete, 7 mostly-Done sprint items)
**Owner:** Nellie (sponsor)
**Composite score:** 9 (P0 finish — ship-by-default)
**Bucket:** P0 (finish)

## Signals

### 2026-05-25 — slack
- **Who:** Aakansha Srivastava
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1779695870007809)
- **Summary:** PR review request for ENG-81013 (Performance Summary jsondecode fix), with branch deployed to Rainforest for testing; tagging Riya Malik and Tejas for review.

### 2026-05-25 — slack
- **Who:** Aakansha Srivastava
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1779716323006229)
- **Summary:** Follow-up PR review request for ENG-81013 (Performance Summary jsondecode fix) — QA now complete on Rainforest; PR#529 ready for team review.

### 2026-05-29 — slack
- **Who:** Riya Malik
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1780042289931109)
- **Summary:** Performance Summary correctly picks up scheduled conversation data; anytime conversations have a bug in the Conversations module (team investigating); Riya will re-verify Performance Summary integration once Conversations bug is resolved.

### 2026-06-01 — slack
- **Who:** AIOnCallBot (on-call alert)
- **Where:** [#internal-ai-alerts](https://betterworks.slack.com/archives/C0B26A0EC5U/p1780304105700659)
- **Summary:** CRITICAL alert on ai-pluto-errors: performance_summary feature failing — LLM returned unparseable JSON or upstream schema changed; dependency team flagged to investigate LLM proxy schema changes; Aakansha Srivastava on-call.

### 2026-06-02 — slack
- **Who:** Hemant Kumar
- **Where:** [DM — Lalit Maharana](https://betterworks.slack.com/archives/D0B1J102F34/p1780384501046599)
- **Summary:** Hemant flagged ENG-74804 to Lalit — design question on performance summary fiscal year rollover; Nellie clarified the current behavior (summaries stay in the configured FY until admin rolls it over) is expected; Hemant asking whether to close the ticket and proposed adding an admin warning for past-end-date FY configs.
