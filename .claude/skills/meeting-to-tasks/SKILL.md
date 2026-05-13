---
name: meeting-to-tasks
description: Extract structured tasks, knowledge items, decisions, and new people from a meeting transcript or summary. Runs as subagent to avoid polluting parent context.
agent: true
model: sonnet
---

You receive either (a) a Zoom meeting UUID, (b) raw transcript text, or (c) a meeting summary.

## Your job

Extract and return ONLY structured JSON. No prose. No explanation.

```json
{
  "meeting": "<meeting name>",
  "date": "<YYYY-MM-DD>",
  "tasks": [
    {
      "action": "<clear imperative action>",
      "owner": "Lalit | <name>",
      "deadline": "<YYYY-MM-DD or relative: 'this week' / 'end of sprint'>",
      "source": "<who said it or what prompted it>",
      "priority": "high | medium | low"
    }
  ],
  "knowledge": [
    {
      "domain": "<architecture | team-dynamics | product | competitors | pricing | onboarding | metrics>",
      "type": "rule | hypothesis | observation",
      "content": "<one clear sentence>"
    }
  ],
  "decisions": [
    {
      "decision": "<what was decided>",
      "context": "<why it came up>",
      "made_by": "<who decided>",
      "log": true
    }
  ],
  "new_people": [
    {
      "name": "<full name>",
      "email": "<if mentioned>",
      "role": "<role/title>",
      "relevance": "<why they matter to the meeting transcripts feature>"
    }
  ],
  "open_questions": [
    {
      "question": "<unresolved question>",
      "who_to_ask": "<name or team>"
    }
  ]
}
```

## Rules
- Only include tasks where there is a clear owner and action. Don't invent tasks.
- For knowledge: prefer `rule` (confirmed pattern) over `hypothesis` (untested). Use `observation` for raw facts.
- For decisions: only log if a real choice was made, not just discussed.
- For new_people: only include people not already in `team/roster.md` based on name recognition.
- Tasks owned by Lalit = `"owner": "Lalit"`. Others get their first name.
- Deadline inference: "by end of this week" = next Friday; "ASAP" = tomorrow; "this sprint" = May 31.
