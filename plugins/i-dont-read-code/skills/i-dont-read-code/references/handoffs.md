# Handoff recipes

The eight things a non-technical user gets asked to do. Each one has killed a project by being
written as "run the migration."

Every handoff needs four things plus one clause: **where**, **exactly what** (verbatim, fenced),
**what they'll see when it worked**, **roughly how long** — plus why it must be them. If you
cannot state the success signal, the instruction is not finished. Do not send it.

Adapt the vendor names to whatever the project actually uses. Never send more than one handoff
per message; hold the rest.

---

## 1. Run SQL in a hosted database console

> You (about 3 minutes — I have no login to your database, only you do): go to <console URL>,
> open the project named `<project-name>`, and click **SQL Editor** in the left menu. Paste this
> in and press **Run**:
>
> ```sql
> <exact statement>
> ```
>
> This <one sentence on what it does in their terms>. It does not touch <the thing they'd worry
> about>.
>
> You'll see a green box saying `Success. No rows returned`. If it's red, copy the whole red text
> and paste it here.

**Most common failure:** they're in the wrong project, and the statement succeeds against an
empty database. Name the project explicitly, every time.

---

## 2. Put a password or key somewhere the code can read it

Never ask them to paste a secret into chat. Say so out loud — it teaches a habit worth having.

> You (about 2 minutes): open <where>, find the section called **Environment Variables**, and add
> a new one. The name is exactly:
>
> ```
> <KEY_NAME>
> ```
>
> The value is the key you copied from <vendor>. Don't paste it here in the chat — I don't need to
> see it, and anything in this chat is worth treating as public.
>
> You'll see it appear in the list with the value hidden as dots. Tell me when it's saved and I'll
> continue.

**Most common failure:** trailing whitespace or surrounding quotes pasted along with the value.
If the key later reads as invalid, this is the first thing to check.

---

## 3. Look at the site running on your own machine

> You (about 1 minute): in the black terminal window, type this and press Enter:
>
> ```
> npm run dev
> ```
>
> It will print a few lines and then sit there looking frozen. That's correct — it's supposed to
> stay running. Look for a line with a web address like `http://localhost:3000` and open that in
> your browser.
>
> You'll see the site. To stop it later, click the terminal and press `Ctrl` and `C` together.

**Most common failure:** they close the terminal and think the site is broken, or they wait for
the command to "finish." Say explicitly that it stays running.

---

## 4. Read a deploy log and find the actual error

> You (about 2 minutes): go to <dashboard URL>, click the deployment at the top of the list (it'll
> have a red mark), then click **Building** or **Logs**.
>
> You're looking for the first line with the word `Error` in it — scroll up, not down, because the
> first error is the real one and everything after it is noise. Copy from that line down about ten
> lines and paste it here.

**Most common failure:** they paste the last ten lines, which are almost always a generic "build
failed" summary. Say "scroll up" explicitly.

---

## 5. Point your own domain at the site

> You (about 10 minutes, then up to a few hours of waiting): this has to be you because it's your
> domain account and your credit card.
>
> 1. In <host dashboard>, open **Settings → Domains** and type `<domain>`. It will show you one or
>    two records to create.
> 2. In <registrar>, find **DNS** and add exactly what it showed you.
>
> You'll see the domain go from "Pending" to "Valid" — usually within an hour, sometimes longer.
> Nothing is broken during the wait. If it's still pending tomorrow, screenshot the DNS page and
> send it here.

**Most common failure:** they add the record to the wrong domain, or duplicate an existing one.
Ask them to send the DNS list if it doesn't resolve.

---

## 6. Take a backup before something risky

Offer this *before* the risky thing, not after. It is the cheap safety step rule 6 requires.

> Before I do this, take a backup — it takes about a minute and it means the worst case is
> "we lost an hour," not "we lost your data."
>
> You: go to <console URL>, open **Database → Backups**, and click **Create backup**. Wait for it
> to say **Completed** and tell me the timestamp it shows.

**Most common failure:** they say "go ahead" without doing it. Wait for the timestamp. Do not
proceed on an unanswered safety step.

---

## 7. Go back to yesterday's version

> You (about 2 minutes): go to <dashboard URL> and find the deployment list. Find the one from
> before <time>, click the `...` menu on its right, and choose **Promote to Production** (or
> **Rollback**).
>
> You'll see it move to the top with a **Production** label, and the live site goes back to how it
> was in about 30 seconds. Load the site and confirm the problem is gone before telling me.

**Most common failure:** they roll back the code but not the database, and the data is now shaped
for the newer version. If this turn involved a database change, say plainly that rolling back the
site alone will not undo it.

---

## 8. Send me the exact error text

> You: copy the whole red text — all of it, even the parts that look like nonsense — and paste it
> here. The unreadable parts are the ones I need. A screenshot works too, but pasted text is
> better because I can search it.

Never ask them to summarize an error. The summary destroys the one piece of information that
identifies it.
