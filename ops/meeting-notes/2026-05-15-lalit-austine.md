---
date: 2026-05-15
meeting: Lalit / Austine
type: 1:1
attendees: [Lalit Maharana, Austine Joy]
source: zoom
meeting_uuid: 76DA5954-B7EC-4C3E-A654-275380CC4D03
backfilled: 2026-07-07
---

# Lalit / Austine — 2026-05-15

## Summary
Working session between Lalit and Austine (design) on elevating the meetings experience through AI-powered recommendations, focused on one-on-one preparation and reducing cognitive load for managers and employees. No AI summary was generated; notes below are drawn from Lalit's personal notes and the transcript. The core problem: users must manually skim past one-on-ones to prepare and then log actions afterward, creating overhead and risk of missed items. The vision is to synthesize information from multiple sources (Zoom transcripts first, then Slack, Jira, etc.) to automatically surface relevant recommendations and context for one-on-ones.

## Key decisions
- Focus MVP scope on the meetings page specifically, while documenting the caveat that global cross-module patterns need future work.
- AI recommendations belong in the right panel (context/references) to complement the action-taking workflow on the left panel; show top 3–5 most relevant recommendations at a time.
- Recommendations are contextualized to a specific meeting series (one-on-one), not global across all meetings.
- Meetings page shows all recommendation types (goals, feedback, skills) because meetings are a primary, product-owned data source; other pages filter to their own type (goals page shows goal recommendations, feedback page shows feedback recommendations).

## Action items
- [ ] Lalit & Austine — Establish global recommendation design guidelines: define universal elements (CTA, dismiss action, title, evidence sources) while allowing module-specific presentation patterns.
- [ ] Austine (with team input) — Resolve cross-module UX pattern conflicts: confirm whether changing the left/right panel structure in meetings affects feedback/conversation modules, and how recommendations work in goals/recognition, before committing to development.
- [ ] Austine — Brief the group on the right-panel recommendation approach and share updated designs for feedback.
- [ ] Austine — Design the user authentication/consent flow ("Connect to Zoom" with connection-status indicator and manual transcript upload fallback).
- [ ] Lalit — Proceed with solving the meetings page for MVP.
- [ ] Lalit — Define the priority-logic algorithm: how urgency, importance, and immediate relevance rank recommendations, and how dismissals affect future ordering.

## Follow-ups / open questions
- How to handle historical context when users need information from meetings 4+ months ago (Austine suggested a chat interface with Betterworks AI; Lalit's priority system could naturally resurface old signals when relevant).
- Tension between module-specific UX (compact tables in goals vs. panel layouts in meetings/feedback) and establishing universal AI recommendation patterns — needs resolution before full development; may affect MVP scope/timeline.

## Discussion notes
- AI meeting-intelligence architecture (Lalit): extract patterns across all transcripts for a given one-on-one series; generate summaries for previous meetings and recommendations for the latest; maintain a prioritized recommendation dataset ranked by urgency/importance/relevance; source from 6–12 months of transcripts; user dismissals adjust priority ordering.
- Data model: each recommendation has a CTA, dismiss action, title header, and sources/evidence.
- UI placement: left panel = action workspace (agenda items, action items, shared notes); right panel = contextual recommendations and references to external objects (goals, feedback, skills, recognition, last-meeting summaries).
- Austine's context: current meetings page shows all instances with the next meeting expanded (agenda topics, action items, feedback). Right panel is a WIP being standardized by Eden across modules; production currently shows AI summary and goals with hover-to-reveal redirection. Feedback, conversation, and meetings share the same left/right panel structure; not applicable to goals (compact table) or possibly recognition.
- Recommendation types from transcripts: feedback suggestions (log feedback / coaching from signals), skills identification (add identified skills to profile), and goal-related actions.
- Auth/consent: show "connected to Zoom" status; nudge to connect and consent if not; support multiple connections later (Teams, Slack); manual transcript fallback.

## Next steps
Proceed with the meetings-page MVP while defining universal recommendation elements and the priority-logic algorithm, resolve cross-module UX conflicts with the team, and design the Zoom connect/consent flow.
