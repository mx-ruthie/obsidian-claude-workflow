Log a Notion page or Linear ticket into today's Obsidian daily note.

The user will provide a URL or ticket ID. Steps:

**If it's a Notion URL:**
1. Use the Notion MCP to fetch the page — get the title, a 2-3 sentence summary of what it covers, and the URL.
2. Append to today's daily note (`YOUR_VAULT_PATH/Daily notes/DD-MM-YYYY.md`) under `## From Slack` — or create a `## Docs & Decisions` section just above `## From Slack` if one doesn't exist:
   ```
   - [[Page Title]] — 2-3 sentence summary. [Notion](url)
   ```

**If it's a Linear ticket URL or ID (e.g. ABC-410):**
1. Use the Linear MCP to get the ticket title, description summary, current status, and URL.
2. Append to today's daily note under a `## Docs & Decisions` section (create it above `## From Slack` if it doesn't exist):
   ```
   - [[LINEAR-ID]] Title — brief summary of what the ticket is about. [Linear](url)
   ```

Always use today's date to determine the correct daily note filename (format: DD-MM-YYYY.md).
Report back the title and where it was logged.
