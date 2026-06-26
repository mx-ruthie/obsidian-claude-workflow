Add a new chapter to the career narrative in My Story.md, drawing from both your career Slack channel posts and merged PRs since the last update.

Files:
- Narrative doc: `YOUR_VAULT_PATH/Career/My Story.md`
- Slack channel: your career channel (search for channel ID via Slack MCP)

Steps:
1. Read `My Story.md`. Find the date the last chapter ends — this is the "since" date for all lookups.

2. Fetch in parallel:
   a. **Career Slack channel posts** — read your career channel since the last chapter date. Collect all messages posted by you (skip bot messages). These are raw career moments: shoutouts received, reflections logged, things worth remembering.
   b. **Merged PRs** — `gh pr list --author "@me" --state merged --search "merged:>=SINCE_DATE" --json number,title,url,mergedAt,body` — these are the technical evidence. Look for PRs that show ownership, complexity, cross-team impact, or growth — not just routine work.

3. Synthesize: look across both sources for themes, moments of growth, ownership, recognition, or technical depth. PRs that nobody posted about may still belong in the story if they represent a meaningful step.

4. Write the next chapter in the same voice and style as the existing ones:
   - Third person, outside looking in
   - Narrative prose — no bullet points, no headers within the chapter
   - Lead with the human story, use PRs as evidence not as a list
   - Chapter title format: `## Chapter N: [Theme] *(Month – Month Year)*`
   - Honest about gaps, uncertainty, and what you are still developing toward

5. Append the new chapter to `My Story.md`, before the `## Visualizing the Arc` section. Update the mermaid timeline with 2-3 key moments from the new chapter.

6. Update the `*Last updated*` line at the bottom.

7. Report what was added — chapter title, date range covered, and the 2-3 moments that anchored it.
