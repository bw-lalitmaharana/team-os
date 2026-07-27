# Meeting-Transcripts (ENG-79199) — Refinement Package, 2026-07-27

Gap analysis + proposed updates to bring **Jira, Confluence, and the repo PRDs** in line with decisions since the 2026-06-07 build-out. **Nothing here has been written to Jira/Aha/Confluence** — per process rules, system-of-record writes happen in a refinement call.

**Source of truth:** `../../signals/ai-201-meeting-transcripts.md` (current to 2026-07-27). Jira, all 4 Confluence PRDs, the repo PRD trio, and `../../jira-diff.md` (dated 2026-05-13) are all behind.

## Files
| File | What it is |
|---|---|
| `jira-refinement-package.md` | Agenda + diff: §0 decisions to resolve first, epic rewrites, structural fixes, decision→ticket map, new stories, deferrals, spike-gate call-out |
| `jira-ready-descriptions.md` | Copy-paste-ready Jira description bodies (4 epics), new-story blocks, and AC snippets |
| `confluence-redlines.md` | Page-by-page (P0→P2) change list for the 4 Confluence PRDs + repo trio |
| `confluence-ready-blocks.html` | Copy-paste-ready HTML section blocks for each page + a full InfoSec page body |
| `infosec-consent-doc.md` | Standalone consent doc for Brian Jacobs (InfoSec) — the overdue-since-7/9 release gate |

## The 5 headline changes that must propagate
1. Recommendations use **structured meeting data only, not the transcript** (7/7).
2. **Reconciliation demoted** to a routine task (7/7).
3. **Consent architecture** — three-level, default opt-in/opt-out, recap needs full consent, third-party join discards recap (7/7–7/21).
4. **Non-happy (no-transcript) path** can't fill the full output — needs a decision (7/22).
5. **Inference substrate locked** — direct LM endpoint, Gemma 4 by ~Aug 10, 64K context (6/29).

## Blocked on a decision before AC/text can be finalized
PII handling · meeting-state model · coaching-cards/item-notes phase · **canonical release dates** (needed for fixVersion) · non-happy-path schema. Details in `jira-refinement-package.md` §0.

## Also stale
`../../jira-diff.md` predates the 6/7 decomposition — rebuild from the ledger after refinement. The 4 Confluence "Research Notes" pages (2026-06-15) were never folded into the PRDs — harvest first.
