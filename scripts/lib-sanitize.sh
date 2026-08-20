#!/usr/bin/env bash
# Shared placeholder substitution for the maintainer publish/compare pair.
#
# sync-from-local.sh (publish) and check-drift.sh (compare) MUST produce byte-identical
# output for an unchanged file. When they don't, check-drift reports drift on skills
# nobody touched, the tool stops being trusted, and the local copies quietly diverge —
# which is exactly how they diverged before.
#
# Two separate implementations drifted twice: a trailing newline (check-drift wrote
# '%s', sync wrote '%s\n'), and sentence-initial capitalization of the author's name
# (sync produced "The user", check-drift produced "the user"). Both showed up as
# permanent phantom drift. One implementation, sourced by both, is the fix.
#
# Every value is optional here. sync-from-local.sh separately fails closed on the ones
# that must be present before anything is published; check-drift only reads, so it
# tolerates a missing config.env with a warning.

# Reads content on stdin, writes substituted content on stdout (with trailing newline).
apply_placeholders() {
  local content
  content="$(cat)"

  # Explicit config values, longest/most-specific first.
  [[ -n "${YOUR_VAULT_PATH:-}" ]]              && content="${content//$YOUR_VAULT_PATH/YOUR_VAULT_PATH}"
  [[ -n "${YOUR_LINEAR_EMAIL:-}" ]]            && content="${content//$YOUR_LINEAR_EMAIL/YOUR_LINEAR_EMAIL}"
  [[ -n "${YOUR_SLACK_CHANNEL_ID:-}" ]]        && content="${content//$YOUR_SLACK_CHANNEL_ID/YOUR_SLACK_CHANNEL_ID}"
  [[ -n "${YOUR_SLACK_USER_ID:-}" ]]           && content="${content//$YOUR_SLACK_USER_ID/YOUR_SLACK_USER_ID}"
  [[ -n "${YOUR_CAREER_SLACK_CHANNEL_ID:-}" ]] && content="${content//$YOUR_CAREER_SLACK_CHANNEL_ID/YOUR_CAREER_SLACK_CHANNEL_ID}"

  # Channel names: strip both the #-prefixed and the bare form (the bare form appears
  # inside keyword lists, where a leading # would not be written).
  if [[ -n "${YOUR_REMINDERS_CHANNEL:-}" ]]; then
    content="${content//$YOUR_REMINDERS_CHANNEL/YOUR_REMINDERS_CHANNEL}"
    content="${content//${YOUR_REMINDERS_CHANNEL#\#}/reminders-channel name}"
  fi
  if [[ -n "${YOUR_CAREER_SLACK_CHANNEL:-}" ]]; then
    content="${content//$YOUR_CAREER_SLACK_CHANNEL/YOUR_CAREER_SLACK_CHANNEL}"
    content="${content//${YOUR_CAREER_SLACK_CHANNEL#\#}/career-channel}"
  fi

  # Employer / repo / team identifiers. These reach the skills through incidental prose
  # (a reading-list category, a named weekly ritual, the main repo) rather than through
  # config, so they need stripping too. Longest phrase first.
  [[ -n "${YOUR_TEAM_UPDATE_NAME:-}" ]] && content="${content//$YOUR_TEAM_UPDATE_NAME/YOUR_TEAM_UPDATE_NAME}"
  [[ -n "${YOUR_TEAM_UPDATE_DEST:-}" ]] && content="${content//$YOUR_TEAM_UPDATE_DEST/YOUR_TEAM_UPDATE_DEST}"
  [[ -n "${YOUR_TEAM_CHANNEL:-}" ]]     && content="${content//$YOUR_TEAM_CHANNEL/YOUR_TEAM_CHANNEL}"
  [[ -n "${YOUR_ORG:-}" ]]              && content="${content//$YOUR_ORG/YOUR_ORG}"
  [[ -n "${YOUR_REPO:-}" ]]             && content="${content//$YOUR_REPO/YOUR_REPO}"

  # Author's first name -> generic voice. Whole-word match (possessive first),
  # substituted rather than deleted, so mid-sentence mentions don't break grammar.
  # Sentence-initial occurrences (start of string, or after . ! ? + optional closing
  # quote + whitespace) capitalize to "The user"; mid-sentence ones stay lowercase.
  # (macOS/BSD sed has no \b and no lookbehind; perl handles both.)
  if [[ -n "${YOUR_NAME:-}" ]]; then
    content="$(YOUR_NAME_ENV="$YOUR_NAME" perl -0777 -pe '
      my $n = $ENV{"YOUR_NAME_ENV"};
      s/(^|[.!?][\x22\x27\x{2019}\x{201d}]?\s+)\Q$n\E\x27s\b/$1 . "The user\x27s"/gme;
      s/(^|[.!?][\x22\x27\x{2019}\x{201d}]?\s+)\Q$n\E\b/$1 . "The user"/gme;
      s/\Q$n\E\x27s\b/the user\x27s/g;
      s/\Q$n\E\b/the user/g;
    ' <<< "$content")"
  fi

  printf '%s\n' "$content"
}
