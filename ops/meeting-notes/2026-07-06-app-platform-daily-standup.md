---
date: 2026-07-06
meeting: App Platform - Daily Standup
type: sync
attendees: [Jason Bilyeu, Victor Chen, Emerson Matthews, Nellie LeMonier, Eden Owen, Lalit Maharana]
source: zoom
meeting_uuid: 25ACE9F7-3B57-4432-9DDE-6E113EE3C899
---

# App Platform - Daily Standup — 2026-07-06

## Summary
The team completed several in-progress items including a custom-content language bug fix and skills-module configuration testing on the Rainforest environment. Key discussion centered on MCP vs. Public API V2 architecture differences, a Lessons Learned document for the public MCP rollout, and a duplicate-active-user-account bug that needs reproduction steps before investigation can begin.

## Key decisions
- MCP vs. V2 deployment cadence: V2 follows a 2-week release lifecycle; MCP should update near-instantly and programmatically — tool-explosion risk flagged, requiring diligence on what gets added to MCP.
- Duplicate active user bug: Jason to attempt reproduction; if steps can't be confirmed, the ticket will be closed rather than pursued blindly.
- Custom content bug (language issue): confirmed fixed and merged; ticket moved to product acceptance — Eden to handle.

## Action items
- Jason: incorporate feedback on Encoder View contracts today; attempt to reproduce the duplicate active user bug.
- Jason: share the Lessons Learned document with the full team post-standup.
- Jason: pair with Donnie on the talent tool (~3 hours of work).
- Emerson: finalize write-up covering both the MCP and Public API V2 solutions for team review.
- Eden: complete product acceptance on the custom content ticket; update Aha and documentation.
- Nellie: attempt to recreate the duplicate active user account bug steps; review the LLM tool backlog.
- Victor: test translation updates on the Rainforest environment by changing language in the UI.

## Follow-ups / open questions
- Whether Lessons Learned document content should feed into Emerson's existing tech-debt ticket.
- Succession module work still in progress — no completion date mentioned.

## Discussion notes
- Skills module configuration tested on Rainforest — working.
- Disallowing-notification issue resolved by adding missing chat props to the configuration JSON.
- Lessons Learned document generated for the public MCP rollout using Git history + LLM; includes an audio summary — team review is part of the acceptance criteria.
- Encoder View / Truly Encoder View: feedback received and incorporated; contracts being simplified.
- Duplicate active user accounts bug: discovered while fixing a client's data; team believes it happened via the user-admin UI rather than file upload, but couldn't recall exact repro steps — Nellie/Eden to attempt recreation before Jason invests time.
- Jason noted he's currently light on work after wrapping current tasks and is available to pick up additional items.

## Next steps
- Jason to attempt bug reproduction and share the Lessons Learned doc today.
- Emerson to finish the MCP/V2 write-up for team review.
- Eden to close out product acceptance on the custom content ticket.
