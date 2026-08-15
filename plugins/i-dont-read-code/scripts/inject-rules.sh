#!/usr/bin/env bash
# Re-inject the plain-English rule card, plus the recent record of what actually ran.
#
# Why the rules: the output style lives in the system prompt and survives compaction, but a long
# session still drifts. Claude Code's own docs recommend hooks when behaviour needs enforcing
# deterministically rather than remembering.
#
# Why the record: PostToolUse stdout goes to the debug log, not to the model. UserPromptSubmit
# stdout IS added to context, so this is where the ledger written by record-action.sh comes back
# into view — turning "(I watched this work: ...)" from a promise into a citation.
#
# Deliberately no JSON: plain stdout is added as context for this event, so there is no escaping
# to get wrong and no interpreter to be missing. Roughly 500 tokens per turn, plus the tail.
# To turn it off, disable the plugin's hooks or delete this file.

set -euo pipefail

PLUGIN_ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"
RULES="$PLUGIN_ROOT/skills/i-dont-read-code/RULES.md"
LEDGER=".i-dont-read-code/ledger.log"
TAIL_LINES=15

# A broken hook must never block the user's prompt.
[ -f "$RULES" ] || exit 0

printf '%s\n' "[i-dont-read-code] Standing rules for every message you address to this user:"
cat "$RULES"

if [ -s "$LEDGER" ]; then
  echo
  echo "What actually ran recently (newest last). This is the record, not your memory —"
  echo "write \"(I watched this work: ...)\" only when a matching action appears here."
  echo "\"ok\" means the tool succeeded; it does NOT mean a human has used the result."
  echo "On \"what have you actually checked?\", show these lines in plain language."
  echo "--- begin record ---"
  tail -n "$TAIL_LINES" "$LEDGER"
  echo "--- end record ---"
fi
