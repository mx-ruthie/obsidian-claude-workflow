# obsidian-claude-workflow

One evening ritual — `/eod` — that closes today and seeds tomorrow in Obsidian.

Morning is a **glance**, not a command. `/morning` exists only as catch-up when you skip a night.

Built for Claude Code or Cursor. ADHD-aware: if it requires remembering without a nudge, it won't stick — so Slack reminds you once at ~5pm, and the skill does the blank-page work.

---

## Quick start (adopter)

```bash
git clone https://github.com/mx-ruthie/obsidian-claude-workflow.git
cd obsidian-claude-workflow
cp config.example.env config.env   # fill in vault path, Linear email, Slack IDs
chmod +x scripts/install.sh
./scripts/install.sh
```

Then set **one** weekday Slack reminder (~5pm): `Run /eod`.

Tonight, run `/eod` once. Tomorrow morning, open the seeded daily note.

Full checklist + smoke test: **[docs/ADOPT.md](docs/ADOPT.md)**  
Why it's shaped this way (shareable): **[docs/SHARE.md](docs/SHARE.md)**  
Fork for Jira / GitLab / no Slack / etc.: **[docs/TWEAK.md](docs/TWEAK.md)**

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

Obsidian starters (`Daily Workflow.md`, `Today.md`, templates for daily notes / Shipped / Weekly Wins / My Story) install into your vault **only if those files don't already exist**.

---

## Shape of a day

```
Last night's /eod  →  tomorrow already has Focus + Morning
Morning            →  open note, set Focus, glance
During day         →  forward Slack yeses; optional /log-this
~5pm               →  /eod once
```

---

## Prerequisites

**Required for full default skills**
- Obsidian (or any markdown vault with the same folder names)
- Claude Code and/or Cursor
- `gh` authenticated
- Linear MCP + Slack MCP

**Optional**
- Granola MCP (meeting catch-up in `/eod`)
- Notion MCP (`/log-this` for Notion URLs)
- Career Slack channel (`/my-story` + Friday prompt)

If your stack differs, install anyway, then edit adapters — see [docs/TWEAK.md](docs/TWEAK.md).

---

## Config placeholders

| Placeholder | Meaning |
|---|---|
| `YOUR_VAULT_PATH` | Absolute path to vault (no trailing slash) |
| `YOUR_LINEAR_EMAIL` | Linear account email |
| `YOUR_REMINDERS_CHANNEL` | e.g. `#your-name-reminders` |
| `YOUR_SLACK_CHANNEL_ID` | Channel ID |
| `YOUR_SLACK_USER_ID` | Your Slack member ID |
| `YOUR_CAREER_SLACK_CHANNEL` | Optional career moments channel name |
| `YOUR_CAREER_SLACK_CHANNEL_ID` | Optional channel ID |

`scripts/install.sh` reads `config.env` and substitutes these into the skill files before copying them to `~/.claude/commands` and/or `~/.cursor/commands`.

---

## Forwarding commitments

When you say “I’ll look at that” in Slack, forward the message to your reminders channel. `/eod` that evening sweeps it into next workday’s Morning. No task manager required.

Catch-up is built for skipped days: since the last note with `## EOD` or `## Morning`, or the last 5 calendar days if you went dark — not “today only.”

---

## Career growth layer (optional)

```
Daily Growth/Revise crumbs  →  /weekly-wins story seeds  →  /my-story chapters
         ↑                              ↑
   Career Slack moments           Shipped.md trail
```

Nothing auto-posts. `/eod` only **asks** on Fri/Mon whether to run weekly wins / my-story.

---

## Design decisions

Kept small on purpose. Rejected:
- Live-updating dashboard (destroys the historical arc)
- Required morning command (reminder fatigue killed the baseline)
- Calendar MCP (faster to glance)
- Auto-capturing every agent session (low signal)

**July 2026 redesign:** one evening ritual. Seed tomorrow at closeout. Morning nudge deleted.

---

## Sharing this with a teammate

1. Send [docs/SHARE.md](docs/SHARE.md) (or paste into Notion).  
2. Point them at [docs/ADOPT.md](docs/ADOPT.md).  
3. Let them fork adapters via [docs/TWEAK.md](docs/TWEAK.md) — don’t hand them your private `config.env` or vault.

---

*You don't have to be perfect. Even `/eod` most evenings builds the trail.*
