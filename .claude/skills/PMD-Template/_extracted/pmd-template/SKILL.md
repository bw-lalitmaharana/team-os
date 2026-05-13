---
name: pmd-template
description: >
  Fill out the Betterworks Feature Documentation Template (PMD template) by gathering inputs through conversation and producing a clean HTML file optimized for Confluence copy-paste. Use this skill whenever a user wants to write, fill out, complete, or generate a PMD doc, feature spec, feature documentation, product requirements document, or Betterworks feature brief. Also trigger when the user mentions "Phase 1", "Phase 2", "GTM messaging", "MoSCoW", or asks to document a feature for Confluence. This skill guides the conversation, extracts inputs, and produces a ready-to-paste HTML file.
---

# PMD Template Skill

Produces a filled-out Betterworks Feature Documentation Template as a downloadable HTML file optimized for Confluence copy-paste.

The template has two phases:
- **Phase 1: Why It Matters** — Sections 1–7. Strategy and rationale. Completed before development begins.
- **Phase 2: Product Requirements** — Sections 8–12. Execution detail. Completed at least one week before ship.

---

## Step 1: Identify the Phase

Ask the user which phase(s) they need:
- Phase 1 only (pre-dev, strategy/rationale)
- Phase 2 only (requirements/how-it-works)
- Both phases together

**Default heuristic**: If the user is early in the process, default to Phase 1 and mention Phase 2 can be added later. If the feature is nearly shipping or in development, suggest doing both.

---

## Step 2: Gather Inputs

Ask targeted questions grouped naturally by section. Don't ask everything at once. If the user has already provided context, extract what you can and only ask for genuine gaps.

### Phase 1 Inputs

**Header Info**
- Feature name and capability name (if different)
- Seasonal release year (e.g., "Spring 2025")
- Code Ready Date (calendar date)
- Early Access Clients / Contractual Commitments

**Section 1 – Overview**: What is this feature? Who is it for? Where does it sit in the product?

**Section 2 – Problem & Rationale**: Legacy limitations, customer pain points, why Betterworks specifically?

**Section 3 – Benefits & Value**: Per audience: Employees, Managers, Admins/HR/Leaders, CHRO/CEO/CFO (skip if irrelevant)

**Section 4 – GTM Messaging**:
- Core Value Prop: "Turn [input] into [outcome] — so [persona] can [business impact]"
- 2–3 Key Messages (traditional approach → we enable)
- Differentiation: Others do X → We do Y → Why it matters

**Section 5 – Existing Alternatives / Competition**: How is this solved today? Workarounds, competitors, manual processes.

**Section 6 – Key Metrics & Revenue Drivers**: How is success measured? Revenue impact?

**Section 7 – Core Capabilities**: List of capabilities with Aha! and/or Jira story refs. Group by UI, backend, admin.

### Phase 2 Inputs

**Section 8 – What's Changed**: New workflows, UI/UX changes, backend/behavioral changes vs. prior state.

**Section 9 – How It Works**: Setup → User Flow → Admin Config → Permissions → MoSCoW table per capability.

**Section 10 – Assumptions, Dependencies, & Risks**: Three sub-sections. For Risks: include likelihood or mitigation.

**Section 11 – Out of Scope**: Deprioritized features, deferred roadmap items, migration considerations.

**Section 12 – Documentation & Resources**: Links to Figma, Confluence, Jira, Aha!, training docs.

---

## Step 3: Draft the Document

Fill every selected section in clear, confident product language. Quantify where possible. Use `[TBD]` only for genuinely unknown items — never leave a section blank without explanation.

### Writing Guide

**Phase 1 voice**: Compelling, strategic, written for sales reps and leadership.  
**Phase 2 voice**: Precise, execution-ready, written for engineering and design.

**Section 1 – Overview**: 3–5 sentences. What → Who → Where in the ecosystem.

**Section 2 – Problem & Rationale**: Bullet the legacy limitations, pain points, and the "why Betterworks" angle. Be specific — avoid generic language.

**Section 3 – Benefits & Value**: 2–4 bullets per audience segment. Lead with outcomes, not features.

**Section 4 – GTM Messaging**:
- One crisp Value Prop sentence.
- 2–3 Key Message blocks (traditional setup → we enable payoff).
- Differentiation in "Others do X → We do Y → Why it matters" format.

**Section 5 – Alternatives / Competition**: Table format. Name the alternatives accurately. Don't editorialize.

**Section 6 – Key Metrics**: Group as adoption, efficiency, quality, and revenue/ARR.

**Section 7 – Core Capabilities**: Numbered list. Format: `[Capability] — [Aha! link] / [Jira link]`. Group by UI, backend, admin.

**Section 8 – What's Changed**: New workflows / UI changes / Backend changes. Use before/after framing where helpful.

**Section 9 – How It Works**: Setup → User Flows → Admin Config → Permissions → MoSCoW table.

**Section 10 – Assumptions, Dependencies, & Risks**: Three sub-sections. Bullets. Risks include mitigation/likelihood.

**Section 11 – Out of Scope**: Specific bullets. Sub-sections: Future Roadmap / Migration Considerations.

**Section 12 – Resources**: Bullets with links. Use `[Link TBD]` for known-but-unlinked items.

---

## Step 4: Produce the HTML Output

Generate a downloadable `.html` file using the structure below. Save to `/mnt/user-data/outputs/` and present with `present_files`.

```html
<!-- 
  CONFLUENCE IMPORT INSTRUCTIONS:
  1. Open this file in a browser (double-click it)
  2. Select All (Cmd+A / Ctrl+A) and Copy (Cmd+C / Ctrl+C)
  3. In Confluence, create or edit a page, paste into the editor
  Headings, tables, and bullets will transfer cleanly.
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  body { font-family: -apple-system, sans-serif; max-width: 960px; margin: 40px auto; padding: 0 24px; color: #172B4D; }
  h1 { font-size: 26px; border-bottom: 3px solid #0052CC; padding-bottom: 10px; }
  h2 { font-size: 18px; margin-top: 36px; color: #0052CC; border-bottom: 1px solid #DFE1E6; padding-bottom: 6px; }
  h3 { font-size: 14px; font-weight: 600; margin-top: 20px; text-transform: uppercase; letter-spacing: 0.05em; color: #5E6C84; }
  .phase-banner { background: #DEEBFF; border-left: 4px solid #0052CC; padding: 10px 16px; border-radius: 3px; margin: 24px 0 8px; font-weight: 600; color: #0052CC; }
  .meta-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 8px 24px; margin: 12px 0 24px; }
  .meta-item { font-size: 14px; }
  .meta-label { font-weight: 600; color: #5E6C84; font-size: 12px; text-transform: uppercase; }
  table { border-collapse: collapse; width: 100%; margin: 12px 0; }
  th, td { border: 1px solid #DFE1E6; padding: 8px 12px; text-align: left; font-size: 14px; }
  th { background: #F4F5F7; font-weight: 600; }
  ul, ol { padding-left: 20px; }
  li { margin: 4px 0; }
  .moscow-must { color: #00875A; font-weight: 600; }
  .moscow-should { color: #0052CC; }
  .moscow-could { color: #5E6C84; }
  .moscow-wont { color: #BF2600; text-decoration: line-through; }
</style>
</head>
<body>
  <h1>[Feature Name]: [Capability Name]</h1>
  <div class="meta-grid">
    <div class="meta-item"><span class="meta-label">Release</span><br>[Season Year]</div>
    <div class="meta-item"><span class="meta-label">Code Ready Date</span><br>[Date]</div>
    <div class="meta-item"><span class="meta-label">Early Access Clients</span><br>[Clients + dates]</div>
  </div>

  <div class="phase-banner">Phase 1: Why It Matters</div>

  <h2>1. Overview</h2>
  <p>[3–5 sentences: What → Who → Where]</p>

  <h2>2. Problem &amp; Rationale</h2>
  <h3>Legacy Limitations</h3>
  <ul>[bullets]</ul>
  <h3>Customer Pain Points</h3>
  <ul>[bullets]</ul>
  <h3>Why Betterworks</h3>
  <p>[1–2 sentences]</p>

  <h2>3. Benefits &amp; Value</h2>
  <h3>Employees</h3><ul>[bullets]</ul>
  <h3>Managers</h3><ul>[bullets]</ul>
  <h3>Admins / HR / Leaders</h3><ul>[bullets]</ul>
  <!-- Add CHRO/CEO/CFO section only if relevant -->

  <h2>4. GTM Messaging</h2>
  <h3>Core Value Proposition</h3>
  <p>[Turn X into Y — so Z can W]</p>
  <h3>Key Messages</h3>
  <p>[Message 1: Traditional approach... We enable...]</p>
  <p>[Message 2]</p>
  <p>[Message 3]</p>
  <h3>Differentiation</h3>
  <p>Others do [X] → We do [Y] → Why it matters: [Z]</p>

  <h2>5. Existing Alternatives &amp; Competition</h2>
  <table>
    <tr><th>Alternative</th><th>Who / What</th><th>Limitation</th></tr>
    <tr><td>[e.g., Manual process]</td><td>[description]</td><td>[gap]</td></tr>
  </table>

  <h2>6. Key Metrics &amp; Revenue Drivers</h2>
  <h3>Adoption</h3><ul>[bullets]</ul>
  <h3>Efficiency</h3><ul>[bullets]</ul>
  <h3>Quality</h3><ul>[bullets]</ul>
  <h3>Revenue / ARR</h3><ul>[bullets or N/A]</ul>

  <h2>7. Core Capabilities</h2>
  <h3>UI / Front-End</h3>
  <ol>[numbered list with Aha!/Jira links]</ol>
  <h3>Back-End</h3>
  <ol>[numbered list]</ol>
  <h3>Admin Configuration</h3>
  <ol>[numbered list]</ol>

  <!-- Phase 2 block — include only if Phase 2 selected -->
  <div class="phase-banner">Phase 2: Product Requirements</div>

  <h2>8. What's Changed / What's New</h2>
  <h3>New Workflows</h3><ul>[bullets]</ul>
  <h3>UI / UX Changes</h3><ul>[bullets]</ul>
  <h3>Backend / Behavioral Changes</h3><ul>[bullets]</ul>

  <h2>9. How It Works</h2>
  <h3>Setup &amp; Enablement</h3><ol>[steps]</ol>
  <h3>User Flow</h3><ol>[steps]</ol>
  <h3>Admin Configuration</h3><ol>[steps]</ol>
  <h3>Permissions &amp; Visibility</h3><ul>[bullets]</ul>
  <h3>MoSCoW</h3>
  <table>
    <tr><th>Capability</th><th>Classification</th><th>Notes</th></tr>
    <tr><td>[capability]</td><td class="moscow-must">Must Have</td><td>[note]</td></tr>
    <tr><td>[capability]</td><td class="moscow-should">Should Have</td><td>[note]</td></tr>
    <tr><td>[capability]</td><td class="moscow-could">Could Have</td><td>[note]</td></tr>
    <tr><td>[capability]</td><td class="moscow-wont">Won't Have</td><td>[note]</td></tr>
  </table>

  <h2>10. Assumptions, Dependencies, &amp; Risks</h2>
  <h3>Assumptions</h3><ul>[bullets]</ul>
  <h3>Dependencies</h3><ul>[bullets]</ul>
  <h3>Risks / Areas to Monitor</h3><ul>[bullets with likelihood/mitigation]</ul>

  <h2>11. Out of Scope / Known Limitations</h2>
  <ul>[specific deprioritized features]</ul>
  <h3>Future Roadmap Items</h3><ul>[explicitly deferred items]</ul>
  <h3>Migration Considerations</h3><ul>[bullets or link to doc]</ul>

  <h2>12. Documentation &amp; Resources</h2>
  <ul>
    <li>Figma: [link]</li>
    <li>Confluence: [link]</li>
    <li>Jira: [link]</li>
    <li>Aha!: [link]</li>
  </ul>
</body>
</html>
```

---

## Quality Checklist

Before delivering the file, verify:
- Header fields populated (Feature Name, Capability, Release, Code Ready Date)
- Every selected section is filled — no blank sections
- Phase 1: GTM messaging has all three parts (Value Prop, Key Messages, Differentiation)
- Phase 1: Benefits broken out by audience (Employees, Managers, Admins minimum)
- Phase 1: Core Capabilities include Aha!/Jira refs or `[Link TBD]`
- Phase 2: How It Works has a MoSCoW table
- Phase 2: Risks have mitigations or likelihood noted
- Phase 2: Out of Scope explicitly names what's deferred

---

## Tips

- **Phase 1 is strategy, Phase 2 is execution** — voice differs: Phase 1 is compelling, Phase 2 is precise.
- **GTM messaging is for sales reps** — write it so they can repeat it in a demo without the spec in front of them.
- **MoSCoW is a commitment** — "Won't Have" means won't, not "maybe later." Be direct.
- **Out of Scope protects the team** — vague lists cause scope creep. Be specific.
- **Risks are not shameful** — flag them clearly; leadership respects honest scoping.
- **Flag the weakest sections** to the user after drafting — never just fill in a template and ship it silently.
