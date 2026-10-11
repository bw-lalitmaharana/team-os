# Open Actions — Meetings Transcripts Feature

Updated after each `/meeting-debrief`. Sorted by priority. **Refreshed 2026-06-08** — the May week-1 onboarding items were completed and archived; current owed items below reflect the May 27–30 recalibration + 2026-06-07 Jira decomposition + the June 1–5 daily-catchup / UX-Sync / roadmap signal. **Backfilled 2026-10-11** with July–Aug meeting-notes signal (#26–45 unverified; #46–49 from 9/17 Zoom summary). **Backfilled 2026-06-30** with June 9–30 Zoom-summary signal — new items #13–25 below; #4 and #5 resolved.

## Lalit's open items (current)

| # | Action | From | Deadline | Status |
|---|--------|------|----------|--------|
| 1 | **Visibility-sharing doc** — PM decisions on visibility/sharing of AI-suggested vs user-added items; include one-sentence B-02 forward-pointer (language drafted in recalibration §H.3) | UX Alignment 2026-05-28 | — (owed to design + eng) | 🔴 Open |
| 2 | **Answer Sagar's open questions** — (a) fiscal-period definition for the goals data window; (b) data-staleness re-trigger policy on failed pre-processing/embedding job (OPEN-D9) | Daily Catchup 2026-05-29 | Before AI inference lock (~mid-June) | 🔴 Open |
| 3 | **Child-PRD Confluence sync** — push team-os versions of Meetings AI Surfaces / Connect Layer / Zoom Connector to Confluence (3 of 4 drifted; parent PRD is in sync). Confluence pushes are manual by Lalit. | Recalibration §H.4 | Before further child-PRD recalibration | 🔴 Open |
| 4 | Ratify **OPEN-D11** (inference substrate) once eng POC lands | Daily Catchup 2026-05-29 | ~mid-June 2026 | ✅ Resolved 2026-06-29 — direct LM inference server, Gemma 4 by Aug 10, 64K ctx |
| 5 | **Design walkthrough with Harshini (Mon 6/9)** → sit with Anuj, break updated designs into stories | Daily Catchup 6/5 | 6/9 | ✅ Done — design sessions 6/11, 6/23, 6/25 finalized the AI surface (5 tags, recap/prep schema); Figma = source of truth |
| 6 | **Document must-have vs nice-to-have** for the summer release (with Harshini); team meetings deferred to Winter | UX Sync 6/3 | Near-term | 🔴 Open |
| 7 | **Study transcript TTL policy**; co-decide the TTL value with Anuj (storage = S3 w/ TTL, 2–6 mo proposed) | Daily Catchup 6/2 | Before storage build | 🔴 Open |
| 8 | **Close duplicate** "transmit from external meeting tools" ticket + link to ENG-79199; inform Nataliya | Nellie roadmap 6/4 | Near-term | 🔴 Open |
| 9 | Respond to **Hemant's open questions** posted in the transcript channel (tagged Lalit) | Daily Catchup 6/3 | Near-term | 🔴 Open |
| 10 | Join Pankaj's 11am AI-initiatives call (ping Sriram if not on it) | Pankaj/Lalit 6/4 | — | 🟡 Open |
| 11 | Identify 5–8 Rainforest cohort participants (3–4 Managers, 2–3 ICs, 1–2 Admins) for JTBD switch interviews — see `jtbd.md` §8 + `research/switch-interview-guide.md` | JTBD v1 2026-05-14 | After Rainforest go-live (slipped from 5/31; tracks ~Aug release) | 🟡 Blocked on go-live |
| 12 | Run JTBD switch interviews + synthesize forces; promote Big Jobs hypothesis→validated; bump `jtbd.md` status | JTBD v1 2026-05-14 | Within 2 weeks of Rainforest go-live | 🟡 Blocked on go-live |

## Lalit's open items — June 9–30 backfill (2026-06-30)

> From the Zoom-summary backfill. Items marked 🟦 are **system-of-record changes that must land in a refinement call** (per process rules — capture here, don't execute unilaterally).

| # | Action | From | Deadline | Status |
|---|--------|------|----------|--------|
| 13 | 🔥 **Deliver finalized recap/prep key fields (data points) to Sagar** — gates his prompt-engineering start | Estimations 6/30 | **~July 2 (hard)** | 🔴 Urgent |
| 14 | **Write spike stories per rec component** (skill graph, pre-processing, runtime generation) | Rec. Arch 6/29 | Near-term | 🔴 Open |
| 15 | **Clean up AI module enable/disable ticket doc** (proposed solutions + AI-vs-other-pod ownership split) → share w/ Nellie; log action-button-visibility bug to Eden's UI team; add AC to Tejas's ticket | 6/18 | Near-term | 🔴 Open |
| 16 | **Confirm documented meeting tag-state matrix** (upcoming vs past) | Meetings 6/25 | Near-term | 🔴 Open |
| 17 | **Reach out to Jason Seitz (Talent team)** re privacy-preserving skill-search API for AI recommendations | Nellie 1:1 6/23 | Near-term | 🟡 Open |
| 18 | **Set up shared Google Drive** of sample 1:1 transcripts for Hemant's POC; share link w/ Nellie | Nellie 1:1 6/10 | — | 🟡 Open |
| 19 | **Assess Docebo integration feasibility with Rinku** before committing | Nellie 1:1 6/15 | Before Phase-2 commit | 🟡 Open |
| 20 | **1:1 with Prasanna** to scope his delivery-manager / process-support role for the AI team | Nellie 1:1 6/15, 6/23 | Near-term | 🟡 Open |
| 21 | **Explore ownership of the Slackbot/MCP connector**; design **notifications-batching UI**; add **personal goals** in Betterworks | Nellie 1:1 6/29 | Ongoing | 🟡 Open |
| 22 | **Resolve webhook routing** (single `account_id` URL vs per-org) with Pankaj + Danish | Project Plan 6/16 | Before integration impl | 🟡 Open |
| 23 | 🟦 **Rename parent epic ENG-79199** (drop "pipeline-only" implication) | Nellie 1:1 6/10 | Refinement call | 🟦 Land in refinement |
| 24 | 🟦 **Create Phase-2 (Winter) Aha feature** for goals/recognition/skills extraction + update Confluence summer/winter split (Teams marked out) | Nellie 1:1 6/10 | Refinement call | 🟦 Land in refinement |
| 25 | 🟦 **Move speaker-resolution + user-revoke stories to MeetingsPod** | Refinement 6/10 | Refinement call | 🟦 Land in refinement |

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

## Cross-pod commitments to track

| Dependency | They owe us | Deadline | Status |
|------------|-------------|----------|--------|
| 3 spikes (ENG-82987 / ENG-82135 / ENG-82992) | Converge on ONE signed-off I/O contract before any story enters a sprint | Before sprint planning | 🔴 In progress (all Draft) |
| POC ENG-82389 (Hemant) | Document outputs (schema, chunking, fixed-vs-open) — gates AI spike close | Before AI spike done | 🟡 In Progress |
| Integrations (Rinku) | Zoom Marketplace app submission (8–13 wk review window, runs in parallel) | Submit ASAP (was targeted 6/9; likely slipped) | 🔴 Pending |
| Danish | **Webhook-architecture spike** (generic inbound framework; Nellie drafts story+AC) — integration-side stories blocked until done | Starts wk of 6/9 | 🔴 Pending |
| Anuj | Calendar-service PR (Zoom ID extraction / conferencing data) + meeting-series→Zoom-event edge cases | PR up, blocked on review | 🟡 Pending |
| Nellie | Update Confluence roadmap pages; add LaunchDarkly flags for Lalit's new epics | — | 🟡 Pending |
| Emerson (Goals) | **PATCH at service layer** for `update goal` (MCP V2) — gates Meetings "Create Goal" card | Before Meetings goal flow | 🔴 Outstanding (longest backend task, 6/29) |
| Danish / Okan | **In-house inbound webhook gateway** (build confirmed; ~9d; dual-use Zoom + LMS) | ~July 10 | 🟡 In progress (6/30) |
| Sagar / Hemant | Transcript implementation per Estimations plan (recap/prep generation, S3 read, goals pull) | July 1 → ~Aug 10 | 🟡 In progress (6/30) |
| Anuj + Hiten | EDA-event DB schema + Meetings S3 bucket Terraform (via Emerson) | Early July | 🔴 Setup gap (6/30) |
| InfoSec (Brian Jacobs) | Approval of transcript consent/retention wording — gates summer release | Before release | 🔴 Pending (7/20) |
| Nellie | MCP tool inventory + Anthropic design resources to Tejas/Lalit; heads-up to JB on webhooks; Bhavesh pre-processing fiscal-year rollover | — | 🟡 Pending (7/20) |
| Tejas | Customer-reported fiscal-year/pre-processing bug list to Nellie; MCP follow-up w/ Pankaj | — | 🟡 Pending (7/21) |
| Anuj / Harshini | Series-level consent field in backend (after Zoom ingestion review); Figma for consent banner/sensitive flag/multi-upload | — | 🟡 Pending (7/8) |
| Nataliia | LMS/provider ask to Rinku + review placeholders | — | 🟡 Pending (7/13) |
| Saurabh | PDP scope-alignment PRs, merge by Monday | Wk of 8/17 | 🟡 Pending (8/13) |
| Varnika | Mixpanel event tracking for NextGen | — | 🟡 Pending (7/3) |
| Ankit (+ Bhavesh) | **Feedback Summary Tool spike** — can summaries be generated end-to-end in one MCP tool call vs. current multi-call/pre-processed API flow | Next sprint | 🟡 Pending (9/17) |

## Adjacent ownerships (from Nellie roadmap 6/4 — outside ENG-79199, tracked here for visibility)
- **Preview epic** for custom-content-by-tenant notifications (+ spike this sprint; blocked on E2E QA by PM Eden).
- **Business-entities notification epic** (+ spike on how legacy batch notifications work).
- Check what remains for **Custom Roles** support in branding / settings / integrations (ties to [[project_custom_roles]]).

## Archived — May week-1 onboarding (completed)

All May 7–15 onboarding/intro items (recurring with Pankaj; intros to Anuj/Danish/Gauri/Rinku/Varnica; Haven prototypes; Recall-AI POC review; ENG-79199 epic review + story breakdown; vendor-vs-native framing; prototype workshop; GitHub/Metabase access; training modules; BetterAsk intro) are **complete** — superseded by the work that followed (PRD trio, story-audit, the 2026-06-07 Jira decomposition). See git history + `delivery-plan.md` for the original list.

| ✅ | Onboarding (New Hire Orientation, Rainforest + INFOSEC access, Nellie/Sriram/JB 1:1s) | May 4–7 |
