Write the morning orientation section to today's Obsidian daily note.

Today's date: compute at runtime. Daily note path: `YOUR_VAULT_PATH/Daily notes/DD-MM-YYYY.md` (e.g. 25-06-2026.md).

Steps:
1. Check today's daily note for an existing `## Morning` section. If it already exists, stop — do not overwrite or duplicate.

2. Fetch the following in parallel:
   a. **In-progress Linear tickets** — use Linear MCP, list issues assigned to YOUR_LINEAR_EMAIL with state "In Progress". Get title and Linear ID.
   b. **Your open PRs** — `gh pr list --author "@me" --state open --json number,title,url,reviewDecision,reviews` — note review state (approved / changes requested / waiting / no reviews yet).
   c. **Reviews waiting on you** — `gh search prs --review-requested "@me" --state open --json number,title,url,author` — PRs where your review is requested.
   d. **Slack commitments** — read your reminders channel (channel ID: YOUR_SLACK_CHANNEL_ID), messages from user YOUR_SLACK_USER_ID sent today only. Skip any message containing "End of day nudge". These are messages you forwarded as reminders to yourself.

3. Format as a `## Morning` section. Omit any subsection that has no entries.

   ```
   ## Morning

   **Commitments**
   - [forwarded Slack message text]

   **In progress**
   - [TICKET-123] Ticket title

   **Your PRs**
   - #12345 — PR title (waiting on review / approved / changes requested)

   **Reviews waiting on you**
   - #12346 — PR title (from author-name)
   ```

4. Insert the `## Morning` section into today's daily note, after the `# [title]` heading and before `## Remember & Action Items`. If the note does not exist yet, create it with just the Morning section.

5. Report what was written — counts for each category. Say "all clear" if every category is empty.
