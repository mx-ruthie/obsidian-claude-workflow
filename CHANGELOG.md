# Changelog

All notable changes to the shareable skills in this repo. Dates are release dates; the [`VERSION`](VERSION) file always holds the latest, and each entry has a matching `v<date>` tag on the **Releases** page. Format loosely follows [Keep a Changelog](https://keepachangelog.com/).

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
