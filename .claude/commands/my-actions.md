---
name: my-actions
description: Show all of Lalit's open action items, sorted by deadline. Aggregated from open-actions.md and all meeting notes.
---

Read `product/meeting-transcripts/open-actions.md`.
Scan all files in `ops/meeting-notes/` for action items attributed to Lalit that are not marked complete.

Return a clean table sorted by deadline (soonest first):

| Priority | Action | Deadline | Source |
|----------|--------|----------|--------|
| 🔴 High | ... | ... | ... |
| 🟡 Med | ... | ... | ... |
| 🟢 Low | ... | ... | ... |

After the table, show:
- **Cross-pod items others owe you** (from open-actions.md cross-pod section)
- **Blockers** — anything where you can't proceed until someone else acts

Keep it tight. No prose. This is a quick daily check.
