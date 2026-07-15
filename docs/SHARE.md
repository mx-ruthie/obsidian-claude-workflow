# How I close the day (and keep notes I can trust)

People usually ask for “the skill.” The useful thing to steal is the **loop**, not my exact MCP wiring.

I use a slash command (`/eod`) so an AI agent can close my day into Obsidian. This page explains the system. The repo has the installable skills + a 20-minute adopt path.

---

## The short version

I tried **two** daily commands (morning + evening). Morning nudges became noise, I skipped them, and evening had nothing useful to compare against.

**New shape:** one evening ritual.
- `/eod` closes **today**
- and **seeds tomorrow’s orientation**
- Morning is a glance at a note that already exists — not a second ceremony

Imperfect is fine. Even “most weeknights” builds a trail I can trust later.

---

## Design principles

1. **Orientation over journaling.** Start-of-day is “what’s live?” not “how do I feel?”
2. **Daily notes are history, not a live dashboard.** Morning = start of arc. EOD = end of arc.
3. **Capture commitments where they happen.** Forward Slack “yeses” to a private reminders channel; tonight’s closeout pulls them into tomorrow’s Morning.
4. **Ship somewhere durable.** Merged work also lands in `Shipped.md` so weekly/monthly reflection isn’t archaeology.
5. **Prompts > autopilot for career writing.** End of week/month it *asks* — nothing posts unless I say yes.
6. **Growth is optional and honest.** Sometimes one line of judgment. Silence is correct when nothing’s real.

---

## Phases vs adapters

| Stay the same (phases) | Swap per person (adapters) |
|---|---|
| Baseline → gather → diff → write today → durable log → seed tomorrow → prompt-only career asks | Linear vs Jira, GitHub vs GitLab, Granola vs skip meetings, Slack forward vs a commitments note |

Forking for a colleague means renaming adapters and what “shipped” means — not redesigning the day.

---

## What `/eod` does

| Phase | Job |
|---|---|
| Baseline | Read Morning on today’s note |
| Gather | PRs, tickets, meetings, commitments |
| Diff | Shipped / picked up / still in flight |
| Catch-up | Meetings you forgot to log (optional) |
| Write today | Short `## EOD` (+ optional Growth/Revise) |
| Durable log | Append to `Career/Shipped.md` |
| Seed next workday | Focus + Morning on tomorrow (or Monday) |
| Prompt only | Weekly wins / monthly story — ask, don’t auto-run |

---

## Start smaller than the full skill

1. Daily note with Focus / Morning / EOD  
2. One end-of-day pass: shipped · still in flight · tomorrow’s orientation  
3. One durable shipped list  

Add MCP / GitHub / Slack when the blank-page tax at 5pm is the actual pain.

---

## What this is not

- Not a second-brain encyclopedia  
- Not a public journal  
- Not “AI manages your career”  
- Not a requirement to be perfect every weekday  

---

## Implement it

See [ADOPT.md](ADOPT.md) for the install checklist, and [TWEAK.md](TWEAK.md) for stack forks.
