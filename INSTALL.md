# Install

Pick the tool you use. You don't need to understand any of this to do it.

---

## Claude Code — the recommended way

Type these two lines into Claude Code, one after the other:

```
/plugin marketplace add WinterDDo/i-dont-read-code
/plugin install i-dont-read-code@i-dont-read-code
```

The second one opens a small menu asking where to install it. **User** (the default) is the right
answer if you want it in all your projects.

If the summary at the end says `Run /reload-plugins to activate.`, type that too.

**Check it worked:** start a new chat and type exactly:

```
skill check
```

It should reply `i-dont-read-code is on` and nothing else. If it says anything else, it isn't
installed — the plugin didn't load, and everything else you see will just be normal Claude.

Nothing else to do. It's on for every project and every new chat.

---

## Claude Code on the web

Plugins install the same way, but the hook layer doesn't run in web sessions. The other layers still
work.

To cover the gap, also copy the block from
[`portable/CLAUDE.md-snippet.md`](portable/CLAUDE.md-snippet.md) into a file called `CLAUDE.md` in
your project, and commit it. Web sessions read that file from your repository.

---

## Cursor

**For every project (do this once):**

1. Open Cursor → **Settings** → **Rules**
2. Find the box called **User Rules**
3. Open [`portable/cursor-user-rules.txt`](portable/cursor-user-rules.txt), copy everything below
   the "copy everything below this line" marker, and paste it into that box

**For one project only:** copy
[`portable/.cursor/rules/i-dont-read-code.mdc`](portable/.cursor/rules/i-dont-read-code.mdc) into a
`.cursor/rules/` folder in that project. It's set to apply automatically, and it travels with the
project if you use git.

---

## Codex, Windsurf, Gemini CLI, and others

These read a file called `AGENTS.md` in your project folder.

Open [`portable/AGENTS.md-snippet.md`](portable/AGENTS.md-snippet.md), copy everything below the
marker, and paste it into `AGENTS.md` at the top level of your project. If you don't have that file
yet, create it. If you do, add this as a new section rather than replacing what's there.

---

## No plugin, just a file

If you'd rather not install anything, copy the block from
[`portable/CLAUDE.md-snippet.md`](portable/CLAUDE.md-snippet.md) into either:

- `CLAUDE.md` in your project — applies to that project
- `~/.claude/CLAUDE.md` — applies to all of them

This works, but it's the weakest option: `CLAUDE.md` is added as a message rather than built into
the system prompt, so it fades in very long conversations where the plugin wouldn't.

---

## Turning it off

**For one reply:** say **"details"** or **"technical version"**. You get the full technical answer
for that reply only, then it goes back to normal. You don't need to turn anything off to see the
underlying detail — that's the point.

**For good:** `/plugin uninstall i-dont-read-code@i-dont-read-code`, or delete whichever file you
pasted.

---

## If something isn't working

**`skill check` doesn't reply `i-dont-read-code is on`.** The plugin didn't load. Try
`/plugin marketplace update i-dont-read-code`, then `/reload-plugins`. Then start a **new** chat —
the style is read when a session starts, so an existing chat won't pick it up.

**It's on, but replies still look technical.** Two likely causes. If you've been in the same chat
for a very long time, start a new one. If you're on Claude Code on the web, add the `CLAUDE.md`
snippet as described above — the hook that reinforces the rules doesn't run there.

**It's being *too* brief and you want more.** Say "details" for the technical version of any reply,
or just tell it what you want more of. It's meant to bend to you, not the other way round.
