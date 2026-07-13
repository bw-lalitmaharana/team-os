---
date: 2026-07-13
meeting: BetterBrain Demo
type: review
attendees: [Paul Agustin, Sweta Kande, Pankaj Lohmor, Balram Agnihotri, Prithvi Singh, Ankit Sharma, Shoreya Gupta, Prasanna Poojary, Aditya Maliyan, Rani Pandit, Sagar Bhat, Bhavesh Vaviya, Manish Tomar, Ajeet Maurya, Dasharath, Hiten Khuman, Shubham Singh, Bhargav Prajapati, Hemant Kumar, Abhishek Punj, Sharan, Harikrishnan S, Atul Kumar, Varnith Kumar, Ankit Bhardwaj, Sujay, Nitish Devadiga, Varnika Garg, Rinku, Lalit Maharana, Neetesh Kaushik, Manroop Parmar, Rishikesh R, Brahadeesh Kishore, Saurabh Pandey, Danish Sharma]
source: zoom
meeting_uuid: E6883F55-1A7F-4997-8768-B0641A214260
---
# BetterBrain Demo — 2026-07-13

## Summary
Paul Agustin walked through BetterBrain, an internal project he built to fix Guru: the existing Guru agent was unconfigured and answered most product questions wrong or with unusable "novel"-length responses. Paul first stood up a product-specific Guru agent with a tighter prompt, then realized the deeper problem was that Guru was pointed at sparse/stale sources (Confluence, Aha, and near-empty Guru cards). That led to BetterBrain: a Codex-based scheduled pipeline that daily pulls status from Aha, scrapes product-relevant Slack channels (#product, #support, #engage-product) for tribal knowledge, and periodically re-syncs Confluence PRDs and weekly support articles. It synthesizes all of this into versioned "product knowledge records" (JSON objects in a GitHub repo) that track first-seen/last-confirmed evidence, source, a confidence score, and any contradictions/open questions — explicitly designed to need less human maintenance than hand-written Guru cards. When BetterBrain doesn't know an answer it says so rather than guessing, which surfaces a gap for a human (often Paul) to fill; that answer then flows back into the corpus. Paul demoed a live query (Hebrew language support) returning a grounded answer with a source pointer.

## Key decisions
- None formally decided in this meeting — this was a demo/FYI, not a scoping session. See open questions below for the two directions raised.

## Action items
- Paul: continue running/maintaining BetterBrain's daily Aha/Slack/Confluence sync and the product-knowledge-record corpus.
- Paul: open to giving repo access to anyone who wants to contribute engineering effort.
- Support team (initiated by Balram/Nitish conversations, per Paul): explore using low-confidence-score records to find support-article gaps.
- Sweta: point interested SE1/SE2 engineers at BetterBrain as an AI-impact project.

## Follow-ups / open questions
- Feedback loop: Sweta asked whether a thumbs-up/down (or similar) reaction on BetterBrain answers could feed back into the confidence score, or route to a human when wrong. Paul agreed this is wanted and pointed to work Balram has already been doing toward a native Slack-agent front end (replacing Guru as the UI layer) that would support this.
- Auto-remediation: Paul's manual gap-filling loop (search code repos when BetterBrain has no answer, then post the answer to Slack) is a candidate to automate — "take the human out of that process."
- Future direction: exposing BetterBrain via MCP as a customer-facing support agent was raised as a possibility, not committed.

## Discussion notes
- Root cause of the original Guru complaints: an unconfigured base agent with no curated source targeting, not a model-quality problem.
- Product and engineering had very few maintained Guru cards — Paul explicitly did not want to add manual-maintenance burden back onto the team, which shaped BetterBrain's design (AI-authored/maintained records vs. hand-written cards).
- Contradiction tracking matters because of fast-moving changes (e.g. NextGen migration making older "classic" product-knowledge records stale) — the pipeline reasons over existing records to flag contradictions rather than silently overwriting.
- Support articles sync weekly; Confluence syncs are point-in-time (re-pulled, not continuously watched); Aha and Slack are pulled daily.
- Balram was called out (by Sweta, jokingly) as also actively building in this space — signals overlapping/complementary work between Paul and Balram worth coordinating on before it duplicates.

## Next steps
- No committed roadmap next steps; Paul remains the owner and is soliciting engineering collaborators. Worth a light-touch check-in if this becomes a real feature request (e.g. the MCP customer-facing-agent idea) since it would then need Aha/Jira surfacing.
