# For IDE agents (Cursor / Claude Code / etc.)

If a human opened this repo and asked you to help them set it up (e.g. “get this working for my actual tech”, “install this for me”, “adapt it to Jira instead of Linear”):

1. Read `docs/AGENT_SETUP.md` and follow that brief.
2. Read `docs/TWEAK.md` before assuming they use Linear + GitHub + Slack + Granola.
3. Ask what they actually use (ticket tool, git host, notes home, commitments capture, meetings). Strip or swap adapters; keep the phases.
4. Create `config.env` from `config.example.env`, run `scripts/install.sh`, report the installed `VERSION`.
5. Do **not** run `/eod` unless they ask. Do **not** invent Focus from tickets. Do **not** post to Slack unless they ask.

Human-facing why: `docs/SHARE.md`  
Version / drift: `VERSION`
