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
- Shipped or merged something couldn’t explain at a boundary that mattered
- Avoided a hard conversation that then got worse
- Let noise win over the one ritual
- Accepted AI output they couldn’t defend when stakes were high
- Burned the day’s momentum via unowned scope creep
- Went deep on technical detail before checking whether the audience needed it

When proposing lines from the session, `## Learning`, or a meeting transcript (including a social meeting from step 4 that got no `## Meetings` entry — the transcript still gets skimmed for this), or highlights flagged in the **YOUR_CAREER_SLACK_CHANNEL** channel, offer **candidates** and let the user confirm, edit, or skip. Never fabricate a growth moment — a quiet day with no real signal means no coaching line, not a manufactured one.

---

## Part A — Close today

1. Read today’s daily note. Extract the `## Morning` section if it exists — baseline to diff against. **Missing Morning is normal** (often won’t have run a morning command; seed may also be absent after skipped EODs). If missing, still write EOD from current state — no need to call it out as a failure, just omit Morning-based “Picked up” diffs you can’t compute.

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

5b. **Growth / revise (optional, 30 seconds):** Using the Growth lens above + today’s `## Learning` + this session + the transcripts from step 4 (work and skipped-social alike) for communication/delivery moments + a skim of the **YOUR_CAREER_SLACK_CHANNEL** Slack channel (private, ID `YOUR_CAREER_SLACK_CHANNEL_ID`) since the last EOD (fall back to the past week) for any career highlight the user or their manager flagged there:
   - If there’s a real growth moment, add under EOD: `**Growth:** …` (one line; congratulate specifically — name the judgment, not “good job”)
   - If there’s a real miss worth course-correcting, add: `**Revise:** …` (one line — what to try differently, not self-attack)
   - A communication moment from a transcript (audience calibration, went too technical too early, landed a message well) counts as either — file it under Growth or Revise, don’t add a third category.
   - Prefer proposing 0–2 candidate lines in chat for the user to confirm/edit/skip, then write what they approve. If nothing fits, omit both lines — silence is correct.

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
        - **Reading link** ("link i want to read", "add to links I read", a bare article/repo/RFC URL): file it into `YOUR_VAULT_PATH/Links I want to read.md` under the best-fit `## Category` heading (that file is already bucketed — e.g. AI & Agents, Work: Honeycomb Internal, Frontend & Design Systems, Learning, Interesting Reads). Create a new `## Category` only if none fits. Entry format: `- [Title](url) — one-line what-it-is`. This is low-stakes and reversible, so file it directly; then list what you filed in the report. Do **not** put reading links in the daily note.
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
   - **Tue–Thu:** skip unless asks. If either was already run this week (Fri→Mon), don't re-ask.
   - Never run either automatically; only the user's yes triggers them.

---

## Report

14. Report briefly:
    - Today’s EOD summary + any meetings caught up (call out anything skipped as social-but-logged-under-Growth)
    - **Open tasks checklist** (same content as the note — scannable in chat)
    - **Project status** line
    - **Reminder triage** (from step 8c): what was filed to the reading list, what became a Commitment, what’s proposed as a ticket, and any expense to handle — or “nothing new”
    - Growth / Revise lines written (or “none — nothing forced”)
    - Next workday date seeded (or “already seeded”) + counts for Commitments / Open tasks rows
    - Prompt status: weekly-wins / my-story / weekly-skill-coach / team-update-blurb / career-channel (asked / already done / skipped) — **stop for an answer if you asked anything**
