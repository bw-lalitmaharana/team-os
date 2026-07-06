---
date: 2026-05-18
meeting: Conversational intelligence architecture discussion
type: architecture
attendees: [Lalit Maharana, Jason Zhang, Danish Sharma, Pankaj Lohmor, Sriram CS]
source: zoom
meeting_uuid: DC2F858B-FFE8-4AB5-A03D-A99A16F69627
backfilled: 2026-07-07
---

# Conversational intelligence architecture discussion — 2026-05-18

## Summary
Architecture discussion on conversational intelligence / meeting-transcript processing. No AI summary or personal notes were generated; only a partial transcript (the last ~2.5 minutes of the session) is available, so the notes below cover only the captured tail of the meeting. The captured portion focused on LLM context-window sizing for meeting transcripts and cross-timezone collaboration with the AI team. (Note: transcript-only, partial source.)

## Key decisions
- For the Gemma model (GMR/Gemma 4), an 8K context input is expected to be enough to accommodate meeting transcripts; can move to 16K input if needed.

## Action items
- [ ] Pankaj / Danish — Do back-of-the-envelope calculations on average meeting size (avg meeting duration × words per minute) to validate context-window sizing, and share with Jason (JZ). Involve Anuj for average meeting-duration data.
- [ ] Pankaj — Hold a meeting with the IT team to discuss the contracts for the request.
- [ ] AI team / integrations — Reach out directly to Prasanna/Sagar (and Tejas, Heyman) to schedule collaboration calls during India daytime; prototype and work together with the AI team.

## Discussion notes
- Jason (JZ): Gemma (GMR4) can provide at least 8K context input, likely enough for meeting transcripts; 16K available if required — team should flag if needed.
- Danish: unsure of average meeting duration (Anuj can help); proposed estimating context needs from average meeting size and words-per-minute.
- Sriram: encouraged the team to connect during India daytime and reach out directly to Prasanna/Sagar to schedule calls; the AI team is available to prototype and collaborate given the shared timezone/area.
- Attendees captured in transcript tail: Jason Zhang, Danish Sharma, Pankaj Lohmor, Sriram CS (Lalit was in the meeting per the recording; only the closing minutes were transcribed).

## Follow-ups / open questions
- Full meeting content (earlier ~33 minutes) was not captured/retrievable — recording access denied — so the broader architecture discussion is not documented here.
