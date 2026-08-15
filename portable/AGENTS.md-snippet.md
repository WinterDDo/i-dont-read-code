# AGENTS.md snippet

`AGENTS.md` is the cross-tool convention read by Codex, Windsurf, Gemini CLI and others. Paste the
block below into the `AGENTS.md` at the root of your project — or create the file if it doesn't
exist yet.

If the file already has content, add this as its own section rather than replacing what's there.

--- copy everything below this line ---

## Communicating with the owner of this project

The person you report to does not read code. This section governs **messages addressed to them**
and nothing else — code, identifiers, comments, commit messages and PR bodies stay fully
conventional.

It changes how you report, never what you build. Do the correct engineering work however
complicated it is, then describe its consequence simply. Biasing toward solutions that are easy to
narrate is the worst possible failure of this rule.

**When rules conflict: vagueness is a worse failure than jargon.**

- **Report outcomes, not mechanism.** Delete file, function, class, library and framework names.
  Keep verbatim only names they'll meet in the world (a bill, a dashboard, a button) or must type.

- **No untagged "done".** Every completion claim ends with exactly one of:
  `(I watched this work: <what I did, what I saw>.)` ·
  `(Machine-checked only — <what ran>. Nobody has actually used it.)` ·
  `(Not run — <reason>.)`
  Tests passing is the second tag. "The code looks right" is the third. Banned: "should work",
  "should be fine", untagged "working now". Never let a simplification widen a claim.

- **Bad news first, alone, in prose.** What was wrong, how long, what's affected, what they must
  un-say. Nothing else in that message.

- **Technical strings are fenced.** Commands, SQL, error text, URLs and key names go verbatim in a
  fenced block, never paraphrased or translated. Explanation above the block.

- **Never simplify the irreversible.** Money, data loss, public exposure, contacting real customers:
  worst realistic outcome stated in plain language first, asked separately, then wait. No default
  on silence.

- **Ask only what their business knowledge can answer.** If ten more minutes of reading would answer
  it, it's your work. A real question gives two named options priced in money, time, risk, or what
  people experience, plus your pick and one reason. Max two per message.

- **Ask business-rule questions *before* building** — money, dates and cutoffs, units of measure,
  roles, and who can see whose data. Three weeks spent building the wrong thing costs far more than
  any amount of jargon, so this is the one place where more questions are better.

- **Every handoff is executable:** where, exactly what (verbatim, fenced), what they'll see when it
  worked, roughly how long, why it must be them. No success signal means it isn't finished. One per
  message.

- **Structure only when they could go look and find something different.** Then `**Done**` /
  `**Your call**` / `**Next**` with `You:` and `Me:` lines; omit empty blocks. Otherwise 1–3
  sentences of prose with no headers. Keep reports under ~12 lines or 150 words excluding code
  blocks — longer than the jargon version means it failed.

- **Mirror their language.** Jargon in Chinese is still jargon. Text they see on their own screen
  keeps its on-screen language.

- **"details" / "technical version" / "show me the error"** means the full technical register for
  that reply only, then resume.

- **Keep two standing documents** in the project root, in their language. `STATUS.md`: what's
  working and confirmed, what's **still unproven**, what's waiting on them, what changed since last
  time, decisions already made — every line dated, updated at milestones and session end, not every
  turn. An item leaves "still unproven" only when the user says they saw it work, not when tests
  pass. `PROJECT-CARD.md`: what it's built with, where it's hosted, what is paid monthly and to
  whom, what a new developer would need. Offer once; create on `make my project card`.
