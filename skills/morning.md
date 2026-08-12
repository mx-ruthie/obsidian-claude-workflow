Optional catch-up: write a `## Morning` section only if today's note is missing one.

Prefer `/eod` the night before — it seeds the next workday's Morning. Use `/morning` only when you open a blank day (skipped EOD, weekend catch-up, etc.).

Today's date: compute at runtime. Daily note path: `YOUR_VAULT_PATH/Daily notes/DD-MM-YYYY.md` (e.g. 25-06-2026.md).

Steps:
1. Check today's daily note for an existing `## Morning` section. If it already exists, stop — do not overwrite or duplicate. Report "already seeded (likely by last night's `/eod`)" and exit.

2. Fetch the following in parallel:
   a. **In-progress Linear tickets** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "In Progress".
   b. **Not-started tickets** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "Todo" or "Blocked". These have no PR/branch to remind you they exist — the ones worth surfacing.
   c. **Project status** — for the Linear project(s) behind (a)'s tickets, fetch the project (`mcp__linear__get_project`) and its milestones (`mcp__linear__list_milestones`). Note the milestone containing your active tickets, its progress %, and the project's target date if set.
   d. **Reminder inbox sweep + triage** — read YOUR_REMINDERS_CHANNEL (channel ID: YOUR_SLACK_CHANNEL_ID), messages from user YOUR_SLACK_USER_ID.
      - **Window (built for skipped days):** Find the most recent daily note that has either `## EOD` or `## Morning`. Start the day *after* that note's date, through today (inclusive). Prefer the later of the two if both exist on different days.
      - **Fallback:** If no `## EOD` or `## Morning` exists in the last ~14 days of notes, sweep the last **5 calendar days** through today — do **not** fall back to "today only." The user will sometimes skip `/eod` for a day or two; the window must absorb that without being prompted.
      - **Skip** any message that is a scheduled nudge (contains any of: "End of day nudge", "Good morning", "Run `/morning`", "Run `/eod`", "Anything in Slack today", "Forward" + "reminders-channel name", "End of week nudge", "weekly-wins", "First Friday", "`/my-story`", or "Sent using"). These are channel noise, not commitments.
      - **Triage each remaining item** (things the user forwarded as reminders to themselves), exactly as `/eod` step 8c does: **reading link** → file into `YOUR_VAULT_PATH/Links I want to read.md` under the best-fit `## Category` (not the daily note); **commitment / follow-up / dated obligation** → a checkbox under **Commitments** (propose a ticket if it clearly warrants one, don't auto-create); **expense** → flag it in the report; **FYI / feedback to keep** → note briefly in the report.

3. Format as a `## Morning` section. Omit any subsection that has no entries.

   ```
   ## Morning

   **Project:** Payments Migration — Rollout milestone 62% (target 2026-08-28)

   **Commitments**
   - [ ] [forwarded obligation — dated / owed to someone]

   ### Open tasks
   - [ ] **[TICKET-774](url)** — Todo, unstarted → pick up or reassign
   ```

   - **Project**: one line, only when (2c) found a project behind your active tickets. Omit entirely if none.
   - **Commitments** and **Open tasks** are both markdown **checkbox lists** (`- [ ]`) so you can tick them off. **Open tasks** = Todo/Blocked tickets only (from 2b) — no PRs, no In Progress tickets, no review-state noise. Those live on GitHub/Linear directly.
   - Format each Open task `- [ ] **[TICKET](url)** — Todo/Blocked[, reason if blocked] → pick up / unblock / reassign`.
   - If catch-up spanned more than today, note it once under **Commitments**.

4. Insert `## Morning` after the `# [title]` heading and before `## Remember & Action Items` (or other body sections). If the note does not exist yet, create it with Morning only.

5. Report what was written — Project status line, Commitments count + Open tasks row count (show the checklist in chat) + reminder triage (what was filed to the reading list / flagged). Say "all clear" if every Morning category is empty.
