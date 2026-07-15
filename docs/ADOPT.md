# Adopt / week one

Most people should **not** start here. Open the repo in your IDE and tell the agent:

> Help me set this up for my actual stack.

That path is [`AGENT_SETUP.md`](AGENT_SETUP.md) (agents also read [`../AGENTS.md`](../AGENTS.md)).

This page is the human checklist for *after* install: smoke test + week-1 habit.

---

## After your agent finishes install

### Smoke test tonight

- [ ] Run `/eod` in Claude Code or Cursor
- [ ] Today’s daily note has `## EOD`
- [ ] Next workday note has `## Focus` + `## Morning`
- [ ] You know which `VERSION` you installed

### One reminder

Weekdays ~5pm: `Run /eod`. Skip morning nudges.

### Week 1 habit

| Day | Do this |
|---|---|
| Each work evening | Run `/eod` when the nudge hits |
| During day | Capture commitments the way you configured (often: forward Slack yeses) |
| Morning | Open the seeded note; set Focus; glance |
| Friday (optional) | Say yes when `/eod` asks about weekly wins |

Skip Weekly Wins / My Story until the evening ritual feels boringly reliable. When you’re ready, wire them via [CAREER.md](CAREER.md) (or ask your agent to).

---

## If something fails

| Symptom | Likely fix |
|---|---|
| Skill writes to wrong path | Re-check `YOUR_VAULT_PATH` in `config.env`, re-run install (or ask your agent) |
| No tickets | Ticket MCP / email mismatch — or you stripped tickets and that’s fine |
| No PRs | `gh auth login` — or you stripped PRs |
| Commitments empty | Wrong Slack IDs, or you chose a non-Slack capture and haven’t used it yet |
| Meetings skipped | Expected without Granola (or your meeting tool) |

---

## Next reading

- [SHARE.md](SHARE.md) — why it’s shaped this way  
- [TWEAK.md](TWEAK.md) — change adapters later  
- Vault `Daily Workflow.md` — operator cheat sheet once installed
