---
date: 2026-07-01
meeting: AI Platform Product Acceptance
type: review
attendees: [Nellie LeMonier, Tejas S, Lalit Maharana]
source: zoom
meeting_uuid: E4ACA054-A772-4D1F-A8F1-29C51B979359
backfilled: 2026-07-07
---

# AI Platform Product Acceptance — 2026-07-01

## Summary
Nellie, Tejas, and Lalit discussed testing approaches for MCP tools and current system issues. Nellie requested Tejas's guidance on testing strategies for the MCP tools, particularly since team members (Sweta and Sanchit) are split between UI pod testing and app platform testing. Tejas agreed to review the MCP epic and develop a testing strategy, including potential automation and golden data sets for conversation endpoints. They also discussed a critical GPU-utilization issue on the Dev1 environment where pending inference requests were reaching 100K+ due to a race condition in the inference system, causing failures in AI features and blocking testing. Tejas explained this was only affecting Dev1, not production or other inference clusters (which have higher GPU configurations). The team agreed to discuss the GPU issue with Jason Zhang (JZ) after the stand-up to determine the proper fix and architecture changes.

## Key decisions
- The App Platform team (not Talent) will implement the Skills Module access-filtering feature, since Talent lacks bandwidth.
- Tejas will review MCP documentation, consult Sanchit, and co-develop an MCP testing strategy; JB and JC to be pulled in once a plan is drafted.
- Do NOT enable the Gemma system-admin panel in production — it is not ready; Nellie to communicate this in release notes.
- The Dev1 inference race-condition fix requires an architecture change to be reviewed with JZ before implementation.

## Action items
- Nellie: Share MCP documentation with Tejas.
- Nellie: Pull in JB and JC to finalize the MCP testing strategy once Tejas has a plan.
- Nellie: Communicate in release notes not to use the Gemma feature (not production-ready).
- Nellie: Message JZ re: the Rainforest/Dev1 issue and get input on a solution approach; add a comment on the blocker ticket to drive prioritization.
- Tejas: Review MCP tools epic and tickets; propose a testing strategy (automation, CI library, golden dataset) for Sanchit and Sweta.
- Tejas: Speak with Sanchit to provide QA mentorship and discuss the MCP testing strategy.
- Tejas: Prioritize with Bhavesh to address the Rainforest issue (circuit-breaker pattern, GPU increase, retry limit) to unblock AI feature testing.
- Tejas: Keep JZ informed about the use of his bandwidth for the MCP testing strategy.
- Lalit & Tejas: Discuss the Dev1 blocker in detail after stand-up.

## Follow-ups / open questions
- Optimal retry limit for intermediate-summary workers (currently 3 retries, but no cap specifically on intermediate summaries).
- Whether Dev1 GPU resources should be increased as a short-term mitigation.
- Final architecture approach for the race-condition fix (pending review with JZ).

## Discussion notes
- MCP tools testing: No established approach exists for testing all MCP tools that will back the AI chat components. Sweta and Sanchit are split across UI pod and app platform testing. Tejas to define a strategy.
- Release notes: Internal-only updates last week (including new embedding features with system-admin settings) had not been deployed to production; more detail needed before generating release notes.
- September items / Gemma: Agreed not to enable the Gemma system-admin panel in production. Nellie also flagged that the Synopsys clone-org instance should not be used and has reached out to CS.
- Cloned-org testing: Nellie confirmed the cloned production system works for publishing; noted uncertainty about whether name changes might trigger email notifications.
- Skills demo: Nellie showed how to view a user's skills (example had 92 TechWolf skills). Skills Module config has both backend and frontend, enabling filtering of which groups have access.
- Departments vs groups: Groups handle user selection/inclusion/exclusion; departments are organizational and assigned at user-creation time (including via bulk CSV upload).
- Dev1 inference blocker: Race condition where failed summarization tasks (intermediate summaries) retry infinitely, flooding the worker queue and blocking further requests. Pending requests went from ~40K (prior day) to 100K+. Root cause tied to summary-of-summaries flow when the inference proxy is overloaded / GPU utilization is high. Affects Dev1 only (test env with lower infra); internal, prod-US, and prod-EU inference clusters are independent and unaffected. Ongoing ~3 days.

## Next steps
Take the Dev1 blocker to JZ after stand-up to agree on the fix approach (circuit breaker, retry limit, and/or GPU increase); Tejas and Bhavesh to implement once agreed. Nellie to progress the MCP testing-strategy alignment with Tejas/Sanchit/JB/JC.
