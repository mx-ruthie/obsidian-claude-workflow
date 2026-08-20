# Changelog

All notable changes to the shareable skills in this repo. Dates are release dates; the [`VERSION`](VERSION) file always holds the latest, and each entry has a matching `v<date>` tag on the **Releases** page. Format loosely follows [Keep a Changelog](https://keepachangelog.com/).

## [2026-08-20]

Adherence release. Nine `/eod` runs in the author's vault were measured against what they actually produced, and the changes below follow from where the ritual leaked rather than from taste.

- **`/eod` Part C never blocks.** It was five conditional "ask once" prompts, and the report step ended with *"stop for an answer if you asked anything"* — so on a Friday the ritual could fire five questions at the moment you're trying to leave. Part C now computes which follow-ups are **due** and prints them as one line of bare commands (`Optional: /weekly-wins · /my-story`). An ignored menu is a successful EOD; leaving is the point.
- **Both rituals verify what they wrote.** New `/eod` step 10b and `/morning` step 4b re-read the note from disk and confirm the `## Morning` heading is present before reporting success, retrying once and warning loudly if it still isn't. Three runs had reported a seeded next workday whose note contained no Morning section at all — a silent failure that breaks the chain, because the next day then opens blank and the `/morning` repair has to be remembered.
- **Growth/Revise writes instead of asking, and leads with countable signals** — a ticket recurring across the last five Open tasks checklists (a deferred papercut, and computable from the notes themselves), a PR merged clean in an area that previously churned, review rounds, backward ticket movement. Over nine runs the propose-a-candidate-and-confirm version produced 2 Growth lines and 0 Revise lines; the approval gate, not a lack of material, was the problem. The Growth lens remains as the fallback when no countable signal fires.
- **New skill: `/weekly-skill-coach`** — Friday/Monday efficiency audit that surveys the past week across connected tools, produces a friction log, and pitches 1–3 automations to build. Referenced by step 13b, which previously pointed at a command that wasn't published.
- **Sanitizer covers org, repo, and team identifiers** (`YOUR_ORG`, `YOUR_REPO`, `YOUR_TEAM_UPDATE_NAME`, `YOUR_TEAM_CHANNEL`, `YOUR_TEAM_UPDATE_DEST`). These reach the skills through incidental prose — a reading-list category naming an employer, a named weekly team ritual — rather than through explicit config, so they were being published raw. Two such leaks were already live in `skills/eod.md`. All five are optional; blank skips the substitution, so existing `config.env` files keep working.
- **`check-drift.sh` stops crying wolf.** The publish path and the compare path each carried their own copy of the substitutions, and the copies had drifted twice: a trailing newline (`sync` wrote `'%s\n'`, `check-drift` wrote `'%s'`), and sentence-initial capitalization of the author's name (`The user` vs `the user`). Both showed up as permanent phantom drift on `eod.md` and `morning.md` — the two files that change most, reported as drifted *immediately after a successful sync*. A drift tool that is wrong about the files you actually edit stops being consulted, which is how the local copies diverged in the first place. The substitutions now live once in `scripts/lib-sanitize.sh`, sourced by both, so the two cannot disagree by construction; `check-drift` reports **No drift** against a fresh sync for the first time.
- **Default sync source is now `~/.claude/commands`.** It had been `~/.cursor/commands` with a note that the Claude copy actually led. Since the author has moved off Cursor, a bare `./scripts/sync-from-local.sh` would have sanitized from stale files and silently regressed the published skills.
- **README**: dropped the stale `Focus` step from "Shape of a day" (Focus was removed in 2026-08-12 but the diagram still advertised it), and added `/weekly-skill-coach` to the command table.

## [2026-08-12]
- `/eod` + `/morning`: dropped the daily Focus prompt/placeholder entirely — it went unused, so stop asking and stop seeding it.
- `/eod` meeting catch-up now splits **work** meetings (one line: decisions + owned actions, no roster-of-everyone's-status) from **social** meetings (no `## Meetings` entry at all — the transcript is still skimmed for a career-relevant nugget, which surfaces via Growth/Revise instead of a summary).
- **Open tasks** narrows to genuinely **not-started** work — tickets sitting in Todo/Blocked with no PR to remind you they exist. Dropped open-PR review-state and In Progress/In Review listings entirely; those are one glance away on GitHub/Linear and don't need repeating in the note.
- Added a **Project** line to both rituals: the Linear project behind your active tickets, its current milestone, and that milestone's progress % (+ target date if set) — a standing "where am I on this" signal instead of ticket-level noise.

## [2026-07-24]
- `/eod` + `/morning`: **Open loops → Open tasks**, now a tickable markdown checkbox list (`- [ ]`); Commitments are checkboxes too.
- Both rituals **stop putting "reviews waiting on you" in the daily note** (that's a GitHub view, not note content); dropped the review-request fetch from `/morning`.
- `/eod` + `/morning`: the reminders sweep is now a **triage** — reading links get filed into a bucketed reading-list note (not the daily note), follow-ups become checkbox tasks (a ticket is *proposed*, never auto-created), expenses are flagged, FYIs noted; scheduled nudges still skipped.

## [2026-07-21]
- `/eod` meeting catch-up (step 4) now builds each entry from the **verbatim transcript** (`get_meeting_transcript`), not the AI summary — meeting summaries hallucinate content and mis-attribute speakers, so all claims/decisions/attributions are grounded in the transcript.
- Added **step 8b**: prompt once for tomorrow's Focus (ticket + one-line goal) while seeding; falls back to the placeholder, never blocks.
- Growth lens gained two signals ("read the room / adjusted pacing mid-call", "went too deep before checking the audience"); step 5b now skims meeting transcripts for communication/delivery moments.
- Added **step 13b**: optional Friday efficiency prompts (skill-usage coach, team-update blurb) — prompt-only, never auto-run, kept out of Weekly Wins.
- `docs/TWEAK.md`: prefer transcripts over AI summaries for any meeting tool.

## [2026-07-15]
- One-ritual `/eod` system with easy adopter install; VERSION + drift tooling; explicit career-growth wiring guide.
