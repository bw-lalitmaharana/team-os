#!/usr/bin/env bash
# PostToolUse hook: warn when any CLAUDE.md grows past its soft limit.
# Soft limits per .claude/context-design.md: root ≤80 lines, sub-folder ≤40 lines.
# Emits a warning to stderr (visible to Claude) — does not block.
set -euo pipefail

REPO_ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"

payload="$(cat)"
file_path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"

case "$file_path" in
  */CLAUDE.md|CLAUDE.md) ;;
  *) exit 0 ;;
esac

[ -f "$file_path" ] || exit 0

lines=$(wc -l < "$file_path" | tr -d ' ')
rel="${file_path#$REPO_ROOT/}"

# Soft limit: root is 80, sub-folders are 40
if [ "$rel" = "CLAUDE.md" ]; then
  limit=80
else
  limit=40
fi

if [ "$lines" -gt "$limit" ]; then
  echo "⚠️  $rel is now $lines lines (soft limit: $limit). See .claude/context-design.md § Sizing rules — consider moving content to a skill or sub-folder." >&2
fi

exit 0
