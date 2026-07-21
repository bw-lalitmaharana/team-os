#!/usr/bin/env bash
# Jira MCP wrapper — STATIC-TOKEN example (Layer 2, Tier A).
# A local, headless-safe alternative to the remote Atlassian entry in .mcp.json.
# Invoked by .mcp.json as:  { "command": "bash", "args": ["automation/aegis/mcp/jira.sh"] }
#
# Static API token → no interactive OAuth at run time → serves launchd routines.
# The model sees only tool descriptions — never the token.
#
# GOVERNANCE: Jira WRITES stay double-gated (host HITL + refinement-window policy)
# no matter what tools this server exposes. Aegis calls READ tools live and DRAFTS
# writes for a refinement session — see automation/CLAUDE.md and PLAN.md §6.
set -euo pipefail
cd "$(dirname "$0")"
# shellcheck source=_lib.sh
source ./_lib.sh

# One-time setup:
#   Create an Atlassian API token (id.atlassian.com/manage-profile/security/api-tokens)
#   and store it:
#     security add-generic-password -a "$USER" -s "aegis/atlassian-api-token" -w -U
JIRA_API_TOKEN="$(kc_get "aegis/atlassian-api-token")"
export JIRA_API_TOKEN

# Non-secret config — safe to keep here (no credential material).
export JIRA_EMAIL="${JIRA_EMAIL:-lalit.maharana@betterworks.com}"
export JIRA_BASE_URL="${JIRA_BASE_URL:-https://betterworks.atlassian.net}"

# Actual MCP server command. LEFT EMPTY ON PURPOSE — set to a VETTED,
# VERSION-PINNED server (never @latest). Example (pin the real version you audit):
#   MCP_JIRA_CMD="npx -y @vendor/jira-mcp@0.4.1"
MCP_JIRA_CMD="${MCP_JIRA_CMD:-}"
require_cmd MCP_JIRA_CMD

exec ${MCP_JIRA_CMD}
