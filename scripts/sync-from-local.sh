#!/usr/bin/env bash
# Re-publish skills/ from local Cursor commands, sanitized to YOUR_* placeholders.
# Review git diff before committing. Bump VERSION date after sync.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCAL_DIR="${LOCAL_COMMANDS_DIR:-$HOME/.cursor/commands}"
CONFIG="${CONFIG_ENV:-$ROOT/config.env}"

SKILLS=(eod morning weekly-wins my-story log-shipped log-this)

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
if [[ -f "$CONFIG" ]]; then
  # shellcheck disable=SC1090
  source "$CONFIG"
fi

sanitize() {
  local src="$1" dest="$2"
  local content
  content="$(cat "$src")"
  if [[ -n "${YOUR_VAULT_PATH}" ]]; then
    content="${content//$YOUR_VAULT_PATH/YOUR_VAULT_PATH}"
  fi
  content="${content//\/Users\/ruthieirvin\/code\/Ruthie Notes/YOUR_VAULT_PATH}"
  content="${content//ruthieirvin@honeycomb.io/YOUR_LINEAR_EMAIL}"
  content="${content//#ruthie-reminders/YOUR_REMINDERS_CHANNEL}"
  content="${content//C0BAC96P6G1/YOUR_SLACK_CHANNEL_ID}"
  content="${content//U05G4HS8LRK/YOUR_SLACK_USER_ID}"
  content="${content//#career-ruthie/YOUR_CAREER_SLACK_CHANNEL}"
  if [[ -n "${YOUR_LINEAR_EMAIL}" ]]; then
    content="${content//$YOUR_LINEAR_EMAIL/YOUR_LINEAR_EMAIL}"
  fi
  if [[ -n "${YOUR_REMINDERS_CHANNEL}" ]]; then
    content="${content//$YOUR_REMINDERS_CHANNEL/YOUR_REMINDERS_CHANNEL}"
  fi
  if [[ -n "${YOUR_SLACK_CHANNEL_ID}" ]]; then
    content="${content//$YOUR_SLACK_CHANNEL_ID/YOUR_SLACK_CHANNEL_ID}"
  fi
  if [[ -n "${YOUR_SLACK_USER_ID}" ]]; then
    content="${content//$YOUR_SLACK_USER_ID/YOUR_SLACK_USER_ID}"
  fi
  if [[ -n "${YOUR_CAREER_SLACK_CHANNEL}" ]]; then
    content="${content//$YOUR_CAREER_SLACK_CHANNEL/YOUR_CAREER_SLACK_CHANNEL}"
  fi
  if [[ -n "${YOUR_CAREER_SLACK_CHANNEL_ID}" ]]; then
    content="${content//$YOUR_CAREER_SLACK_CHANNEL_ID/YOUR_CAREER_SLACK_CHANNEL_ID}"
  fi
  content="${content//Help Ruthie notice/Help the user notice}"
  content="${content//unless Ruthie says yes/unless the user says yes}"
  content="${content//if Ruthie asked/if the user asked}"
  content="${content//so Ruthie can/so the user can}"
  content="${content//what Ruthie is/what the person is}"
  content="${content//posted by Ruthie/posted by the user}"
  content="${content//Ruthie //}"
  content="${content// Ruthie/ the user}"
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
