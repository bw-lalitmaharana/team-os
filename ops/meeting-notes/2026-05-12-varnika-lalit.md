---
date: 2026-05-12
meeting: Varnika / Lalit
type: 1:1
attendees: [Lalit Maharana, Varnika Garg]
source: zoom
meeting_uuid: D236D5E5-A01C-4D20-91C3-935FF3588D90
backfilled: 2026-07-07
---

# Varnika / Lalit — 2026-05-12

## Summary
Lalit's first working discussion with Varnika (PM for meetings and goals) on the MVP scope for AI-driven meeting transcripts, goal suggestions, and cross-platform signal aggregation. The feature extracts actionable insights from meeting transcripts (starting with Zoom) and suggests goals, action items, and agenda topics across Betterworks modules. Lalit presented a draft architecture for processing transcripts and deriving insights; they reviewed the current state of AI features in Goals (writing assistant, AI meeting summary) and how to add suggestion functionality while respecting org-level validation settings. They discussed handling confidential meetings via exclusions, and agreed to scope a Phase 1 MVP focused on meetings (not goals) initially. The 1:1 also included personal/career introductions.

## Key decisions
- Freeze scope for Phase 1 to avoid scope creep; target Phase 1 with Zoom integration, using transcripts for meeting suggestions (action items, agenda topics), with goal suggestions as a stretch target.
- Start with meetings as the initial scope, potentially dropping goals if needed.
- Maintain the same suggestion wireframe for all users while implementing org-level validations for goal attributes (scope, type, mandatory/optional) configured in the admin goals settings page.
- Validations are at the organization level, not the user level — users can customize within set parameters.

## Action items
- [ ] Lalit — Fine-tune the proposed architecture and scope for the meeting transcript AI feature; coordinate with the design team on common UI/UX patterns (suggestion card patterns and placement).
- [ ] Lalit — Connect with Sriram (and Danish) to align on MVP scope, especially transcript integration and deriving insights.
- [ ] Lalit — Work with the team to freeze Phase 1/MVP scope, initially Zoom integration and meeting suggestions.
- [ ] Lalit — Join/schedule a cross-team workshop (design, AI, others) to define and build the end-to-end MVP workflow using internal AI tools.
- [ ] Varnika — Check Aha for existing customer ideas/requests related to meeting-transcript data ingestion and share findings with Lalit.

## Follow-ups / open questions
- How to display goal suggestions on the Goals page (top of the list vs. a separate placeholder) — design team to decide.
- Whether different goal frameworks can be set for different people.
- Validate the MVP with the customer success team before production release for early feedback.

## Discussion notes
- Signal sources: gather signals from meeting transcripts, Slack, Notion, Confluence, and Jira to suggest goals, action items, and skill evidence.
- AI layer responsibilities: summarize transcripts, derive action items, extract goal signals, provide coaching items.
- Reconciliation service: prevent duplicate suggestions and reconcile new signals with existing goals before surfacing; accumulate evidence across multiple meetings over time.
- Centralized suggestion queue: per-user, prioritized (top 3–5 shown), synced across one-on-ones, feedback, and goals pages; dismissing/acting updates all surfaces.
- Two suggestion scopes: aggregate across multiple meetings for new goals, and meeting-specific for progress updates/milestones/timestamps.
- Goal suggestions: approved suggestions pass org-wide settings before publishing; users can reword/adjust within org constraints.
- One-on-one enhancements: suggest action items from current meetings and agenda topics for future meetings; Zoom one-time authorization to auto-ingest transcripts (expand to Teams later); manual transcript add as fallback; exclusion filter for confidential/escalation meetings.
- Suggestion card pattern: title, subtext, evidence link, type label (goal/feedback/skill), CTA, dismiss action.
- Current Goals AI features: writing assistant and AI meeting summary; goal suggestions considered but not yet implemented.
- Sriram context: feature is a new May request just beginning; focus on scope/MVP with one or two modules plus at least one integration; proposed a workshop to create an end-to-end working version using existing AI initiatives.
- Personal/career: Varnika ~3 years at Betterworks (finds next-gen transition rewarding; customers have mixed emotions about changes); Lalit's 7-year prior tenure, background in customer success → product, HR tech via MBA; recently married (Feb); interested in applying performance-management/platform experience.

## Next steps
Start with meetings as initial scope, fine-tune the approach with the design team for common patterns, freeze Phase 1 (Zoom integration + meeting suggestions), align with Sriram/Danish, and run a cross-team AI-assisted workshop to prototype the end-to-end workflow. Varnika to surface any relevant Aha customer requests for the next discussion.
