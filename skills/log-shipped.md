Pull today's shipped work from Linear and GitHub, then write it to Shipped.md.

Steps:
1. Use the Linear MCP to list issues assigned to YOUR_LINEAR_EMAIL that were completed/done today. For each, get the title, Linear ID, and URL.
2. Use `gh` CLI to list PRs merged today: `gh pr list --author "@me" --state merged --search "merged:>=TODAY" --json number,title,url,mergedAt` (replace TODAY with today's date in YYYY-MM-DD format)
3. For each shipped item, write a one-line entry in this format:
   - `- [[TICKET-ID]] Title — one sentence of what it did or what problem it solved. PR: #number` (omit PR line if no linked PR)
4. Append a dated section to `YOUR_VAULT_PATH/Career/Shipped.md`:
   ```
   ## YYYY-MM-DD
   - [entries]
   ```
   If a section for today already exists, append to it rather than creating a duplicate header.
5. Report back what was logged. Say "nothing shipped today" if both Linear and GitHub were empty.
