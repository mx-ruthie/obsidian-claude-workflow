Add a new chapter to the career narrative in My Story.md, drawing from the career Slack channel, merged PRs, Weekly Wins, and daily growth crumbs since the last update.

Files:
- Narrative doc: `YOUR_VAULT_PATH/Career/My Story.md`
- Weekly Wins: `YOUR_VAULT_PATH/Career/Weekly Wins.md`
- Daily notes: `YOUR_VAULT_PATH/Daily notes/`
- Slack channel: `YOUR_CAREER_SLACK_CHANNEL` (channel ID: `YOUR_CAREER_SLACK_CHANNEL_ID`)

Steps:
1. Read `My Story.md`. Find the date the last chapter ends — this is the "since" date for all lookups.

2. Fetch in parallel:
   a. **Career channel posts** — read `YOUR_CAREER_SLACK_CHANNEL` since the last chapter date. Collect messages posted by the user (skip bots). Raw career moments: shoutouts, reflections, things worth remembering.
   b. **Merged PRs** — `gh pr list --author "@me" --state merged --search "merged:>=SINCE_DATE" --json number,title,url,mergedAt,body` — technical evidence of ownership, complexity, cross-team impact, or growth (not routine churn).
   c. **Weekly Wins** — sections with `## Week of` dates on/after the since date. Story seeds already shaped for narrative.
   d. **Daily growth crumbs** — in daily notes since the since date, collect EOD `**Growth:**` / `**Revise:**` lines and standout `## Learning` bullets that show judgment (not every declined exercise).

3. Synthesize themes across all four sources. PRs nobody posted about may still belong if they mark a real step. Growth/Revise lines often carry the human arc Weekly Wins already started.

4. Write the next chapter in the same voice and style as the existing ones:
   - Third person, outside looking in
   - Narrative prose — no bullet points, no headers within the chapter
   - Lead with the human story; use PRs as evidence not as a list
   - Chapter title format: `## Chapter N: [Theme] *(Month – Month Year)*`
   - Honest about gaps, uncertainty, misses that led to a revised approach, and what the person is still developing toward

5. Append the new chapter to `My Story.md`, before any `## Visualizing the Arc` section if present. Update a mermaid timeline with 2-3 key moments from the new chapter if one exists.

6. Update the `*Last updated*` line at the bottom if present.

7. Report what was added — chapter title, date range covered, and the 2-3 moments that anchored it.
