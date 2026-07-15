# Career growth tracking — how to wire it

The daily ritual builds a **trail**. Career docs turn that trail into story seeds and a narrative you can reuse for promo, reviews, and interviews.

Nothing auto-posts. `/eod` only **asks** on Fri/Mon. You say yes/no.

```
Daily: Shipped.md + optional Growth/Revise (+ Learning)
        ↓
Weekly: /weekly-wins  →  Career/Weekly Wins.md
        ↓
Monthly: /my-story     →  Career/My Story.md
        ↑
Optional capture: private career Slack channel (praise, hard calls, ownership moments)
```

---

## Layers (add in this order)

### Layer 1 — Shipped trail (on by default)

**What:** `Career/Shipped.md`  
**When:** every `/eod` (and `/log-shipped` anytime)  
**Needs:** ticket tool and/or `gh` (whatever you configured for “done today”)

This alone is valuable. Skip everything below until evenings feel easy.

**Agent checklist**
- [ ] `Career/Shipped.md` exists in the vault (install creates it if missing)
- [ ] `/eod` Part A step 6 points at that path
- [ ] First smoke-test `/eod` appends a dated section when something actually shipped

---

### Layer 2 — Daily Growth / Revise crumbs (optional, in `/eod`)

**What:** one-line `**Growth:**` / `**Revise:**` under `## EOD`  
**When:** only when something real showed up — silence is correct  
**Needs:** nothing extra; Growth lens is already in `skills/eod.md`

These crumbs are judgment, not output volume. Weekly Wins and My Story read them later.

**Agent checklist**
- [ ] Leave Growth lens in `/eod` unless the human asked to strip it
- [ ] Confirm `/eod` **proposes candidates** and waits — never invents praise

---

### Layer 3 — Weekly Wins

**What:** `Career/Weekly Wins.md` via `/weekly-wins`  
**When:** Fridays (or when Monday `/eod` notices last week is missing)  
**Needs:** Layer 1; Layer 2 improvise story quality

`/eod` Part C prompts — does **not** run `/weekly-wins` unless the human says yes.

**Agent checklist**
- [ ] `Career/Weekly Wins.md` exists (template installed)
- [ ] `/weekly-wins` installed and vault path substituted
- [ ] Optional: Friday ~2pm nudge `Run /weekly-wins` (or rely on `/eod` asking)

---

### Layer 4 — Career capture channel (optional but powerful)

**What:** a private Slack channel (e.g. `#career-you`) for moments you’d forget  
**Habit:** when praise lands, or you made a hard call / owned something hard — forward or post a short note *that week*  
**Needs:** Slack MCP + `YOUR_CAREER_SLACK_CHANNEL` (+ ID) in `config.env`

This is separate from the **reminders** channel (commitments). Don’t mix them.

**Agent checklist — ask the human:**
- [ ] Do you want a career moments channel? If yes, create or name it
- [ ] Fill `YOUR_CAREER_SLACK_CHANNEL` and `YOUR_CAREER_SLACK_CHANNEL_ID` in `config.env`
- [ ] Re-run `scripts/install.sh` so `/eod` Friday ask + `/my-story` can read it
- [ ] Confirm `/eod` keeps Part C step 13 (career-channel ask) — omit only if they declined Layer 4

If they skip Slack: they can keep a `Career/Moments.md` and teach `/my-story` to read that instead ([TWEAK.md](TWEAK.md)).

---

### Layer 5 — My Story (monthly narrative)

**What:** `Career/My Story.md` chapters via `/my-story`  
**When:** first Friday of the month (or first Monday if missed); `/eod` asks  
**Needs:** Layer 1 strongly; Layer 3 ideally; Layer 4 optional; Chapter 1 seeded once

**Agent checklist**
- [ ] `Career/My Story.md` exists with a real **Chapter 1** (template has a stub — help them draft Chapter 1 once from recent shipped work + any career notes, or leave the stub if they want to write it by hand)
- [ ] `YOUR_CAREER_SLACK_*` filled **or** `/my-story` edited to skip Slack and use Moments.md / Weekly Wins only
- [ ] `/my-story` installed
- [ ] Optional: first-Friday nudge `Run /my-story`

---

## Agent: “wire up career growth” brief

If the human says they want career tracking (now or later), do this without waiting for them to discover each file:

1. Confirm Layers 1–2 are alive (Shipped path + Growth lens kept).
2. Ensure `Weekly Wins.md` + `/weekly-wins` installed; explain `/eod` will ask Fridays.
3. Ask whether they want Layer 4 (career Slack) or a markdown Moments file.
4. If yes to story narrative: seed Chapter 1 if still a stub; install `/my-story`; set career channel placeholders; remind them nothing auto-runs.
5. Report the ladder they have enabled vs deferred.

Example human prompt:

```text
Also wire up career growth tracking — Shipped, Weekly Wins, and My Story.
I want a private Slack channel for career moments. Walk me through what's needed.
```

---

## What success looks like in 6–8 weeks

| Artifact | You can open it and see… |
|---|---|
| `Shipped.md` | Dated bullets of finished work |
| Daily notes | Occasional Growth/Revise lines (not every day) |
| `Weekly Wins.md` | Story-shaped weeks you barely remember writing |
| Career channel | Raw moments that didn’t fit a ticket |
| `My Story.md` | Chapters that read like an outsider’s narrative of your arc |

Promo / review season becomes assembly, not archaeology.

---

## Explicit non-goals

- AI does not manage your career  
- AI does not post praise or Slack messages unless you ask  
- Empty Growth lines are worse than none — skip when nothing’s real  
- Don’t enable Layers 3–5 on night one if Layer 1 isn’t reliable yet
