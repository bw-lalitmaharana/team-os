# Aug–Oct Zoom backfill — staging (not yet merged into open-actions.md)

> Zoom AI-summary scan of ~45 further meetings 8/17–10/8 (pagination now complete: ~290 held meetings, 143 with summaries, 123 readable). Grouped/deduped; all **unverified** (August items may be done). Staged in a separate file so it can't conflict with your local triage of `open-actions.md` — once your marks are pushed/merged, say the word and I'll fold these in as #72+.
> **Not read:** 36 PDP stand-ups; App Platform QA 9/9, 9/16, 9/24, 10/1, 10/8; OKR standups (no permission); ~14 solo/under-3-min entries. Slack/Jira unreachable.

## Lalit's open items

| # | Action | From | Deadline | Status |
|---|--------|------|----------|--------|
| 72 | **Zoom transcripts — consent & testing:** Ask Hemant for a solution accepting more transcript formats beyond VTT; communicate single-consent + multi-format must be prod-ready | 1:1 8/18; Acceptance 8/19, 9/9 | 9/15 | 🟡 Open |
| 73 | **Zoom transcripts — consent & testing:** Push eng on end-to-end Rainforest testing of Zoom transcripts; test with Betterworks test account; nudge Anuj to add seats; enable Zoom + consent on Nellie's account | 1:1 8/18; Zoom 8/19; Acceptance 8/19 | — | 🟡 Open |
| 74 | **Zoom transcripts — consent & testing:** Schedule security review with Brian (via Tanveer); bring consent-model feature-flag change to team | 1:1 8/18 | — | 🟡 Open |
| 75 | **Zoom transcripts — consent & testing:** Follow up on Zoom integration with Ajay/Gail; transfer scheduled meeting to Danish | Zoom Mtg 8/19 | — | 🟡 Open |
| 76 | **Zoom transcripts — consent & testing:** Verify AI suggestions + transcript meeting events; test linking in NextGen; guide users to Bulk Create 1:1s | Anuj 8/25 | — | 🟡 Open |
| 77 | **Zoom transcripts — consent & testing:** Single-participant consent: discuss with Nellie, refine sysadmin wording/placement, review UI in code review; finalize Zoom consent flow (option 3, OR logic) | Anuj 9/1; 1:1 9/1; QA 9/2; Acceptance 9/9 | — | 🟡 Open |
| 78 | **Zoom transcripts — consent & testing:** Move cloud-recording TXT ticket to Ready for QA; add release tag meetings-API_V1.72.0; check flow after stop recording / Zoom exports; QA transcript-upload subtask (coordinate w/ Champlain) | Anuj 9/1; 1:1 9/1 | — | 🟡 Open |
| 79 | **Zoom transcripts — consent & testing:** Explore alternative connect/disconnect wording; finalize Zoom/consent UI with Natalia + Ellie (with Harshini) | QA 9/2; Harshini 9/3 | — | 🟡 Open |
| 80 | **Zoom transcripts — consent & testing:** **Critical:** follow up with Danish on Zoom webhook events not arriving for Champaign; check env/org setup for Zoom app testing | 1:1 9/8, 10/6 | — | 🔴 Open |
| 81 | **Zoom transcripts — consent & testing:** Move 'exclude specific meetings' + series-level consent to Phase 2; create privacy & removal controls epic; consider renaming 'flag as sensitive' → 'exclude this meeting instance' | 1:1 9/8; Tejas 9/9 | — | 🟡 Open |
| 82 | **Zoom transcripts — consent & testing:** Simplify transcript banner/message text; share Zoom Marketplace app details once submitted; make Zoom admin/user manuals accessible | 1:1 9/15 | — | 🟡 Open |
| 83 | **Zoom transcripts — consent & testing:** Troubleshoot Natalia's missing Zoom transcripts | 1:1 9/22 | — | 🟡 Open |
| 84 | **Zoom transcripts — consent & testing:** Log Champaign bug (1:1 prep not regenerating, transcripts not fetching) + tell Tanvir; raise bug-fix communication gap with Kanwar | 1:1 10/6 | — | 🔴 Open |
| 85 | **Zoom transcripts — consent & testing:** Document 3-hour transcript-mapping window; follow up on rescheduled-meeting handling; log calendar-sync bug for rescheduled meetings | 1:1 8/25; Acceptance 9/9 | — | 🟡 Open |
| 86 | **AI Platform, Phase 2 & MCP:** Triage/prioritize transcript bugs; log P1–P3 blockers from doc review; update prep-generation docs to single-pass architecture | Acceptance 8/19, 9/9 | — | 🟡 Open |
| 87 | **AI Platform, Phase 2 & MCP:** Prioritize Phase 2 scope, get estimates, present roadmap; plan/limitations/status summary incl. Tanveer; communicate slipping items proactively; dog-food end to end | 1:1 8/18, 8/25 | — | 🟡 Open |
| 88 | **AI Platform, Phase 2 & MCP:** Department-level AI enablement controls as P1; tooltip ticket for agenda vs action recommendations | 1:1 8/25 | — | 🟡 Open |
| 89 | **AI Platform, Phase 2 & MCP:** Size Google Meet + Teams integration for winter; proceed with MS Teams connector POC; Confluence Phase 2 page (Winter MCP tools, Teams/Meet/WebEx) | 1:1 8/25, 10/6 | Winter | 🟡 Open |
| 90 | **AI Platform, Phase 2 & MCP:** Move 'additional file types' to Phase 1.5 in Aha; share enablement doc with Tejas + Nellie; add archived-meeting AI Prep behavior to ticket | Acceptance 8/26; Anirudh 8/26 | — | 🟡 Open |
| 91 | **AI Platform, Phase 2 & MCP:** Update ticket with AI-update label scenarios; add meeting-data details (CRUD, calendar events) to sheet | Nudge 8/21 | — | 🟡 Open |
| 92 | **AI Platform, Phase 2 & MCP:** Own prompt + MCP-tool engineering; add 'extend language support w/ new Gemma model' roadmap item; review Natalia's skill-gap prototype as MCP tool; coordinate PDP Phase 2 retro with Pankaj | 1:1 9/1 | — | 🟡 Open |
| 93 | **AI Platform, Phase 2 & MCP:** Share evaluation sheet + Phase 2 epic doc with Tejas (tell Satish); highlight 2–3 priority transcript items; sign off production acceptance tickets | Tejas 9/9, 9/16; Acceptance 9/16 | — | 🟡 Open |
| 94 | **AI Platform, Phase 2 & MCP:** Draft MCP tool stories (prep, recap, feedback summary); restructure MCP training doc to MVP + monthly cadence; coordinate weekly demos of completed MCP tools; add MCP Inspector to Rainforest | Acceptance 9/16; 1:1 9/22, 9/30 | — | 🟡 Open |
| 95 | **AI Platform, Phase 2 & MCP:** Connect with Tanvir on Phase 2 stories/spikes | 1:1 9/22 | 9/23 | 🟡 Open |
| 96 | **AI Platform, Phase 2 & MCP:** Update Aha with done/not-done; post to Molly + Mary what shipped; Jira release notes for Sept tickets; respond to Molly on goals-recommendation UI | 1:1 9/22, 9/30 | — | 🟡 Open |
| 97 | **AI Platform, Phase 2 & MCP:** Raise cross-team meeting on Phase 2.0 scope; own recurring AI team refinement call; refine app platform refinement + check support-ticket backlog | Acceptance 9/30; 1:1 9/30 | ~10/5 | 🟡 Open |
| 98 | **AI Platform, Phase 2 & MCP:** Add Ankit to chat sync call; connect with Paul on MCP tools for meetings (possibly own MCP roadmap) | 1:1 10/6 | — | 🟡 Open |
| 99 | **AI Platform, Phase 2 & MCP:** Mixpanel: create/fill event-tracking tickets (conversational intelligence, PDP), run event list by Jay-Z; follow up w/ Neetesh on 2 PDP AI items | Sagar 10/6 | — | 🟡 Open |
| 100 | **AI Platform, Phase 2 & MCP:** Move 'new data for AI recommended skills' → Ready for Dev (implement per spike); move Streaming/Kong auth/Kong upgrade ticket to backlog | AI Platform Refinement 10/8 | — | 🟡 Open |
| 101 | **AI Platform, Phase 2 & MCP:** Render initial recognition + feedback form in UI; check manual-upload flow data; prepare documentation | Tanveer 10/5 | — | 🟡 Open |
| 102 | **Custom Roles & App Platform:** Review Nellie's custom roles doc; refine 4 custom-roles tickets; create UI + policy tickets/epic; notifications idea as Aha for Varnika's team | 1:1 8/25 | ~8/27 | 🟡 Open |
| 103 | **Custom Roles & App Platform:** Share custom roles doc with Sarah; confirm simplified ticket (view + edit only) for release 1; consolidate platform tickets per JB; reach out to Rinku; scope user-mgmt policy support | 1:1 9/8, 9/15, 9/22 | — | 🟡 Open |
| 104 | **Design, UI & misc:** Archive-section logic note; consolidate comments + notify Hiten | Zoom Mtg 8/20 | — | 🟡 Open |
| 105 | **Design, UI & misc:** Goal-recommendation: check with Kaushika; P1–P3 tickets from observations; remove redundant rec from goal description; manager-POV flag recommendation to Sagar | Sagar 9/8 | — | 🟡 Open |
| 106 | **Design, UI & misc:** Check calendar-sync wording with Varnika; refine AI tools/use-case list for performance partner → Nellie; complete Anthropic AI fluency course | 1:1 9/8 | — | 🟡 Open |
| 107 | **Design, UI & misc:** Share 'skills' context with Harshini; developer walkthrough once feedback/recognition designs final | Harshini 10/1 | ~10/8 | 🟡 Open |
| 108 | **Design, UI & misc:** Share popular-questions video via Drive | 1:1 8/18 | — | 🟡 Open |
| 109 | **Design, UI & misc:** Prototyping initiative (low confidence — Sriram PMR, date uncertain): freeze scope w/ Sharan, sessions w/ Mahesh + Gauri, Aha prioritization tool check, end-of-quarter write-up for Sriram | Sriram PMR 9/4 | Monday | 🟡 Open |

## Cross-pod commitments to track

| Dependency | They owe us | Deadline | Status |
|------------|-------------|----------|--------|
| Nellie | Define admin roles, create AHAs, Conversations-team meeting; Gemma 4 notes + CS feedback recording; unlink event from org, demo invite; MCP best-practices link, schedule refinement | — | 🟡 Pending (8/17–9/16) |
| Tejas | NextGen user IDs; Kong checklist; test Zoom w/ Hiten/Anuj; review Phase 1.5 tickets; goals-misattributed follow-up; Champion data | — | 🟡 Pending (8/19–9/16) |
| Danish | Create Zoom app + message Lalit; move new-service PR to prod | — | 🟡 Pending (8/20) |
| Harshini / Hiten / Satish | UI changes in Lalit's doc; consolidated UI ticket; test transcript paste | — | 🟡 Pending (8/20) |
| Anuj | Multi-org event linking feasibility; flexible transcript formats; consent ticket after review | — | 🟡 Pending (8/25–9/1) |
| Sagar / Hemant | Share Hemant's number + Slack copy; implement approved Mixpanel events | — | 🟡 Pending (9/8, 10/6) |
| Tanveer | Capture Teams + Zoom/Meet signals; check existing feedback; Teams customer commitments | — | 🟡 Pending (10/5) |
| Kate / Paul Agustin | Help Nellie with Aha; locate Performance Snapshot policy | — | 🟡 Pending (8/17) |
