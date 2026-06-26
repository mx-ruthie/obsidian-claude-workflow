Write the end-of-day summary section to today's Obsidian daily note. Run this manually when you're ready to close out the day.

Today's date: compute at runtime. Daily note path: `YOUR_VAULT_PATH/Daily notes/DD-MM-YYYY.md` (e.g. 25-06-2026.md).

Steps:
1. Read today's daily note. Extract the `## Morning` section if it exists — this is the baseline to diff against.

2. Fetch current state in parallel:
   a. **PRs merged today** — `gh pr list --author "@me" --state merged --search "merged:>=TODAY" --json number,title,url,mergedAt`
   b. **Still-open PRs** — `gh pr list --author "@me" --state open --json number,title,url,reviewDecision`
   c. **Current in-progress Linear tickets** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "In Progress"
   d. **Linear tickets completed today** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "Done", updated today
   e. **Today's meetings** — Granola MCP, list meetings from today

3. Compare current state against the morning snapshot to determine:
   - **Shipped**: PRs merged or tickets completed today
   - **Moved forward**: things that changed state (e.g. PR got approved, ticket moved)
   - **Still in flight**: open PRs + in-progress tickets carrying over to tomorrow
   - **Picked up**: anything in-progress now that wasn't in the morning snapshot
   - Omit any line that has nothing to report

4. **Granola catch-up:** Check today's daily note for an existing `## Meetings` section. For each meeting returned by Granola, if it isn't already mentioned in `## Meetings`, append a brief entry:
   ```
   ### Meeting title (HH:MMam/pm)
   [2-3 sentence summary: what was discussed, any decisions made, any actions you own]
   ```
   If all meetings are already logged, skip silently.

5. Append an `## EOD` section to today's daily note (at the end of the file, before `## Claude Sessions` if that section exists):

   ```
   ## EOD

   **Shipped:** PR #12345 merged (TICKET-123), TICKET-456 done
   **Picked up:** TICKET-789
   **Still in flight:** #12346 (waiting on review), TICKET-123 in progress
   ```

   Keep it to one line per category. If nothing shipped, say so honestly.

6. Also append the shipped items to `YOUR_VAULT_PATH/Career/Shipped.md` under today's date:
   ```
   ## YYYY-MM-DD
   - [[TICKET-ID]] Title — one sentence of what it did. PR: #number
   ```
   If a section for today already exists, append to it rather than creating a duplicate header.

7. Report what was written — EOD summary and any meetings that were caught up.
