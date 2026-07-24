Generate a weekly wins summary from Shipped.md + that week's learning/growth crumbs, formatted as story seeds for promo prep or interview use.

Today's date: compute at runtime. Weekly Wins path: `YOUR_VAULT_PATH/Career/Weekly Wins.md`.
Daily notes: `YOUR_VAULT_PATH/Daily notes/DD-MM-YYYY.md`.

### Which week to write

- Let `this_monday` = Monday of the calendar week containing today.
- Let `prior_monday` = `this_monday` minus 7 days.
- **Default target:**
  - If today is **Monday** and `## Week of {prior_monday}` is missing → target **prior week** (`prior_monday`).
  - Else if `## Week of {this_monday}` is missing → target **this week** (`this_monday`).
  - Else if the user asked for a specific week → use that.
  - Else tell them that week already exists and stop.
- Date range: that week's Monday 00:00 through Sunday 23:59 (local).

Steps:
1. Resolve the target Monday as above. Read `Weekly Wins.md`; if `## Week of YYYY-MM-DD` for that Monday already exists, skip writing and tell the user.
2. Read `YOUR_VAULT_PATH/Career/Shipped.md` and collect entries whose dated `## YYYY-MM-DD` headers fall in the target week (Mon–Sun).
3. **Also skim that week's daily notes** for:
   - `## Learning` bullets
   - EOD `**Growth:**` / `**Revise:**` lines
   These are judgment/career crumbs PRs don't capture. Pull 0–3 into story seeds (or a short **Growth & revise** subsection under the week) when they’re distinct from the shipped items. Prefer Growth lines for seeds; include a Revise line only if it shows a real course-correction worth remembering.
4. For each shipped entry, expand into a story seed with three parts:
   - **Situation:** what problem existed or what was needed
   - **What I did:** the action taken (use Linear MCP if sparse)
   - **Outcome:** what changed or was unblocked
5. Include a one-line **Week in review** at the top (theme of shipped + growth, not a task list).
6. Append `## Week of YYYY-MM-DD` to `Weekly Wins.md`.
7. Print the output and confirm where it was written. Call out any Growth lines that became seeds so the user can feel the congratulate loop.

If Shipped.md has no entries and there are also no Learning/Growth crumbs, say so and suggest `/eod` / `/log-shipped` — offer a short "quiet week" stub only if the user asks.
