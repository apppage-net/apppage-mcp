# AppPage.net MCP server

A remote [Model Context Protocol](https://modelcontextprotocol.io) server that
gives Claude, ChatGPT, Cursor, VS Code or your own agent **Google Play and App
Store data**, and lets it **build and run websites for mobile apps**: privacy
policy, terms, account deletion page, app-ads.txt, changelog, status page and
more.

- **Endpoint:** `https://apppage.net/mcp` (Streamable HTTP)
- **Free, no signup** for app data: 50 calls a day. A free
  [API key](https://apppage.net/panel/api-keys) raises it to 1000.
- **Registry:** [`net.apppage/app-data`](https://registry.modelcontextprotocol.io/v0/servers?search=net.apppage)
  on the official MCP Registry
- **Docs:** [apppage.net/developers](https://apppage.net/developers)

The server runs at apppage.net; this repository holds its documentation,
client setup and examples. There is nothing to install.

## Connect

### Claude Code

```bash
claude mcp add --transport http apppage https://apppage.net/mcp
```

With a key: add `--header "Authorization: Bearer YOUR_KEY"`.

### Claude (claude.ai and Claude Desktop)

Settings → Connectors → **Add custom connector**, then paste
`https://apppage.net/mcp/account` and click Connect. You log in to
AppPage.net and choose whether Claude may change your sites. For app data
only, without an account, use `https://apppage.net/mcp`.

### ChatGPT

In connector settings (developer mode), create a connector with
`https://apppage.net/mcp/account` and choose **OAuth** as the authentication.
`https://apppage.net/mcp` works without authentication for app data only.

### Cursor

`~/.cursor/mcp.json` (or `.cursor/mcp.json` in a project), see
[examples/cursor.json](examples/cursor.json):

```json
{
  "mcpServers": {
    "apppage": {
      "url": "https://apppage.net/mcp",
      "headers": { "Authorization": "Bearer YOUR_KEY" }
    }
  }
}
```

### VS Code

`.vscode/mcp.json`, see [examples/vscode.json](examples/vscode.json):

```json
{
  "servers": {
    "apppage": {
      "type": "http",
      "url": "https://apppage.net/mcp",
      "headers": { "Authorization": "Bearer YOUR_KEY" }
    }
  }
}
```

### Windsurf, Cline and other clients

Any client that speaks Streamable HTTP: URL `https://apppage.net/mcp`,
optional header `Authorization: Bearer YOUR_KEY` (or `x-api-key: YOUR_KEY`).
Clients that only run local (stdio) servers can bridge with
[`mcp-remote`](https://www.npmjs.com/package/mcp-remote), see
[examples/stdio-bridge.json](examples/stdio-bridge.json).

Leave out the header to use the anonymous tier.

## Tools

### App data (no account needed)

| Tool | What it does |
|---|---|
| `search_apps` | Search Google Play or the App Store by keyword (live results) |
| `get_app` | Full details of one app: developer and contact, rating, installs, version, description, screenshots |
| `get_app_reviews` | User reviews with rating, date, text and app version |
| `get_app_privacy` | Google Play data safety and permissions, or Apple's App Privacy labels |
| `find_alternatives` | Similar apps, compared by rating, price and installs |
| `browse_category` | Top free, paid and grossing charts, overall or per category |
| `get_developer_apps` | A developer's other apps |

Android apps are identified by package name (`com.whatsapp`), iPhone and iPad
apps by numeric App Store id (`310633997`). `search_apps`, `browse_category`
and `get_developer_apps` take `store=google_play` (default) or
`store=app_store`.

### Your app websites (API key with "Can change my sites", or a connected account)

| Tool | What it does |
|---|---|
| `list_my_sites`, `get_site` | Your sites, their pages and app-ads.txt |
| `check_subdomain`, `create_site` | Make `{name}.apppage.net` for a published app, filled from its store listing |
| `generate_page`, `get_page`, `set_page` | Privacy policy, terms, account deletion and support pages, from AppPage.net's templates or your own Markdown |
| `set_app_ads_txt` | The app-ads.txt that AdMob and other ad networks check, validated before it's saved |
| `set_app_links` | Universal Links (`apple-app-site-association`) and Android App Links (`assetlinks.json`) |
| `update_site`, `refresh_site_from_store` | Theme, and a fresh copy of the store listing |
| `get_modules`, `set_module` | Feedback board, bug reports, beta sign-up, promo codes, remote config, changelog, press kit, status page |
| `add_changelog_entry` | A release on the public changelog and its RSS feed |
| `post_status_incident`, `resolve_status_incident` | Incidents on the status page |
| `set_remote_config` | Minimum and latest version, flags, read by your app from `/app-config.json` |
| `get_feedback` | Feature requests and bug reports users sent |
| `set_custom_domain` | Serve a site on your own domain (Pro) |
| `get_plan` | Your plan and today's usage |

Tools that replace content (`set_page`, `set_app_ads_txt`, …) are marked as
destructive, so assistants ask before they run.

## Example prompts

- "Compare the top 5 free meditation apps on Google Play by rating and installs."
- "What data does com.example.app share with third parties?"
- "Summarize the last 50 reviews of 310633997 and group the complaints."
- "Make a website for my app com.example.game with a privacy policy and an account deletion page."
- "Add my AdMob line `google.com, pub-1234567890123456, DIRECT, f08c47fec0942fa0` to my site's app-ads.txt."
- "Post a changelog entry for version 2.4 from the store's What's new text."

## Try it with curl

```bash
curl -s https://apppage.net/mcp -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"get_app","arguments":{"app_id":"com.whatsapp"}}}'
```

More in [examples/curl.sh](examples/curl.sh).

## Limits

| | Calls a day | Site changes a day |
|---|---|---|
| Anonymous (per IP) | 50 | none |
| Free account / API key | 1,000 | 300 (up to 10 new sites) |
| Pro account | 10,000 | 3,000 |

Values missing from a result are unknown, not zero.

## Related

- [app-ads-txt-validator](https://github.com/OWNER/app-ads-txt-validator): CLI and GitHub Action that checks app-ads.txt the way ad networks do
- [Free tools for app developers](https://apppage.net/tools): ASO audit, keyword rank checker, privacy policy generator, app-ads.txt checker, icon and screenshot generators

## Support

Issues and requests: [open an issue](https://github.com/OWNER/apppage-mcp/issues)
or write to info@apppage.net.

## License

Documentation and examples: MIT. The hosted service is covered by the
[AppPage.net terms](https://apppage.net/terms-of-use) and
[privacy policy](https://apppage.net/privacy).
