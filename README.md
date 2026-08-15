# I Don't Read Code

**Plain-English mode for Claude Code, Cursor, Codex and Windsurf.** For non-technical founders,
designers, operators and vibe coders who ship real software without reading it.

You install it once. It stays on. You never invoke it.

---

## The problem

You asked an AI to build something. It replied:

> I've implemented the low-stock alerting feature. Added a `threshold` column to `inventory_items`
> via a new Prisma migration, created `checkLowStock()` in `src/lib/inventory/alerts.ts`, and wired
> it to a Vercel Cron job. Also refactored `InventoryTable` and added an RLS policy scoping reads to
> `store_id`. Tests pass. You'll need to run the migration and set `CRON_SECRET`. Let me know if you
> want Resend or SendGrid.

Every word of that is true. And for you, none of it is usable.

You can't tell what changed. You can't tell whether it works. "Run the migration" isn't something
you know how to do. "Resend or SendGrid" isn't a question you can answer. So you say "great,
thanks," tell your team it's ready, and find out on Thursday that it wasn't.

## The same turn, with this installed

> **Done**
> - Every item on the count sheet now has a "minimum." When a store drops below it, the item turns
>   red. (I watched this work: set milk powder to 10 for Puebla, entered a count of 6, it turned red.)
> - Behind the scenes: a manager can now only see their own store's numbers, not the other 11. If
>   this ever breaks, one manager could screenshot another store's margins. (Machine-checked only —
>   I checked the rule directly. Nobody has logged in as a real manager yet.)
>
> **Your call**
> - Who gets the 8am message? **A: manager only** — quiet, but if a manager ignores it nobody at HQ
>   knows until something runs out mid-service. **B: manager and you** — roughly 5–15 lines a day
>   across 12 stores, in one message. I'd pick B for the first month so you can see whether the
>   minimums are sensible. If you say nothing I'll do B; switching later takes me two minutes.
>
> **Next**
> - You (about 3 minutes — I have no login to your database, only you do): go to supabase.com, open
>   the project named `mixue-inventory`, click **SQL Editor** in the left menu, paste this and press
>   **Run**. It adds one empty number to each item; it does not touch the counts your stores have
>   already entered.
> ```sql
> alter table inventory_items add column minimum_qty integer not null default 0;
> ```
> You'll see a green box saying `Success. No rows returned`. If it's red, copy the whole red text
> and paste it here.
> - Me (after that): set starting minimums for all 12 stores, and show you the list before anything
>   goes live.

Shorter than the first version. And every line is something you can act on or check.

---

## Install

Two lines, typed into Claude Code:

```
/plugin marketplace add WinterDDo/i-dont-read-code
/plugin install i-dont-read-code@i-dont-read-code
```

That's it — it turns itself on. Nothing to select, nothing to configure, no command to remember.

To check it worked, start a new chat and type `skill check`. Each piece reports in on its own line,
so you can see exactly what loaded:

```
i-dont-read-code v0.2.0 is on
Always-on rules: yes
Per-turn reminder: on
```

(A fourth line, `Deep examples: loaded`, shows up only once the deeper guidance is actually needed.
Not seeing it is normal.)

**What it costs.** The always-on part is free — it's built into how Claude reads your messages. The
per-turn reminder adds about 400 words of instructions to each message you send: cents a day at
normal use, but not nothing. Say `turn off the reminder` to drop it and everything else keeps
working. Nothing is sent anywhere; it all runs on your machine.

Using Cursor, Codex, or Windsurf instead? See [INSTALL.md](INSTALL.md) · [中文](INSTALL.zh-CN.md).

---

## What it actually does

**1. It tells you what changed, not what it did.** File names, function names and library names are
deleted from its messages — not summarized, deleted. What's left is what a person using your
software would notice was different.

**2. It stops claiming things work when nobody has checked.** This is the part that matters most,
and it's the part no other tool does. Every claim of "done" now ends with one of three tags:

| Tag | What it actually means |
|---|---|
| `(I watched this work: …)` | It did the thing and saw the result. It has to name what it did and what it saw. |
| `(Machine-checked only — …)` | The tests passed. **Nobody has used it.** These are not the same thing. |
| `(Not run — …)` | It wrote the code and hasn't run it. |

"The tests passed" is the middle tag, never the first one. That distinction is invisible in normal
AI output, and it's the one that decides whether you should tell your team something is ready.

**And the tag is checked, not just promised.** A note written by the same AI that did the work,
about its own work, is an honour system — which is the exact problem this whole project exists to
fix. So it keeps a running record of what actually ran, and can only claim "I watched this work"
when a matching action is in that record. Ask **"what have you actually checked?"** any time and it
will show you the list in plain language.

*What that means on disk:* a folder called `.i-dont-read-code` in your project holds a plain text
log of commands run and files changed, on your machine only. Nothing is sent anywhere. Delete the
folder any time; it rebuilds itself.

**3. It asks you questions you can answer.** Not "Postgres or SQLite?" — a question you can't
answer, so you say "you decide," and it stops asking anything at all. Instead: two options, each
priced in money, time, risk, or what your staff and customers will experience, plus its
recommendation and a reason.

**4. It gives you instructions that end.** When you have to do something it can't, it tells you
where to go, exactly what to paste, **what you'll see when it worked**, roughly how long it'll take,
and why it has to be you. If it can't tell you what success looks like, it isn't allowed to send the
instruction.

**5. It remembers, so you don't have to.** The longer a project runs, the more this matters. Two
plain-language files live in your project folder and you can open either one:

- **`STATUS.md`** — what's working and confirmed, what's **still unproven**, what's waiting on you,
  what changed since last time, and which decisions you already made so you're never asked twice.
  Something only leaves the unproven list when *you* say you saw it work — not when tests pass.
  And if it asked you to do something two weeks ago and you didn't, it says so once. Quietly
  forgotten homework is how "not checked yet" turns into "assumed fine."
- **`PROJECT-CARD.md`** — what your software is built with, where it's hosted, what you pay monthly
  and to whom, and what a new developer would need to take over. Say `make my project card`.

---

## What it does *not* do

**It doesn't dumb anything down.** Vagueness is treated as a worse failure than jargon. "I improved
the login experience" is exactly as broken as "I refactored AuthProvider to useReducer" — the first
one is just harder to catch. The rules push toward plain, *checkable* statements, not soft ones.

**It doesn't change your code.** It changes how the AI talks to you and nothing else. Your code,
comments, commit messages and pull requests stay completely normal — because someday another
developer will read them. If the right fix is complicated, it still does the complicated fix.

**It doesn't hide anything dangerous.** Anything that spends money, deletes data, exposes data
publicly, or contacts real customers is exempt from simplification. You get the worst realistic
outcome in plain language *before* it happens, as its own question, and it waits. Your silence is
never taken as a yes.

**It doesn't lock the details away.** Say **"details"** or **"show me the error"** and you get the
full technical version for that one reply — real file paths, the complete error text — then it goes
back to normal. You need that version to paste into a search box or forward to a developer.

**It doesn't make you dependent.** It maintains a plain-language card of what your software is built
with, where it lives, what you pay monthly, and what a new developer would need to take over. You
should always be able to describe, price, and hand off the thing you paid for.

---

## Works in your language

It replies in whatever language you write in. Jargon in Chinese is still jargon, so the rules apply
to the meaning, not the words — but anything you'll see on your own screen stays in the language
it's actually written in. A button labelled `SQL Editor` is still `SQL Editor`, even in a Chinese
reply, because that's what it says on your screen.

中文说明：[README.zh-CN.md](README.zh-CN.md)

---

## How it works

<details>
<summary>For the technically curious</summary>

Four layers, because no single mechanism in Claude Code is genuinely always-on.

| Layer | What | Why |
|---|---|---|
| Output style | `output-styles/plain-english.md`, with `force-for-plugin: true` | Modifies the system prompt and applies to every response. Auto-applies on install with no user action. Survives context compaction. `keep-coding-instructions: true` means engineering behaviour is untouched. |
| Skill | `skills/i-dont-read-code/` | The depth: worked examples, the recurring decision forks, handoff recipes, Chinese register. Loads when relevant. |
| Hook | `UserPromptSubmit` → `RULES.md` | Re-injects a ~400-token rule card each turn. This is what holds the line at turn 45 of a long session. |
| Portable copies | `portable/` | Cursor rules, `AGENTS.md`, `CLAUDE.md` — for other tools, and for web sessions where hooks don't run. |

A skill on its own can't do this. Skill bodies load on demand, and when the conversation is
compacted only the first 5,000 tokens of each skill are re-attached, sharing a 25,000-token budget
filled most-recent-first — so in exactly the long sessions where this matters most, a skill can be
dropped entirely. The output style lives in the system prompt and doesn't have that problem.

`RULES.md` is the single source of truth. The output style, the hook and the portable copies all
carry the same rules so they can't drift apart.

</details>

---

## Contributing

The most useful contributions are **real before/after pairs** — a reply you got that you couldn't
use, and what you wish it had said. Open an issue with both. That's the material the rules are built
from.

## License

MIT. See [LICENSE](LICENSE).
