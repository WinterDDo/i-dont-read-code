# Install

Pick the tool you use. You don't need to understand any of this to do it.

中文版：[INSTALL.zh-CN.md](INSTALL.zh-CN.md)

---

## Claude Code — the recommended way

Type these two lines into Claude Code, one after the other:

```
/plugin marketplace add WinterDDo/i-dont-read-code
/plugin install i-dont-read-code@i-dont-read-code
```

(The name looks doubled because it's `plugin-name@where-it-came-from`. It isn't a typo.)

The second line opens a small menu asking where to install it. **User** — the default — is right if
you want it in all your projects.

When it finishes it prints a short summary. If that summary contains the words
`Run /reload-plugins to activate.`, type `/reload-plugins` too. If it doesn't say that, skip it.

**Now check it worked.** Start a new chat and type exactly:

```
skill check
```

You should get back something like this:

```
i-dont-read-code v0.2.0 is on
Always-on rules: yes
Per-turn reminder: on
```
```
No "what you own" card yet — say "make my project card" when you want one.
```

Each line is a different piece reporting in. The first two are the ones that matter — that's the
part that's always on.

You may also see a line saying `Deep examples: loaded`. Don't worry if you don't: the deeper
guidance only loads when it's actually needed, so most of the time it correctly stays quiet.

**Getting fewer lines is useful information, not failure.** Getting nothing like this at all means
it isn't installed; see below.

That's everything. It's on for every project and every new chat.

---

## Claude Code on the web

Plugins install the same way, but one piece — the per-turn reminder — doesn't run in web sessions.
The rest works.

To cover the gap, just ask Claude:

```
set up my rules file
```

It will create the file, put the rules in it, and tell you where it went. You don't need to know
what the file is or where it lives.

---

## Cursor

**For every project (do this once):**

1. Open Cursor → **Settings** → **Rules**
2. Find the box called **User Rules**
3. Open [`portable/cursor-user-rules.txt`](portable/cursor-user-rules.txt), copy everything below
   the "copy everything below this line" marker, and paste it into that box

You'll see the text sitting in the box. That's it — it applies to every project from now on.

**For one project only:** ask Cursor's AI `set up my rules file` and it will create the right file
in the right place. (If you'd rather do it yourself, the file to copy is
[`portable/.cursor/rules/i-dont-read-code.mdc`](portable/.cursor/rules/i-dont-read-code.mdc).)

---

## Codex, Windsurf, Gemini CLI, and others

Ask the assistant:

```
set up my rules file
```

It reads [`portable/AGENTS.md-snippet.md`](portable/AGENTS.md-snippet.md) if you point it at this
repo, or you can paste that file's contents in yourself. Either way it ends up in a file called
`AGENTS.md`, which is the shared convention these tools read.

---

## No plugin, just a file

If you'd rather not install anything, ask Claude `set up my rules file` and say you want it for
every project. It writes the rules to your personal settings file.

This works, but it's the weakest option: rules in a file fade in very long conversations, where the
plugin wouldn't.

---

## What this costs

The always-on part is free — it's built into how Claude reads your messages.

The per-turn reminder adds about 400 words of instructions to each message you send. At normal use
that's cents a day, but it isn't nothing. Say **`turn off the reminder`** to drop it; everything
else keeps working.

Nothing is sent anywhere. Everything runs on your own machine.

---

## Turning it off

**For one reply:** say **"details"** or **"technical version"**. You get the full technical answer
for that reply only, then it goes back to normal. You never need to uninstall it to see the
underlying detail — that's the point.

**For good:** `/plugin uninstall i-dont-read-code@i-dont-read-code`, or delete whichever file you
pasted.

---

## If something isn't working

**The first line gave an error.** Either the repository name has changed, or you have an older
Claude Code that doesn't have `/plugin`. Type `/help` — if you don't see `plugin` listed, update
Claude Code first. If you do see it, please open an issue with the exact error text; that means the
name in these instructions is wrong and it's our bug, not yours.

**The second line gave an error.** The first line probably didn't finish. Run
`/plugin marketplace list` — you should see `i-dont-read-code` in it. If you don't, run the first
line again.

**`skill check` gives nothing like the block above.** The plugin didn't load. Try
`/plugin marketplace update i-dont-read-code`, then `/reload-plugins`. Then start a **new** chat —
the rules are read when a chat begins, so an existing chat won't pick them up.

**`skill check` gives some lines but not all of them.** Partly working. The missing line tells you
which piece — paste what you got into an issue. Meanwhile it's still doing most of its job.

**It's on, but replies still look technical.** If you've been in the same chat a very long time,
start a new one. If you're on Claude Code on the web, ask it to `set up my rules file` as described
above.

**It's being *too* brief and you want more.** Say "details" for the technical version of any reply,
or just tell it what you want more of. It's meant to bend to you, not the other way round.
