---
date: 2026-07-27
meeting: Zoom Meeting
type: sync
attendees: [Lalit Maharana, Hiten Khuman]
source: zoom
meeting_uuid: 8CD33C63-052C-49AA-A1F4-3D1602F1C7F0
---
# Zoom Meeting — 2026-07-27

## Summary
The meeting focused on the design and integration of AI-driven features for meeting management, including meeting prep, recap, and suggestions. Hiten and Lalit discussed the UI components, such as side panels, banners, and modals, for connecting Zoom and handling transcripts. They reviewed the layout for displaying AI-generated content like action items, goals, and recommendations, and how these elements would be structured and refreshed. The conversation also covered the handling of processing states, potential failure scenarios, and the need for a clear schema to manage AI-generated data. Additionally, they discussed admin settings for enabling AI features and the integration of Zoom at the organization level. The meeting included clarifications on the separation of UI components and the user experience for viewing and interacting with AI-prepared content.

## Key decisions
- Refresh will support two independent levels — Meeting Level and Prep Summary — rather than a single blanket refresh, while keeping existing UI components for personalized support and TPA features.
- Partial-failure handling in AI processing is a hard requirement: the pipeline must stay robust and handle service failures gracefully rather than failing wholesale.
- A schema change is needed to support future AI recommendation tracking and acknowledgment.
- Interface splits into two components — a left-hand side for meetings and a right-hand side for preparation and goals.

## Action items
- **Hiten:** Update the ticket description for the Zoom consent modal and side-panel changes.
- **Hiten:** Implement the UI for the AI Prep, Recap, and Suggestions components, including the fixed JSON structure and loaders.
- **Hiten:** Implement admin settings for Zoom integration, including the feature flag and UI for connecting/disconnecting.
- **Hiten:** Implement functionality for adding goals, action items, and suggestions, ensuring they're meaningful and linked to the correct components.
- **Hiten:** Handle the partial-failure scenario in AI processing so the system stays robust under service failures.
- **Hiten:** Clarify and implement refresh logic for Meeting Prep, Recap, and Suggestions so they update independently.
- **Hiten:** Create the schema change to support future AI recommendation tracking and acknowledgment.
- **Lalit:** Keep the relevant tickets live and update them as necessary.
- **Lalit:** Refine settings and feature flags for AI features, including one-on-one summaries and generative AI.
- **Lalit:** Provide feedback and clarify any doubts regarding the integration and settings.

## Follow-ups / open questions
- Which system tags to use for admin access to AI features was unclear to Hiten; needs clearer documentation.
- Rainforest connections are currently at the instance level rather than user level — open question on whether that needs to change.
- One-on-one summary settings: to be implemented as a feature flag, but data-organization details (including a very large data point volume) remain unclear.

## Discussion notes
- Covered implementation details for meeting-prep functionality, including failure scenarios and status tracking through JSON structures and database updates, plus API access/authentication requirements for the Zoom integration.
- Discussed a one-on-one processing approach for the data pipeline; Lalit clarified the system would let users voluntarily reload to see processing-pipeline changes, with no current blocks in the process.
- Touched on "last mile" implementation work concerning state-level rollout, AI-prep data generation, and layout/loader issues, plus the need for recommendations and linking contracts.
- Discussed loading calendar functionality and backend linking for states, and whether refresh updates should apply to a single meeting instance or the entire meeting-prep system.

## Next steps
- Hiten to work through his 7 tickets (consent modal, component UI, admin settings/feature flag, goals/action-items/suggestions functionality, partial-failure handling, refresh logic, schema change).
- Lalit to keep tickets current and refine AI feature-flag settings.
