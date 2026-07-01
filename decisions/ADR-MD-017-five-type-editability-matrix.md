---
id: ADR-MD-017
status: staged
date: 2026-05-20
deciders: PM Owner (LM) — to be ratified at refinement call
related_prd: PRD-MEETINGS-AI-SURFACES
related_decisions: [ADR-MD-013, ADR-MD-015]
---

# ADR-MD-017 — Five-type editability matrix; row vs object source-of-truth rule

## Status
Staged for ratification at next refinement call. PRD v0.6.0 is authored against this decision.

## Context
The 1:1 page already had three implicit "row types" before this work: manual rows (fully editable), admin-policy rows (locked, indicated by 🔒 icon, not removable), and rolled-over rows (manual rows from prior meetings, threaded forward by `action_item.id`).

The AI layer adds two more categories: rows the AI authored (which the user can still edit freely — they're just drafts), and rows that represent a *committed performance object* (a goal, a recognition, a development plan that already exists in the system as a record). These two new types have different edit/delete/complete affordances than the existing three.

Without an explicit matrix, edge cases proliferate: "Can I edit the title of the goal row in the action items list?" "What happens if I check 'complete' on a recognition row?" "Can I delete an admin policy row that's been forwarded from last meeting?" Each question is answerable, but only if there's a governing rule.

The chat session distilled the rule: **editability follows the source of truth.** A row is editable iff the row itself is the source of truth. If the source of truth lives elsewhere (a goal record, a recognition record, an admin policy in the policy engine), the row is a reflection — editing must happen at the source.

## Decision
The system SHALL enforce row-level edit / delete / complete affordances per the matrix below. There are **5 row types**:

| Row type | Created by | Edit text | Delete / Remove | Check complete | Notes |
|---|---|---|---|---|---|
| Manual row | User | ✅ Always | ✅ Always | ✅ Yes | No restrictions |
| AI plain row | AI (no object link) | ✅ Always | ✅ Always | ✅ Yes | Badge gains "✦ AI · edited" qualifier on edit |
| AI typed row — Recognition / Goal / Development | AI (links to object) | ❌ Not inline | ✅ Dismiss only | ❌ Not until Reviewed | Review opens pre-filled side panel; Dismiss removes permanently |
| Committed object row | System (post Review → Save) | ❌ Read-only | ✅ Via overflow menu only | ✅ Pre-checked | Remove from meeting does not delete the linked object |
| Admin policy row 🔒 | Admin | ❌ Never | ❌ Never | ❌ Never | Existing lock icon behavior — unchanged |

**The governing rule (MUST):** editability follows the source of truth. If the row IS the source of truth (manual row, AI plain row, AI typed row in draft), it is editable per its type. If the source of truth lives elsewhere (committed object → record; admin policy → policy engine), the row reflects the external state — editing happens at the source.

## Consequences
- The lock icon 🔒 already used for admin-policy rows is **reused** for committed-object rows. No new affordance needed. Both render with 🔒 in the same position; the difference is in the overflow-menu (admin: no remove; committed-object: remove-from-meeting is allowed).
- Removing a committed-object row from the meeting SHALL NOT delete the linked object. The object lives at its source (goal record, recognition record). Remove-from-meeting is a *meeting-record* operation, not an object operation. UX must communicate this in the overflow menu copy: "Remove from this meeting" (not "Delete recognition").
- AI typed rows are deliberately non-editable inline. This forces the Review → Save flow, which surfaces AI-highlighted fields in the side panel (CAP-208). Editing inline would skip that affordance.
- MOPEN-D12 (typed-row checkbox — muted/non-interactive or hidden) is open; current spec is present-but-muted. Hidden is the alternative if testing shows muted-checkbox creates confusion.
- The five-row count is exhaustive **for the 1:1 detail page**. Other surfaces (Goals page, Recognition page, etc.) may have different row types; this matrix is scoped to the 1:1 page.
- MPAC-11 enforces: manual QA confirms no row type permits an action outside its column.
- The rule "editability follows source of truth" is documented in §3 mental model + §5.1 MUST + this ADR. Engineers and designers can apply it to unspecified row types or edge cases without escalation.

## Source
- claude.ai chat `d3e6e6d2-4fb4-4152-b26d-26f7cb4b3bd7` (2026-05-20)
- PRD-MEETINGS-AI-SURFACES v0.6.0 §5.1
- Existing lock icon convention (admin policy rows)
- Existing rolled-over row convention (manual rows threaded forward by `action_item.id`)
