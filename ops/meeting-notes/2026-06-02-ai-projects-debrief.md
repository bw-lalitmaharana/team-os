---
date: 2026-06-02
meeting: AI Projects Debrief
type: debrief
attendees: [Jason Zhang, Bhavesh Vaviya, Aakansha Srivastava, Hemant Kumar, Sagar Bhat, Maher Hanafi, Tejas S, Okan Akbulut, Lalit Maharana, Ankit Sharma]
source: zoom
meeting_uuid: F7F7B1F3-934C-46A9-BD94-CAD9CEE3BC2A
backfilled: 2026-07-07
---

# AI Projects Debrief — 2026-06-02

## Summary
Team-wide AI projects debrief hosted by JZ, with round-robin updates from the pod and guidance from Maher (Maher Hanafi). Updates spanned pre-processing/Airflow upgrades, the new AI meeting-transcript feature (POC kicking off), the Meta-Llama → Gemma migration, skills multi-language work, an N8N-based AI alerts workflow, benchmarks/regression via a Claude-based test agent, TechWolf taxonomy import, and the agentic/MCP chat work. Maher's steer: keep this team focused on the platform side (AI primitives) and let product/feature teams build their own features, escalating timeline/resource issues.

## Key decisions
- Platform focus (Maher): as much as possible, focus on the platform side / AI primitives; get support from product & feature teams to build their own features. Escalate timeline/resource issues so leadership can navigate them. Avoid over-investing this team in product features going forward (acceptable for now if it's the only way).
- AI meeting-transcript POC: start with transcript-file processing — extracting relevant chunks from the whole transcript for further processing. Open questions: whether to use service-level embeddings for goals/conversations vs. an alternative; which model (Gemma vs. existing Llama).
- Try Gemma as the backend for the AI alerts workflow (currently uses OpenAI token) and compare against OpenAI.
- Skills multi-language: create skills in different languages saved under the talent schema in the Warehouse DB as the single source of truth; extend to the seven previously-supported languages.
- Schedule an architecture review with Okan and Chao on the meeting-transcript pipeline (after the standup / today's call).

## Discussion notes
- Bhavesh (pre-processing): Phase 2 complete; monitoring auto-scheduled runs over the last two weeks; internal and ProdEU working fine; some stability issues on ProdUS being fixed; upgraded all environments to Airflow 2.11.0 (from unsupported 2.5.1). On Cloud EU the AI pre-processing phase is running; on Cloud US the first phase (data gathering) is running.
- Aakansha: integrated Gemma end-to-end and added it for Writing Assistant; added an N8N workflow for AI alerts (fetches on-call person, tags them, attaches RCA) — saving on-call engineers' time. Building (with Akhil) a reusable workflow for all Betterworks bots. AI alerts currently use OpenAI; will try Gemma.
- Hemant: working on the meetings-transcript POC and action-items finalization; connected with Lalit to finalize the user flow; working with Sagar on the pipeline; architecture meeting with Okan/Chao to be scheduled post-standup.
- Sagar: starting the meeting-transcript POC (transcript processing, extracting relevant chunks); open questions on service-level embeddings and model choice; creating skills in different languages under the talent schema (single source of truth) for the seven previously-supported languages; a couple of open discrepancies to sort out with the talent team (message drafted). Recently released the embedding API service to Champagne and other internal environments and generated OpenAI + Gemma embeddings saved in the DB. Priority is the AI meeting transcript. Shared an LLM-engine execution doc; Lalit has a broader cross-bar document.
- Tejas: focused on regression (synopsis); completed benchmarks for four AI features; the Claude-based test agent saved significant manual effort (agents used Claude); experimenting with Betterworks-hosted Gemma models — good results but higher latency than Claude, exploring latency improvements. Coordinating with SREs for one New Relic dashboard per board to catch failures before customers report them. Synopsis migration successful.
- Okan: helping the talent team integrate with TechWolf; working on the taxonomy import; finished the TechWolf API client; now working on the import.
- Lalit: refining the meeting-transcript story; vision is a pipeline taking in multiple sources (incl. Okan's webhook-engine spike to track events, likely part of TechForce) to produce signals across performance and talent. MVP focuses on one source (Zoom transcripts), extracting a couple of signals (create/update goals with recommendations on top) and the meetings module (action items + agenda items). Documenting both technically and from a product perspective; a few design/UI tweaks left, aiming to be through this week; then take help from the meetings team and integrations.
- Ankit: formally joined the team June 1; working with Aakansha on prompt templates for the goal writing assistant; prompt ready and tested on a few examples; needs to add a few test cases.
- JZ: built a proof of concept streaming Gemma from backend to frontend; hooked the MCP public API (running); now focusing on backend observability (token tracking) using an open-source third-party tool for agentic-core visibility.
- Maher: received a request from "DHS"/leadership to look into costs; will do that for everyone.

## Action items
- [ ] Aakansha — Try Gemma as the backend for the AI alerts workflow and compare against OpenAI.
- [ ] Hemant & Sagar — Schedule the meeting-transcript architecture review with Okan and Chao (post-standup).
- [ ] Sagar — Share the drafted message with the talent team to resolve the open skills discrepancies.
- [ ] Tejas — Continue latency improvements for Betterworks-hosted Gemma models; coordinate SREs on one New Relic dashboard per board.
- [ ] Ankit — Add test cases for the goal-writing-assistant prompt templates.
- [ ] JZ — Continue backend observability / token tracking for agentic core.
- [ ] Maher — Look into AI costs across the team (per leadership request).
- [ ] Lalit — Finish meeting-transcript design/UI tweaks this week; then engage the meetings team and integrations.

## Next steps
- Reconnect at the standup; proceed with the meeting-transcript POC and the architecture review with Okan/Chao.
