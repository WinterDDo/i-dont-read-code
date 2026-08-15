#!/usr/bin/env bash
# The README claims the layers "carry the same rules so they can't drift apart."
# That was an aspiration in v0.1 and it was already false. This makes it a test.
#
# Every rule below must be present in every layer that ships to a user. Keyed on content
# rather than numbering, so rewording and renumbering are fine but dropping a rule is not.
#
# Usage: scripts/check-drift.sh   (exit 0 = layers agree, 1 = a rule went missing)

set -uo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")/.."

SKILL_DIR="plugins/i-dont-read-code/skills/i-dont-read-code"

LAYERS=(
  "$SKILL_DIR/RULES.md"
  "$SKILL_DIR/SKILL.md"
  "plugins/i-dont-read-code/output-styles/plain-english.md"
  "portable/CLAUDE.md-snippet.md"
  "portable/cursor-user-rules.txt"
  "portable/AGENTS.md-snippet.md"
  "portable/.cursor/rules/i-dont-read-code.mdc"
)

# name<TAB>extended-regex that must match somewhere in each layer.
# Matching runs against a whitespace-normalised copy of each file, so a rule that wraps
# across a line break still counts — the layers word things differently on purpose.
RULES=$(cat <<'EOF'
outcomes-not-mechanism	report (the )?outcomes?|delete the mechanism|outcomes, not mechanism
trust-tag-observed	I watched this work
trust-tag-machine-checked	Machine-checked only
trust-tag-not-run	Not run
banned-should-work	should work
bad-news-first	bad news (goes )?first
verbatim-in-fences	verbatim
never-simplify-irreversible	irreversible|spends money
answerable-questions-only	(business|own) knowledge can answer|only what their (own )?knowledge
ask-before-building	before.{0,4}(you )?build
handoff-success-signal	success signal|what success looks like
structure-threshold	go look
length-cap	12 lines
mirror-language	jargon in Chinese|mirror (the |their |my )?language
escape-hatch	technical (version|register)
reporting-not-building	never (changes )?what you build|report, never what
standing-documents	STATUS\.md
unproven-needs-user-confirmation	(still )?unproven.{0,80}only when|only when (the user|I) say
EOF
)

fail=0
missing_report=""

for layer in "${LAYERS[@]}"; do
  if [ ! -f "$layer" ]; then
    echo "MISSING LAYER: $layer"
    fail=1
    continue
  fi
  # Collapse all whitespace to single spaces so wrapped rules still match.
  flat=$(tr '\n' ' ' < "$layer" | tr -s ' ')
  while IFS=$'\t' read -r name pattern; do
    [ -z "${name:-}" ] && continue
    if ! printf '%s' "$flat" | grep -qiE "$pattern"; then
      missing_report+="  $layer"$'\n    missing rule: '"$name"$'\n'
      fail=1
    fi
  done <<< "$RULES"
done

rule_count=$(printf '%s\n' "$RULES" | grep -c .)

if [ "$fail" -eq 0 ]; then
  echo "check-drift: OK — all $rule_count rules present in all ${#LAYERS[@]} layers"
else
  echo "check-drift: FAILED — layers have drifted apart"
  echo
  printf '%s' "$missing_report"
  echo
  echo "Every rule must appear in every layer. Add the missing rule, or if it was"
  echo "deliberately removed, delete it from the RULES table in this script too."
fi

exit "$fail"
