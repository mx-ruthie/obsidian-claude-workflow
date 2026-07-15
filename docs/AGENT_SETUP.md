# Agent setup prompt

**Typical human move:** open/clone this repo and say *“help me get this set up for my actual tech.”*  
If they pasted only this file, treat that the same way.

**You (agent):** follow this brief. Prefer doing the work over narrating. Ask only for values you cannot discover. Do not invent Slack/Linear IDs. Adapt adapters to what they say they use ([TWEAK.md](TWEAK.md)).

---

## Brief: install obsidian-claude-workflow for me

Set up this repo so I can run `/eod` tonight. Defaults in `skills/` assume Linear + GitHub (`gh`) + Slack — **do not force that stack**. Match my tools.

### What this system is

One evening ritual. `/eod` closes today in an Obsidian vault and seeds tomorrow’s `## Focus` + `## Morning`. `/morning` is catch-up only. Skills are markdown slash commands for Claude Code (`~/.claude/commands`) and/or Cursor (`~/.cursor/commands`).

Read in the clone (after you have it):
1. `VERSION` — release / sync date
2. `docs/SHARE.md` — design intent (orientation over journaling; phases vs adapters)
3. `docs/TWEAK.md` — how to swap Linear / GitHub / Slack / meetings
4. `docs/ADOPT.md` — human checklist / week-1 habit
5. `config.example.env` + `scripts/install.sh`

### Prerequisites to verify (don’t fail the whole install)

| Piece | If missing |
|---|---|
| Obsidian vault path (or any markdown folder) | Ask me for an absolute path; create `Daily notes/` + `Career/` if needed |
| Claude Code and/or Cursor | Ask which; set `INSTALL_TARGET` to `claude`, `cursor`, or `both` |
| `gh` auth | If broken, still install; note that PR sections will be empty until fixed — or strip PR gather steps per TWEAK.md if I say I don’t use GitHub PRs |
| Linear MCP | If I don’t use Linear, ask what ticket tool I use (or none) and adapt skills per TWEAK.md before install |
| Slack MCP | If I don’t want Slack commitments, leave reminders placeholders as `UNUSED` and remove Slack steps from skills per TWEAK.md before install |
| Granola / Notion / career channel | Optional — skip unless I say I want them |

### Steps (do these)

1. Clone the repo if needed (default `~/code/obsidian-claude-workflow`, or ask where I want it).
2. Ask me, in one batch if possible:
   - Absolute vault path
   - Install target: Claude / Cursor / both
   - Linear email (or “no Linear — use X / none”)
   - Reminders Slack channel name + channel ID + my Slack user ID (or “skip Slack”)
   - Optional career Slack channel name + ID
   - Anything to strip up front (no PRs, no meetings, Jira instead of Linear, etc.)
3. Create `config.env` from `config.example.env` with my answers.
4. If I asked for stack forks, edit files under `skills/` **before** running install (placeholders stay as `YOUR_*` until install substitutes them). Common forks are in `docs/TWEAK.md`.
5. Run `chmod +x scripts/install.sh && ./scripts/install.sh`.
6. Confirm the substituted command files landed under `~/.claude/commands` and/or `~/.cursor/commands` and that vault starter files exist (don’t overwrite existing Career notes).
7. Tell me:
   - Exact command to run tonight: `/eod`
   - What “success” looks like (today’s note has `## EOD`; next workday has `## Focus` + `## Morning`)
   - To set **one** weekday ~5pm nudge: `Run /eod`
   - The installed `VERSION` string so I know what I have
8. Stop. Do not run `/eod` for me unless I ask. Do not post to Slack. Do not invent focus from tickets.

### Success criteria

- [ ] `config.env` exists and is gitignored
- [ ] `/eod` command file is installed for my IDE
- [ ] Vault has `Daily notes/`, `Career/Shipped.md` (or already did)
- [ ] I know the single nightly ritual and the VERSION I installed
