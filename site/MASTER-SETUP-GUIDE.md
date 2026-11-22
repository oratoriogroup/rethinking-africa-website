# RETHINKING AFRICA WITH DR. DAMOLA
# MASTER SETUP GUIDE

Everything in one place: what happens when someone completes the quiz, what they
receive, where contributions go, and the exact values the developer needs.

**Ownership rule for the whole document:** every account below is opened by
Dr Damola, with Dr Damola's email, and Dr Damola's password. The developer is
given URLs to paste, never account passwords. The subscriber list is the most
valuable thing this platform will ever own.

---

# PART 1 — THE THREE ACCOUNTS TO OPEN

Open all three yourself. Roughly 45 minutes in total.

## 1.1 MailerLite — sends every automatic email
mailerlite.com

This is the engine. It receives people and emails them without anyone lifting a
finger. Check the current free tier when signing up; it is generous enough for the
first stage of growth.

**Create three groups** (Subscribers → Groups):
```
Africa Lens Quiz
Contributors
Newsletter
```

**Create four custom fields** (Subscribers → Fields), all type "text":
```
whatsapp
country
profile
type
```

**Create two embedded forms** (Forms → Embedded forms → choose plain HTML):
- one connected to the group `Africa Lens Quiz`
- one connected to the group `Contributors`

Copy the `action` URL from each. These are the two links the developer needs.
They look roughly like:
`https://assets.mailerlite.com/jsonp/000000/forms/000000000/subscribe`

**Verify the sending domain.** MailerLite will ask you to prove you own
rethinkingafrica.africa and will give you DNS records. Send those records to the
developer to add at the registrar. **Skip this and every automated email lands in
spam.** Use `hello@rethinkingafrica.africa` as the sending address.

## 1.2 Formspree — stores every submission where you can see it
formspree.io

MailerLite stores email addresses well but is not built to hold long messages or
WhatsApp numbers. Formspree keeps the complete record and gives you a dashboard
you can search, filter and export.

Create two forms and copy each endpoint URL:
```
Africa Lens Quiz     -> endpoint 1
Contribute           -> endpoint 2
```
Set the notification email on both to your own inbox.

## 1.3 WhatsApp Business — free app on your phone
Install it, set the number, and add a greeting message (text in Part 5).
Nothing to subscribe to and nothing to pay.

---

# PART 2 — WHAT HAPPENS WHEN SOMEONE COMPLETES THE QUIZ

```
Reader finishes the seven questions
        |
        v
Enters name, email, WhatsApp number, country
        |
        +--> Formspree   : full record stored, notification to your inbox
        |
        +--> MailerLite  : joins group "Africa Lens Quiz" with profile tagged
        |                        |
        |                        v
        |                  Welcome email sent automatically, within a minute
        |                        |
        |                        v
        |                  Seven Days of Rethinking, one email a day
        |
        v
Result page shows their profile, a Subscribe button for YouTube,
and a WhatsApp button if they gave a number
```

Nobody sends anything by hand at any point.

---

# PART 3 — THE WELCOME EMAIL

Build this inside MailerLite: **Automations → Create automation**
- Name: `Africa Lens Quiz welcome`
- Trigger: *When subscriber joins a group* → `Africa Lens Quiz`
- Step 1: Email (below)
- Press **Start**

**From name:** Dr Damola
**From address:** hello@rethinkingafrica.africa
**Subject:** Your Africa Lens profile is inside
**Preview text:** Seven things Africa built, and why you were never told

---

Hello {$name},

Thank you for taking the ninety seconds.

Your profile is **{$profile}**.

Whatever your result said about you, here is the part that matters most. Every one
of the seven things you just read has the same shape.

The clay pot that cools water without electricity. The binary system the Yoruba
were using a thousand years before the computer was built. The stone city raised
without cement that has stood for eight hundred years. The libraries of Timbuktu,
where families kept manuscripts on medicine, astronomy and law.

None of them failed. None of them were disproved.

Each one was interrupted. Invaded, defunded, renamed, ridiculed, or buried. And in
every single case the knowledge itself survived, in a pot, in a memory, in a wall,
in a box hidden under a floor.

That is why this platform exists. Africa is not empty of intelligence. Its
intelligence was never recognised, protected, funded or passed on properly.

That is not a tragedy you inherit. It is unfinished work. And unfinished work can
be continued by whoever decides to pick it up.

Over the next seven days I will send you one short idea a day. Each takes about
three minutes to read, and each ends with something you can actually do, in your
own life and in the world around you.

Tomorrow: the question that started this entire platform.

Dr Damola

*Rethinking Africa with Dr. Damola*
*www.rethinkingafrica.africa*

P.S. Everything that will not fit in an email goes on the channel. That is where
the research is made in public: youtube.com/@DrDamola.Africa

---

**Note on `{$name}` and `{$profile}`:** these are MailerLite personalisation tags.
They fill themselves in. Insert them from MailerLite's own menu rather than typing
them, so the spelling matches whatever the platform currently expects.

---

# PART 4 — THE SEVEN DAY SERIES

In the same automation, after the welcome email, add:
**Delay 1 day → Email → Delay 1 day → Email**, and so on, seven times.

The full teaching content for each day is in `SEVEN-DAYS-OF-RETHINKING-module.md`.
Here is the running order and the subject line for each, so the automation can be
built now and the bodies written into it one at a time.

| Day | Subject line | The idea | Ends by asking |
|---|---|---|---|
| 1 | The lens you did not choose | You were taught how to see Africa. It was installed, not chosen. | What were you taught to be ashamed of that was actually knowledge? |
| 2 | Trained away | Education that prepares people to leave rather than to transform. | What opportunity existed near where you grew up that nobody taught you to see? |
| 3 | It was never disproved | Interrupted science: the pot, Ifá, Great Zimbabwe. | What practice from your culture have you never asked "why does this work?" about? |
| 4 | Who is allowed to build | African hands trusted to labour but not to lead. | When did you last choose imported over local out of reflex rather than evidence? |
| 5 | The story you repeat | People become the story told about them, including when they tell it. | Which phrase about Africans have you repeated without checking? |
| 6 | Systems decide | Good people inside bad systems still produce bad outcomes. | Where do you comply with a system you do not trust? |
| 7 | What will you build | An inventory of unfinished work is an assignment, not a tragedy. | Name one thing you will recover, reform, retell or build in ninety days. |

**Day 2 carries the YouTube ask.** Not day one. By then they have received two
things of value for free, so it reads as a next step rather than a toll.

**Day 7 asks for a reply.** Those replies become the Rethinking Wall on the
website, with permission. Keep every one.

**After day 7,** subscribers move to the `Newsletter` group and receive the weekly
letter. Set this as the final step of the automation.

---

# PART 5 — CONTRIBUTIONS

## What the contributor sees

**Immediately, on the page.** The form is replaced by a thank-you message. This is
already built and needs no configuration:

> Thank you. Your contribution has arrived. We read every submission. If it fits a
> current or planned episode, we will write back to you.

**Within a minute, by email.** Build a second automation in MailerLite:
- Name: `Contributor acknowledgement`
- Trigger: *When subscriber joins a group* → `Contributors`
- One email, text below

**Subject:** We have your contribution
**From name:** Dr Damola

---

Hello {$name},

Your contribution has reached us, and it will be read properly by a person rather
than sorted by a machine. That is slower, and it is the point.

If what you sent fits a current or planned episode, we will write back to you. If
it does not fit now, it stays on file, because this platform is built over years
rather than weeks.

One thing worth saying plainly: this programme is not a place where one person
speaks and everyone listens. Constructive disagreement, alternative
interpretations and evidence we have not seen make the work stronger. If you have
more, send it.

Dr Damola

*Rethinking Africa with Dr. Damola*
*www.rethinkingafrica.africa*

---

## Where you will see contributions

Three places, and you only need to watch one of them daily.

**1. Your inbox.** Formspree emails you every submission as it arrives, with all
fields laid out. Create a Gmail filter that labels these `Contributions` so they
never mix with ordinary mail.

**2. The Formspree dashboard.** Every submission stored, searchable, sortable by
date, exportable to CSV. This is the archive. Nothing is ever lost from it, even
if an email is deleted.

**3. MailerLite, group `Contributors`.** The people, rather than the messages.
This is what lets you write to all past contributors at once later.

## How they are arranged

Every submission carries these fields in this order:
```
name
email
whatsapp
country
type of contribution
message
source: "Contribute page"
```

The `type` field is the useful one. It is one of eight fixed values, so the
Formspree dashboard can filter by it:

- Propose an episode
- Submit a lived experience
- Recommend a guest
- Contribute a research essay
- Share an African innovation
- Volunteer as researcher or interviewer
- Institutional partnership
- Invite Dr Damola to speak

**A practical habit:** once a week, open the dashboard, filter by type, and deal
with one type at a time. Speaking invitations and partnerships need answering
within days. Episode proposals and lived experiences can be read in a batch when
you are planning the next block of episodes.

---

# PART 6 — WHAT THE DEVELOPER RECEIVES

Send only this. Four values, no passwords.

```
QUIZ
  quiz.html, CONFIG block at the top of the script:
    SIGNUP_ENDPOINT      = [Formspree endpoint 1]
    MAILING_LIST_ACTION  = [MailerLite "Africa Lens Quiz" form action]
    WHATSAPP_NUMBER      = [digits only with country code, e.g. 2348012345678]

CONTRIBUTE
  contribute.html, near the bottom of the script:
    FORM_ENDPOINT        = [Formspree endpoint 2]
    CONTRIB_LIST_ACTION  = [MailerLite "Contributors" form action]

HOMEPAGE NEWSLETTER
  index.html, find REPLACE_WITH_MAILING_LIST_ACTION
    replace with [MailerLite "Africa Lens Quiz" form action]

DNS
  Add the MailerLite sending-domain records at the registrar.
  Set up forwarding: hello@ , media@ , partnerships@rethinkingafrica.africa

SEARCH
  Add sitemap.xml and robots.txt, verify in Google Search Console,
  submit the sitemap, request indexing of the homepage.

ACCESS
  Provide Dr Damola with file-level access and the login details in writing.
```

Nothing else in any file should change. The code that sends to both services is
already written.

---

# PART 7 — THE TEST BEFORE SIGN-OFF

Run all seven. Do not accept the work until each passes.

1. Complete the quiz with a real email. **The welcome email arrives within two
   minutes.**
2. That subscriber appears in MailerLite, group `Africa Lens Quiz`, with the
   profile field filled in.
3. The same submission appears in the Formspree dashboard, including the WhatsApp
   number.
4. Complete the quiz giving only a WhatsApp number. The WhatsApp button appears
   and opens a chat with a pre-written message.
5. Submit the contribute form. The thank-you appears on the page, the
   acknowledgement email arrives, and the submission is in the dashboard.
6. Check the spam folder. If anything landed there, the DNS records were not added.
7. Run Lighthouse on mobile. Performance 90 or above.

---

# WHATSAPP GREETING (set inside the WhatsApp Business app)

> Thank you for taking the Africa Lens Quiz. Your guide is on its way. One short
> idea a day for the next seven days, then a letter each week. Everything else is
> on the channel: youtube.com/@DrDamola.Africa

---

# ONE PAGE SUMMARY

| Thing | Who owns it | What it does |
|---|---|---|
| MailerLite | Dr Damola | Sends every automatic email |
| Formspree | Dr Damola | Stores every submission, searchable |
| WhatsApp Business | Dr Damola | Replies to readers who message first |
| Domain and hosting | Dr Damola | The site itself |
| The four URLs | Given to developer | Connects the code to the services |
