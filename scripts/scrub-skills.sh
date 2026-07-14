#!/usr/bin/env bash
# scrub-skills.sh — turn a copy of the owner's skills into generic, PII-free
# templates for the public pm-os-starter repo. Deterministic + auditable:
# every substitution rule is listed here, most-specific first.
#
# Usage:
#   scripts/scrub-skills.sh <dir>     # scrubs every .md/.json/.txt under <dir>
#
# After running, ALWAYS gate with scripts/scan-pii.sh <dir> (must print CLEAN)
# and do a human read-through — the scanner is a heuristic, not a proof.
# NOTE: opaque binaries (e.g. packaged *.skill zips) cannot be scrubbed by sed
# and hide from the scanner — ship skills as loose Markdown instead.
set -euo pipefail
DIR="${1:?usage: scrub-skills.sh <dir>}"

mapfile -t FILES < <(find "$DIR" -type f \( -name '*.md' -o -name '*.json' -o -name '*.txt' \))

for f in "${FILES[@]}"; do
  # emails (before names/company)
  sed -i -E 's/[A-Za-z0-9._%+-]+@betterworks\.com/<YOUR-EMAIL>/g' "$f"
  # company
  sed -i -E 's/Betterworks/<COMPANY>/g' "$f"
  # people → role placeholders
  sed -i -E 's/Lalit Maharana|Lalit Kumar Maharana|Lalit/<YOUR-NAME>/g' "$f"
  sed -i -E 's/Nellie Lemonier|Nellie/<MANAGER>/g' "$f"
  sed -i -E 's/Jason Bilyeu|JB/<PM-PEER-A>/g' "$f"
  sed -i -E 's/Jason Zhang/<ENG-LEAD>/g' "$f"
  sed -i -E 's/Varni[ck]a/<PM-PEER-B>/g' "$f"
  sed -i -E 's/Rinku/<PM-PEER-C>/g' "$f"
  sed -i -E 's/Gauri|Harshini|Pankaj|Loh?more?|Cheryl|Sriram|Nataliya|Anthony|Paul/<TEAMMATE>/g' "$f"
  # jira / aha / doc ids
  sed -i -E 's/\b(APP|ENG)-[0-9]+\b/<JIRA-KEY>/g' "$f"
  sed -i -E 's/\b(CD|MD|ZD)-[0-9]{3}\b/<DOC-ID>/g' "$f"
  # service ids
  sed -i -E 's/trig_[A-Za-z0-9]+/<TRIGGER-ID>/g' "$f"
  sed -i -E 's/env_[A-Za-z0-9]+/<ENV-ID>/g' "$f"
  sed -i -E 's/\bD0[A-Z0-9]{8,}\b/<SLACK-DM-ID>/g' "$f"
  # absolute user paths
  sed -i -E 's#/Users/[A-Za-z0-9._-]+#/Users/<you>#g' "$f"
  sed -i -E 's#-Users-[A-Za-z0-9._-]+#-Users-<you>#g' "$f"
  # epics / releases / projects
  sed -i -E 's/Summer 2026|Winter 2026/<RELEASE>/g' "$f"
  sed -i -E 's/summer[_-]?2026/<release-slug>/gI' "$f"
  sed -i -E 's/AI Processing Pipeline/<EPIC-NAME>/g' "$f"
  sed -i -E 's/ai-processing-pipeline/<epic-slug>/g' "$f"
  sed -i -E 's/custom-roles/<area-slug>/g' "$f"
  sed -i -E 's/Rainforest/<PROJECT>/g' "$f"
  # vendors (incl. the "Synopsis" misspelling seen in sense-backlog)
  sed -i -E 's/Synopsys|Synopsis|Techwolf|Gemma/<VENDOR>/g' "$f"
  # internal numeric ids
  sed -i -E 's/board +[0-9]+/board <BOARD-ID>/g' "$f"
  sed -i -E 's/\b[0-9]{9,}\b/<NUMERIC-ID>/g' "$f"
  # slack channels
  sed -i -E 's/#(temp|champagne|oppty|eng-|pod-)[A-Za-z0-9_.-]+/<#channel>/g' "$f"
done
echo "scrubbed ${#FILES[@]} file(s) in $DIR"
echo "next: scripts/scan-pii.sh $DIR   # must print CLEAN, then human-review"
