#!/usr/bin/env bash
# scan-pii.sh — heuristic PII / owner-data scanner for a team-os fork.
#
# Purpose: before you publish a copy of this OS, prove that none of the
# original owner's personal or company data survived the scrub. Run it against
# your fork; it greps for the specific markers known to appear in the source
# repo (names, emails, company, Jira/Aha keys, trigger/env/Slack IDs, absolute
# user paths). Exit 0 = clean; exit 1 = hits found (review each).
#
# It is a HEURISTIC, not a guarantee — it errs toward over-flagging. Add your
# own predecessor-specific terms to .pii-extra (one regex per line) if needed.
#
# Usage:
#   scripts/scan-pii.sh [target-dir]     # default: current directory
#
# NOTE: run this in your FORK. Run against the original repo and it will
# (correctly) light up — the original is the owner's live workspace.

set -euo pipefail

TARGET="${1:-.}"
SELF_REL="scripts/scan-pii.sh"

# --- marker groups -----------------------------------------------------------
# Grouped so the report tells you WHAT kind of leak each hit is.
declare -A PII_GROUPS=(
  [names]='Lalit|Maharana|Nellie|Lemonier|Varni[ck]a|Rinku|Bilyeu|Zhang|Gauri|Harshini|Pankaj|Loh?mor?|Cheryl|Sriram|Nataliya|Anthony'
  [email]='[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
  [company]='Betterworks'
  [jira_aha]='\b(APP|ENG)-[0-9]+\b|\b(CD|MD|ZD|D)-[0-9]{3}\b'
  [service_ids]='trig_[A-Za-z0-9]+|env_[A-Za-z0-9]+|\bD0[A-Z0-9]{8,}\b'
  [user_paths]='-Users-[a-z._-]+|/Users/[a-z._-]+'
  [epics_releases]='Summer 2026|Winter 2026|AI Processing Pipeline|ai-processing-pipeline|custom-roles|Rainforest'
  [vendors]='Synopsys|Techwolf|Gemma'
  [slack_channels]='#(temp|champagne|oppty|eng-|pod-)[A-Za-z0-9_-]+'
)

# Common grep excludes: VCS, deps, and this script (its regexes would self-match).
GREP_COMMON=( -rniE --binary-files=without-match
  --exclude-dir=.git --exclude-dir=node_modules --exclude-dir=.venv
  --exclude="${SELF_REL##*/}" )

# Fold in user-supplied extra patterns, if present.
EXTRA_FILE="${TARGET%/}/.pii-extra"
EXTRA_PATTERNS=""
if [[ -f "$EXTRA_FILE" ]]; then
  EXTRA_PATTERNS="$(grep -vE '^\s*(#|$)' "$EXTRA_FILE" | paste -sd'|' -)"
fi

echo "PII scan → ${TARGET}"
echo "-----------------------------------------------------------------"

total=0
for group in "${!PII_GROUPS[@]}"; do
  pattern="${PII_GROUPS[$group]}"
  # grep exits 1 when no match; don't let that kill the script.
  hits="$(grep "${GREP_COMMON[@]}" -e "$pattern" "$TARGET" 2>/dev/null || true)"
  if [[ -n "$hits" ]]; then
    count="$(printf '%s\n' "$hits" | grep -c . || true)"
    total=$((total + count))
    echo ""
    echo "### [$group]  ($count hit(s))"
    printf '%s\n' "$hits"
  fi
done

if [[ -n "$EXTRA_PATTERNS" ]]; then
  hits="$(grep "${GREP_COMMON[@]}" -e "$EXTRA_PATTERNS" "$TARGET" 2>/dev/null || true)"
  if [[ -n "$hits" ]]; then
    count="$(printf '%s\n' "$hits" | grep -c . || true)"
    total=$((total + count))
    echo ""
    echo "### [custom/.pii-extra]  ($count hit(s))"
    printf '%s\n' "$hits"
  fi
fi

echo ""
echo "================================================================="
if [[ "$total" -eq 0 ]]; then
  echo "CLEAN — no known PII markers found."
  exit 0
else
  echo "FOUND $total potential PII hit(s). Review each before publishing."
  echo "False positives are expected (e.g. a common first name); confirm"
  echo "each hit is either generic or intentionally yours, not inherited."
  exit 1
fi
