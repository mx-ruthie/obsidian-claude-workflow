#!/usr/bin/env bash
# Diff local Claude Code (or Cursor) command files against published skills/,
# after normalizing personal values → YOUR_* placeholders.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOCAL_DIR="${LOCAL_COMMANDS_DIR:-$HOME/.claude/commands}"
CONFIG="${CONFIG_ENV:-$ROOT/config.env}"

# shellcheck source=lib-sanitize.sh
source "$ROOT/scripts/lib-sanitize.sh"

SKILLS=(eod morning weekly-wins my-story log-shipped log-this weekly-skill-coach)

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

if [[ -z "$YOUR_VAULT_PATH$YOUR_LINEAR_EMAIL$YOUR_SLACK_USER_ID" ]]; then
  echo "Note: config.env not found or empty — personal values won't be normalized, so the diff will be noisy (not a leak; this script only reads)." >&2
fi

normalize() {
  apply_placeholders < "$1" > "$2"
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
