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
- Read the room in a call and adjusted depth or pacing mid-conversation

**Miss / revise signals** (not shame — course-correction):
- Same papercut deferred 3+ times
- Shipped or merged something the user couldn’t explain at a boundary that mattered
- Avoided a hard conversation that then got worse
- Let noise win over the one ritual (or over Focus)
- Accepted AI output they couldn’t defend when stakes were high
- Burned the day’s Focus via unowned scope creep
- Went deep on technical detail before checking whether the audience needed it

When proposing lines from the session, `## Learning`, a skim of today’s Granola call transcripts, or highlights flagged in the **YOUR_CAREER_SLACK_CHANNEL** channel, offer **candidates** and let the user confirm, edit, or skip. Never fabricate a growth moment — a quiet day with no real signal means no coaching line, not a manufactured one.

---

## Part A — Close today

1. Read today’s daily note. Extract the `## Morning` section if it exists — baseline to diff against. **Missing Morning is normal** (the user often won’t have run a morning command; seed may also be absent after skipped EODs). If missing, still write EOD from current state — no need to call it out as a failure, just omit Morning-based “Picked up” diffs you can’t compute.

2. Fetch current state in parallel:
   a. **PRs merged today** — `gh pr list --author "@me" --state merged --search "merged:>=TODAY" --json number,title,url,mergedAt`
   b. **Still-open PRs** — `gh pr list --author "@me" --state open --json number,title,url,reviewDecision,isDraft`
   c. **Current in-progress Linear tickets** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "In Progress"
   d. **Linear tickets in Review** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "In Review" (needed for open-task status mismatches)
   e. **Linear tickets completed today** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "Done", updated today
   f. **Today’s meetings** — Granola MCP, list meetings from today

3. Compare current state against the morning snapshot to determine:
   - **Shipped**: PRs merged or tickets completed today
   - **Moved forward**: things that changed state (e.g. PR got approved, ticket moved)
   - **Open tasks**: actionable carry-over (see step 5) — the user’s own open PRs, in-progress tickets, in-review tickets (especially status mismatches). Do **not** include PRs waiting on the user’s review — those live on GitHub, not in the note.
   - **Picked up**: anything in-progress now that wasn’t in the morning snapshot
   - Omit any line that has nothing to report

4. **Meeting catch-up (optional):** If Granola (or your meeting tool) is available, check today’s daily note for an existing `## Meetings` section. For each meeting not already mentioned, pull its **verbatim transcript** (e.g. Granola’s `get_meeting_transcript`) and write the entry from that — **do not** use the AI-generated summary. Meeting summaries have proven unreliable: they hallucinate content and mis-attribute speakers. Ground every claim, decision, and attribution in what the transcript actually says, and attribute a speaker only when the transcript names them. If a transcript is empty or unavailable, say so rather than falling back to the summary. Append a brief entry:
   ```
   ### Meeting title (HH:MMam/pm)
   [2-3 sentence summary grounded in the transcript: what was discussed, any decisions made, any actions you own]
   ```
   If all meetings are already logged, or no meeting tool is configured, skip silently.

5. Append an `## EOD` section to today’s daily note (at the end of the file, before `## Claude Sessions` if that section exists):

   ```
   ## EOD

   **Shipped:** PR #12345 merged (TICKET-123), TICKET-456 done
   **Picked up:** TICKET-789

   ### Open tasks
   - [ ] **[TICKET-774](url)** / [PR #36621](url) — draft, 0 reviews, CI green → get review or mark ready
   - [ ] **[TICKET-778](url)** — In Review but PR already merged → close the Linear ticket
   ```

   - **Shipped** / **Picked up**: one line each. If nothing shipped, say so honestly.
   - **Open tasks**: a markdown **checkbox list** (`- [ ]`) so the user can tick items off in Obsidian. Omit the subsection if empty.
   - **What belongs in Open tasks** (actionable only — skip noise):
     - the user’s own open PRs (draft/review/CI state inline)
     - Tickets assigned to the user in Progress or In Review
     - **Status mismatches** — e.g. Linear still In Review but linked PR(s) merged → close the ticket
     - Follow-ups surfaced by the reminder triage (step 8, Part B) that belong to today’s carry-over
   - **Do not** list PRs waiting on the user’s review — they read those on GitHub, not here.
   - Format each item `- [ ] **[TICKET](url)** — short status → next step` (one concrete verb phrase: Close ticket / Get review / Address comments / Merge / Pick up). Prefer the cheapest close when the loop is stale admin.
   - Also mirror this checklist in the chat report (step 14).

5b. **Growth / revise (optional, 30 seconds):** Using the Growth lens above + today’s `## Learning` + this session + a light skim of `get_meeting_transcript` for today’s Granola meetings (from step 2e) for communication/delivery moments + a skim of the **YOUR_CAREER_SLACK_CHANNEL** Slack channel (private; channel ID: `YOUR_CAREER_SLACK_CHANNEL_ID`) since the last EOD (fall back to the past week) for any career highlight the user or their manager flagged there:
   - If there’s a real growth moment, add under EOD: `**Growth:** …` (one line; congratulate specifically — name the judgment, not “good job”)
   - If there’s a real miss worth course-correcting, add: `**Revise:** …` (one line — what to try differently, not self-attack)
   - A communication moment from a transcript (audience calibration, went too technical too early, landed a message well) counts as either — file it under Growth or Revise, don’t add a third category.
   - Prefer proposing 0–2 candidate lines in chat for the user to confirm/edit/skip, then write what they approve. If nothing fits, omit both lines — silence is correct.

6. Also append the shipped items to `YOUR_VAULT_PATH/Career/Shipped.md` under today’s date (same format as /log-shipped). If a section for today already exists, append to it.

---

## Part B — Seed next workday

7. Compute the next workday date and its daily note path. If that note already has a `## Morning` section, skip Part B — do not overwrite. Report that tomorrow is already seeded.

8. Fetch orientation data in parallel (reuse Part A results where identical):
   a. **In-progress + In Review Linear tickets** — same as 2c + 2d
   b. **Open PRs** — same as 2b; note review state (approved / changes requested / waiting / no reviews yet) and draft
   c. **Reminder inbox sweep + triage** — read YOUR_REMINDERS_CHANNEL (channel ID: `YOUR_SLACK_CHANNEL_ID`), messages from user `YOUR_SLACK_USER_ID`.
      - **Window (built for skipped days):** Find the most recent daily note that has either `## EOD` or `## Morning`. Start the day *after* that note's date, through today (inclusive). Prefer the later of the two if both exist on different days.
      - **Fallback:** If no `## EOD` or `## Morning` exists in the last ~14 days of notes, sweep the last **5 calendar days** through today — do **not** fall back to "today only." The user will sometimes skip `/eod` for a day or two; the window must absorb that without being prompted.
      - **Skip** any message that is a scheduled nudge (contains any of: "End of day nudge", "Good morning", "Run `/morning`", "Run `/eod`", "Anything in Slack today", "Forward" + "ruthie-reminders", "End of week nudge", "weekly-wins", "First Friday", "`/my-story`", or "Sent using"). These are channel noise, not commitments.
      - **Triage each remaining item** (these are things the user forwarded as reminders to themselves) into one of four buckets and act:
        - **Reading link** ("link i want to read", "add to reading list", a bare article/repo/RFC URL): file it into your reading-list note (e.g. `YOUR_VAULT_PATH/Links I want to read.md`) under the best-fit `## Category` heading; keep that file bucketed by topic (e.g. by area of work, tools/AI, frontend, learning, reading-for-fun) and create a new `## Category` only if none fits. Entry format: `- [Title](url) — one-line what-it-is`. This is low-stakes and reversible, so file it directly; then list what you filed in the report. Do **not** put reading links in the daily note.
        - **Commitment / follow-up / dated obligation** ("follow up on this", "implement this soon", "loop back to X", a due date): carry into the seed as a checkbox under **Commitments** (obligations to others / dated) or **Open tasks** (your own follow-through). If it clearly warrants a Linear ticket, *propose* creating one in the report — do not auto-create.
        - **Expense** ("expense this" + receipt/image): surface it as an action in the report with the receipt reference; do not auto-do it.
        - **FYI / feedback to keep** ("great feedback from X", something to remember): note it briefly in the report; don’t clutter the task list.

8b. **Ask for tomorrow’s Focus:** Prompt once — “What’s tomorrow’s focus: ticket + one-line goal?” If the user gives one, use it verbatim as the Focus line in step 9. If they don’t have one ready, don’t push — fall back to the placeholder. Never block seeding on this answer.

9. Create or update the next workday’s daily note. If the file does not exist, create it. Write:

   ```
   # Weekday, Month D, YYYY

   ## Focus

   - _not set — tell me ticket + one-line goal and I'll fill this in_

   ## Morning

   **Commitments**
   - [ ] [forwarded obligation — dated / owed to someone]

   ### Open tasks
   - [ ] **[TICKET-774](url)** / [PR #36621](url) — draft, 0 reviews, CI green → get review or mark ready
   - [ ] **[TICKET-778](url)** — In Review, PR already merged → close the Linear ticket
   ```

   - `## Focus`: the user’s answer from 8b verbatim if given, otherwise the placeholder shown above (session-start reads it either way).
   - **Commitments** and **Open tasks** are both markdown **checkbox lists** (`- [ ]`) so the user can tick them off. **Open tasks** replaces the old table + the old In-progress / Your-PRs / Reviews-waiting bullet lists; same actionable-only rules as EOD step 5.
   - **Do not** list PRs waiting on the user’s review — those live on GitHub. Reading links go to `Links I want to read.md` (step 8c), not the note.
   - Under `## Morning`, omit any subsection that has no entries.
   - If catch-up spanned more than today, note it once under **Commitments** like: `*(catch-up: last EOD/Morning was DD-MM, sweeping YOUR_REMINDERS_CHANNEL from … through today)*`
   - Do not invent a focus from Linear. Do not copy today’s focus forward unless the user explicitly asks.

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

13. **YOUR_CAREER_SLACK_CHANNEL (Friday only, once):** Ask once: "Anything from this week worth dropping in YOUR_CAREER_SLACK_CHANNEL (praise, hard call, ownership moment)?" If no, move on. Do not draft a Slack post unless they ask.

13b. **Weekly Skill Coach + Team-Update Blurb (prompt only — do not auto-run; keep their output OUT of Weekly Wins.md).** Both are Fri-weighted efficiency prompts, siblings to weekly-wins. Both live in Cursor (`~/.cursor/skills/`).
   - **Friday (or Thu when the Scale Weekly Update draft posts):**
     - "Want me to run the **weekly skill coach** before you go? (surveys the week → friction log + 1–3 skill pitches)"
     - "Want a **team-update blurb** for the Scale Weekly Update? (paste-ready line from your merged PRs + closed tickets)"
   - **Monday:** "Want me to run the **weekly skill coach** for the past week?" (skip the team-update blurb Mondays — the update already shipped)
   - **Tue–Thu:** skip unless the user asks. If either was already run this week (Fri→Mon), don't re-ask.
   - Never run either automatically; only the user's yes triggers them.

---

## Report

14. Report briefly:
    - Today’s EOD summary + any meetings caught up
    - **Open tasks checklist** (same content as the note — scannable in chat)
    - **Reminder triage** (from step 8c): what was filed to the reading list, what became a task, what’s proposed as a ticket, and any expense to handle — or “nothing new”
    - Growth / Revise lines written (or “none — nothing forced”)
    - Next workday date seeded (or “already seeded”) + counts for Commitments / Open tasks rows
    - Prompt status: weekly-wins / my-story / weekly-skill-coach / team-update-blurb / career-ruthie (asked / already done / skipped) — **stop for an answer if you asked anything**
