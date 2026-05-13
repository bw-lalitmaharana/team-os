---
id: PRD-FEEDBACK-AI-SURFACES
status: stub
parent: PRD-AI-PROCESSING-PIPELINE
promote_when: 3 of 6 split criteria satisfied
owners:
  feedback_pm: "[TBD — Performance pod PM]"
  pm_owner_platform: lalit.maharana@betterworks.com
---

# PRD-FEEDBACK-AI-SURFACES — Stub

> Placeholder. Today the Feedback AI surface area maps to a single platform capability (CAP-010 Template-Bound Feedback Pre-fill). Stays as stub.

## Anticipated capabilities (preview)

- **FB-CAP-101 — Pre-filled feedback drafts on Feedback page** — Slot-filled drafts bound to the user's allowed feedback templates. One-click "log" copies slot values into the real feedback record. Consumes platform CAP-010.
- **FB-CAP-102 — Feedback evidence panel** — Per-draft Why-this panel showing the evidence rows that produced each slot value. Consumes platform CAP-009.

## Platform contracts consumed
- CAP-003 `signal_type = feedback_moment` (positive + constructive)
- CAP-005 Reconciliation
- CAP-009 Why-this provenance
- CAP-010 Template-Bound Feedback Pre-fill (anti-Lattice pattern enforced)

## Promotion trigger
Promote when ≥3 capabilities exist or when Performance pod takes independent ownership.
