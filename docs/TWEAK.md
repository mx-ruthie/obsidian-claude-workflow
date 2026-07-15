# Tweak it for your stack

The skill is a **loop** (phases). Your tools are **adapters**. Change adapters; keep the loop.

## Phases (keep these)

1. Baseline — read Morning on today's note  
2. Gather — current state from sources of truth  
3. Diff — shipped / picked up / still in flight  
4. Catch-up — meetings (optional)  
5. Write today — `## EOD` (+ optional Growth/Revise)  
6. Durable log — `Career/Shipped.md`  
7. Seed next workday — Focus + Morning  
8. Prompt only — weekly/monthly career asks (never auto-run)

## Adapters (swap freely)

| Phase piece | Default in this repo | Swap ideas |
|---|---|---|
| Tickets | Linear MCP + `YOUR_LINEAR_EMAIL` | Jira / Asana / GitHub Issues — same “in progress” + “done today” queries |
| My changes | `gh` PRs | GitLab MRs; or drop entirely if you don't ship via PRs |
| Reviews waiting | `gh search prs --review-requested` | Equivalent on your host, or delete the subsection |
| Meetings | Granola MCP | Notion AI notes, Fireflies, or skip (calendar glance only) |
| Commitments | Slack forward → reminders channel | Apple Reminders, a `#commitments` note, email-to-self |
| Notes home | Obsidian markdown | Notion pages with the same heading names |
| What “shipped” means | PR merged + ticket Done | Doc published / email sent / decision locked / person unblocked |

## Common forks

### “I'm not an engineer who lives in PRs”
In `skills/eod.md` Part A gather + Part B Morning: replace PR sections with whatever proves progress for you (docs, launches, decisions). Rewrite `/log-shipped` the same way.

### “I don't want Slack MCP”
Delete Slack commitment steps from `/eod` and `/morning`. Capture commitments by hand under Morning → **Commitments**, or drop the subsection.

### “Two rituals still work for me”
You can keep a real morning run — but then you'll fight reminder fatigue. Prefer: evening seeds tomorrow; morning is glance-only.

### “Daily is too much”
Weekly-only is honest: run a weekly close that writes shipped + seeds next Monday. Accept that mid-week Slack yeses will leak unless you forward them somewhere you'll actually look.

### “Different note date format”
Skills use `DD-MM-YYYY.md`. Search/replace the path pattern if your vault uses `YYYY-MM-DD`.

### “No career narrative yet”
Leave `YOUR_CAREER_SLACK_CHANNEL` blank. `/eod` will skip the Friday career ask if you also remove Part C step 13. Keep `/weekly-wins` — it only needs Shipped + daily crumbs.

## Edit order that hurts least

1. `config.env` + re-run `./scripts/install.sh`  
2. If you need structural changes, edit files in `skills/` **then** re-install (install overwrites `~/.claude/commands` / `~/.cursor/commands` from `skills/`)  
3. Keep a local branch/commit of your forks so upgrades from upstream are mergeable
