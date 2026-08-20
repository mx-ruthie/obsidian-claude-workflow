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
- Let noise win over the one ritual
- Accepted AI output they couldn’t defend when stakes were high
- Burned the day’s momentum via unowned scope creep
- Went deep on technical detail before checking whether the audience needed it

When proposing lines from the session, `## Learning`, or a meeting transcript (including a social meeting from step 4 that got no `## Meetings` entry — the transcript still gets skimmed for this), or highlights flagged in the **YOUR_CAREER_SLACK_CHANNEL** channel, offer **candidates** and let the user confirm, edit, or skip. Never fabricate a growth moment — a quiet day with no real signal means no coaching line, not a manufactured one.

---

## Part A — Close today

1. Read today’s daily note. Extract the `## Morning` section if it exists — baseline to diff against. **Missing Morning is normal** (the user often won’t have run a morning command; seed may also be absent after skipped EODs). If missing, still write EOD from current state — no need to call it out as a failure, just omit Morning-based “Picked up” diffs you can’t compute.

2. Fetch current state in parallel:
   a. **PRs merged today** — `gh pr list --author "@me" --state merged --search "merged:>=TODAY" --json number,title,url,mergedAt`
   b. **Current in-progress Linear tickets** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "In Progress"
   c. **Linear tickets completed today** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "Done", updated today
   d. **Not-started tickets** — Linear MCP, issues assigned to YOUR_LINEAR_EMAIL with state "Todo" or "Blocked". These have no PR or branch to remind the user they exist, so they're the ones actually worth surfacing.
   e. **Today’s meetings** — Granola MCP, list meetings from today
   f. **Project status** — for the Linear project(s) behind (b)’s tickets, fetch the project (`mcp__linear__get_project`) and its milestones (`mcp__linear__list_milestones`). Note the milestone that contains today’s active tickets, its progress %, and the project’s target date if set.

3. Compare current state against the morning snapshot to determine:
   - **Shipped**: PRs merged or tickets completed today
   - **Picked up**: anything in-progress now that wasn’t in the morning snapshot
   - **Open tasks**: tickets from (2d) still sitting in Todo/Blocked — not a GitHub-visible carry-over, just the genuinely stalled ones
   - Omit any line that has nothing to report

4. **Meeting catch-up:** Check today’s daily note for an existing `## Meetings` section. For each meeting from Granola (step 2e) not already logged, pull its **verbatim transcript** with `get_meeting_transcript` — **never** the AI summary; summaries have proven unreliable (they hallucinate content and mis-attribute speakers).
   - **Work meeting** (standup, sync, pairing on a work topic): write **one line** — decisions made plus anything the user owns. Skip the roster of everyone else’s status unless it changes their own work.
     ```
     ### Meeting title (HH:MMam/pm)
     [one line: decisions/actions only]
     ```
   - **Social meeting** (donut, casual 1:1, no work agenda): write **no** `## Meetings` entry. Still skim the transcript — if a career-relevant moment surfaced (advice given, feedback, a hard call, a promo/comp conversation), it becomes a Growth/Revise candidate in step 5b instead of a summary here. Nothing career-relevant → no trace at all, which is correct.
   - If all meetings are already logged, skip silently.

5. Append an `## EOD` section to today’s daily note (at the end of the file, before `## Claude Sessions` if that section exists):

   ```
   ## EOD

   **Shipped:** PR #12345 merged (TICKET-123), TICKET-456 done
   **Picked up:** TICKET-789
   **Project:** Payments Migration — Rollout milestone 62% (target 2026-08-28)

   ### Open tasks
   - [ ] **[TICKET-774](url)** — Todo, unstarted → pick up or reassign
   ```

   - **Shipped** / **Picked up**: one line each. If nothing shipped, say so honestly.
   - **Project**: one line, only when (2f) found a project behind today’s tickets. Omit entirely if none.
   - **Open tasks**: a markdown **checkbox list** (`- [ ]`), sourced only from (2d)/(3) — tickets still Todo or Blocked, with no PR and no active work. **Do not** list the user’s own open PRs, their review state, or tickets already In Progress/In Review — those are visible on GitHub/Linear directly and don’t need repeating here.
   - Format each item `- [ ] **[TICKET](url)** — Todo/Blocked[, reason if blocked] → pick up / unblock / reassign`.
   - Also mirror this checklist in the chat report (step 14).

5b. **Growth / Revise — write, don’t ask.**

   *Changed 2026-08-20: this step no longer proposes candidates and waits for approval, and it leads with signals that can be **checked** rather than inferred. Over nine EOD runs the propose-and-confirm version produced 2 Growth lines and 0 Revise lines — the approval gate, not a lack of material, was the problem. Write the line; the user edits the note if it’s wrong.*

   **First, the countable signals** — these come from data, not judgment:

   - **Recurring Open task** — scan the `### Open tasks` checklist in the last 5 daily notes carrying an `## EOD`. A ticket appearing 3+ times is a deferred papercut:
     `**Revise:** SCALE-123 has ridden Open tasks 4 EODs — pick it up, hand it off, or close it.`
   - **Clean landing after churn** — a PR merged today with no change requests, in an area where a previous PR needed them. Real, checkable Growth.
   - **Review churn** — a PR merged today that took 2+ rounds of change requests (`gh pr view <n> --json reviews`). Revise only if the rounds were about something knowable up front.
   - **Backward movement** — a ticket that moved In Review → In Progress today.

   **Then, only if no countable signal fired,** use the Growth lens above against today’s session, `## Learning`, and step 4’s transcripts (work and skipped-social alike). Cap: one line total.

   **Writing rules:**
   - At most one `**Growth:**` and one `**Revise:**` per day. Usually zero or one line.
   - Name the specific judgment or the specific next action, never “good work today.”
   - A communication moment from a transcript counts as either — never a third category.
   - **Never fabricate.** A quiet day gets no line. Silence is correct output, not a failed step.
   - **YOUR_CAREER_SLACK_CHANNEL** (private, `YOUR_CAREER_SLACK_CHANNEL_ID`): skim since the last EOD only to *corroborate* a signal that already fired. Not every run — nine runs of skimming produced almost nothing.

6. Also append the shipped items to `YOUR_VAULT_PATH/Career/Shipped.md` under today’s date (same format as /log-shipped). If a section for today already exists, append to it.

---

## Part B — Seed next workday

7. Compute the next workday date and its daily note path. If that note already has a `## Morning` section, skip Part B — do not overwrite. Report that tomorrow is already seeded.

8. Fetch orientation data in parallel (reuse Part A results where identical):
   a. **Not-started + in-progress Linear tickets** — same as 2b + 2d
   b. **Project status** — same as 2f
   c. **Reminder inbox sweep + triage** — read YOUR_REMINDERS_CHANNEL (channel ID: `YOUR_SLACK_CHANNEL_ID`), messages from user `YOUR_SLACK_USER_ID`.
      - **Window (built for skipped days):** Find the most recent daily note that has either `## EOD` or `## Morning`. Start the day *after* that note's date, through today (inclusive). Prefer the later of the two if both exist on different days.
      - **Fallback:** If no `## EOD` or `## Morning` exists in the last ~14 days of notes, sweep the last **5 calendar days** through today — do **not** fall back to "today only." The user will sometimes skip `/eod` for a day or two; the window must absorb that without being prompted.
      - **Skip** any message that is a scheduled nudge (contains any of: "End of day nudge", "Good morning", "Run `/morning`", "Run `/eod`", "Anything in Slack today", "Forward" + "reminders-channel name", "End of week nudge", "weekly-wins", "First Friday", "`/my-story`", or "Sent using"). These are channel noise, not commitments.
      - **Triage each remaining item** (these are things the user forwarded as reminders to themselves) into one of four buckets and act:
        - **Reading link** ("link i want to read", "add to links I read", a bare article/repo/RFC URL): file it into `YOUR_VAULT_PATH/Links I want to read.md` under the best-fit `## Category` heading (that file is already bucketed — e.g. AI & Agents, Work: YOUR_ORG Internal, Frontend & Design Systems, Learning, Interesting Reads). Create a new `## Category` only if none fits. Entry format: `- [Title](url) — one-line what-it-is`. This is low-stakes and reversible, so file it directly; then list what you filed in the report. Do **not** put reading links in the daily note.
        - **Commitment / follow-up / dated obligation** ("follow up on this", "implement this soon", "loop back to X", a due date): carry into the seed as a checkbox under **Commitments**. If it clearly warrants a Linear ticket, *propose* creating one in the report — do not auto-create.
        - **Expense** ("expense this" + receipt/image): surface it as an action in the report with the receipt reference; do not auto-do it.
        - **FYI / feedback to keep** ("great feedback from X", something to remember): note it briefly in the report; don’t clutter the task list.

9. Create or update the next workday’s daily note. If the file does not exist, create it. Write:

   ```
   # Weekday, Month D, YYYY

   ## Morning

   **Project:** Payments Migration — Rollout milestone 62% (target 2026-08-28)

   **Commitments**
   - [ ] [forwarded obligation — dated / owed to someone]

   ### Open tasks
   - [ ] **[TICKET-774](url)** — Todo, unstarted → pick up or reassign
   ```

   - **Project**: one line, only when (8b) found a project behind the user’s active tickets. Omit entirely if none.
   - **Commitments** and **Open tasks** are both markdown **checkbox lists** (`- [ ]`) so the user can tick them off. **Open tasks** = Todo/Blocked tickets only, same rule as EOD step 5 — no PRs, no In Progress/In Review tickets, no review-state noise.
   - Under `## Morning`, omit any subsection that has no entries.
   - If catch-up spanned more than today, note it once under **Commitments** like: `*(catch-up: last EOD/Morning was DD-MM, sweeping YOUR_REMINDERS_CHANNEL from … through today)*`

10. If the next-workday note already existed with other sections (Learning, etc.), insert Morning after the title heading without wiping the rest.

10b. **Verify the seed landed — do not skip this.** Re-read the next workday's note *from disk* and confirm a `## Morning` heading is actually present. Never report a day as seeded without reading it back.
   - If the section is missing, write it again, then re-read again.
   - If it is still missing after the retry, say so loudly at the top of the report — a silently unseeded day is the failure mode that breaks the whole chain, because the next morning opens blank and `/morning` has to be remembered.
   - **Why this exists:** three EOD runs in Aug 2026 (03-08, 04-08, 05-08) completed and reported success while the following day's note had no `## Morning` section at all. Nothing caught it, and the misses were only visible weeks later by counting headings across the vault.

---

## Part C — Optional follow-ups (never blocking)

**By this point the note is written and the ritual is complete.** Part C asks nothing and waits for nothing. Compute which follow-ups are *due*, list them as a single line at the end of the report, and end the turn. The user runs what they want. An ignored menu is a successful EOD — leaving is the point.

Never auto-run any of these. Keep their output OUT of `Weekly Wins.md`.

11. **Weekly wins** (`/weekly-wins`) — check `YOUR_VAULT_PATH/Career/Weekly Wins.md`.
   - **Fri/Sat/Sun:** due if `## Week of YYYY-MM-DD` for *this* Monday is missing.
   - **Monday:** due if `## Week of YYYY-MM-DD` for the *prior* Monday is missing.
   - **Tue–Thu:** never due.

12. **My Story** (`/my-story`) — read `YOUR_VAULT_PATH/Career/My Story.md` for the last chapter's end month. Due on the **first Friday of the month** (day-of-month 1–7), or the **first Monday** if that Friday was missed, when no chapter has been added since the previous calendar month ended. Otherwise not due.

13. **YOUR_CAREER_SLACK_CHANNEL** — due **Fridays only**: a reminder that anything from the week worth dropping there (praise, hard call, ownership moment) hasn't been. Never draft a Slack post unless asked.

13b. **Weekly skill coach / team-update blurb** — optional efficiency siblings; never auto-run.
   - `/weekly-skill-coach` — due **Friday or Monday**. Surveys the week, produces a friction log and 1–3 automation pitches.
   - `/team-update-blurb` — due **Thu/Fri**, when the YOUR_TEAM_UPDATE_NAME draft posts. Never due Monday; the update already shipped.
   - If either already ran this week (Fri→Mon), not due.

---

## Report

14. Report briefly. **Ask nothing. Wait for nothing.** End the turn when the report is printed — the user is trying to leave.
    - Today’s EOD summary + any meetings caught up (call out anything skipped as social-but-logged-under-Growth)
    - **Open tasks checklist** (same content as the note — scannable in chat)
    - **Project status** line
    - **Reminder triage** (from step 8c): what was filed to the reading list, what became a Commitment, what’s proposed as a ticket, and any expense to handle — or “nothing new”
    - Growth / Revise lines written (or “none — nothing forced”)
    - **Seed confirmation** (from 10b): next workday date + that `## Morning` was read back from disk — or a loud warning if it wasn’t. “Already seeded” is fine, unverified is not.
    - **Optional follow-ups:** one line listing only what Part C found *due*, as bare commands — e.g. `Optional: /weekly-wins · /team-update-blurb`. Omit the line entirely when nothing is due. No questions, no explanations of what each does.
