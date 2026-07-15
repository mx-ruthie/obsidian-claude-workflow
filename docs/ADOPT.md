# Adopt this in one sitting (~20 min)

Goal: `/eod` works tonight. Everything else can wait.

## You need

- [ ] Obsidian vault (any folder of markdown is fine)
- [ ] Claude Code **or** Cursor with agent slash commands
- [ ] GitHub CLI (`gh auth status` works) — or plan to strip PR steps later (see [TWEAK.md](TWEAK.md))
- [ ] Linear MCP connected — or plan to swap ticket tool later
- [ ] Slack MCP connected (for the commitments channel)

Optional later: Granola (meetings), Notion (`/log-this`), career Slack channel (`/my-story`)

## Steps

1. **Clone this repo**
   ```bash
   git clone https://github.com/mx-ruthie/obsidian-claude-workflow.git
   cd obsidian-claude-workflow
   ```

2. **Fill in config**
   ```bash
   cp config.example.env config.env
   # edit config.env — vault path, Linear email, Slack channel + user IDs
   ```

   Find Slack IDs: open channel → About → bottom for channel ID; profile → `...` → Copy member ID.

3. **Install**
   ```bash
   chmod +x scripts/install.sh
   ./scripts/install.sh
   ```

   This copies substituted skills into `~/.claude/commands` and/or `~/.cursor/commands`, and creates vault starter files **only if missing**.

4. **Create the Slack channel** if it doesn't exist (private is fine). Forward one test message to it.

5. **Set one reminder** — weekday ~5pm: “Run `/eod`”. Nothing else required.

6. **Smoke test tonight**
   - Open Claude Code or Cursor
   - Run `/eod`
   - Confirm today's note got `## EOD` and tomorrow (or Monday) got `## Focus` + `## Morning`

## Week 1 habit

| Day | Do this |
|---|---|
| Each work evening | Run `/eod` when the nudge hits |
| During day | Forward Slack yeses to your reminders channel |
| Morning | Open the seeded note; set Focus; glance |
| Friday (optional) | Say yes when `/eod` asks about weekly wins |

Skip Growth/Revise, Weekly Wins, and My Story until the evening ritual feels boringly reliable.

## If something fails

| Symptom | Likely fix |
|---|---|
| Skill writes to wrong path | Re-check `YOUR_VAULT_PATH` in `config.env`, re-run install |
| No tickets | Linear MCP auth / email mismatch |
| No PRs | `gh auth login` for the right account |
| Commitments empty | Wrong channel/user ID, or you didn't forward anything |
| Meetings skipped | Expected if Granola isn't configured |

## Next reading

- [SHARE.md](SHARE.md) — why the system is shaped this way (good to soft-share with a curious teammate)
- [TWEAK.md](TWEAK.md) — swap Linear/GitHub/Slack/Granola; change what “shipped” means
- `../obsidian/Daily Workflow.md` — operator's cheat sheet once it's in your vault
