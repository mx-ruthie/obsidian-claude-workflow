#!/usr/bin/env bash
# Re-publish skills/ from local Cursor commands, sanitized to YOUR_* placeholders.
# Review git diff before committing. Bump VERSION date after sync.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCAL_DIR="${LOCAL_COMMANDS_DIR:-$HOME/.cursor/commands}"
CONFIG="${CONFIG_ENV:-$ROOT/config.env}"

SKILLS=(eod morning weekly-wins my-story log-shipped log-this weekly-skill-coach)

if [[ ! -d "$LOCAL_DIR" ]]; then
  echo "No local commands dir: $LOCAL_DIR"
  exit 1
fi

YOUR_VAULT_PATH=""
YOUR_LINEAR_EMAIL=""
YOUR_REMINDERS_CHANNEL=""
YOUR_SLACK_CHANNEL_ID=""
YOUR_SLACK_USER_ID=""
YOUR_CAREER_SLACK_CHANNEL=""
YOUR_CAREER_SLACK_CHANNEL_ID=""
YOUR_NAME=""
YOUR_ORG=""
YOUR_REPO=""
YOUR_TEAM_UPDATE_NAME=""
YOUR_TEAM_CHANNEL=""
YOUR_TEAM_UPDATE_DEST=""
if [[ -f "$CONFIG" ]]; then
  # shellcheck disable=SC1090
  source "$CONFIG"
fi

# Fail closed: never publish if we lack the values needed to strip personal data.
missing=()
for v in YOUR_VAULT_PATH YOUR_LINEAR_EMAIL YOUR_REMINDERS_CHANNEL YOUR_SLACK_CHANNEL_ID YOUR_SLACK_USER_ID YOUR_NAME; do
  [[ -z "${!v}" ]] && missing+=("$v")
done
if (( ${#missing[@]} )); then
  echo "Refusing to publish: config.env is missing ${missing[*]}." >&2
  echo "These personal values must be set so they can be stripped out of skills/." >&2
  echo "Copy config.example.env -> config.env and fill it in." >&2
  exit 1
fi

sanitize() {
  local src="$1" dest="$2"
  local content
  content="$(cat "$src")"
  # All personal values come from config.env (gitignored) — nothing hardcoded here.
  content="${content//$YOUR_VAULT_PATH/YOUR_VAULT_PATH}"
  content="${content//$YOUR_LINEAR_EMAIL/YOUR_LINEAR_EMAIL}"
  content="${content//$YOUR_SLACK_CHANNEL_ID/YOUR_SLACK_CHANNEL_ID}"
  content="${content//$YOUR_SLACK_USER_ID/YOUR_SLACK_USER_ID}"
  [[ -n "$YOUR_CAREER_SLACK_CHANNEL_ID" ]] && content="${content//$YOUR_CAREER_SLACK_CHANNEL_ID/YOUR_CAREER_SLACK_CHANNEL_ID}"
  # Channel names: strip both the #-prefixed and bare forms (the bare form appears in keyword lists).
  content="${content//$YOUR_REMINDERS_CHANNEL/YOUR_REMINDERS_CHANNEL}"
  content="${content//${YOUR_REMINDERS_CHANNEL#\#}/reminders-channel name}"
  if [[ -n "$YOUR_CAREER_SLACK_CHANNEL" ]]; then
    content="${content//$YOUR_CAREER_SLACK_CHANNEL/YOUR_CAREER_SLACK_CHANNEL}"
    content="${content//${YOUR_CAREER_SLACK_CHANNEL#\#}/career-channel}"
  fi
  # Employer / repo / team identifiers. These reach the skills through incidental
  # prose (a reading-list category, a named weekly ritual, the main repo) rather
  # than through config, so they need stripping too. Longest phrase first.
  [[ -n "$YOUR_TEAM_UPDATE_NAME" ]] && content="${content//$YOUR_TEAM_UPDATE_NAME/YOUR_TEAM_UPDATE_NAME}"
  [[ -n "$YOUR_TEAM_UPDATE_DEST" ]] && content="${content//$YOUR_TEAM_UPDATE_DEST/YOUR_TEAM_UPDATE_DEST}"
  [[ -n "$YOUR_TEAM_CHANNEL" ]]     && content="${content//$YOUR_TEAM_CHANNEL/YOUR_TEAM_CHANNEL}"
  [[ -n "$YOUR_ORG" ]]              && content="${content//$YOUR_ORG/YOUR_ORG}"
  [[ -n "$YOUR_REPO" ]]             && content="${content//$YOUR_REPO/YOUR_REPO}"
  # Author's first name -> generic voice. Whole-word match (possessive first),
  # substituted rather than deleted, so mid-sentence mentions don't break grammar.
  # Sentence-initial occurrences (start of string, or after . ! ? + optional closing
  # quote + whitespace) capitalize to "The user"; mid-sentence ones stay lowercase.
  # (macOS/BSD sed has no \b, and no lookbehind assertions; perl handles both.)
  content="$(YOUR_NAME_ENV="$YOUR_NAME" perl -0777 -pe '
    my $n = $ENV{"YOUR_NAME_ENV"};
    s/(^|[.!?][\x22\x27\x{2019}\x{201d}]?\s+)\Q$n\E\x27s\b/$1 . "The user\x27s"/gme;
    s/(^|[.!?][\x22\x27\x{2019}\x{201d}]?\s+)\Q$n\E\b/$1 . "The user"/gme;
    s/\Q$n\E\x27s\b/the user\x27s/g;
    s/\Q$n\E\b/the user/g;
  ' <<< "$content")"
  printf '%s\n' "$content" > "$dest"
}

echo "Syncing from $LOCAL_DIR → skills/"
for name in "${SKILLS[@]}"; do
  local_file="$LOCAL_DIR/${name}.md"
  if [[ ! -f "$local_file" ]]; then
    echo "skip (no local): $name.md"
    continue
  fi
  sanitize "$local_file" "$ROOT/skills/${name}.md"
  echo "  wrote skills/${name}.md"
done

today="$(date +%Y-%m-%d)"
{
  echo "$today"
  echo ""
  tail -n +3 "$ROOT/VERSION"
} > "$ROOT/VERSION.tmp" && mv "$ROOT/VERSION.tmp" "$ROOT/VERSION"

echo ""
echo "Bumped VERSION date to $today"
echo "Next: git diff skills/ VERSION && commit if it looks right"
echo "Reminder: growth lens and wording may need a quick human pass after sanitize."
