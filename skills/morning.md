Optional catch-up: write a `## Morning` section only if today's note is missing one.

Prefer `/eod` the night before — it seeds the next workday's Morning. Use `/morning` only when you open a blank day (skipped EOD, weekend catch-up, etc.).

Today's date: compute at runtime. Daily note path: `YOUR_VAULT_PATH/Daily notes/DD-MM-YYYY.md` (e.g. 25-06-2026.md).

Steps:
1. Check today's daily note for an existing `## Morning` section. If it already exists, stop — do not overwrite or duplicate. Report "already seeded (likely by last night's `/eod`)" and exit.

2. Fetch the following in parallel:
   a. **In-progress Linear tickets** — use Linear MCP, list issues assigned to YOUR_LINEAR_EMAIL with state "In Progress". Get title and Linear ID.
   b. **In Review Linear tickets** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "In Review" (catch status mismatches vs merged PRs).
   c. **Your open PRs** — `gh pr list --author "@me" --state open --json number,title,url,reviewDecision,reviews,isDraft` — note review state (approved / changes requested / waiting / no reviews yet).
   d. **Reminder inbox sweep + triage** — read YOUR_REMINDERS_CHANNEL (channel ID: YOUR_SLACK_CHANNEL_ID), messages from user YOUR_SLACK_USER_ID.
      - **Window (built for skipped days):** Find the most recent daily note that has either `## EOD` or `## Morning`. Start the day *after* that note's date, through today (inclusive). Prefer the later of the two if both exist on different days.
      - **Fallback:** If no `## EOD` or `## Morning` exists in the last ~14 days of notes, sweep the last **5 calendar days** through today — do **not** fall back to "today only." The user will sometimes skip `/eod` for a day or two; the window must absorb that without being prompted.
      - **Skip** any message that is a scheduled nudge (contains any of: "End of day nudge", "Good morning", "Run `/morning`", "Run `/eod`", "Anything in Slack today", "Forward" + "ruthie-reminders", "End of week nudge", "weekly-wins", "First Friday", "`/my-story`", or "Sent using"). These are channel noise, not commitments.
      - **Triage each remaining item** (things the user forwarded as reminders to themselves), exactly as `/eod` step 8c does: **reading link** → file into `YOUR_VAULT_PATH/Links I want to read.md` under the best-fit `## Category` (not the daily note); **commitment / follow-up / dated obligation** → a checkbox under **Commitments** or **Open tasks** (propose a ticket if it clearly warrants one, don't auto-create); **expense** → flag it in the report; **FYI / feedback to keep** → note briefly in the report.

3. Ensure a top-level `## Focus` exists (session-start reads it). If missing, add:

   ```
   ## Focus

   - _not set — tell me ticket + one-line goal and I'll fill this in_
   ```

   If `## Focus` already has real content, leave it. Do not invent a focus from Linear.

4. Format as a `## Morning` section. Omit any subsection that has no entries.

   ```
   ## Morning

   **Commitments**
   - [ ] [forwarded obligation — dated / owed to someone]

   ### Open tasks
   - [ ] **[TICKET-774](url)** / [PR #36621](url) — draft, 0 reviews, CI green → get review or mark ready
   - [ ] **[TICKET-778](url)** — In Review, PR already merged → close the Linear ticket
   ```

   - **Commitments** and **Open tasks** are both markdown **checkbox lists** (`- [ ]`) so you can tick them off. **Open tasks** replaces the old table + the In-progress / Your-PRs / Reviews-waiting bullets; same inclusion rules as `/eod` (your open PRs, In Progress + In Review tickets, status mismatches).
   - **Do not** list PRs waiting on your review — those live on GitHub. Reading links go to `Links I want to read.md` (step 2d), not the note.
   - Format each Open task `- [ ] **[TICKET](url)** — short status → next step` (one concrete verb phrase).
   - If catch-up spanned more than today, note it once under **Commitments**.

5. Insert `## Focus` (if added) and `## Morning` after the `# [title]` heading and before `## Remember & Action Items` (or other body sections). If the note does not exist yet, create it with Focus + Morning.

6. Report what was written — Commitments count + Open tasks row count (show the checklist in chat) + reminder triage (what was filed to the reading list / flagged). Say "all clear" if every Morning category is empty.
