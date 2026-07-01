---
id: ADR-MD-006
status: accepted
date: 2026-05-13 (PM)
deciders: Exec Sponsor (NL)
related_prd: PRD-MEETINGS-AI-SURFACES
---

# ADR-MD-006 — List-page features demoted to V2; only connect nudge ships in MVP

## Status
Accepted.

## Context
During the 2026-05-13 Product Acceptance call (Zoom uuid 7D6A937E), Exec Sponsor reviewed the Meetings PRD scope and stated: "Focus MVP on changes to the details page for meetings, and move list page digest features to stretch/V2." Rationale was MVP scope discipline given the May 31 Rainforest target and a stated preference: "More features require removing features." Two MEET-CAPs were affected: MEET-CAP-101 (list-level rollup digest) and MEET-CAP-102 (list-page signal feed top 3–5).

## Decision
MEET-CAP-101 and MEET-CAP-102 are deferred to V2 / stretch. Only MEET-CAP-103 (connect-source nudge) ships on the list page in MVP. Detail page (MEET-CAP-201 / 202 / 203 / 204 / 205) is the MVP focus.

## Consequences
- Stories M-02 (signal feed) and M-03 (rollup digest) move to V2; freed Meetings-pod capacity in Weeks 5–9.
- North-star metric "engagement on list-page rollup" is not measurable in MVP; relies on detail-page metrics for early signal.
- GTM messaging adjusted: "AI in your 1:1 detail page" rather than "AI signal feed across all your meetings."
- Re-visit V2 prioritization post-launch based on connect-rate + AI-confirm-rate data.

## Source
- Product Acceptance call 2026-05-13 PM (Zoom uuid 7D6A937E-6C54-4362-8AD2-8E16FF3E2A96)
- PRD-MEETINGS-AI-SURFACES §11 + §7 (MEET-CAP-101/102 marked V2)
