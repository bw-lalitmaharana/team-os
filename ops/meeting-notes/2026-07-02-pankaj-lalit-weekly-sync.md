---
date: 2026-07-02
meeting: Pankaj <> Lalit Weekly Sync
type: 1:1
attendees: [Lalit Maharana, Pankaj Lohmor]
source: zoom
meeting_uuid: 93693197080
backfilled: 2026-07-07
---

# Pankaj <> Lalit Weekly Sync — 2026-07-02

## Summary
The sync focused on scoping AI-driven learning recommendations for the PDP (Personal Development Plan) module. Lalit presented a holistic learning framework covering six dimensions. Pankaj raised significant concerns about the social media / influencer discovery component, leading to agreement to tone it down. Both aligned on prioritizing courses, reading materials, and video content for V1 while deferring more complex features. They also briefly discussed hackathon prep.

## Key decisions
- Social media influencer recommendation dropped from active scope; replaced with a user-driven tracking approach (users self-report social media content consumed).
- V1 scope confirmed: course recommendations, quick reads (articles/blogs), and short-form video content are the priority.
- Influencer/channel discovery will not be platform-driven; Betterworks will not curate or recommend specific social media personalities.
- AI-generated quizzes/questionnaires discussed as a retention tool, distinct from formal certification; third-party validation preferred for credentialed skills.

## Action items
- Lalit: Fine-tune the PDP learning recommendations proposal, especially the social/influencer part — reduce/remove direct influencer recommendations, focus on user-driven tracking and assessments.
- Pankaj: Review the full PDP learning framework and sync with Nitish (integration engineer, already spiked on this) for technical input; optionally schedule a separate call with Lalit and Nitish.

## Follow-ups / open questions
- Final prioritization of PDP features to be confirmed with Natalia (owns roadmap priorities).
- Scope/format of AI-generated quizzes vs. third-party assessment integration unresolved.
- How to implement "applying to work" (experiential learning via Jira/Slack/meeting transcripts) — flagged as futuristic, not scoped for V1.
- Whether a Goal Quality Assessment for development goals (analogous to the existing Goal Quality Assistant) should be included in V1.

## Discussion notes
- Framework spans formal learning (courses), social learning (finding skilled colleagues/mentors), and experiential learning (on-the-job), with six components: reading materials, quick watches, influencers, mentors, courses, and applying learning at work.
- Pankaj's concerns: liability risk of recommending influencers who may post controversial content; marginal value differentiation (users can search YouTube/LinkedIn themselves); technical complexity (multiple API integrations, hallucination risk from LLM summaries, sparse coverage for non-tech skills).
- Pankaj proposed an evolving study-plan / questionnaire-based evaluation approach as more valuable than social discovery.
- Hackathon: Pankaj has an evening meeting with Sagar on infrastructure/LLM-engine changes; joining mainly for architecture questions.

## Next steps
- Pankaj to sync with Nitish; follow-up call if needed. Lalit to revise the social discovery section.
