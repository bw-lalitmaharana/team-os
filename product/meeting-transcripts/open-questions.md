# Open Questions & Decisions — Meetings Transcripts Feature

## Active decisions (unresolved)

### D1: Vendor vs. Native Zoom Integration
**Status:** Open — decide by May 31
**Options:**
- A) Vendor (e.g., Recall AI type) — bot joins meetings, handles retrieval. Sriram's preference. Faster to integrate, but security concerns + user friction.
- B) Native Zoom API direct integration — Nellie's preference. More control, no bot friction, but more build work. CEO has Zoom CEO relationship.
- C) Hybrid — vendor for POC, migrate to native later
**Evidence needed:** Integrations team Zoom API POC results; user friction data on bot approach
**Decision owner:** Lalit (include Sriram until end of May)
**Logged decision will go to:** `decisions/2026-05-XX-vendor-vs-native-zoom.md`

### D2: Processing Architecture — Unified vs. Multi-Pass
**Status:** Open — decide before Week 2 workshop
**Options:**
- A) Single prompt pass — all 4 outputs (summary, action items, signals, coaching) in one call. Lower latency + cost, less quality control.
- B) Multi-pass — separate prompt per capability. Better quality, independent tuning, higher cost + latency.
**Decision owner:** AI team + Lalit
**Logged decision will go to:** `decisions/2026-05-XX-processing-architecture.md`

### D3: Input/Output Schema (Cross-pod Contract)
**Status:** Open — must be agreed before either pod starts building
**What's needed:** Payload schema Meetings pod delivers to AI platform; schema of structured suggestions AI platform returns
**Blocks:** Both pods building in parallel
**Owner:** Lalit (drive), Meetings pod (Varnica), AI platform (Jason Zhang)

### D4: API Versioning for New Endpoints
**Status:** Open — Skills API decision imminent, impacts pipeline API design
**Options:** Extend V1 (V1.5 — Jason Bilyeu preference) vs full V2 rewrite
**Owner:** JB + Nellie + engineering leads
**Lalit's stake:** Pipeline API design depends on this

### D5: Retention Policy for Pending Suggestions
**Status:** Open — decide before Rainforest deploy
**Question:** How long do we keep `pending` suggestions a user never reviews? (e.g., 30 days)
**Owner:** Lalit + Platform pod + Meetings pod (Varnica)

## Closed decisions

### CD1: Recall AI — Rejected
**Decision:** Do NOT use Recall AI or similar bot-based aggregators
**Reasoning:** Security concerns (bot joins customer meetings, records conversations); user friction (extra permissions required)
**Made by:** Nellie (with Lalit agreement, May 5)
**Logged in:** `ops/meeting-notes/2026-05-07-lalit-sriram.md`

## Open technical questions

| # | Question | Who to ask |
|---|----------|-----------|
| Q1 | LLM/AI service architecture — how AI platform fits into NextGen? | Jay-Z (Jason Zhang) |
| Q2 | Which engineers (Anuj, Danish) are allocated to this feature full-time? | Sriram / Nellie |
| Q3 | What Betterworks data is available at inference time for context enrichment? | AI team + Goals pod |
| Q4 | How does speaker attribution get resolved to Betterworks user IDs? | Integrations pod (Rinku) |
| Q5 | What's the event bus schema for async processing state machine? | JB / Pankaj |
| Q6 | Can Zoom transcript retrieval API deliver clean text? What's the format? | Integrations team POC |
