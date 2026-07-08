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

### 2026-06-03 — slack
- **Who:** Tejas S
- **Where:** [Group DM (Tejas S, Nellie LeMonier, Lalit Maharana)](https://betterworks.slack.com/archives/C0B1Y367FK3/p1780457400484669)
- **Summary:** Tejas asked for feature flag rollout date for Performance Summary UI redesign — needs timeline to prioritize updating AI E2E automated test suite before new design goes live.

### 2026-06-05 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19e939793d054869 — "Meeting assets for Nellie / Lalit - Roadmap priorities are ready!"
- **Summary:** Nellie flagged a new story on performance summary bucketing by fiscal year; she will refine the story and discuss with Jay-Z (Jason Zhang) about potential impacts on search and filter capabilities.

### 2026-06-10 — slack
- **Who:** Joe Tambascio
- **Where:** [#oppty-gtm](https://betterworks.slack.com/archives/C0B7ZS5EJMU/p1781044959708169)
- **Summary:** Customer surfaced in GTM channel needs dual competency ratings (current-role performance + promotion-readiness) in one system to replace Excel tracking — adjacent scope signal for Performance Summary redesign.

### 2026-06-11 — slack
- **Who:** Tejas S
- **Where:** [#pluto_support](https://betterworks.slack.com/archives/C02CYPAHR4Y/p1781147026358339)
- **Summary:** Data cleanup confirmed complete in Pluto database — performance_summary orphan records cleared (0 remaining as of 2026-06-11T03:02:33 UTC).

### 2026-06-11 — slack
- **Who:** Riya Malik
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1781176306740979)
- **Summary:** QA testing complete for Conversation Writing Assistant (CWA) and Feedback Writing Assistant (FWA) on gemma model integration across Haven and Legacy — 100 tests, 100% pass rate, overall quality 9.0/10 (grammar 9.1, formatting 9.2); performance_review conversation category 100% pass — adjacent AI quality signal for the platform pod.

### 2026-06-15 — slack
- **Who:** Amy Culverhouse
- **Where:** [#oppty_drreddy](https://betterworks.slack.com/archives/C0BA636686B/p1781524666841779)
- **Summary:** Dr. Reddy's (active evaluation, FY27 go-live target) surfaced explicit need for AI-driven performance management including goal recommendations, manager insights, and AI support for performance workflows — external prospect validation that performance summary + AI direction is market-relevant.

### 2026-06-26 — slack
- **Who:** Riya Malik
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1782447934208549)
- **Summary:** Production incident: Performance Summary returning 500 errors (14 replies in thread, Tejas cc'd) — possible regression or infra issue requiring active investigation.

### 2026-07-07 — slack
- **Who:** Support incident bot
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1783430495483989)
- **Summary:** P2 support incident filed: ENG-84564 — Teacher Retirement System of Texas reporting AI Performance Summary still showing last fiscal year's data under YTD; customer-facing data staleness bug.

### 2026-07-07 — slack
- **Who:** Rachel Scoffield
- **Where:** [#product](https://betterworks.slack.com/archives/C033TEH2T/p1783430541866319)
- **Summary:** Rachel raised Jira ENG-84564 after confirming the issue is not matching what Nellie described — P2 customer incident on AI Performance Summary showing stale FY data for an org that has reached out.

### 2026-07-08 — slack
- **Who:** Aakansha Srivastava
- **Where:** [#pod-ai-platform](https://betterworks.slack.com/archives/C04N1P7N1PT/p1783487894025249)
- **Summary:** Follow-up on ENG-84564 (Teacher Retirement System of Texas): confirmed prod customer-facing issue; fix is to regenerate performance summary for the affected org; Tejas and Bhavesh Vaviya looped in for execution.
