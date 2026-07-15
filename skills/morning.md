Optional catch-up: write a `## Morning` section only if today's note is missing one.

Prefer `/eod` the night before — it seeds the next workday's Morning. Use `/morning` only when you open a blank day (skipped EOD, weekend catch-up, etc.).

Today's date: compute at runtime. Daily note path: `YOUR_VAULT_PATH/Daily notes/DD-MM-YYYY.md` (e.g. 25-06-2026.md).

Steps:
1. Check today's daily note for an existing `## Morning` section. If it already exists, stop — do not overwrite or duplicate. Report "already seeded (likely by last night's `/eod`)" and exit.

2. Fetch the following in parallel:
   a. **In-progress tickets** — Linear MCP, list issues assigned to `YOUR_LINEAR_EMAIL` with state "In Progress". Get title and ticket ID.
   b. **Your open PRs** — `gh pr list --author "@me" --state open --json number,title,url,reviewDecision,reviews` — note review state (approved / changes requested / waiting / no reviews yet).
   c. **Reviews waiting on you** — `gh search prs --review-requested "@me" --state open --json number,title,url,author`
   d. **Slack commitments** — read `YOUR_REMINDERS_CHANNEL` (channel ID: `YOUR_SLACK_CHANNEL_ID`), messages from user `YOUR_SLACK_USER_ID`.
      - **Window (built for skipped days):** Find the most recent daily note that has either `## EOD` or `## Morning`. Start the day *after* that note's date, through today (inclusive). Prefer the later of the two if both exist on different days.
      - **Fallback:** If no `## EOD` or `## Morning` exists in the last ~14 days of notes, sweep the last **5 calendar days** through today — do **not** fall back to "today only."
      - **Skip** any message that is a scheduled nudge (contains any of: "End of day nudge", "Good morning", "Run `/morning`", "Run `/eod`", "Anything in Slack today", "Forward" + reminders-channel name, "End of week nudge", "weekly-wins", "First Friday", "`/my-story`", or "Sent using"). These are channel noise, not commitments.

3. Ensure a top-level `## Focus` exists. If missing, add:

   ```
   ## Focus

   - _not set — tell me ticket + one-line goal and I'll fill this in_
   ```

   If `## Focus` already has real content, leave it. Do not invent a focus from the ticket tool.

4. Format as a `## Morning` section. Omit any subsection that has no entries.

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

   If catch-up spanned more than today, note it once under **Commitments**.

5. Insert `## Focus` (if added) and `## Morning` after the `# [title]` heading and before `## Remember & Action Items` (or other body sections). If the note does not exist yet, create it with Focus + Morning.

6. Report what was written — counts for each category. Say "all clear" if every Morning category is empty.
