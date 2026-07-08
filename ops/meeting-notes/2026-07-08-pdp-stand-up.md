---
date: 2026-07-08
meeting: PDP Stand Up
type: status
attendees: [Nitish Devadiga, Sriram CS, Pankaj Lohmor, Nataliia Savenko, Rinku, Harikrishnan]
source: zoom
meeting_uuid: 145B3FE9-9CE5-4E7E-AA3D-36FCBEC6205B
---

# PDP Stand Up — 2026-07-08

## Summary
Progress-update standup for the PDP/course-recommendations track. Nitish reported his Google Colab text-recommendations spike shows ~10s latency and still needs testing against real Zoom data. Nataliia confirmed background goal creation is an acceptable approach per her session with Saurabh, and that the networking/mentor-connect feature will sit behind its own feature toggle for org-level privacy control. Pankaj reported a working right-side drawer UI with hard-coded data pending LMS search API integration. The team settled on a "fake latency" UX pattern to mask the AI delay and reaffirmed an MVP-first sequencing — ship the rest of the feature now, optimize latency later, gated on an NVIDIA inference-server release the AI team is waiting on.

## Key decisions
- Fake-latency UX pattern adopted: show predetermined "Connect with a Mentor" (~2s) and "Take Courses" (~3s) steps first, then AI-generated suggestions once ready — masks the ~10s AI latency with a loading sequence.
- Latency optimization deferred until the AI team's NVIDIA inference-server release lands; no changes (including MTP Raptors for Gemma, ~2x speedup) until then.
- MVP-first sequencing reaffirmed: build remaining features now, optimize latency closer to release.
- Networking/mentor-connect feature will ship behind a separate feature toggle (per Kate/Natalia's suggestion) so orgs can control whether skills/networking data is shared internally.
- Background goal creation and milestone creation confirmed as acceptable approaches (per Nataliia's session with Saurabh).

## Action items
- Pankaj: Demo the completed front-end screen directly to design and product for early review before Rainforest deployment.
- Pankaj: Integrate the LMS search APIs for the browse-courses section (targeted 1–2 days out).
- Harikrishnan: Move the ticket to product acceptance once QA testing completes.
- Harry: Write/generate test cases so Pankaj can complete manual testing independently.
- Nitish: Test the Google Colab text-recommendations spike on real Zoom data; curate a performance-testing dataset.
- Nitish: Investigate using the life-skill taxonomy to derive personas for text recommendations.
- Nataliia: Wait for Saurabh's spike documentation (settings + background goal creation) before proceeding.
- Nataliia: Implement the feature toggle for the networking feature in admin settings.
- Nitish/AI team: Revisit inference optimization (MTP Raptors, scale graph) once the NVIDIA release is available.

## Follow-ups / open questions
- Whether MTP Raptors for Gemma (~2x inference speedup) gets adopted once the NVIDIA release lands.
- Design/product acceptance review still pending for the front-end screen currently staged in Rainforest.
- Scale-graph approach (an alternative AI-team suggestion) isn't ready — would require dedicated effort before it's viable.

## Discussion notes
- Current AI latency (~10s) was called acceptable relative to the ~40s seen elsewhere in the course-recommendation pipeline.
- Nitish had already checked with Jay-Z (AI team) on latency help; the AI team is blocked on the NVIDIA inference-server release and is not prioritizing optimization until then.
- Sriram framed the deferred-optimization path as good "agile MVP" sequencing, and noted it doubles as a marketing story (10s at MVP → sub-1s within a month).
- Pankaj's Italian/right-side-drawer UI work is functional with hard-coded data; LMS search API wiring is the next step.
- Rinku confirmed the "Connect with a Mentor" UI will be its own section, separate from AI-generated recommendations.

## Next steps
- Nitish to test the recommendations spike against real data; Pankaj to complete LMS integration and get design/product sign-off on the front-end screen before further testing.
