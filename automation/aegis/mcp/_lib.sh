# shellcheck shell=bash
# Shared helpers for Aegis local MCP wrappers.
# Sourced, never executed directly. No shebang on purpose.

# kc_get <service>  — echo a secret from the macOS Keychain to stdout.
# Fails LOUDLY (to stderr) with the exact `add` command if the item is missing,
# so a missing credential is an obvious setup error, not a silent empty token.
# Never logs the secret itself.
kc_get() {
  local service="$1"
  if [ -z "$service" ]; then
    echo "kc_get: missing service name" >&2
    return 2
  fi
  local secret
  if ! secret="$(security find-generic-password -a "$USER" -s "$service" -w 2>/dev/null)"; then
    echo "aegis/mcp: Keychain item '$service' not found for user '$USER'." >&2
    echo "  Store it once with:" >&2
    echo "    security add-generic-password -a \"\$USER\" -s \"$service\" -w -U" >&2
    return 1
  fi
  if [ -z "$secret" ]; then
    echo "aegis/mcp: Keychain item '$service' is empty; re-store it with -U." >&2
    return 1
  fi
  printf '%s' "$secret"
}

# require_cmd <var-name>  — assert an MCP_<X>_CMD is set; else fail-fast with why.
# Prevents a wrapper from silently doing nothing (or worse, running an
# unpinned package) when the server command hasn't been chosen + pinned yet.
require_cmd() {
  local var="$1"
  if [ -z "${!var:-}" ]; then
    echo "aegis/mcp: \$$var is empty." >&2
    echo "  Edit this wrapper and set it to a VETTED, VERSION-PINNED MCP server command" >&2
    echo "  (see automation/aegis/local-mcp-setup.md — supply-chain warning)." >&2
    return 1
  fi
}
