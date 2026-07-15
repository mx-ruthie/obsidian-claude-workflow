#!/usr/bin/env bash
# Diff local Cursor (or Claude) command files against published skills/,
# after normalizing personal values → YOUR_* placeholders.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCAL_DIR="${LOCAL_COMMANDS_DIR:-$HOME/.cursor/commands}"
CONFIG="${CONFIG_ENV:-$ROOT/config.env}"

SKILLS=(eod morning weekly-wins my-story log-shipped log-this)

if [[ ! -d "$LOCAL_DIR" ]]; then
  echo "No local commands dir: $LOCAL_DIR"
  echo "Set LOCAL_COMMANDS_DIR (e.g. \$HOME/.claude/commands)"
  exit 1
fi

# Load personal values for reverse-substitution if config.env exists
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

normalize() {
  local src="$1" dest="$2"
  local content
  content="$(cat "$src")"
  if [[ -n "${YOUR_VAULT_PATH}" ]]; then
    content="${content//$YOUR_VAULT_PATH/YOUR_VAULT_PATH}"
  fi
  # Common Ruthie / author defaults if config missing
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
  # Soften first-person name in growth lens for comparison
  content="${content//Ruthie/the user}"
  content="${content//Help Ruthie/Help the user}"
  printf '%s' "$content" > "$dest"
}

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
drift=0

echo "Comparing $LOCAL_DIR → skills/ (normalized)"
echo "VERSION: $(head -1 "$ROOT/VERSION")"
echo ""

for name in "${SKILLS[@]}"; do
  local_file="$LOCAL_DIR/${name}.md"
  pub_file="$ROOT/skills/${name}.md"
  if [[ ! -f "$local_file" ]]; then
    echo "MISSING locally: $name.md"
    drift=1
    continue
  fi
  if [[ ! -f "$pub_file" ]]; then
    echo "MISSING in repo skills/: $name.md (local has it)"
    drift=1
    continue
  fi
  normalize "$local_file" "$TMP/local-$name.md"
  if ! diff -u "$pub_file" "$TMP/local-$name.md" > "$TMP/diff-$name.txt"; then
    echo "DRIFT: $name.md"
    drift=1
    # show short summary
    diffstat_lines=$(wc -l < "$TMP/diff-$name.txt" | tr -d ' ')
    echo "  ($diffstat_lines lines of diff — full: $TMP/diff-$name.txt)"
    head -40 "$TMP/diff-$name.txt"
    echo ""
  else
    echo "ok: $name.md"
  fi
done

echo ""
if [[ "$drift" -ne 0 ]]; then
  echo "Drift detected. Review diffs, then ./scripts/sync-from-local.sh (and bump VERSION)."
  exit 1
fi
echo "No drift."
