---
date: 2026-06-18
meeting: AI tickets for AI module enable/disable
type: sync
attendees: [Lalit Maharana, Nellie LeMonier]
source: zoom
meeting_uuid: B6AAFE92-CCB9-4A30-ADA8-48B09ABA0B67
backfilled: 2026-07-07
---

# AI tickets for AI module enable/disable — 2026-06-18

## Summary
Nellie and Lalit investigated inconsistencies in AI settings behavior relative to module enablement toggles and planned how to structure and assign tickets across teams. They examined module enablement settings (AI features like Goal AI Assist and AI Writing Assist), where they found that settings are not consistently applied and saved. They also noted a UI issue where action buttons sometimes disappear during impersonation mode. Lalit had just come from a Claude Code training session (hosted by Test Rail, led by Prasad Gupta) covering basics like initializing Claude Code, MCP setup, file reads, and scheduling; a key takeaway was breaking skills into smaller composable units. They noted the org had hit its monthly Claude usage limit, with ChatGPT as a fallback.

## Key decisions
- Claude org rate limit confirmed hit for the organization; ChatGPT identified as fallback alternative.
- Action button visibility bug (hidden when impersonating a user) to be logged as a ticket and assigned to Eden's UI team, as it involves a global component.
- AI settings inconsistency (re-enabling a module in system admin restores AI flags even when goals are off) flagged as a known inconsistency to document.

## Action items
- [ ] Lalit — Add proposed solutions to the ticket document, clean it up, and share with Nellie
- [ ] Lalit — Log the action button visibility bug and assign to Eden's UI team
- [ ] Lalit — Update the ticket Tejas referenced with the AC (acceptance criteria) needed
- [ ] Lalit/Nellie — Annotate tickets indicating which items the AI team can own vs. which need placeholder tickets for other pods
- [ ] Nellie — Review recording of the Claude Code training session (optional — noted as basic-level content)

## Follow-ups / open questions
- Whether feedback module toggle behavior can be tested in a clean org (no active sessions).
- Final review of Lalit's cleaned-up documentation/solutions before sharing.

## Discussion notes
- Module enablement and AI settings are not fully linked: disabling a module (e.g., Goals) does not consistently disable its AI features; toggling role settings can turn off flags, but saving system admin settings can restore them.
- Feedback settings land on the templates page by default; toggling off feedback may be blocked by live scheduled sessions in progress.
- One-on-one settings are dependency-linked to the meeting summary feature; disabling requires a page reload to take effect. Proposed solution: auto-reload the page when saving.
- Training session (hosted with Test Rail, led by Prasad Gupta) covered Claude Code basics — MCP setup, file reads, scheduling; key takeaway: break skills into smaller composable units.

## Next steps
- Create placeholder tickets for other pods where additional logic is needed beyond what the current team can implement.
- Continue ticket review in the next available session.
