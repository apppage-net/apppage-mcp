#!/usr/bin/env bash
# Calls the AppPage.net MCP server directly. Set APPPAGE_API_KEY for the
# higher limit; without it you get the anonymous tier (50 calls a day).
set -euo pipefail
URL=https://apppage.net/mcp
AUTH=()
[ -n "${APPPAGE_API_KEY:-}" ] && AUTH=(-H "Authorization: Bearer $APPPAGE_API_KEY")

call() {
  curl -s "$URL" -H "Content-Type: application/json" -H "Accept: application/json, text/event-stream" ${AUTH[@]+"${AUTH[@]}"} -d "$1"
  echo
}

# List the tools
call '{"jsonrpc":"2.0","id":1,"method":"tools/list"}'

# Search Google Play
call '{"jsonrpc":"2.0","id":2,"method":"tools/call","params":{"name":"search_apps","arguments":{"query":"habit tracker"}}}'

# Top free games on the App Store
call '{"jsonrpc":"2.0","id":3,"method":"tools/call","params":{"name":"browse_category","arguments":{"store":"app_store","chart":"top_free","category":"games"}}}'

# Data safety of an Android app
call '{"jsonrpc":"2.0","id":4,"method":"tools/call","params":{"name":"get_app_privacy","arguments":{"app_id":"com.whatsapp"}}}'
