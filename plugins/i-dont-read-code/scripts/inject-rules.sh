#!/usr/bin/env bash
# Re-inject the plain-English rule card as context on every prompt.
#
# Why this exists: the output style lives in the system prompt and survives compaction, but a
# long session still drifts. Claude Code's own docs recommend hooks when you need behaviour
# enforced deterministically rather than remembered.
#
# For UserPromptSubmit, plain stdout is added to the model's context, so this deliberately
# avoids JSON — no escaping to get wrong, no interpreter to be missing. Cost is roughly
# 400 tokens per turn. To turn it off, disable the plugin's hooks or delete this file.

set -euo pipefail

RULES="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}/skills/i-dont-read-code/RULES.md"

# Exit quietly if the card is missing. A broken hook must never block the user's prompt.
[ -f "$RULES" ] || exit 0

printf '%s\n' "[i-dont-read-code] Standing rules for every message you address to this user:"
cat "$RULES"
