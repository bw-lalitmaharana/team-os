# DP-76 / ENG-72524 — Techwolf Skills Taxonomy Integration

**Aha:** `DP-76` · **Jira:** ENG-72524 (Draft, owner Nellie, 2 open-sprint items in flight — Okan A driving)
**Composite score:** 19 (P1)

## Signals

### Synopsys is a named opportunity driver
**Sources:**
- [Slack #oppty_synopsys](https://betterworks.slack.com/archives/) — Tyler Felber, Sam East, Christina Rodriguez, Rob Budzinski (multiple threads Feb–Mar 2026)
**Type:** commitment / competitive
**Owner-impact:** Sales (Tyler, Christina), Nellie, Cheryl

Synopsys uses TechWolf as their skills vendor. Cheryl pitched "BYO Skills" infrastructure to Synopsys during exec alignment. This integration is a deal-influencing item, not just internal tech debt. Status:
- Synopsys went into POC ~March 2026; Performance POC ongoing
- Separate TechWolf integration ask documented; no integration built yet
- Synopsys asked for a TechWolf contact to discuss the integration

**Implication for ranking:** DP-76 likely deserves an "Account Commitment" lift (+3 to +5) if Synopsys POC depends on it. Confirm with Cheryl/Tyler whether TechWolf integration is on the Synopsys recovery/close-plan.

### Adjacent gaps from Synopsys feedback (not in this epic but flagged)
**Source:** [Slack #oppty_synopsys](https://betterworks.slack.com/archives/) — Paul Agustin
**Type:** open-question (related-but-separate)

Paul flagged from Synopsys conversations:
- Rename chatbot/external plugins from "Betterworks" → white-label as "My Performance powered by Betterworks"
- Integration with Degreed (separate LMS)
- LinkedIn Learning / Udemy integration follow-up

**Implication for ranking:** Doesn't change DP-76 directly; surfaces three candidate items for Summer/Winter backlog.

### 2026-06-16 — slack
- **Who:** Tejas S
- **Where:** [#pod-data-platform](https://betterworks.slack.com/archives/CSEURUBDG/p1781596570283749)
- **Summary:** Tejas verified TechWolf integration end-to-end (import and org-enable flow) and posted detailed observations to Jira ENG-77778, tagging Cheau Ng and Okan for review.

### 2026-06-25 — gmail
- **Who:** Zoom (no-reply@zoom.us → lalit.maharana@betterworks.com)
- **Where:** Email thread 19efe0b21f3eb13c — "Meeting assets for Pankaj <> Lalit Weekly Sync are ready!"
- **Summary:** Zoom summary for Pankaj <> Lalit weekly sync includes a TechWolf features update: Lalit discussed TechWolf pay updates and user data maintenance (skills + people data); outlined upcoming features including group creation, retirement, HR admin, MCP beta, custom content by tenant, notifications, email previews, business entities, custom role permissions, and module name translations.

### 2026-06-26 — slack
- **Who:** Cheau-Long Ng
- **Where:** [#pod-data-platform](https://betterworks.slack.com/archives/CSEURUBDG/p1782424757012389)
- **Summary:** Cheau and Okan successfully tested TechWolf import in production on Clone_Synopsys (org 500001539): 39k taxonomy + 20k+ skill profiles imported; Nellie tagged to coordinate TechWolf credentials for real Synopsys org setup — Synopsys integration moving toward production readiness.

### 2026-07-07 — slack
- **Who:** Jason Sites
- **Where:** [#pod-app-platform](https://betterworks.slack.com/archives/C01GYVBME90/p1783383278612039)
- **Summary:** Jason Sites rewrote requirements and shared an ERD for Talent profile skills visibility: group/dept-based access rules governing who sees talent_profile_skills (user self-view, manager view, admin view); explicitly notes skills exist in a globally available skill taxonomy (Lightcast, TechWolf) — signals ongoing engineering work on the skills display layer that DP-76 data feeds into.
