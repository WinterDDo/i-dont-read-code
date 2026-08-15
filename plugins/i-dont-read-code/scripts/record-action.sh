#!/usr/bin/env bash
# Keep a factual record of what actually ran, so "(I watched this work: ...)" can be checked.
#
# The problem this solves: the skill correctly says plain language is "a lossy compression,
# written by the same system that did the work, handed to someone with no way to check it" —
# and then fixed that with a tag written by the same system, with nothing cross-checking it.
# An honour system with good formatting. This is the cross-check.
#
# Fires on PostToolUse (the tool succeeded) and PostToolUseFailure (it didn't). Which event
# fired IS the outcome, so nothing here depends on the undocumented shape of tool_response.
#
# PostToolUse stdout is NOT shown to the model — it goes to the debug log — so this writes a
# file. inject-rules.sh feeds the recent tail back through UserPromptSubmit, whose stdout IS
# visible. A broken recorder must never block a tool, so every path exits 0.

set -uo pipefail

LEDGER_DIR=".i-dont-read-code"
LEDGER="$LEDGER_DIR/ledger.log"
MAX_LINES=400

command -v python3 >/dev/null 2>&1 || exit 0
mkdir -p "$LEDGER_DIR" 2>/dev/null || exit 0

# The hook payload arrives on stdin, but the heredoc below also needs stdin to supply the
# Python source — so park the payload in a temp file and pass its path. Reading both from
# stdin makes json.load() parse this script instead of the payload, silently recording
# nothing, which is exactly the kind of quiet no-op this whole feature exists to prevent.
PAYLOAD=$(mktemp 2>/dev/null) || exit 0
trap 'rm -f "$PAYLOAD"' EXIT
cat > "$PAYLOAD"

python3 - "$LEDGER" "$MAX_LINES" "$PAYLOAD" <<'PY' 2>/dev/null || true
import datetime, json, os, sys

ledger, max_lines, payload_path = sys.argv[1], int(sys.argv[2]), sys.argv[3]

try:
    with open(payload_path, encoding="utf-8", errors="replace") as fh:
        data = json.load(fh)
except Exception:
    sys.exit(0)
if not isinstance(data, dict):
    sys.exit(0)

event = data.get("hook_event_name", "")
tool = data.get("tool_name", "?")
ti = data.get("tool_input") or {}

# PostToolUse only fires after a tool succeeds; failures arrive as PostToolUseFailure.
outcome = "FAIL" if "Failure" in event else "ok"

def summarise(tool, ti):
    if not isinstance(ti, dict):
        return ""
    for key in ("command", "file_path", "path", "pattern", "url", "notebook_path"):
        v = ti.get(key)
        if isinstance(v, str) and v.strip():
            return " ".join(v.split())
    for v in ti.values():
        if isinstance(v, str) and v.strip():
            return " ".join(v.split())
    return ""

detail = summarise(tool, ti)
if len(detail) > 160:
    detail = detail[:157] + "..."

stamp = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
line = f"{stamp}  {outcome:<4}  {tool:<10}  {detail}"

try:
    with open(ledger, "a", encoding="utf-8") as f:
        f.write(line + "\n")
except Exception:
    sys.exit(0)

# Keep the file bounded; it is a recent record, not an audit log.
try:
    with open(ledger, encoding="utf-8", errors="replace") as f:
        lines = f.readlines()
    if len(lines) > max_lines * 2:
        with open(ledger, "w", encoding="utf-8") as f:
            f.writelines(lines[-max_lines:])
except Exception:
    pass
PY

exit 0
