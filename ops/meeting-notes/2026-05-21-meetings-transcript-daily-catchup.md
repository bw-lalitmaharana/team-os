---
date: 2026-05-21
meeting: Meetings Transcript - Daily Catchup
type: catchup
attendees: [Lalit Maharana, Pankaj Lohmor, Anuj Pancholi, Tejas S, Nellie LeMonier, Prasanna Poojary, Hemant Kumar, Sagar Bhat]
source: zoom
meeting_uuid: 7A972BCD-632F-46F7-A5E7-B0D4FFD6AC99
backfilled: 2026-07-07
---

# Meetings Transcript - Daily Catchup — 2026-05-21

## Summary
A sync to track progress and unblock a story on AI integration with transcript processing. Pankaj and Anuj discussed finalizing contracts with the AI team; technical discussion centered on transcript data flow and metadata enrichment across services.

Key discussion threads:
- **Story progress:** Pankaj and Anuj finalizing contracts with the AI team; updates to share tomorrow. Anuj needed access to the architecture document (Pankaj to share). Session framed as ongoing progress tracking to continue in future scrums.
- **Metadata processing:** Anuj raised efficiency concerns when multiple services process the same transcript with different contexts (e.g., generating action items vs. goal-related signals from the same event).
- **AI system efficiency:** Discussed having the AI action system handle multiple actions per transcript rather than each service processing individually. Pankaj proposed the AI action system hold configuration "recipes" for processing signal types (pulling data from services via TOML-like specs). Integration team to handle user-ID mapping; possible direct data-warehouse queries by user ID and date range.
- **Transcript data integration:** User IDs are crucial for fetching additional data from the warehouse. Explored tagging transcripts with speaker info (TLDV-style). Integration layer can correlate participant details to Betterworks user IDs and enrich event data.
- **Implementation plan:** Focus initially on 1:1 manager/employee meetings. No bot will join customer calls (security). Challenges mapping Zoom participants to Betterworks (email matching, duplicate names). Raw transcripts with participant info deemed sufficient for MVP; AI can identify participants/context at a high level but may need contextual tuning.
- **AI meeting summary:** Use LLMs (e.g., Claude) to extract action items, agendas, and summaries from raw transcripts. Nellie shared a POC showing reliable participant distinction and action-item identification. Agreed to run a small POC (Sagar, Hemant, Pankaj) to test system integration; document and freeze the architecture for clarity.

## Key decisions
- No bot will join customer calls (security implications).
- Raw transcripts with participant information are sufficient for the MVP.
- Proceed with a small POC to validate the transcript-processing approach.

## Action items
- Anuj: Set up and configure the Zoom app for the POC.
- Lalit: Share updates from design-questions discussions with the team.
- Lalit: Ensure Prasanna is included in future relevant conversations/meetings.
- Pankaj: Provide commenter access to Tejas for the relevant document.
- Pankaj & Anuj: Finalize and share the contract with the AI team tomorrow.
- Sagar, Hemant, Pankaj: Collaborate on a small POC to test the integration/contract using sample Zoom transcripts.
- All: Document open questions, linkages, and freeze the architecture in the shared document to clarify contracts and responsibilities.
- Sagar & Hemant: Connect after the call to discuss the AI layer and share updates with the broader team.

## Follow-ups / open questions
- How to reliably map Zoom participants to Betterworks user IDs (email matching, duplicate names)?
- How to avoid redundant processing when multiple services consume the same transcript event?
