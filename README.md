# obsidian-claude-workflow

One evening ritual — `/eod` — that closes today and seeds tomorrow in Obsidian.

Morning is a **glance**, not a command. `/morning` exists only as catch-up when you skip a night.

Built for Claude Code or Cursor. ADHD-aware: one ~5pm nudge; the skill does the blank-page work.

**Version:** see [`VERSION`](VERSION) (currently dated in that file).

---

## Fastest path: hand the repo to your AI

You do **not** need to follow a long manual checklist. Expected use:

1. Clone or download this repo (or open it in your IDE).
2. Tell your IDE agent something like:

> Help me set up this repo for my actual stack. Adapt the skills to the tools I use. Ask me anything you need, then install the commands.

3. Answer its questions (vault path, Linear vs Jira, Slack or not, Claude vs Cursor, etc.).
4. Tonight: run `/eod` once.

Agents reading this repo should follow **[`AGENTS.md`](AGENTS.md)** → **[`docs/AGENT_SETUP.md`](docs/AGENT_SETUP.md)** and fork adapters per **[`docs/TWEAK.md`](docs/TWEAK.md)**.

### Example prompts to paste

```text
Open this repo and set it up for me. I use Cursor, Obsidian at <path>, Jira not Linear,
GitHub PRs, and I want a private Slack reminders channel. Skip Granola for now.
```

```text
Install obsidian-claude-workflow for Claude Code. I don't use Slack MCP —
capture commitments in the daily note instead. Keep Growth/Revise.
```

```text
Diff my installed /eod against this repo and tell me what's drifted.
```

```text
Also wire up career growth tracking — Shipped, Weekly Wins, My Story,
and a private Slack channel for career moments. Follow docs/CAREER.md.
```

---

## Manual install (if you prefer)

```bash
git clone https://github.com/mx-ruthie/obsidian-claude-workflow.git
cd obsidian-claude-workflow
cp config.example.env config.env   # fill in
chmod +x scripts/install.sh && ./scripts/install.sh
```

Then one weekday ~5pm nudge: `Run /eod`.

---

## Docs map

| Doc | Who it's for |
|---|---|
| [`AGENTS.md`](AGENTS.md) | IDE agents — start here when asked to install/adapt |
| [`docs/AGENT_SETUP.md`](docs/AGENT_SETUP.md) | Full agent brief (also pasteable) |
| [`docs/SHARE.md`](docs/SHARE.md) | Human: why the system is shaped this way |
| [`docs/CAREER.md`](docs/CAREER.md) | Wire Shipped → Weekly Wins → My Story (± career Slack) |
| [`docs/ADOPT.md`](docs/ADOPT.md) | Human: week-1 habit + smoke test |
| [`docs/TWEAK.md`](docs/TWEAK.md) | Human + agent: swap adapters |
| [`VERSION`](VERSION) | Release date + maintainer sync notes |

---

## What you get

| Command | Role |
|---|---|
| `/eod` | **The daily ritual** — close today, optional Growth/Revise, update `Shipped.md`, seed next workday, prompt (don't auto-run) weekly/monthly |
| `/morning` | Catch-up only if today's Morning is missing |
| `/log-this` | Drop a Notion/Linear link into today's note |
| `/log-shipped` | Write shipped items without a full EOD |
| `/weekly-wins` | Friday story seeds from Shipped + growth crumbs |
| `/my-story` | Monthly narrative chapter from career channel + evidence |

Obsidian starters install into your vault **only if those files don't already exist**.

---

## Shape of a day

```
Last night's /eod  →  tomorrow already has Focus + Morning
Morning            →  open note, set Focus, glance
During day         →  forward Slack yeses (or your capture habit); optional /log-this
~5pm               →  /eod once
```

---

## Prerequisites (defaults — your AI should adapt)

**Common default stack in the skill files**
- Obsidian-style markdown vault
- `gh` + Linear MCP + Slack MCP

**Optional**
- Granola, Notion MCP, career Slack channel

Missing pieces are fine — tell the agent what to strip or swap ([`docs/TWEAK.md`](docs/TWEAK.md)).

---

## Config placeholders

| Placeholder | Meaning |
|---|---|
| `YOUR_VAULT_PATH` | Absolute path to vault (no trailing slash) |
| `YOUR_LINEAR_EMAIL` | Linear account email (or unused if forked away) |
| `YOUR_REMINDERS_CHANNEL` | e.g. `#your-name-reminders` |
| `YOUR_SLACK_CHANNEL_ID` | Channel ID |
| `YOUR_SLACK_USER_ID` | Your Slack member ID |
| `YOUR_CAREER_SLACK_CHANNEL` | Optional |
| `YOUR_CAREER_SLACK_CHANNEL_ID` | Optional |

`scripts/install.sh` substitutes these into skills before copying to `~/.claude/commands` and/or `~/.cursor/commands`.

---

## Maintainer: keep the public skills honest

```bash
./scripts/check-drift.sh      # local Cursor commands vs skills/ (normalized)
./scripts/sync-from-local.sh  # re-sanitize local → skills/, bump VERSION date
```

See [`VERSION`](VERSION) for details.

---

## Design decisions

Kept small on purpose. Rejected: live dashboards, required morning commands, calendar MCP, auto-capturing every agent session.

**July 2026:** one evening ritual. Seed tomorrow at closeout. Morning nudge deleted.

---

## Sharing with a teammate

1. Send the repo link (or [`docs/SHARE.md`](docs/SHARE.md)).
2. Tell them: *open it in your IDE and ask the agent to set it up for your stack.*
3. Don’t share your private `config.env` or vault.

---

*You don't have to be perfect. Even `/eod` most evenings builds the trail.*
