#!/usr/bin/env bash
# Give a new session the two standing documents, so "where are we" has an answer that does not
# depend on the user remembering to ask, or on scrollback they could not read the first time.
#
# SessionStart stdout IS added to the model's context (unlike PostToolUse), so plain text is
# enough here — no JSON, no interpreter, nothing to escape wrong.
#
# Also surfaces handoffs that have gone stale. An item the user was asked to do two weeks ago is
# the exact thing that dies quietly and takes the verification mechanism with it.

set -uo pipefail

STATUS="STATUS.md"
CARD="PROJECT-CARD.md"
STALE_DAYS=7

# Only speak up in a directory that looks like a project the user is building.
[ -d .git ] || [ -f package.json ] || [ -f "$STATUS" ] || exit 0

echo "[i-dont-read-code] Standing project documents:"

if [ -f "$STATUS" ]; then
  echo
  echo "--- $STATUS (current state; keep it updated at milestones and session end) ---"
  head -c 6000 "$STATUS"
  echo

  # Surface anything under "Waiting on you" older than STALE_DAYS.
  if command -v python3 >/dev/null 2>&1; then
    python3 - "$STATUS" "$STALE_DAYS" <<'PY' 2>/dev/null || true
import datetime, re, sys
path, stale_days = sys.argv[1], int(sys.argv[2])
text = open(path, encoding="utf-8", errors="replace").read()
m = re.search(r"^##+\s*Waiting on you\s*$(.*?)(?=^##\s|\Z)", text, re.S | re.M)
if m:
    today = datetime.date.today()
    stale = []
    for line in m.group(1).splitlines():
        d = re.search(r"(\d{4})-(\d{2})-(\d{2})", line)
        if not d or not line.strip().startswith("-"):
            continue
        try:
            asked = datetime.date(*map(int, d.groups()))
        except ValueError:
            continue
        age = (today - asked).days
        if age >= stale_days:
            stale.append((age, line.strip()))
    if stale:
        print()
        print("ATTENTION - these were handed to the user and have not come back:")
        for age, line in sorted(stale, reverse=True):
            print(f"  ({age} days ago) {line}")
        print("Mention the oldest one ONCE, plainly, without nagging. Anything depending on it is")
        print("still unproven, and must not be described as working.")
PY
  fi
else
  echo
  echo "No $STATUS yet. Once real work has been done, create it from the skill's template so the"
  echo "owner can see what is proven, what is not, and what is waiting on them. Do not create it"
  echo "for a session that has not built anything."
fi

if [ -f "$CARD" ]; then
  echo
  echo "--- $CARD (what the owner owns; keep costs and accounts current) ---"
  head -c 3000 "$CARD"
  echo
else
  echo
  echo "No $CARD yet. Offer to make one ONCE, early, in one sentence - it is what they would"
  echo "forward if they ever hired someone, and it is the thing that stops them being locked in."
  echo "If they decline, do not ask again this session."
fi
