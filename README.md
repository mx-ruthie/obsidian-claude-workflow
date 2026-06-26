# obsidian-claude-workflow

A daily note system for engineers using Obsidian + Claude Code. Two commands — `/morning` and `/eod` — triggered by Slack reminders, that together build a timestamped arc of each workday.

**`/morning`** pulls your in-progress tickets, open PRs, review requests, and anything you've forwarded to a private Slack channel as a commitment. It writes a `## Morning` section to today's Obsidian daily note so you open it already oriented.

**`/eod`** diffs the day against the morning snapshot, catches any Granola meeting notes you forgot to log, and writes a `## EOD` section with what shipped, what moved, and what's carrying over. It also appends to a running `Career/Shipped.md` log useful for promo prep and interview stories.

Three Slack reminders (9:30am, 3:33pm, 5pm) handle the "remember to do this" problem. They don't run the commands for you — they just nudge you to open Claude Code and run them yourself.

---

## Prerequisites

- [Claude Code](https://claude.ai/code) with the following MCP servers connected:
  - **Linear** — for ticket state
  - **Slack** — for reading your reminders channel
  - **Granola** — for meeting notes (used by `/eod`)
- **GitHub CLI** (`gh`) — authenticated
- **Obsidian** — with a `Daily notes/` folder and a `Career/Shipped.md` file

---

## Setup

### 1. Replace placeholders

Search the `skills/` folder for these four strings and replace with your own values:

| Placeholder | Replace with |
|---|---|
| `YOUR_VAULT_PATH` | Absolute path to your Obsidian vault (e.g. `/Users/you/Notes`) |
| `YOUR_LINEAR_EMAIL` | Your Linear account email |
| `YOUR_SLACK_CHANNEL_ID` | Channel ID of your private reminders channel in Slack |
| `YOUR_SLACK_USER_ID` | Your Slack user ID |

To find your Slack channel ID: open the channel in Slack → click the channel name → scroll to the bottom of the About panel.

To find your Slack user ID: click your profile picture → Profile → click the `...` menu → Copy member ID.

### 2. Install the skill files

Copy the three files from `skills/` to your Claude Code commands folder:

```bash
cp skills/morning.md ~/.claude/commands/morning.md
cp skills/eod.md ~/.claude/commands/eod.md
cp skills/log-shipped.md ~/.claude/commands/log-shipped.md
```

### 3. Add the Obsidian files

Copy the two files from `obsidian/` into the root of your Obsidian vault:

```bash
cp "obsidian/Today.md" "/YOUR_VAULT_PATH/Today.md"
cp "obsidian/Daily Workflow.md" "/YOUR_VAULT_PATH/Daily Workflow.md"
```

Also create a `Career/Shipped.md` file in your vault if you don't have one:

```bash
mkdir -p "/YOUR_VAULT_PATH/Career"
echo "# Shipped" > "/YOUR_VAULT_PATH/Career/Shipped.md"
```

### 4. Set up Slack reminders

Create a private Slack channel for reminders (e.g. `#your-name-reminders`). This is where you'll forward Slack commitments you want to track, and where the automated nudges land.

Then set up three recurring cloud agent routines in Claude Code via `/schedule`:

- **9:30am weekdays** — send a message to your channel reminding you to run `/morning`
- **3:33pm weekdays** — send a message asking if there's anything from Slack worth forwarding
- **5:00pm weekdays** — send a message reminding you to run `/eod`

---

## How it works

```
9:30am  Slack nudge → you open Claude Code and run /morning → ## Morning written to today's note
3:33pm  Slack nudge → you forward any Slack commitments to your reminders channel
5:00pm  Slack nudge → you open Claude Code and run /eod → meetings caught up, ## EOD written, Shipped.md updated
```

The reminders are just nudges — automated Slack messages that prompt you to act. The commands themselves are always run manually by you in Claude Code.

The daily note ends up with a frozen arc of the day: what you started with, what moved, where things landed. Open any past note and you'll know exactly what you were juggling that day.

The `Career/Shipped.md` file accumulates over time — useful for performance reviews, promo packets, and interview prep.

---

## Forwarding commitments

When you tell someone "I'll look at that" in Slack, forward the message to your reminders channel. `/morning` reads it the next day and surfaces it in your daily note. No task manager, no copy-pasting — just a forward.

---

## Design decisions

The system was intentionally kept small. Things that were designed and rejected:

- **Live-updating status dashboard** — overwrites itself, loses the historical record of what a day looked like
- **Calendar integration** — no MCP available; faster to just glance at your calendar
- **Automated EOD synthesis with multiple snapshots** — too many moving parts, nothing gets used
- **Auto-capturing git/Claude Code session activity** — lower signal than the manual `## Claude Sessions` notes engineers already write naturally

The interesting constraint was ADHD-aware design: if it requires remembering to do something, it won't get done. The Slack reminders solve the "remember" problem; the commands solve the "do the work" problem.
