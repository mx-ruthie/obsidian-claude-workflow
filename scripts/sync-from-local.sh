#!/usr/bin/env bash
# Re-publish skills/ from local Claude Code commands, sanitized to YOUR_* placeholders.
# Review git diff before committing. Bump VERSION date after sync.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCAL_DIR="${LOCAL_COMMANDS_DIR:-$HOME/.claude/commands}"
CONFIG="${CONFIG_ENV:-$ROOT/config.env}"

# shellcheck source=lib-sanitize.sh
source "$ROOT/scripts/lib-sanitize.sh"

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
  apply_placeholders < "$1" > "$2"
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
