#!/usr/bin/env bash
# PostToolUse hook: append an entry to ops/claudemd-changelog.md whenever a
# CLAUDE.md file anywhere in the repo is created or modified via Edit/Write/MultiEdit.
set -euo pipefail

REPO_ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG="$REPO_ROOT/ops/claudemd-changelog.md"

payload="$(cat)"
file_path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"
tool_name="$(printf '%s' "$payload" | jq -r '.tool_name // empty')"

# Only fire on CLAUDE.md files
case "$file_path" in
  */CLAUDE.md|CLAUDE.md) ;;
  *) exit 0 ;;
esac

mkdir -p "$(dirname "$LOG")"
if [ ! -f "$LOG" ]; then
  {
    echo "# CLAUDE.md changelog"
    echo
    echo "Auto-maintained by \`.claude/hooks/log-claudemd-change.sh\` (PostToolUse on Edit/Write/MultiEdit)."
    echo "Each entry records a Claude Code edit to any CLAUDE.md in the tree. Manual edits outside Claude Code are not captured here — rely on \`git log\` for those."
    echo
  } > "$LOG"
fi

ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
rel="${file_path#$REPO_ROOT/}"
git_sha="$(cd "$REPO_ROOT" && git rev-parse --short HEAD 2>/dev/null || echo "-")"

printf -- '- %s — `%s` via %s (HEAD %s)\n' "$ts" "$rel" "$tool_name" "$git_sha" >> "$LOG"
exit 0
