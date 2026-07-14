#!/usr/bin/env bash
# scan-pii.sh — heuristic secret / PII scanner for a team-os fork.
#
# Purpose: prove that nothing you shouldn't publish survives before you push.
# It scans for TWO classes of leak:
#
#   1. UNIVERSAL secrets — useful to every fork, regardless of origin: live
#      credentials (AWS / GitHub / Slack / OpenAI tokens, private keys, JWTs),
#      quoted password/api_key/secret assignments, and IPv4 addresses. These
#      are the ones that actually hurt if they land in a public repo.
#   2. TEMPLATE-LINEAGE guards — markers from THIS template's source workspace
#      (names, emails, company, Jira/Aha keys, trigger/env/Slack IDs, absolute
#      user paths). They should already be scrubbed; the scan proves it. Once
#      you've made this OS yours these rarely fire — swap in your own
#      predecessor-specific terms via .pii-extra as your data changes.
#
# Exit 0 = clean; exit 1 = hits found (review each).
#
# It is a HEURISTIC, not a guarantee — it errs toward over-flagging. Add your
# own patterns to .pii-extra (one regex per line) if needed.
#
# Usage:
#   scripts/scan-pii.sh [target-dir]     # default: current directory
#
# NOTE: if you forked from a populated workspace, run this in your FORK. Run it
# against the original owner's live repo and it will (correctly) light up.

set -euo pipefail

TARGET="${1:-.}"
SELF_REL="scripts/scan-pii.sh"

# --- marker groups -----------------------------------------------------------
# Grouped so the report tells you WHAT kind of leak each hit is.
# NOTE: parallel indexed arrays (not `declare -A`) so this runs on the bash 3.2
# that ships as /bin/bash on macOS — associative arrays are bash 4+ only.
#
# Two blocks: UNIVERSAL secrets (first — matter to any fork) then
# TEMPLATE-LINEAGE guards (markers specific to this template's source repo).
GROUP_NAMES=(
  # --- universal secrets ---
  secret_tokens credential_assignment ipv4
  # --- template-lineage guards ---
  names email company jira_aha service_ids
  user_paths epics_releases vendors slack_channels numeric_ids
)
GROUP_PATTERNS=(
  # secret_tokens: high-signal live-credential formats (near-zero false positives).
  'AKIA[0-9A-Z]{16}|(ghp|gho|ghs|ghu)_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|xox[baprs]-[A-Za-z0-9-]{8,}|sk-[A-Za-z0-9]{20,}|-----BEGIN [A-Z ]*PRIVATE KEY-----|eyJ[A-Za-z0-9_-]{10,}\.eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]+'
  # credential_assignment: password/secret/api_key set to a QUOTED value (quotes
  # keep prose like "your secret sauce" from firing).
  '(password|passwd|secret|api[_-]?key|access[_-]?key|auth[_-]?token|client[_-]?secret|bearer)['\''"]?[[:space:]]*[:=][[:space:]]*['\''"][A-Za-z0-9/+_.=-]{8,}['\''"]'
  # ipv4: dotted-quad. Localhost / example IPs are expected false positives.
  '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b'
  'Lalit|Maharana|Nellie|Lemonier|Varni[ck]a|Rinku|Bilyeu|Zhang|Gauri|Harshini|Pankaj|Loh?mor?|Cheryl|Sriram|Nataliya|Anthony|Paul'
  '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}'
  'Betterworks'
  '\b(APP|ENG)-[0-9]+\b|\b(CD|MD|ZD)-[0-9]{3}\b'
  'trig_[A-Za-z0-9]+|env_[A-Za-z0-9]+|\bD0[A-Z0-9]{8,}\b'
  '-Users-[a-z._-]+|/Users/[a-z._-]+'
  'Summer 2026|Winter 2026|AI Processing Pipeline|ai-processing-pipeline|custom-roles|Rainforest'
  'Synopsys|Techwolf|Gemma'
  '#(temp|champagne|oppty|eng-|pod-)[A-Za-z0-9_-]+'
  '\bboard +[0-9]+\b|\b[0-9]{9,}\b'
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
for i in "${!GROUP_NAMES[@]}"; do
  group="${GROUP_NAMES[$i]}"
  pattern="${GROUP_PATTERNS[$i]}"
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

# --- opaque/binary files: the scanner can't see inside them, so they must
# --- not exist in a repo that claims to be all-text-and-clean. Hard-flag any.
while IFS= read -r bf; do
  if [[ -s "$bf" ]] && ! grep -qI . "$bf" 2>/dev/null; then
    total=$((total + 1))
    echo ""
    echo "### [opaque-file]  (binary — cannot be PII-scanned; remove or ship as text)"
    echo "$bf"
  fi
done < <(find "$TARGET" -type f -not -path '*/.git/*' 2>/dev/null)

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
