Close out today and seed tomorrow’s daily note in one pass. Run this when you’re ready to leave — it’s the only daily ritual.

Today’s date: compute at runtime. Daily note path: `YOUR_VAULT_PATH/Daily notes/DD-MM-YYYY.md` (e.g. 25-06-2026.md).

Next workday: Mon–Thu → tomorrow; Fri/Sat/Sun → next Monday. Filename uses that date’s `DD-MM-YYYY`.

---

## Growth lens (use in Part A step 5b — do not invent empty praise)

Help the user notice **growth** and **misses** without a long journal. Prefer one sharp line over three vague ones. Skip entirely if nothing real showed up.

**Growth signals** (congratulate — judgment, not just output):
- Anticipated a reviewer’s concern *before* they saw the PR
- Refused a band-aid / fixed a root cause after deferring it
- Held two true things at once (e.g. “files are right AND machine is wrong”)
- Chose durable-over-fast when it mattered
- Insisted on understanding mid-deadline instead of accepting opaque working code
- Enabled someone else (recipe, runbook, clear ask) instead of only solving solo
- Course-corrected in public after a miss

**Miss / revise signals** (not shame — course-correction):
- Same papercut deferred 3+ times
- Shipped or merged something the user couldn’t explain at a boundary that mattered
- Avoided a hard conversation that then got worse
- Let noise win over the one ritual (or over Focus)
- Accepted AI output they couldn’t defend when stakes were high
- Burned the day’s Focus via unowned scope creep

When proposing lines from the session or `## Learning`, offer **candidates** and let the user confirm, edit, or skip. Never fabricate a growth moment.

---

## Part A — Close today

1. Read today’s daily note. Extract the `## Morning` section if it exists — baseline to diff against. **Missing Morning is normal** (seed may be absent after skipped EODs). If missing, still write EOD from current state — do not call it out as a failure; omit Morning-based “Picked up” diffs you can’t compute.

2. Fetch current state in parallel:
   a. **PRs merged today** — `gh pr list --author "@me" --state merged --search "merged:>=TODAY" --json number,title,url,mergedAt`
   b. **Still-open PRs** — `gh pr list --author "@me" --state open --json number,title,url,reviewDecision`
   c. **Current in-progress tickets** — Linear MCP, issues assigned to `YOUR_LINEAR_EMAIL` with state "In Progress"
   d. **Tickets completed today** — Linear MCP, issues assigned to `YOUR_LINEAR_EMAIL` with state "Done", updated today
   e. **Today’s meetings** — Granola MCP, list meetings from today *(omit this step if Granola isn’t configured)*

3. Compare current state against the morning snapshot to determine:
   - **Shipped**: PRs merged or tickets completed today
   - **Moved forward**: things that changed state (e.g. PR got approved, ticket moved)
   - **Still in flight**: open PRs + in-progress tickets carrying over
   - **Picked up**: anything in-progress now that wasn’t in the morning snapshot
   - Omit any line that has nothing to report

4. **Meeting catch-up (optional):** If Granola (or your meeting tool) is available, check today’s daily note for an existing `## Meetings` section. For each meeting not already mentioned, append:
   ```
   ### Meeting title (HH:MMam/pm)
   [2-3 sentence summary: what was discussed, any decisions made, any actions you own]
   ```
   If all meetings are already logged, or no meeting tool is configured, skip silently.

5. Append an `## EOD` section to today’s daily note (at the end of the file, before `## Claude Sessions` if that section exists):

   ```
   ## EOD

   **Shipped:** PR #12345 merged (TICKET-123), TICKET-456 done
   **Picked up:** TICKET-789
   **Still in flight:** #12346 (waiting on review), TICKET-123 in progress
   ```

   Keep it to one line per category. If nothing shipped, say so honestly.

5b. **Growth / revise (optional, 30 seconds):** Using the Growth lens above + today’s `## Learning` + this session:
   - If there’s a real growth moment, add under EOD: `**Growth:** …` (one line; congratulate specifically — name the judgment, not “good job”)
   - If there’s a real miss worth course-correcting, add: `**Revise:** …` (one line — what to try differently, not self-attack)
   - Prefer proposing 0–2 candidate lines in chat for the user to confirm/edit/skip, then write what they approve. If nothing fits, omit both lines — silence is correct.

6. Also append the shipped items to `YOUR_VAULT_PATH/Career/Shipped.md` under today’s date (same format as `/log-shipped`). If a section for today already exists, append to it.

---

## Part B — Seed next workday

7. Compute the next workday date and its daily note path. If that note already has a `## Morning` section, skip Part B — do not overwrite. Report that tomorrow is already seeded.

8. Fetch orientation data in parallel (reuse Part A results where identical):
   a. **In-progress tickets** — same as 2c
   b. **Open PRs** — same as 2b; note review state (approved / changes requested / waiting / no reviews yet)
   c. **Reviews waiting on you** — `gh search prs --review-requested "@me" --state open --json number,title,url,author`
   d. **Slack commitments** — read `YOUR_REMINDERS_CHANNEL` (channel ID: `YOUR_SLACK_CHANNEL_ID`), messages from user `YOUR_SLACK_USER_ID`.
      - **Window (built for skipped days):** Find the most recent daily note that has either `## EOD` or `## Morning`. Start the day *after* that note's date, through today (inclusive). Prefer the later of the two if both exist on different days.
      - **Fallback:** If no `## EOD` or `## Morning` exists in the last ~14 days of notes, sweep the last **5 calendar days** through today — do **not** fall back to "today only."
      - **Skip** any message that is a scheduled nudge (contains any of: "End of day nudge", "Good morning", "Run `/morning`", "Run `/eod`", "Anything in Slack today", "Forward" + reminders-channel name, "End of week nudge", "weekly-wins", "First Friday", "`/my-story`", or "Sent using"). These are channel noise, not commitments.
      - These are things the user forwarded as reminders to themself.

9. Create or update the next workday’s daily note. If the file does not exist, create it. Write:

   ```
   # Weekday, Month D, YYYY

   ## Focus

   - _not set — tell me ticket + one-line goal and I'll fill this in_

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

   - Always include `## Focus` with the placeholder (session-start can read it).
   - Under `## Morning`, omit any subsection that has no entries.
   - If catch-up spanned more than today, note it once under **Commitments**.
   - Do not invent a focus from the ticket tool. Do not copy today’s focus forward unless the user explicitly asks.

10. If the next-workday note already existed with other sections (Learning, etc.), insert Focus + Morning after the title heading without wiping the rest.

---

## Part C — Story prompts (prompt only, do not auto-run)

11. **Weekly wins** — Check `YOUR_VAULT_PATH/Career/Weekly Wins.md`. **Never run `/weekly-wins` unless the user says yes.**
   - **Friday (or Sat/Sun if they wrap then):** Let `this_monday` = Monday of the current week. If `## Week of YYYY-MM-DD` for `this_monday` is missing, ask once: "This week's Weekly Wins isn't written yet — want me to run `/weekly-wins` before you go?"
   - **Monday:** Let `prior_monday` = today minus 7 days. If `## Week of YYYY-MM-DD` for `prior_monday` is missing, ask once: "Last week (Week of YYYY-MM-DD) has no Weekly Wins — want me to run `/weekly-wins` for that week?"
   - **Tue–Thu:** Skip unless the user asks.
   - If the section already exists, say nothing about weekly-wins.

12. **My Story (monthly)** — Read `YOUR_VAULT_PATH/Career/My Story.md` for the last chapter’s end month. **Never run `/my-story` unless the user says yes.**
   - **First Friday of the month** (Friday with day-of-month 1–7), or **first Monday** if that Friday was missed: if no new chapter has been added since the previous calendar month ended, ask once: "My Story hasn't been updated this month — want me to run `/my-story`?"
   - Otherwise stay quiet.

13. **Career channel (Friday only, once):** Ask once: "Anything from this week worth dropping in `YOUR_CAREER_SLACK_CHANNEL` (praise, hard call, ownership moment)?" If no, move on. Do not draft a Slack post unless they ask. *(Omit this step if no career channel is configured.)*

---

## Report

14. Report briefly:
    - Today’s EOD summary + any meetings caught up
    - Growth / Revise lines written (or “none — nothing forced”)
    - Next workday date seeded (or “already seeded”) + counts for Commitments / In progress / PRs / Reviews
    - Prompt status: weekly-wins / my-story / career-channel (asked / already done / skipped) — **stop for an answer if you asked anything**
