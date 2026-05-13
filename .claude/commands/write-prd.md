---
description: Draft a PRD using the prd-agentic skill (Markdown source of truth + A2A agent-card)
---

Use the `prd-agentic` skill at `.claude/skills/prd-agentic/SKILL.md` to draft a PRD.

Steps:
1. Identify the feature/area. If user provided a Jira epic (e.g. ENG-XXXXX), an Aha! id, or a feature name, use it. Otherwise ask.
2. Run the skill's **Step 1: Pre-flight context gathering** — pull from Aha! MCP, Atlassian MCP, and the local repo files listed in the skill.
3. Show the user what was found vs. what's missing. Ask only for genuine gaps.
4. Identify phase (1, 2, or both). Default to Phase 1 if pre-development.
5. Draft into `product/<area>/prds/<slug>/<slug>.prd.md` using `template.md`.
6. Emit `agent-card.json` sibling.
7. Run the `checklist.md` quality gate and report the 3 weakest sections.
8. Only render HTML (via `pmd-template`) if the user asks for Confluence paste.
9. After ship: update `knowledge/<domain>/` and `decisions/` per the skill's Step 7.

Do NOT modify the `pmd-template` skill. Wrap it.
