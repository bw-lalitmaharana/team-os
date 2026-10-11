# Actions UI

Local, zero-dependency editor for `product/meeting-transcripts/open-actions.md`.

```
python3 automation/actions-ui/server.py      # http://127.0.0.1:8765
```

- Shows every table in the file (Lalit's items, backfill, cross-pod) as cards.
- Filter open/done/all, search, one-click Done (stamps today's date) / 🔴 / 🟡 / Blocked, full Edit, + Add.
- Only the edited row is rewritten; the markdown stays the source of truth. If the file changed on disk (e.g. `/meeting-debrief` ran), the save is refused with "reload".
- Binds to 127.0.0.1 only. `ACTIONS_MD=<path>` and `PORT=<n>` override defaults.
- Commit the file yourself after editing; the UI does not touch git.
