# Daily Workflow

*Brain went blank? Start here. Follow top to bottom.*

---

## The shape of a day

```mermaid
flowchart TD
    A([Start of day]) --> B[Open today's note\nFocus + Morning already seeded]
    B --> C[Set Focus if needed\nglance commitments · tickets · PRs]

    C --> D{During the day}

    D --> E[Finished a meeting?]
    E --> F[Optional: log it now\nor let /eod catch it]
    F --> G[Meeting lands in\n## Meetings]

    D --> H[Saw a useful\ndoc or ticket?]
    H --> I[/log-this url-or-ticket-id]
    I --> J[Link lands in\n## Docs & Decisions]

    D --> K[Slack commitment\nyou want to track?]
    K --> L[Forward message to\nyour reminders channel\n/eod picks it up tonight]

    C --> M([End of day])
    M --> N[Slack nudge ~5pm\nOpen Claude Code or Cursor]
    N --> O[Run /eod]
    O --> P[## EOD on today\nShipped → Career/Shipped.md]
    O --> Q[Next workday note seeded\n## Focus + ## Morning]
```

---

## Morning (glance only — no command)

- [ ] Open today's daily note — `/eod` last night already wrote `## Focus` + `## Morning`
- [ ] Set Focus if the placeholder is still there
- [ ] Glance: commitments · tickets · PRs · reviews waiting on you

If the note has no `## Morning` (skipped EOD): run `/morning` once as catch-up.

---

## During the day

| When this happens | Do this | Where it lands |
|---|---|---|
| Meeting ends | Log it now — or skip and let `/eod` catch it | `## Meetings` in today's note |
| Useful Notion/doc URL | `/log-this [url]` | `## Docs & Decisions` |
| Ticket worth noting | `/log-this [TICKET-ID]` | `## Docs & Decisions` |
| Slack commitment | Forward to your reminders channel | Tonight's `/eod` → tomorrow's Morning |
| Quick thought | Drop it under `## Remember & Action Items` | Today's note |

---

## End of day (the one ritual)

- [ ] Nudge at ~5pm → open Claude Code or Cursor
- [ ] Run `/eod`
  - Catches meeting notes you didn't log (if a meeting MCP is configured)
  - Diffs against the Morning baseline (seeded last night, or catch-up `/morning`)
  - Appends `## EOD` — including optional **Growth** / **Revise** lines
  - Writes shipped items to `Career/Shipped.md`
  - **Seeds next workday** (Fri/Sat/Sun → Monday) with Focus + Morning
  - Slack catch-up is automatic since last `## EOD` or `## Morning` (or last 5 days if you went dark)
  - Prompts (Fri/Mon as relevant): `/weekly-wins`, `/my-story`, career-channel — say yes/no; nothing auto-runs

---

## Weekly (Fridays, ~15 min)

- [ ] Run `/weekly-wins` → review story seeds *(or say yes when `/eod` prompts)*
- [ ] Skim `Career/Shipped.md`
- [ ] Clear your reading / links queue if you keep one

---

## Where things live

| What | Where |
|---|---|
| Daily notes | `Daily notes/` |
| Meeting notes | Inside daily note → `## Meetings` |
| Shipped work log | `Career/Shipped.md` |
| Weekly story seeds | `Career/Weekly Wins.md` |
| Career narrative | `Career/My Story.md` |
| Templates | `Templates/` |

---

## Commands

| Command | When to run | What it does |
|---|---|---|
| `/eod` | End of day — **the daily ritual** | Closes today + optional Growth/Revise + seeds next workday + prompts for weekly/monthly |
| `/morning` | Only if today's Morning is missing | Catch-up orientation; no-op if already seeded |
| `/log-this [url or ticket]` | Anytime | Pulls Notion/Linear context → today's note |
| `/log-shipped` | Anytime | Writes shipped items to `Career/Shipped.md` |
| `/weekly-wins` | Fridays (or when `/eod` prompts) | Story seeds from Shipped + Learning / Growth / Revise |
| `/my-story` | First Friday (or when `/eod` prompts) | Chapter from career channel + PRs + Weekly Wins + crumbs |

---

## Slack reminders (keep these lean)

| When | Nudge |
|---|---|
| Weekdays ~5pm | Run `/eod` |
| Fridays ~2pm (optional) | Run `/weekly-wins` |
| First Friday ~2pm (optional) | Run `/my-story` |

Skip a morning nudge. Morning is a glance, not a ceremony.

---

## Growth lens (optional)

Look for **judgment**, not output volume. One honest line beats a polished paragraph.

**Growth:** caught a reviewer's concern early; refused a band-aid; enabled someone else; held two true things at once; course-corrected in public.

**Revise:** same papercut deferred 3+ times; shipped something you can't explain at a boundary that mattered; let noise beat Focus; scope creep burned the day.

**Loop:** EOD crumb → Weekly Wins → monthly My Story. Forward praise and ownership moments to your career channel when they happen.

Full wiring guide (for you or your IDE agent): if this repo is still nearby, see `docs/CAREER.md` in [obsidian-claude-workflow](https://github.com/mx-ruthie/obsidian-claude-workflow).

---

## Redesign note (why one ritual)

Two daily commands (morning + evening) failed in practice — morning nudges became noise, the command didn't run, reminders piled up, and EOD lost its baseline.

**New shape:** one evening ritual. `/eod` closes today *and* writes tomorrow's orientation. `/morning` stays only as catch-up.

Still true:
- Orientation over journaling
- Daily notes are historical (`## Morning` start-of-arc, `## EOD` end-of-arc), not a live dashboard
- Slack commitments via forwarding
- Calendar: glance yourself (no calendar MCP required)

---

*You don't have to be perfect. Even just `/eod` most evenings builds the trail.*
