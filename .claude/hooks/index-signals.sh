#!/usr/bin/env bash
# PostToolUse hook: when a file under product/roadmap/<release>/signals/ is created or modified,
# keep that release's signals/INDEX.md fresh with one line per signal file (last-touched timestamp).
set -euo pipefail

REPO_ROOT="${CLAUDE_PROJECT_DIR:-$(pwd)}"

payload="$(cat)"
file_path="$(printf '%s' "$payload" | jq -r '.tool_input.file_path // empty')"

# Only fire on files inside product/roadmap/<release>/signals/<something>.md
case "$file_path" in
  */product/roadmap/*/signals/*.md) ;;
  *) exit 0 ;;
esac

# Skip if the modified file itself is the INDEX
case "$file_path" in
  */signals/INDEX.md) exit 0 ;;
esac

# Resolve the signals directory for this release
signals_dir="$(dirname "$file_path")"
[ -d "$signals_dir" ] || exit 0

index="$signals_dir/INDEX.md"
release_dir="$(dirname "$signals_dir")"
release_name="$(basename "$release_dir")"

# Regenerate the index — one line per signal file, sorted by most recent
{
  echo "# Signals index — $release_name"
  echo
  echo "Auto-maintained by \`.claude/hooks/index-signals.sh\` (PostToolUse on signals/*.md). Do not hand-edit."
  echo
  echo "| Feature | Last touched | Bytes |"
  echo "|---|---|---|"
  find "$signals_dir" -maxdepth 1 -type f -name '*.md' ! -name 'INDEX.md' -print0 \
    | xargs -0 -I{} sh -c '
        f="$1"
        ts=$(date -u -r "$f" +%Y-%m-%dT%H:%M:%SZ)
        size=$(wc -c < "$f" | tr -d " ")
        name=$(basename "$f" .md)
        printf "%s\t| %s | %s | %s |\n" "$ts" "$name" "$ts" "$size"
      ' _ {} \
    | sort -r | cut -f2-
} > "$index"

exit 0
