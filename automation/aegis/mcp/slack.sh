#!/usr/bin/env bash
# Slack MCP wrapper — STATIC-TOKEN example (Layer 2, Tier A).
# A local, headless-safe alternative to the remote Slack entry in .mcp.json.
# Invoked by .mcp.json as:  { "command": "bash", "args": ["automation/aegis/mcp/slack.sh"] }
#
# Slack bot token (xoxb-…) is static → no interactive OAuth at run time → serves
# launchd routines. The model sees only tool descriptions — never the token.
#
# GOVERNANCE: reads unrestricted; outbound POSTS (send/schedule message, canvas,
# reactions) are an external side effect → stay host-HITL-gated like any other
# outward action (automation/CLAUDE.md). Aegis drafts messages; a human releases.
set -euo pipefail
cd "$(dirname "$0")"
# shellcheck source=_lib.sh
source ./_lib.sh

# One-time setup:
#   Create a Slack app, add bot scopes, install to the workspace, copy the
#   Bot User OAuth Token (starts with xoxb-), then store it:
#     security add-generic-password -a "$USER" -s "aegis/slack-bot-token" -w -U
#   (Some servers also want a user token xoxp- for search — store as
#    aegis/slack-user-token and add a second kc_get line if your server needs it.)
SLACK_BOT_TOKEN="$(kc_get "aegis/slack-bot-token")"
export SLACK_BOT_TOKEN

# Non-secret config — safe to keep here (no credential material).
# Workspace/team ID (starts with T…); override per-workspace via env if needed.
export SLACK_TEAM_ID="${SLACK_TEAM_ID:-}"

# Actual MCP server command. LEFT EMPTY ON PURPOSE — set to a VETTED,
# VERSION-PINNED server (never @latest). Example (pin the real version you audit):
#   MCP_SLACK_CMD="npx -y @vendor/slack-mcp@1.0.0"
MCP_SLACK_CMD="${MCP_SLACK_CMD:-}"
require_cmd MCP_SLACK_CMD

exec ${MCP_SLACK_CMD}
