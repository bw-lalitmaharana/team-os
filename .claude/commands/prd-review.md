---
description: Run the prd-agentic quality checklist against an existing PRD markdown file
---

Given a PRD path (default: most recent `product/**/prds/**/*.prd.md`):

1. Load the file.
2. Run every item in `.claude/skills/prd-agentic/checklist.md` against it.
3. Validate the sibling `agent-card.json` against `agent-card.schema.json`.
4. Output:
   - ✅ Passed checks (one line each, terse)
   - ❌ Failed checks (with file:section pointers and what to fix)
   - **WEAKEST SECTIONS (top 3)** with one-line reasons
5. Do not edit the PRD. Report only.
