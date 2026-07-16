---
date: 2026-07-15
meeting: "AI Accelerator Program: India Team Hackathon"
type: review
attendees: [Doug Dennerline, Sriram CS, Nataliya Kolb, Aakansha Srivastava, Paul Agustin, Cheryl Johnson (Porro), Samantha Matheson, Cassie Fulton Flores, Cheau-Long Ng, Sam East, Bruce Walcroft, Jason Bilyeu, Nellie LeMonier, Shubham Tanwar, Jason Zhang, Eden Owen, Ian Gover, Caitlin Collins, Ankit Bhardwaj, Ryan Mulready, Sudin Maharjan, Andrea Lagan, Sanchit Kanwar, Neetesh Kaushik, Jamie Aitken, Kate Malcolm, Dori Tucker, Manish Tomar, Emerson Matthews, Maher Hanafi, Jason Sites, Talia Salvi, Anuj Gunjad, Julian Kelly, Sarah Brose, Greg Saiz, Bhargav Prajapati, Nova Devasia, Harshini Vijay, Rob Budzinski, akhildesai, Jaishankar Nedunchezhian, Austine Joy, Josh Iverson, Shubham Singh, Pankaj Lohmor, Bhavesh Vaviya, Hemant Kumar, Elise Fujimoto, Lalit Maharana, Dasharath Dyavari, Saurabh Pandey, Henry He, Emad Ahmed, Rupesh Raj, Sweta Kande, Will Pratt, Rishikesh R, Balram Agnihotri, Arnav Garg, Shoreya Gupta, Rani Pandit, Tyler Felber, Kristen Young, Donnie Ellstrom, Victor Chen, Aaryan Dewan, Mayank Gupta, Sujay Katakam, Brahadeesh Kishore, Brian Jacobs, Nitish Devadiga, Sharan, Varnith Kumar, Raj Sinkar, Aditya Maliyan, Ankit Sharma, Neeraj Mohan, Saurabh Pandey, Mahesh V]
source: zoom
meeting_uuid: 64C83971-E4C8-43E9-8936-D309E1669136
---
# AI Accelerator Program: India Team Hackathon — 2026-07-15

## Summary
Finale of the 2-week AI Accelerator hackathon: 10 cross-functional teams presented AI-powered feature prototypes built exclusively on existing Betterworks infrastructure (Haven, LLM Engine, KitchenSync, data warehouse), followed by judge scoring and live results.

## Key decisions
- Winner: **Better Ask Cal** (calibration co-pilot), score 4.51 — MCP per service → main agent → AGUI protocol → KitchenSync frontend → Gemma 4 inference, with confidence ratings and source transparency.
- Runner-up: **Internal Mobility Matching**, score 4.04 — closed-loop AI workflow for internal fills using embeddings, cosine search, and a new Matching Service microservice.
- Other strong performers called out: **Performance Partner** and **Skill Graph-Based Recommendations** (Lalit/Neetesh/Manish/Dasharath's team).
- All 10 ideas are now under consideration for a production path with product and engineering leadership.

## Action items
- Doug: share the final judge scoring spreadsheet with all participants.
- Sriram: set up a review with Nataliya Kolb, Maher Hanafi, and product/engineering leadership to evaluate and plan production paths for all 10 presented ideas.
- All teams: be available on Slack for follow-up questions on their demos (per Aakansha's instruction).
- Akhil Desai (Pathfinder): look into grounding job-requirement data beyond LLM world knowledge.
- Akhil Desai (Performance Partner): add clickable resources to the "show evidence" feature.
- Lalit (Skill Graph team): answer Cassie's chat question about soft-skills coverage.
- Aaryan Dewan (Internal Mobility): move forward with go-to-market planning for Talent Mobility.
- Arnav Garg (Compass): pursue a 90-day pilot with two customers to measure adoption and capture stories for a packaging decision.

## Follow-ups / open questions
- Production roadmap and resourcing for all 10 hackathon features — pending the leadership review Sriram is setting up.
- Pathfinder: no approved/connected external data source for job-role requirements yet.

## Discussion notes
- **Pathfinder** (Team: Minimum Viable People) — employee development coach in Haven; four modules (Coach Home, Gap Snapshot, Grow by Doing, Manager Prep); built on a new Code Service using a LangGraph agent; writes back one goal via the Goals API.
- **Performance Partner** — cuts manager review admin time (68% of cycle spent on admin); drafts feedback answers from pre-processed goals/conversations/feedback/recognition data; built on LLM Engine (Gemma) with evidence citations.
- **Better Ask Cal** — admin dashboard shows AI-vs-manager deviation and acceptance rates across managers.
- **Sarthi** (Ripple Reimagined) — manager coaching companion: Insights, Coaching Plan, and Rehearse (AI simulation) modules; exports coaching plans to meeting private notes.
- **AI Pulse** (Analytics + Engage) — combines anonymized team-level engagement with individual performance data; gate-based algorithm enforces data-freshness/anonymity thresholds.
- **Skill Graph-Based Recommendations** — knowledge graph connecting people, skills, and roles; live Talent Graph UI with semantic clustering, exportable results, Lightcast/TechPulse support; supports successor recommendations, talent search, and mentor matching.
- **Better Coached** — manager-driven coaching-plan generator with a warehouse-data → draft → manager-approval → goal-creation flow; matches reportees to accountability partners.
- **Compass** — conversational intelligence layer for HR admins/CHROs, row-level security governed, outputs executive-ready reports; pilot cost ~$250/month.
- **Spark** — signal-detection layer linking conversations → goals → feedback → recognition; pre-fills goal/recognition forms from detected signals.

## Next steps
- Await the product/engineering leadership review of production scoping for all 10 ideas.
- Compass team to scope the proposed 90-day two-customer pilot.
- Track outcome of the leadership review as a signal for whether Skill Graph (AI-203) gets a production commitment.
