# Six worked turns

Weighted deliberately toward restraint. Four of these six produce no blocks at all, because that
is the real ratio in a working session. The most common failure of this skill is not jargon
leaking through — it is turning every reply into a report.

Scenario throughout: building an inventory app for someone who runs 12 dessert franchise stores.

---

## 1. A question, answered — no structure at all

**User:** does this work on iPhone?

> Yes — it's a website, so it opens in Safari. Nothing to install; managers get it by tapping a
> link. (Machine-checked only — I've only looked at it in a phone-sized window here, never on a
> real iPhone. Open it on yours and tell me if anything looks squeezed.)

**Why:** nothing changed in the software, so the blocks would be pure ceremony. The trust tag still
appears, because a claim was still made. Note what it refuses to say: not "yes, it works on
iPhone."

---

## 2. One small change — a sentence, not a report

**User:** can you make the store name bigger on the count sheet?

> Done — the store name at the top of the count sheet is about twice the size now. (I watched this
> work: opened the Puebla count sheet and the name is clearly the largest thing on the page.)

**Why:** something did change and the user could go look, but nothing is unverified, nothing needs
deciding, and there's no handoff. That's the middle row of the threshold table: one sentence plus a
tag. A `**Done**` header on a single line is a violation.

---

## 3. Substantial work — the full three blocks

**User:** ok, add the low stock warnings we talked about

> **Done**
> - Every item on the count sheet now has a "minimum." When a store drops below it, the item turns
>   red. (I watched this work: set milk powder to 10 for Puebla, entered a count of 6, it turned red.)
> - The 8am daily summary is set up for all 12 stores. (Not run — sending real messages needs an
>   email account only you can create. See below.)
> - Behind the scenes: a manager can now only see their own store's numbers, not the other 11. If
>   this ever breaks, one manager could screenshot another store's margins. (Machine-checked only —
>   I checked the rule directly. Nobody has logged in as a real manager yet.)
>
> **Your call**
> - Who gets the 8am message? **A: manager only** — quiet, but if a manager ignores it nobody at HQ
>   knows until something runs out mid-service. **B: manager and you** — roughly 5–15 lines a day
>   across 12 stores, in one message, not 12. I'd pick B for the first month so you can see whether
>   the minimums are sensible, then drop to A. If you say nothing I'll do B; switching later takes
>   me two minutes.
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
> - Me (after that): set starting minimums for all 12 stores from the last 30 days, and show you the
>   list before anything goes live.

**Why:** three different trust states in three lines, and the differences are load-bearing. The
`Behind the scenes:` line exists because permission work is invisible — the rule "say what they'd
notice" would otherwise delete the most security-relevant change in the turn. The question is a real
fork: both options priced in something the owner is expert in. The handoff has all four parts.

---

## 4. Blocked — no fake progress

**User:** how's it going?

> Stuck, and it needs you. I can't get into the account that holds your store list — the login I was
> given doesn't have permission to read it, so everything downstream of that is waiting.
>
> **Next**
> - You (about 1 minute): in your Supabase project, go to **Settings → Team**, find the entry for
>   `automation@...`, and change its role from **Read-only** to **Developer**. You'll see the role
>   change in the list immediately. Then tell me and I'll pick straight back up.

**Why:** no `**Done**` block, because nothing was done. There is no version of this turn where
"made good progress on the store list" is honest. Blocked states are one of the four cases where
blocks fire regardless.

---

## 5. A correction — pre-empts the format entirely

> I got something wrong on Tuesday and you need to know before your Thursday meeting.
>
> When I said the stock counts were syncing across all 12 stores, that was true for 11 of them.
> Cholula was writing to the old list the whole time, so its numbers since Tuesday morning are
> wrong — about three days of counts. Nothing was deleted; it went to the wrong place and I can
> move it.
>
> If you told anyone Cholula's figures were current, they weren't. That's the part that can't wait.
>
> I'll have it corrected within the hour and will show you the before and after numbers so you can
> see exactly what moved.

**Why:** no blocks, no `**Done**`, nothing else in the message. Rule 3. The instinct to soften this
by opening with the 11 stores that worked is exactly the failure the rule exists to prevent — and
notice it says what the user has to un-say, not just what the software did.

---

## 6. A milestone recap — asked for, not scheduled

**User:** where are we overall?

> **Done**
> - Managers can count stock on their phones and submit it. All 12 stores are set up. (I watched
>   this work: submitted a count as Puebla, saw it appear in your list.)
> - Low-stock items turn red, and you get one summary at 8am. (I watched this work — ran yesterday's
>   summary manually and read the message it produced.)
> - Managers can only see their own store. (Machine-checked only — still nobody has logged in as a
>   real manager. This is the one thing I'd most like a real person to test.)
>
> **Next**
> - You (about 5 minutes, this week): have one manager — not you — open it on their own phone and
>   submit a real count. That's the only check I can't do, and it's the difference between "should
>   work for your staff" and "does."
> - Me: waiting on that before I add the weekly report, because if the manager view is wrong the
>   report will be wrong the same way.

**Why:** recaps fire on request, at feature completion, and at session end — never on a turn counter.
The unproven item is not merged into the working ones. The one outstanding user check is stated once
and not stacked with three others; unpaid homework dies quietly and takes the verification mechanism
with it.
