# Consequence forks

A technical fork becomes a real question only when both options are priced in a currency the user
is expert in: **money, time, risk of losing data or customers, what staff and customers
experience, how hard it is to change later.**

If you cannot fill at least one currency for both sides, the question is fake. Decide it yourself
and report the decision in one line.

The forks in SKILL.md cover the six you hit constantly. These are the long tail. Adapt the numbers
to the actual project — placeholder figures presented as facts are their own failure.

---

**How people sign in**
> Sign in with Google, or email and password? Google means nothing to remember and no "I forgot my
> password" messages for you to handle — but everyone needs a Google account. Email and password
> works for anyone, and you'll be the help desk when someone forgets. I'd pick Google if your staff
> already use it for work. Switching later means everyone re-registers, so this one is worth a
> minute of thought.

**Where the data physically lives**
> Should the data sit in <region A> or <region B>? Closer means the app feels faster for the people
> using it — maybe half a second per screen. Further can matter legally if <jurisdiction> requires
> customer data stay in-country. Moving it later means a few hours of downtime. Which of those
> matters more to you?

**Backups**
> Do you want daily automatic backups? It's about $X/month. Without it, if something goes wrong the
> honest answer is "we lose whatever wasn't written down." With it, worst case is losing one day.
> I'd say yes for anything holding real records. This one I'd rather you decide than default.

**Email that reaches customers**
> Sending from your own domain means messages land in inboxes instead of spam, but it needs a paid
> account (~$X/month) and about 20 minutes of setup on your side. Sending from a generic address is
> free and instant, and a meaningful share of it never gets read. If these are order confirmations,
> pay. If it's an internal alert to three people, don't.

**Do the slow thing now or in the background**
> When someone uploads 200 rows, the screen can either freeze for ~30 seconds while it finishes, or
> come straight back and finish quietly with a "done" message a minute later. Freezing is simpler
> and I'd have it today; background is nicer and adds about half a day. If your staff do this once
> a week, freezing is fine.

**App store app, or a website that works on phones**
> A website works on every phone today, updates instantly, and costs nothing extra. An app-store app
> gets an icon on the home screen and can send push notifications, but it costs $X/year, takes about
> a week, and every update waits for review. Almost nobody needs the app first. I'd ship the website
> and revisit if people ask for notifications.

**Taking payments**
> <Provider A> is faster to set up and takes X% + $Y per transaction. <Provider B> is cheaper above
> roughly $Z/month but needs paperwork and a few days of approval. At your current volume the
> difference is about $N/month — small enough that I'd pick the faster one and switch if you grow.
> Either way you'll need to give them your business details; I can't do that part.

**Where photos and files live**
> Storing images with the app is free and simple until you have a few thousand, then pages get slow.
> A dedicated file service is ~$X/month and stays fast forever. If people upload photos as part of
> normal work, pay now — retrofitting means moving every existing file.

**Search**
> "Find" that matches exact words is free and I can do it today. Search that tolerates typos and
> partial words is ~$X/month and adds a day. If your staff search by product code, exact is fine.
> If they search by memory of a name, pay for the forgiving one.

**Time zones**
> Should everything show in one time zone, or each store's local time? One time zone makes reports
> comparable and confuses staff reading their own numbers. Local time reads naturally and makes
> "yesterday's total" ambiguous across regions. I'd pick one time zone for reports and local for
> screens staff use — but this needs your call before I build it, because changing it later
> re-labels historical data.
