#!/usr/bin/env bash
# Google Calendar MCP wrapper — OAUTH-REFRESH example (Layer 2, Tier A).
# Invoked by .mcp.json as:  { "command": "bash", "args": ["automation/aegis/mcp/gcal.sh"] }
#
# Flow: pull the cached OAuth client-creds / refresh token from the Keychain,
# inject as an env var, exec the (vetted, pinned) Calendar MCP server. The
# server refreshes the short-lived access token itself on each run, so this is
# non-interactive after the one-time browser grant. The model sees only tool
# descriptions — never the credential.
set -euo pipefail
cd "$(dirname "$0")"
# shellcheck source=_lib.sh
source ./_lib.sh

# One-time setup (see local-mcp-setup.md §Phase-0):
#   1. Create OAuth client creds in Google Cloud console (Desktop app).
#   2. Do the 3-legged browser grant once (temp local FastAPI redirect, PLAN.md §4).
#   3. Store the resulting client-creds / refresh JSON:
#        security add-generic-password -a "$USER" -s "aegis/google-calendar" -w -U
GOOGLE_OAUTH_CREDENTIALS_JSON="$(kc_get "aegis/google-calendar")"
export GOOGLE_OAUTH_CREDENTIALS_JSON

# The actual MCP server command. LEFT EMPTY ON PURPOSE — set it to a VETTED,
# VERSION-PINNED server (never @latest). Example (pin the real version you audit):
#   MCP_GCAL_CMD="npx -y @vendor/google-calendar-mcp@1.2.3"
MCP_GCAL_CMD="${MCP_GCAL_CMD:-}"
require_cmd MCP_GCAL_CMD

exec ${MCP_GCAL_CMD}
