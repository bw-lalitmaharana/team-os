#!/usr/bin/env bash
# PreToolUse hook on Read: warn when reading a file >2000 lines.
# Suggests delegating to a subagent (principle 4 in .claude/context-design.md).
# Does not block — emits warning via stderr so Claude can see and decide.
set -euo pipefail

payload="$(cat)"
file_path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"

[ -n "$file_path" ] || exit 0
[ -f "$file_path" ] || exit 0

lines=$(wc -l < "$file_path" 2>/dev/null | tr -d ' ')
[ -n "$lines" ] || exit 0

if [ "$lines" -gt 2000 ]; then
  echo "⚠️  $file_path has $lines lines. Per .claude/context-design.md principle 4, files >2000 lines should be delegated to a subagent (Agent with subagent_type=Explore or general-purpose). Reading into main context burns tokens that compound for the rest of the session." >&2
fi

exit 0
