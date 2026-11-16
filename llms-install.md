# Installing the AppPage.net MCP server (for AI agents)

This is a hosted (remote) server. There is nothing to clone, build or run.

1. Add a server named `apppage` with transport **Streamable HTTP** and URL
   `https://apppage.net/mcp`.
2. No API key is needed for app data (search, app details, reviews, privacy,
   charts): leave headers empty. This allows 50 calls a day.
3. If the user has an AppPage.net API key (https://apppage.net/panel/api-keys),
   send it as the header `Authorization: Bearer <key>`. That raises the limit
   to 1000 calls a day and, if the key has "Can change my sites" ticked,
   enables the site tools (create_site, set_page, set_app_ads_txt, ...).

Cline (`cline_mcp_settings.json`):

```json
{
  "mcpServers": {
    "apppage": {
      "type": "streamableHttp",
      "url": "https://apppage.net/mcp",
      "disabled": false
    }
  }
}
```

With a key, add `"headers": { "Authorization": "Bearer <key>" }`.

If the client only supports stdio servers, use the bridge:
`npx -y mcp-remote https://apppage.net/mcp`.

Check it works: call `search_apps` with `{"query": "habit tracker"}`; it
returns a list of Google Play apps.
