#!/usr/bin/env bash
# new-team-os.sh — generate a clean, personal-data-free copy of this OS.
#
# Copies ONLY the framework files known to be free of the owner's personal
# data, creates the content folders EMPTY (with placeholder CLAUDE.md files),
# and writes a templated root CLAUDE.md full of <PLACEHOLDER> tokens for you
# to fill. It deliberately does NOT copy the owner's meeting notes, PRDs,
# decisions, roster, signals, daily briefs, or the skills/commands that have
# names / emails / trigger IDs baked in.
#
# The reusable-but-contaminated skills (prd-agentic, sync-prd, sense-backlog,
# meeting-to-tasks, audit-context, the routine commands) are NOT auto-copied,
# because copying them would re-import PII. Port them in one at a time, scrub
# each, and run scan-pii.sh — see QUICKSTART.md § "Add the advanced skills".
#
# Usage:
#   scripts/new-team-os.sh ../my-team-os
#
# After it runs:
#   cd ../my-team-os
#   git init
#   ./scripts/scan-pii.sh .      # must print CLEAN before you push anywhere
#   claude                       # fill in the <PLACEHOLDER> tokens

set -euo pipefail

DEST="${1:-}"
if [[ -z "$DEST" ]]; then
  echo "usage: scripts/new-team-os.sh <target-dir>" >&2
  exit 2
fi
if [[ -e "$DEST" && -n "$(ls -A "$DEST" 2>/dev/null || true)" ]]; then
  echo "error: '$DEST' exists and is not empty. Pick a fresh path." >&2
  exit 1
fi

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
mkdir -p "$DEST"
DEST="$(cd "$DEST" && pwd)"

echo "Generating clean team-os skeleton"
echo "  from: $SRC"
echo "  into: $DEST"
echo ""

copy() { # copy <relative-path> — only if it exists in the source
  local rel="$1"
  if [[ -e "$SRC/$rel" ]]; then
    mkdir -p "$DEST/$(dirname "$rel")"
    cp -R "$SRC/$rel" "$DEST/$rel"
    echo "  + $rel"
  fi
}

# --- verified-clean framework files -----------------------------------------
copy ".claude/hooks"
copy ".claude/settings.json"
copy ".claude/context-design.md"
copy ".claude/commands/standup.md"
copy ".claude/commands/spec-review.md"
copy ".claude/commands/prd-review.md"
copy ".claude/commands/write-prd.md"
copy ".claude/skills/tldr-pdf"
copy ".mcp.json"
copy ".gitignore"
copy "scripts/scan-pii.sh"
chmod +x "$DEST/scripts/scan-pii.sh" 2>/dev/null || true

# --- empty content tree with placeholder CLAUDE.md files ---------------------
placeholder() { # placeholder <dir> <one-line purpose>
  local dir="$1" purpose="$2"
  mkdir -p "$DEST/$dir"
  cat > "$DEST/$dir/CLAUDE.md" <<EOF
# <AREA> — $purpose

House rules for this area (keep ≤40 lines). Replace this placeholder.

- **Owner:** <your-name>
- **Status:** empty scaffold — no content yet
EOF
  echo "  · $dir/ (empty + placeholder CLAUDE.md)"
}

placeholder "product"              "specs, roadmap, research notes (per area)"
placeholder "analytics"            "metrics, queries, playbooks"
placeholder "team"                 "roster, channels, who-does-what"
placeholder "ops"                  "sprint cadence, meeting notes, rituals"
placeholder "knowledge"            "learning loop: rules, hypotheses, observations"
placeholder "decisions"            "decision journal (ADRs)"
mkdir -p "$DEST/ops/daily" "$DEST/ops/meeting-notes" "$DEST/ops/action-notes" \
         "$DEST/ops/focus" "$DEST/analytics/context-audit"

# --- templated root CLAUDE.md ------------------------------------------------
cat > "$DEST/CLAUDE.md" <<'EOF'
# <COMPANY> PM — Team OS

I'm <YOUR-NAME>, <ROLE> at <COMPANY>. This repo is my team's shared context.

## Top-level layout
- `product/` — specs, roadmap, research notes (per area)
- `analytics/` — metrics, queries, playbooks
- `team/` — roster, channels, who-does-what
- `ops/` — sprint cadence, meeting notes, team rituals
- `knowledge/` — learning loop: rules, hypotheses, observations per domain
- `decisions/` — decision journal (ADRs)

## Don't load everything
Each subfolder has its own `CLAUDE.md`. Read that first, then drill in.

## My current focus
- `product/<area>/` — <EPIC / initiative — fill in>

## Context
- Key manager/sponsor: <NAME>
- Key collaborators: <NAMES / ROLES>

## House rules
- Never hallucinate a metric definition; check `analytics/` first.
- Subagent for any read >5 files or >2000 lines (principle 4 in `.claude/context-design.md`).
- Add integrations/tools under a `## Dedicated Tools` section as you connect them.

## See `.claude/context-design.md`
Architecture (time-scales, principles, sizing rules, hooks) lives there.
EOF
echo "  + CLAUDE.md (templated with <PLACEHOLDER> tokens)"

# --- minimal README so the fork is self-describing ---------------------------
cat > "$DEST/README.md" <<'EOF'
# team-os (your copy)

A personal PM operating system for Claude Code, scaffolded from the team-os
framework. Content folders are empty by design — fill them with YOUR data.

Setup: see `QUICKSTART.md` in the source repo. Before publishing this copy,
run `./scripts/scan-pii.sh .` and confirm it prints CLEAN.
EOF
echo "  + README.md (minimal)"

echo ""
echo "Done. Next:"
echo "  cd $DEST"
echo "  ./scripts/scan-pii.sh .      # expect: CLEAN"
echo "  git init && claude           # fill in the <PLACEHOLDER> tokens"
echo ""
echo "To add PRD / backlog / audit skills, port them in one at a time,"
echo "scrub each, and re-run scan-pii.sh (see QUICKSTART.md)."
