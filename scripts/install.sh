#!/usr/bin/env bash
# Install sanitized skills into Claude Code and/or Cursor, with your placeholders filled in.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG="${1:-$ROOT/config.env}"

if [[ ! -f "$CONFIG" ]]; then
  echo "Missing $CONFIG"
  echo "Copy config.example.env → config.env, fill it in, then re-run:"
  echo "  cp config.example.env config.env && \$EDITOR config.env && ./scripts/install.sh"
  exit 1
fi

# shellcheck disable=SC1090
source "$CONFIG"

: "${YOUR_VAULT_PATH:?Set YOUR_VAULT_PATH in config.env}"
: "${YOUR_LINEAR_EMAIL:?Set YOUR_LINEAR_EMAIL in config.env}"
: "${YOUR_REMINDERS_CHANNEL:?Set YOUR_REMINDERS_CHANNEL in config.env}"
: "${YOUR_SLACK_CHANNEL_ID:?Set YOUR_SLACK_CHANNEL_ID in config.env}"
: "${YOUR_SLACK_USER_ID:?Set YOUR_SLACK_USER_ID in config.env}"
INSTALL_TARGET="${INSTALL_TARGET:-both}"
YOUR_CAREER_SLACK_CHANNEL="${YOUR_CAREER_SLACK_CHANNEL:-}"
YOUR_CAREER_SLACK_CHANNEL_ID="${YOUR_CAREER_SLACK_CHANNEL_ID:-}"

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

substitute() {
  local src="$1" dest="$2"
  sed \
    -e "s|YOUR_VAULT_PATH|${YOUR_VAULT_PATH}|g" \
    -e "s|YOUR_LINEAR_EMAIL|${YOUR_LINEAR_EMAIL}|g" \
    -e "s|YOUR_REMINDERS_CHANNEL|${YOUR_REMINDERS_CHANNEL}|g" \
    -e "s|YOUR_SLACK_CHANNEL_ID|${YOUR_SLACK_CHANNEL_ID}|g" \
    -e "s|YOUR_SLACK_USER_ID|${YOUR_SLACK_USER_ID}|g" \
    -e "s|YOUR_CAREER_SLACK_CHANNEL_ID|${YOUR_CAREER_SLACK_CHANNEL_ID}|g" \
    -e "s|YOUR_CAREER_SLACK_CHANNEL|${YOUR_CAREER_SLACK_CHANNEL}|g" \
    "$src" > "$dest"
}

SKILLS=(eod morning weekly-wins my-story log-shipped log-this)

for name in "${SKILLS[@]}"; do
  substitute "$ROOT/skills/${name}.md" "$TMP/${name}.md"
done

install_dir() {
  local dir="$1"
  mkdir -p "$dir"
  for name in "${SKILLS[@]}"; do
    cp "$TMP/${name}.md" "$dir/${name}.md"
    echo "  → $dir/${name}.md"
  done
}

echo "Installing skills (target: $INSTALL_TARGET)…"
case "$INSTALL_TARGET" in
  claude)
    install_dir "$HOME/.claude/commands"
    ;;
  cursor)
    install_dir "$HOME/.cursor/commands"
    ;;
  both)
    install_dir "$HOME/.claude/commands"
    install_dir "$HOME/.cursor/commands"
    ;;
  *)
    echo "INSTALL_TARGET must be claude, cursor, or both (got: $INSTALL_TARGET)"
    exit 1
    ;;
esac

echo ""
echo "Seeding Obsidian vault files (won't overwrite existing Career/*.md)…"
mkdir -p "$YOUR_VAULT_PATH/Daily notes" "$YOUR_VAULT_PATH/Career" "$YOUR_VAULT_PATH/Templates"

copy_if_missing() {
  local src="$1" dest="$2"
  if [[ -e "$dest" ]]; then
    echo "  skip (exists): $dest"
  else
    cp "$src" "$dest"
    echo "  created: $dest"
  fi
}

if [[ -e "$YOUR_VAULT_PATH/Daily Workflow.md" ]]; then
  echo "  skip (exists): $YOUR_VAULT_PATH/Daily Workflow.md — compare with repo/obsidian/Daily\\ Workflow.md if you want updates"
else
  cp "$ROOT/obsidian/Daily Workflow.md" "$YOUR_VAULT_PATH/Daily Workflow.md"
  echo "  created: $YOUR_VAULT_PATH/Daily Workflow.md"
fi

copy_if_missing "$ROOT/obsidian/Today.md" "$YOUR_VAULT_PATH/Today.md"
copy_if_missing "$ROOT/templates/Daily Note.md" "$YOUR_VAULT_PATH/Templates/Daily Note.md"
copy_if_missing "$ROOT/templates/Shipped.md" "$YOUR_VAULT_PATH/Career/Shipped.md"
copy_if_missing "$ROOT/templates/Weekly Wins.md" "$YOUR_VAULT_PATH/Career/Weekly Wins.md"
copy_if_missing "$ROOT/templates/My Story.md" "$YOUR_VAULT_PATH/Career/My Story.md"

echo ""
echo "Done. Next:"
echo "  1. Confirm MCP servers: Linear, Slack, (optional) Granola / Notion"
echo "  2. Create private Slack channel $YOUR_REMINDERS_CHANNEL if needed"
echo "  3. Set one weekday nudge at ~5pm: Run /eod"
echo "  4. Tonight: open Claude Code or Cursor and run /eod"
echo ""
echo "Read docs/ADOPT.md for a minimal week-1 path and fork tips."
