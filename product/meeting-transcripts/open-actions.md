# Open Actions — Meetings Transcripts Feature

Updated after each `/meeting-debrief`. Sorted by priority. **Refreshed 2026-06-08** — the May week-1 onboarding items were completed and archived; current owed items below reflect the May 27–30 recalibration + 2026-06-07 Jira decomposition + the June 1–5 daily-catchup / UX-Sync / roadmap signal. **Backfilled 2026-10-11** with July–Aug meeting-notes signal (#26–45 unverified; #46–49 from 9/17 Zoom summary; #50–109 from Aug–Oct Zoom summaries, unverified). **Backfilled 2026-06-30** with June 9–30 Zoom-summary signal — new items #13–25 below; #4 and #5 resolved.

## Lalit's open items (current)

| # | Action | From | Deadline | Status |
|---|--------|------|----------|--------|
| 1 | **Visibility-sharing doc** — PM decisions on visibility/sharing of AI-suggested vs user-added items; include one-sentence B-02 forward-pointer (language drafted in recalibration §H.3) | UX Alignment 2026-05-28 | — (owed to design + eng) | ✅ Done 2026-10-11 |
| 2 | **Answer Sagar's open questions** — (a) fiscal-period definition for the goals data window; (b) data-staleness re-trigger policy on failed pre-processing/embedding job (OPEN-D9) | Daily Catchup 2026-05-29 | Before AI inference lock (~mid-June) | ✅ Done 2026-10-11 |
| 3 | **Child-PRD Confluence sync** — push team-os versions of Meetings AI Surfaces / Connect Layer / Zoom Connector to Confluence (3 of 4 drifted; parent PRD is in sync). Confluence pushes are manual by Lalit. | Recalibration §H.4 | Before further child-PRD recalibration | ⛔ Not needed 2026-10-11 |
| 4 | Ratify **OPEN-D11** (inference substrate) once eng POC lands | Daily Catchup 2026-05-29 | ~mid-June 2026 | ✅ Resolved 2026-06-29 — direct LM inference server, Gemma 4 by Aug 10, 64K ctx |
| 5 | **Design walkthrough with Harshini (Mon 6/9)** → sit with Anuj, break updated designs into stories | Daily Catchup 6/5 | 6/9 | ✅ Done — design sessions 6/11, 6/23, 6/25 finalized the AI surface (5 tags, recap/prep schema); Figma = source of truth |
| 6 | **Document must-have vs nice-to-have** for the summer release (with Harshini); team meetings deferred to Winter | UX Sync 6/3 | Near-term | ✅ Done 2026-10-11 |
| 7 | **Study transcript TTL policy**; co-decide the TTL value with Anuj (storage = S3 w/ TTL, 2–6 mo proposed) | Daily Catchup 6/2 | Before storage build | ✅ Done 2026-10-11 |
| 8 | **Close duplicate** "transmit from external meeting tools" ticket + link to ENG-79199; inform Nataliya | Nellie roadmap 6/4 | Near-term | ✅ Done 2026-10-11 |
| 9 | Respond to **Hemant's open questions** posted in the transcript channel (tagged Lalit) | Daily Catchup 6/3 | Near-term | ✅ Done 2026-10-11 |
| 10 | Join Pankaj's 11am AI-initiatives call (ping Sriram if not on it) | Pankaj/Lalit 6/4 | — | ✅ Done 2026-10-11 |
| 11 | Identify 5–8 Rainforest cohort participants (3–4 Managers, 2–3 ICs, 1–2 Admins) for JTBD switch interviews — see `jtbd.md` §8 + `research/switch-interview-guide.md` | JTBD v1 2026-05-14 | After Rainforest go-live (slipped from 5/31; tracks ~Aug release) | ⛔ Not needed 2026-10-11 |
| 12 | Run JTBD switch interviews + synthesize forces; promote Big Jobs hypothesis→validated; bump `jtbd.md` status | JTBD v1 2026-05-14 | Within 2 weeks of Rainforest go-live | ⛔ Not needed 2026-10-11 |

## Lalit's open items — June 9–30 backfill (2026-06-30)

> From the Zoom-summary backfill. Items marked 🟦 are **system-of-record changes that must land in a refinement call** (per process rules — capture here, don't execute unilaterally).

| # | Action | From | Deadline | Status |
|---|--------|------|----------|--------|
| 13 | 🔥 **Deliver finalized recap/prep key fields (data points) to Sagar** — gates his prompt-engineering start | Estimations 6/30 | **~July 2 (hard)** | ✅ Done 2026-10-11 |
| 14 | **Write spike stories per rec component** (skill graph, pre-processing, runtime generation) | Rec. Arch 6/29 | Near-term | ✅ Done 2026-10-11 |
| 15 | **Clean up AI module enable/disable ticket doc** (proposed solutions + AI-vs-other-pod ownership split) → share w/ Nellie; log action-button-visibility bug to Eden's UI team; add AC to Tejas's ticket | 6/18 | Near-term | ✅ Done 2026-10-11 |
| 16 | **Confirm documented meeting tag-state matrix** (upcoming vs past) | Meetings 6/25 | Near-term | ✅ Done 2026-10-11 |
| 17 | **Reach out to Jason Seitz (Talent team)** re privacy-preserving skill-search API for AI recommendations | Nellie 1:1 6/23 | Near-term | ✅ Done 2026-10-11 |
| 18 | **Set up shared Google Drive** of sample 1:1 transcripts for Hemant's POC; share link w/ Nellie | Nellie 1:1 6/10 | — | ✅ Done 2026-10-11 |
| 19 | **Assess Docebo integration feasibility with Rinku** before committing | Nellie 1:1 6/15 | Before Phase-2 commit | ⛔ Not needed 2026-10-11 |
| 20 | **1:1 with Prasanna** to scope his delivery-manager / process-support role for the AI team | Nellie 1:1 6/15, 6/23 | Near-term | ✅ Done 2026-10-11 |
| 21 | **Explore ownership of the Slackbot/MCP connector**; design **notifications-batching UI**; add **personal goals** in Betterworks | Nellie 1:1 6/29 | Ongoing | ✅ Done 2026-10-11 |
| 22 | **Resolve webhook routing** (single `account_id` URL vs per-org) with Pankaj + Danish | Project Plan 6/16 | Before integration impl | ✅ Done 2026-10-11 |
| 23 | 🟦 **Rename parent epic ENG-79199** (drop "pipeline-only" implication) | Nellie 1:1 6/10 | Refinement call | ⛔ Not needed 2026-10-11 |
| 24 | 🟦 **Create Phase-2 (Winter) Aha feature** for goals/recognition/skills extraction + update Confluence summer/winter split (Teams marked out) | Nellie 1:1 6/10 | Refinement call | ✅ Done 2026-10-11 |
| 25 | 🟦 **Move speaker-resolution + user-revoke stories to MeetingsPod** | Refinement 6/10 | Refinement call | ✅ Done 2026-10-11 |

## Lalit's open items — July–Oct backfill (2026-10-11)

> Extracted from `ops/meeting-notes/` 7/1–8/13 + Zoom recordings 8/14–10/11 (only substantive one: AI Platform Refinement 9/17) (no completion markers exist in the notes — **all unverified**; triage in the Actions UI: Done / Not needed). Items 6/30-era (#13–25) not re-listed.

| # | Action | From | Deadline | Status |
|---|--------|------|----------|--------|
| 26 | InfoSec (Brian Jacobs): finish consent docs (incl. admin view), prepare retention/consent doc, request his review — approval needed before summer release | Nellie 1:1 7/6, 7/20; Jira realignment 7/7 | Before summer release | 🔴 Open (unverified) |
| 27 | Raise consent revocation / transcript deletion / artifact retention scenarios with InfoSec | Jira realignment 7/7 | Wk of 7/7 | 🔴 Open (unverified) |
| 28 | Update Confluence enablement docs with Phase One info; notify Mary | Transcripts demo 8/12 | 8/13 | 🔴 Open (unverified) |
| 29 | Meet Veronica; document Legacy batch-notification behavior + requirements (Confluence draft) — gates Aug code-complete for notifications/goals batching | Nellie 1:1 7/20 | 7/21 | 🔴 Open (unverified) |
| 30 | Connect w/ Varnika (Legacy goals-batching demo), then sync w/ Hung | Nellie 1:1 7/8 | Wk of 7/20 | 🟡 Open (unverified) |
| 31 | Confirm global webhook engine is tracked in Aha; request TechWolf integration on roadmap | Nellie 1:1 7/20 | Wk of 7/20 | 🟡 Open (unverified) |
| 32 | Arrange Danish walkthrough of webhooks PR for JB + Ocon; nudge Danish to submit PR; brief JB | Nellie 1:1 7/8, 7/20 | Wk of 7/27 | 🟡 Open (unverified) |
| 33 | Get clarity on inbound webhook framework ownership/delivery; confirm AI needs (transcripts, PDP, TechWolf) covered | Nellie 1:1 7/6 | — | 🟡 Open (unverified) |
| 34 | Docebo vs Udemy API-capability matrix (with India AI team) | LMS sync 7/13 | 7/24 | 🟡 Open (unverified) |
| 35 | Share demo recording + Sigma prototype link with attendees | Transcripts demo 8/12 | — | 🟢 Open (unverified) |
| 36 | Keep transcript tickets live; refine AI feature-flag/settings (1:1 summaries, GenAI); feedback to Hiten | Zoom 7/27 | — | 🟡 Open (unverified) |
| 37 | Update acceptance criteria / wording for input >50% of word limit | Pre-processing sync 7/21 | — | 🟡 Open (unverified) |
| 38 | Reach out to Paul re product-knowledge DB / Gong API; connect w/ Lori Howell (Ripple) on Slackbot/LLM endpoint; follow up w/ JB on internal REST endpoints | Nellie 1:1 7/6, 7/8 | — | 🟡 Open (unverified) |
| 39 | PDP: validate recs w/ Customer Success; thumbs up/down feedback; V1 internal content only; trim influencer section of proposal; test multi-skill output format | Nellie 1:1 7/2; Pankaj 7/2; Rec sync 7/3 | — | 🟡 Open (unverified) |
| 40 | Catch up w/ Nitish/Natalia on course-rec POC (scale, latency); mock-data test scenarios with/without dev goals | Nellie 1:1 7/20; Integrations sync 7/6 | — | 🟡 Open (unverified) |
| 41 | Hackathon/skill-graph follow-ups: loop Nellie on 'people graph' framing; walk Nataliia through skill-graph; share recordings (with Sriram); demo-data script; Talent Graph UI + synthetic data | Hackathon notes 7/14–7/20 | — | 🟢 Open (unverified, likely stale) |
| 42 | Eng follow-ups: confirm embedding-migration prod deploy + close tickets; Gemma upgrade metrics; Gauri DA on LLM golden dataset; translation-service docs to Ankit/Aakansha | Ankit 7/2; Zoom 7/1 | — | 🟢 Open (unverified, likely stale) |
| 43 | Slackbot story owner + showcase at fortnightly AI Projects call; Agentic POC talk w/ Jay-Z | Nellie 1:1 7/6; Aakansha 7/2 | — | 🟢 Open (unverified) |
| 44 | Recurring: monthly catch-ups (Prasanna, Varnika), India PM sync w/ Sharan ~2 wks, share AI/PM courses w/ Neeraj | 1:1s 7/2–7/3 | Recurring | 🟢 Recurring |
| 45 | Bangalore meetup demos; capstone/Manager Copilot zip (7/11); Dev1 inference follow-up (7/1); Cassie soft-skills Q; JZ slot | Various 7/1–7/15 | Passed | ⛔ Likely not needed (event passed) — confirm |
| 46 | **Convert "Feedback Summary Tool" ticket into a spike** (workflow, alternative approaches, define AC) — first item for the winter MCP release | AI Platform Refinement 9/17 | Near-term | 🔴 Open |
| 47 | **Double-check with App Platform team** whether "Implement MCP Tool and Prompt Registration Foundation for AI modules" ticket is needed (AI tools live in the public MCP service) | AI Platform Refinement 9/17 | Near-term | 🟡 Open |
| 48 | **Refine Feedback Summary Tool requirements** — default args (current FY, business quarters), custom date ranges, self/team-member/manager/super-admin scope | AI Platform Refinement 9/17 | Near-term | 🟡 Open |
| 49 | **Sequence winter MCP work:** Feedback Summary → Draft Feedback → Draft Conversations (Goal Assist = MCP prompt, not sequencing) | AI Platform Refinement 9/17 | Near-term | 🟡 Open |

## Lalit's open items — Aug–Oct Zoom summaries backfill (2026-10-11)

> From Zoom AI summaries of 30 meetings 8/31–10/9 (5 pages scanned; **pagination incomplete**; ~134 meetings had no summary/permission, not read). All unverified; Slack/Jira unreachable for cross-check.

| # | Action | From | Deadline | Status |
|---|--------|------|----------|--------|
| 50 | **MCP Tools & Prompts:** Reach out to Mary and Molly to update user docs: enabling Zoom AI for ZoomMate | Perf Partner tools 9/9 | — | 🟡 Open |
| 51 | **MCP Tools & Prompts:** Cross-reference MCP tool inventory spreadsheet vs codebase; second pass (standardize naming, elaborate definitions) | Perf Partner tools 9/9 | — | 🟡 Open |
| 52 | **MCP Tools & Prompts:** Write user stories for AI team: meeting prep/recap, feedback summary, draft feedback → MCP tools + prompts | Perf Partner tools 9/9 | — | 🔴 Open |
| 53 | **MCP Tools & Prompts:** With Nellie: propose monthly MCP tools/prompts release schedule | MCP Session 1 9/21 | — | 🟡 Open |
| 54 | **MCP Tools & Prompts:** Review Nellie's updated doc (MCP prompts approach + tool list) once added | Lalit/Nellie TB 9/23 | — | 🟡 Open |
| 55 | **MCP Meetings tools:** Add comments (API permission gaps, missing update-agenda-item tool) to shared Meetings MCP feature doc | Paul/Lalit 10/7 | — | 🔴 Open |
| 56 | **MCP Meetings tools:** Commit MCP Meetings tools code to GitHub, linked to Paul's Jira tickets; coordinate code review (Varnika, Dhanuj, Anuj) | Paul/Lalit 10/7 | — | 🟡 Open |
| 57 | **MCP Meetings tools:** Give Paul feedback on PM workflow tools; set up recurring meeting with Paul Agustin | Paul/Lalit 10/7 | — | 🟢 Low |
| 58 | **Meetings / transcripts:** Notify Anuj if Nataliya replies with series ID + Zoom meeting ID; ping Nellie re transcript issue/refresh | Meetings Troubleshooting 10/7; 10/7 06:41 | — | 🟡 Open |
| 59 | **Meetings / transcripts:** 10/7 transcript-flow debug follow-ups (call Sagar back; test record upload; prep-call status check) | Sagar/Hemant 10/7 | — | Same day — likely done, confirm |
| 60 | **Meetings / transcripts:** Check alternatives to calendar link/unlink (sync-now, bulk link); keep log of deployment issues | Nellie/Lalit 9/3 | — | 🟡 Open |
| 61 | **Meetings / transcripts:** Ticket: review/rename "Bulk Create 1:1s" (alt "Link Meetings"), with Anika's input | Harshini/Lalit 9/7 | — | 🟡 Open |
| 62 | **Meetings / transcripts:** Ticket: link meeting from series page; convert archived-series ticket to story + add messaging requirement | Harshini/Hiten 9/16 | — | 🟡 Open |
| 63 | **Meetings / transcripts:** Ask Asa who can enable AI Companion / transcripts (users/roles) | Zoom mtg 9/9 | — | 🟡 Open |
| 64 | **Meetings / transcripts:** Assign Harshini as designer in Phase 2; scope all valid transcript UI scenarios → Harshini; speak with Arno Jones | Harshini/Lalit 9/18 | — | 🟡 Open |
| 65 | **Meetings / transcripts:** Manual-upload name-mismatch error should show which name mismatched | Harshini/Lalit 9/18 | — | 🟡 Open |
| 66 | **Meetings / transcripts:** Ticket/epic: onboarding enhancements (activity log, tips, Zoom AI host requirement); evaluate fallback fetch by Zoom Meeting ID with Harshini | Harshini/Lalit 9/25 | — | 🟡 Open |
| 67 | **Meetings / transcripts:** Clarify Teams/Meet spike scope; usability improvements in parallel | Tanveer/Lalit 9/23 | — | Mon 9/28 — likely passed, confirm |
| 68 | **Career Path / AI:** Review Nataliia's prototype, Figma pages and spikes | Career Path/AI vision 9/17 | — | Follow-up was Mon 9/21 — confirm |
| 69 | **Career Path / AI:** Assign AI team member to AI position-skill-recommendation spike; pick up first spike | Career Path AI Engine 9/22 | — | 🟡 Open |
| 70 | **Custom Roles (APP-369/370):** Define per-permission expected behavior/UI (view/list/create/update/delete) for each App Platform page; share in Slack + Confluence | Limited Access UX 9/4 | — | 🔴 Open |
| 71 | **Custom Roles (APP-369/370):** Create recurring weekly review meeting | Limited Access UX 9/4 | — | 🟢 Low |

## Lalit's open items — Aug–Oct Zoom summaries, batch 2 (2026-10-11)

> From ~45 further meetings 8/17–10/8 (Zoom AI summaries; grouped/deduped, **unverified**). Not read: PDP stand-ups, App Platform QA 9/9–10/8, OKR stand-ups. Transcript pass pending.

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
| 3 spikes (ENG-82987 / ENG-82135 / ENG-82992) | Converge on ONE signed-off I/O contract before any story enters a sprint | Before sprint planning | ✅ Done 2026-10-11 |
| POC ENG-82389 (Hemant) | Document outputs (schema, chunking, fixed-vs-open) — gates AI spike close | Before AI spike done | ✅ Done 2026-10-11 |
| Integrations (Rinku) | Zoom Marketplace app submission (8–13 wk review window, runs in parallel) | Submit ASAP (was targeted 6/9; likely slipped) | ✅ Done 2026-10-11 |
| Danish | **Webhook-architecture spike** (generic inbound framework; Nellie drafts story+AC) — integration-side stories blocked until done | Starts wk of 6/9 | ✅ Done 2026-10-11 |
| Anuj | Calendar-service PR (Zoom ID extraction / conferencing data) + meeting-series→Zoom-event edge cases | PR up, blocked on review | ✅ Done 2026-10-11 |
| Nellie | Update Confluence roadmap pages; add LaunchDarkly flags for Lalit's new epics | — | ✅ Done 2026-10-11 |
| Emerson (Goals) | **PATCH at service layer** for `update goal` (MCP V2) — gates Meetings "Create Goal" card | Before Meetings goal flow | ⛔ Not needed 2026-10-11 |
| Danish / Okan | **In-house inbound webhook gateway** (build confirmed; ~9d; dual-use Zoom + LMS) | ~July 10 | ✅ Done 2026-10-11 |
| Sagar / Hemant | Transcript implementation per Estimations plan (recap/prep generation, S3 read, goals pull) | July 1 → ~Aug 10 | ✅ Done 2026-10-11 |
| Anuj + Hiten | EDA-event DB schema + Meetings S3 bucket Terraform (via Emerson) | Early July | ✅ Done 2026-10-11 |
| InfoSec (Brian Jacobs) | Approval of transcript consent/retention wording — gates summer release | Before release | 🔴 Pending (7/20) |
| Nellie | MCP tool inventory + Anthropic design resources to Tejas/Lalit; heads-up to JB on webhooks; Bhavesh pre-processing fiscal-year rollover | — | 🟡 Pending (7/20) |
| Tejas | Customer-reported fiscal-year/pre-processing bug list to Nellie; MCP follow-up w/ Pankaj | — | 🟡 Pending (7/21) |
| Anuj / Harshini | Series-level consent field in backend (after Zoom ingestion review); Figma for consent banner/sensitive flag/multi-upload | — | 🟡 Pending (7/8) |
| Nataliia | LMS/provider ask to Rinku + review placeholders | — | 🟡 Pending (7/13) |
| Saurabh | PDP scope-alignment PRs, merge by Monday | Wk of 8/17 | 🟡 Pending (8/13) |
| Varnika | Mixpanel event tracking for NextGen | — | 🟡 Pending (7/3) |
| Ankit (+ Bhavesh) | **Feedback Summary Tool spike** — can summaries be generated end-to-end in one MCP tool call vs. current multi-call/pre-processed API flow | Next sprint | 🟡 Pending (9/17) |
| Nellie | Log calendar sync error bug (status 0) in Meetings pod → Anuj; create limited-permission test role in Rainforest; update MCP tool list doc + share with JB | — | 🟡 Pending (9/3–9/23) |
| Sarah / Eden | Permission-mapping ticket review; static Figma per page state; read-only field states | — | 🟡 Pending (9/4) |
| Harshini / Hiten | Zoom connection-status UI text, consent modal, banner/tag designs, Figma per scoped scenarios; hide header for archived meetings | — | 🟡 Pending (9/7–9/25) |
| Nataliia | Share spikes/Figma prototype; add Lalit as admin to "Talent only" org; spike quality notes; reschedule scope meeting (Winter vs Spring) | — | 🟡 Pending (9/17–9/22) |
| Tanveer | Teams API change answer + integration-team call for Teams/Meet estimates | Mon 9/28 | 🟡 Pending (9/23) |
| Sagar / Anuj | Transcript trigger investigation (container restart); conferencing-data ticket; review MCP meeting tools; AuthenProxy debug | — | 🟡 Pending (10/7) |
| Paul Agustin | Flesh out Meetings MCP doc; Jira issues for phases/tools assigned to Lalit; share PM workflow tools | — | 🟡 Pending (10/7) |
| Cheau-Long / Jason Bilyeu | Analytics MCP walkthrough; goals/conversation PR links | — | 🟡 Pending (9/24, 10/1) |
| Nellie | Define admin roles, create AHAs, Conversations-team meeting; Gemma 4 notes + CS feedback recording; unlink event from org, demo invite; MCP best-practices link, schedule refinement | — | 🟡 Pending (8/17–9/16) |
| Tejas | NextGen user IDs; Kong checklist; test Zoom w/ Hiten/Anuj; review Phase 1.5 tickets; goals-misattributed follow-up; Champion data | — | 🟡 Pending (8/19–9/16) |
| Danish | Create Zoom app + message Lalit; move new-service PR to prod | — | 🟡 Pending (8/20) |
| Harshini / Hiten / Satish | UI changes in Lalit's doc; consolidated UI ticket; test transcript paste | — | 🟡 Pending (8/20) |
| Anuj | Multi-org event linking feasibility; flexible transcript formats; consent ticket after review | — | 🟡 Pending (8/25–9/1) |
| Sagar / Hemant | Share Hemant's number + Slack copy; implement approved Mixpanel events | — | 🟡 Pending (9/8, 10/6) |
| Tanveer | Capture Teams + Zoom/Meet signals; check existing feedback; Teams customer commitments | — | 🟡 Pending (10/5) |
| Kate / Paul Agustin | Help Nellie with Aha; locate Performance Snapshot policy | — | 🟡 Pending (8/17) |

## Adjacent ownerships (from Nellie roadmap 6/4 — outside ENG-79199, tracked here for visibility)
- **Preview epic** for custom-content-by-tenant notifications (+ spike this sprint; blocked on E2E QA by PM Eden).
- **Business-entities notification epic** (+ spike on how legacy batch notifications work).
- Check what remains for **Custom Roles** support in branding / settings / integrations (ties to [[project_custom_roles]]).

## Archived — May week-1 onboarding (completed)

All May 7–15 onboarding/intro items (recurring with Pankaj; intros to Anuj/Danish/Gauri/Rinku/Varnica; Haven prototypes; Recall-AI POC review; ENG-79199 epic review + story breakdown; vendor-vs-native framing; prototype workshop; GitHub/Metabase access; training modules; BetterAsk intro) are **complete** — superseded by the work that followed (PRD trio, story-audit, the 2026-06-07 Jira decomposition). See git history + `delivery-plan.md` for the original list.

| ✅ | Onboarding (New Hire Orientation, Rainforest + INFOSEC access, Nellie/Sriram/JB 1:1s) | May 4–7 |
