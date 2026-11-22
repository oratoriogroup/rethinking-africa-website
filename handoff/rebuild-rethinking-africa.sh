#!/usr/bin/env bash
#
# Rethinking Africa with Dr. Damola — full site rebuild script
# Regenerates the complete website codebase from this single file.
#
#   Usage:  bash rebuild-rethinking-africa.sh
#   Result: a folder called ./site containing the whole website.
#
# Images (.webp/.jpg) are binary and are NOT inside this script.
# Everything else — every page, the stylesheet, the SVG logos, the docs —
# is here in full. See MISSING-IMAGES.txt after running.
#
set -euo pipefail
ROOT="${1:-site}"
echo "Rebuilding into: $ROOT"

mkdir -p "$ROOT" "$ROOT/assets" "$ROOT/css"


echo "  writing BRIEF-FOR-DEVELOPER.md"
cat > "$ROOT/BRIEF-FOR-DEVELOPER.md" << 'RA_FILE_EOF_7X2K9'
# BRIEF FOR THE DEVELOPER
## Rethinking Africa with Dr. Damola — rethinkingafrica.africa

Please read this before touching anything. The site is finished and approved.
Your job is to **deploy it and connect the live services**, not to redesign it.

---

## 1. The single most important instruction

**Deploy these files exactly as they are.**

Do not rebuild this in WordPress, Wix, a page builder, or any framework.
Do not redesign the layout, change the colours, change the fonts, or "modernise" it.
Do not replace the hand-written HTML with a template.

This is deliberate, not a limitation. The site is plain HTML and one CSS file
because the audience is largely on Nigerian mobile connections. Every page is
around 30 KB and needs no JavaScript to render. Moving it to WordPress would
multiply the page weight, add a database and plugins that need patching, and
slow it down for exactly the people it was built for.

If you believe something genuinely must change, raise it with Dr Damola first
and explain the reason. Do not change it unilaterally.

---

## 2. What to deploy

Upload the entire `site` folder to the web root. The structure must be preserved:

```
index.html          Home
quiz.html           The Africa Lens Quiz  (the main conversion page)
watch.html          Episodes
ideas.html          Articles and research
african-voices.html Featured voices and community wall
news.html           Announcements, blog, events
contribute.html     Contribution form
community.html      Email, WhatsApp, LinkedIn, events
about.html          About and founder
contact.html        Contacts and media kit
canada-2026.html    Canada Conversations collection
policies.html       Privacy, terms, copyright
editorial.html      Editorial standards
css/style.css       The single stylesheet
assets/             Images and logos
```

`index.html` must be the site's default document. HTTPS must be on.
Both `rethinkingafrica.africa` and `www.rethinkingafrica.africa` must work,
with one redirecting to the other, because the video end cards show the www form.

---

## 3. What must be connected (this is the actual work)

Search the files for the word `DEVELOPER` — every item below is marked in the code.

1. **Email provider.** Connect the sign-up forms on `index.html` (the section with
   id `subscribe`) and the email gate inside `quiz.html`. Recommended: MailerLite
   or ConvertKit, free tier. On the quiz, the subscriber must be tagged with their
   result profile (Knowledge Recoverer, Bridge Builder, System Reformer, Story
   Restorer, Future Maker) so Dr Damola can segment later. The quiz already
   calculates the profile in JavaScript; you only need to pass it to the provider.

2. **Contribute form** on `contribute.html`. Connect to Formspree, Google Forms,
   or a simple mail handler. Submissions go to hello@rethinkingafrica.africa.

3. **Email addresses.** Set up forwarding for hello@, media@ and partnerships@
   at rethinkingafrica.africa, all pointing to Dr Damola's chosen inbox.

4. **Video embeds.** Replace the trailer and featured-episode placeholders on
   `index.html` with the YouTube embeds. Use a click-to-play thumbnail facade
   (for example lite-youtube-embed) so the player only loads when clicked.
   **Never autoplay with sound.**

5. **Social links** are already correct. Do not change them:
   YouTube @DrDamola.Africa · Instagram, TikTok, Facebook, X @DrDamolaAfrica ·
   LinkedIn company/rethinking-africa-with-dr-damola

6. **Media kit downloads** on `contact.html` and the concept note on `about.html`
   need the actual PDF files uploaded and linked.

---

## 4. Things that must not be altered

- The name **"Rethinking Africa with Dr. Damola"** in page titles, the header,
  meta descriptions and the JSON-LD. Another scholar runs a similarly named
  platform, so the full name is what distinguishes this one. Never shorten it
  to "Rethinking Africa" anywhere.
- The **JSON-LD structured data** in `index.html`, including the
  `disambiguatingDescription`. It tells Google these accounts and this site are
  one organisation.
- The wording on giving: gifts support an **independent initiative** and are
  **not tax-deductible donations**. This is a legal position, not a style choice.
- The footer line describing the platform as an independent initiative founded
  by Dr Oluwakemi Damola Adejumo-Ayibiowu. It must not be described as a
  registered NGO or company.
- Colours: Adire Indigo #1D2A57, Indigo Night #141D3D, Sunrise Gold #E8A11C,
  Warm Ivory #F7F1E3. Gold is an accent only, never a background.

---

## 5. Performance and accessibility targets

- Lighthouse mobile performance **90 or above** on a simulated slow 4G connection.
  Please run this and send the score before sign-off.
- Any new image: WebP, 150 KB maximum, with width and height attributes set.
- Keep the existing focus styles, form labels and `aria-current` navigation states.
- Add `sitemap.xml` and `robots.txt`, then submit the site to Google Search Console.

---

## 6. Hosting and ownership

- The **domain belongs to Dr Damola** and stays registered in her name. She keeps
  the registrar login. You only need the DNS records to point at the server.
- Please confirm in writing: the hosting account details, how she logs in, and
  that she receives a complete copy of the site files after every update.
- On termination of the arrangement, for any reason, the full site files are to
  be provided within seven days.
- **Recommended alternative:** this is a static site, so it can be hosted free on
  Netlify, Vercel or Cloudflare Pages, faster than a shared server, with the
  account in Dr Damola's own name and you added as a collaborator. If that suits,
  it removes the hosting cost entirely and simplifies ownership.

---

## 7. How updates should work afterwards

Dr Damola needs to be able to make small text changes herself without waiting.
Please set up **one** of these and show her how it works:

- **Preferred:** deploy from a GitHub repository connected to Netlify. She edits a
  file in the GitHub web editor, and the site updates itself in about a minute.
- **Or:** a lightweight editor such as Decap CMS or Pages CMS on top of the same
  static files, giving her a simple login and editable text fields.
- **Minimum:** file manager access plus a short written note explaining which file
  controls which page.

Do not install WordPress to solve this. A static-site editor does the same job
without the weight.

---

Questions or anything you think should change: raise it with Dr Damola before
making the change. Thank you.
RA_FILE_EOF_7X2K9

echo "  writing DEVELOPER-TASK-LIST.md"
cat > "$ROOT/DEVELOPER-TASK-LIST.md" << 'RA_FILE_EOF_7X2K9'
# DEVELOPER TASK LIST
## Rethinking Africa with Dr. Damola — outstanding work

Everything below is code that is already written and waiting for a URL or a value.
No page needs redesigning. Estimated total: **under two hours.**

Please confirm each item back to Dr Damola as it is completed.

---

## TASK 1 — Connect the quiz so it replies automatically

**Problem:** someone completes the quiz and receives nothing. Collecting an address
and replying to it are two separate services, and only collection is connected.

Open `quiz.html`. At the top of the `<script>` block:

```js
const CONFIG = {
  SIGNUP_ENDPOINT:     "",   // Formspree or Web3Forms URL
  WHATSAPP_NUMBER:     "",   // digits only with country code, e.g. 2348012345678
  MAILING_LIST_ACTION: ""    // MailerLite embedded form action URL
};
```

Fill in all three.

- `SIGNUP_ENDPOINT` stores the full submission including WhatsApp number and profile
- `MAILING_LIST_ACTION` is what triggers the automatic welcome email
- `WHATSAPP_NUMBER` powers the WhatsApp button on the result page

Dr Damola provides the MailerLite URL. She owns that account.
The automation that sends the welcome email is built inside MailerLite, not in code.

**Done when:** completing the quiz with a real email produces an email within two
minutes, and the subscriber appears in the MailerLite group "Africa Lens Quiz".

---

## TASK 2 — Connect the contribute form

**Problem:** the form submits to nothing. The sender gets no confirmation and no
record reaches us.

This has now been rebuilt. Open `contribute.html`, find near the bottom:

```js
const FORM_ENDPOINT = "";
```

Paste a Formspree or Web3Forms endpoint that delivers to
`hello@rethinkingafrica.africa`.

Already handled in the code, so do not rebuild it:
- validation before sending
- an on-page thank-you message replacing the form on success
- an error message with a fallback email address if sending fails
- a WhatsApp field added to the form

**Optional but recommended:** in the Formspree or Web3Forms dashboard, switch on
the autoresponder so the sender also receives a confirmation email. One line of
suggested text:

> Thank you for writing to Rethinking Africa with Dr. Damola. Your contribution has
> reached us and will be read properly. If it fits a current or planned episode we
> will be in touch.

**Done when:** a test submission arrives in the inbox, and the sender sees the
thank-you message on screen.

---

## TASK 3 — Connect the homepage newsletter form

Open `index.html`, find `REPLACE_WITH_MAILING_LIST_ACTION` and replace it with the
same MailerLite form action URL from Task 1.

**Done when:** a test submission appears in MailerLite with name, country and
interest fields populated.

---

## TASK 4 — Email addresses

Set up forwarding at the domain registrar, all pointing to Dr Damola's inbox:

```
hello@rethinkingafrica.africa
media@rethinkingafrica.africa
partnerships@rethinkingafrica.africa
```

Also add the DNS records MailerLite provides for sending-domain verification.
**Without these records the automated emails will land in spam.**

---

## TASK 5 — Video embeds on the homepage

Replace the trailer and featured-episode placeholders in `index.html` with the
YouTube embeds, using a click-to-play thumbnail facade such as `lite-youtube-embed`
so the player only loads when clicked. **Never autoplay with sound.**

---

## TASK 6 — Search visibility

1. Add `sitemap.xml` and `robots.txt`.
2. Verify the site in Google Search Console.
3. Submit the sitemap, then request indexing for the homepage.

The site currently does not appear in Google because it has not been crawled yet.
This is what fixes it.

---

## TASK 7 — Give Dr Damola file access

She must be able to edit page text without waiting for anyone. Set up **one** of
these and show her how it works:

1. **Preferred:** a GitHub repository **created under her own account**, with you
   added as a collaborator, deploying to the server. She edits in the browser and
   the site updates itself.
2. cPanel or File Manager login to the hosting.
3. At minimum, FTP access plus a note of which file controls which page.

Please also confirm in writing: the hosting login details, and that she receives a
complete copy of the site files after every update.

---

## Content pages: how they update

The News, African Voices and Canada pages no longer display placeholder text to
visitors. Where content does not exist yet, the page explains what is coming
instead. Instructions for adding real content are inside each file as HTML
comments, invisible to visitors. **Do not put instruction text back on the page.**

---

## Sign-off test

Please run all six and report the results:

1. Complete the quiz with a real email. An email arrives within two minutes.
2. Complete the quiz with only a WhatsApp number. The WhatsApp button opens a chat.
3. Submit the contribute form. The thank-you appears; the message reaches the inbox.
4. Submit the homepage newsletter form. The subscriber appears in MailerLite.
5. Check that none of the emails landed in spam.
6. Run Lighthouse on mobile and send the performance score. Target is 90 or above.
RA_FILE_EOF_7X2K9

echo "  writing EDITING-GUIDE-FOR-DR-DAMOLA.md"
cat > "$ROOT/EDITING-GUIDE-FOR-DR-DAMOLA.md" << 'RA_FILE_EOF_7X2K9'
# EDITING YOUR OWN SITE
## A plain-English guide for Dr Damola

You do not need to be a programmer to change the words on this website.
Everything is written in plain files. This guide explains what lives where,
and how to change it safely.

---

## Which file is which page

| If you want to change... | Open this file |
|---|---|
| The front page | `index.html` |
| The quiz questions or results | `quiz.html` |
| Episode listings | `watch.html` |
| Articles and research | `ideas.html` |
| Featured voices, community wall | `african-voices.html` |
| Announcements, blog posts, events | `news.html` |
| The contribution form page | `contribute.html` |
| Newsletter, WhatsApp, events | `community.html` |
| Your story and biography | `about.html` |
| Contacts and media kit | `contact.html` |
| Canada Conversations | `canada-2026.html` |
| Privacy and terms | `policies.html` |
| Editorial standards | `editorial.html` |
| Colours, fonts, spacing (all pages at once) | `css/style.css` |

---

## The one rule for editing text

Open the file, find the words you want to change, and type over them.
**Only change the words between the angle brackets, never the brackets themselves.**

```
<h2>Trained Away</h2>
     ^^^^^^^^^^^^  change this
^^^^              leave this alone
```

If you see something in square brackets like `[Guest name]` or `[Date]`, that is a
placeholder waiting for you to replace it, including the brackets.

---

## Adding a new blog post or announcement

Open `news.html`. Find an existing post block, which looks like this:

```html
<article class="post"><div class="meta">[Date] · Reflection</div>
<h3><a href="#">Your headline here</a></h3>
<p>Your one-line summary here.</p></article>
```

Copy the whole block, paste it directly above the others so the newest is on top,
then change the date, headline and summary. That is the entire process.

Announcements work the same way, using the `announce` blocks near the top.

---

## Adding a new event with photographs

In `news.html`, find the events section. Copy the heading, the description line and
the `gallery` block. Replace the placeholder image names with your own photographs.

Before uploading any photograph: shrink it first. A photo straight from a phone can
be 5 MB, which will make the page slow for people on mobile data. Aim for under
150 KB. Free tools such as squoosh.app do this in a few seconds.

---

## Changing the quiz

Open `quiz.html` and scroll to the bottom, to the part beginning `const QUESTIONS`.
Each question sits on its own lines with its four answers. You can reword any
question or answer by typing over the text inside the quotation marks.

The letters `KR`, `BB`, `SR`, `ST`, `FM` are the five profiles
(Knowledge Recoverer, Bridge Builder, System Reformer, Story Restorer, Future Maker),
and the numbers are how many points that answer gives each profile. If you are not
comfortable with that part, change only the wording and leave the numbers alone.

The profile descriptions are just below, under `const PROFILES`, and are safe to edit
freely.

---

## What NOT to change without help

- Anything inside `<script>` tags, apart from the quiz wording described above
- The block near the top of `index.html` beginning `application/ld+json`
  (this is what tells Google who you are)
- File names, or the `assets` and `css` folder names
- The word `class="..."` inside any tag; that is what applies the styling

---

## Always keep a copy

Before you edit anything, save a copy of the folder somewhere safe, dated.
If an edit goes wrong, you simply put the old file back. This single habit will
save you every time.

---

## The easiest long-term setup

Ask your developer to put the site on **GitHub connected to Netlify**. It sounds
technical but the experience is simple: you open the file in a web page, type your
change, press a green button, and the live site updates itself in about a minute.
Every previous version is saved automatically, so nothing can be permanently broken.

That setup costs nothing and means you never have to wait for someone else to fix a
typo or publish an announcement.

---

## When to call the developer instead

- The site goes down, or the domain stops working
- Forms stop delivering email
- You want a whole new page or section
- Anything involving payments, the newsletter system, or the video embeds
RA_FILE_EOF_7X2K9

echo "  writing HOW-FORMS-WORK-ON-STATIC.md"
cat > "$ROOT/HOW-FORMS-WORK-ON-STATIC.md" << 'RA_FILE_EOF_7X2K9'
# HOW FORMS, EMAIL AND WHATSAPP WORK ON THIS SITE
## Technical note for the developer

There is a misunderstanding to clear up first, then a short list of what to do.

---

## The misunderstanding

> "Static HTML cannot handle subscriptions."

This is not correct. A subscription form does not need a database on *our* server.
It posts to a service that already has one.

This is the standard modern pattern. It is how most marketing sites, documentation
sites and campaign pages are built today, and it is why static hosting exists as a
category at all. Netlify, Vercel and Cloudflare Pages are billion-dollar businesses
built precisely on static sites that handle forms, payments and subscriptions.

**What actually happens:**

```
Visitor fills in the form on our static page
        |
        v
The browser POSTs the data directly to MailerLite / Formspree / ConvertKit
        |
        v
That service stores the subscriber, tags them, and sends the emails
```

Our server never touches the data. It does not need to. It only needs to serve
HTML, which is the one thing static hosting does perfectly.

**WordPress would not add capability here.** It would add a database, a PHP
runtime, a plugin surface that needs patching, and roughly ten times the page
weight, in order to reach the same third-party email service through a plugin
instead of a form action. For an audience largely on Nigerian mobile data, that
is a real cost with no functional gain.

---

## What is already built

The work is done in code. Open `quiz.html` and look at the top of the `<script>`
block. There is a CONFIG object with three empty strings:

```js
const CONFIG = {
  SIGNUP_ENDPOINT:     "",   // where quiz submissions go
  WHATSAPP_NUMBER:     "",   // digits only, with country code, no plus
  MAILING_LIST_ACTION: ""    // optional: MailerLite/ConvertKit form action
};
```

Fill those three in and the quiz starts capturing data. Nothing else in the file
needs to change. The quiz already collects name, email, WhatsApp number, country,
preferred channel and the calculated profile, and posts them as JSON.

---

## Step 1 — Choose the email service (30 minutes)

**Recommended: MailerLite.** Free up to 1,000 subscribers, works well from Nigeria,
supports automation sequences, and gives a plain HTML embedded form.

1. Create the account and a group called `Africa Lens Quiz`.
2. Create custom fields: `whatsapp`, `country`, `profile`.
3. Build an embedded form, choose the plain HTML option, and copy the form
   `action` URL.
4. Paste that URL into `MAILING_LIST_ACTION` in `quiz.html`, and into the
   homepage form where it says `REPLACE_WITH_MAILING_LIST_ACTION`.

Equally fine: ConvertKit, Brevo, Mailchimp. All provide an embeddable HTML form.

## Step 2 — Capture everything, including WhatsApp numbers (15 minutes)

Email platforms only store email addresses well. To capture the full submission,
including WhatsApp numbers and quiz profiles, use a form endpoint:

- **Formspree** (formspree.io) — free tier, gives a URL like
  `https://formspree.io/f/xxxxxxx`
- **Web3Forms** (web3forms.com) — free, no account needed for basic use
- **Netlify Forms** — free and automatic if hosted on Netlify

Paste the URL into `SIGNUP_ENDPOINT`. Every submission will then arrive in that
dashboard and by email, and can be exported as CSV.

## Step 3 — WhatsApp (15 minutes)

Put the number in `WHATSAPP_NUMBER`, digits only, for example `2348012345678`.

The result page then shows a **Get it on WhatsApp** button which opens a chat with
a pre-written message from the reader.

This design is deliberate and important. WhatsApp does not permit sending
unsolicited messages to numbers you have collected; doing so gets business numbers
restricted or banned. Having the reader message us first creates a legitimate
opt-in and opens a 24-hour window in which we can reply freely. It costs nothing,
needs no API, and cannot get the number blocked.

Later, if volume justifies it, a WhatsApp Business Platform provider (Twilio,
360dialog, Wati) can send approved template messages at scale. That is an upgrade,
not a requirement, and it is unrelated to whether the site is static.

## Step 4 — The contribute form (10 minutes)

`contribute.html` uses the same pattern. Point its form action at a Formspree
endpoint delivering to hello@rethinkingafrica.africa.

## Step 5 — Test before sign-off

1. Complete the quiz with a real email address. Confirm the record appears in the
   dashboard within a minute.
2. Complete it again with only a WhatsApp number. Confirm the WhatsApp button
   opens a chat with the pre-written message.
3. Submit the homepage newsletter form. Confirm the subscriber appears in
   MailerLite with the correct group and fields.
4. Run Lighthouse on mobile and send Dr Damola the performance score.

---

## If a genuinely dynamic feature is needed later

Static hosting still covers it, using serverless functions:

- Netlify Functions, Vercel Functions or Cloudflare Workers
- Each is a small piece of code that runs on demand, with no server to maintain

Examples this would cover: taking payments through Paystack, storing quiz results
in a database, or a members-only area. None of these require WordPress, and none
require abandoning the current build.

---

## Summary

| Requirement | Works on static? | How |
|---|---|---|
| Email subscription | Yes | Embedded form action to MailerLite |
| Capture WhatsApp numbers | Yes | Form endpoint (Formspree) |
| Message people on WhatsApp | Yes | wa.me opt-in link, already implemented |
| Contribution form | Yes | Form endpoint to our inbox |
| Tag subscribers by quiz result | Yes | Hidden field, already implemented |
| Automated 7-day email series | Yes | Automation inside MailerLite |
| Payments, later | Yes | Paystack inline, or a serverless function |

Total setup time is roughly one to two hours. Please raise any question before
changing the build.
RA_FILE_EOF_7X2K9

echo "  writing MASTER-SETUP-GUIDE.md"
cat > "$ROOT/MASTER-SETUP-GUIDE.md" << 'RA_FILE_EOF_7X2K9'
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
RA_FILE_EOF_7X2K9

echo "  writing README-FOR-DEVELOPER.md"
cat > "$ROOT/README-FOR-DEVELOPER.md" << 'RA_FILE_EOF_7X2K9'
# Rethinking Africa — Website Package (Developer Notes)

## What this is
A complete, mobile-first static website for **Rethinking Africa with Dr. Damola**:
7 pages + shared CSS + brand assets. No frameworks, no build step, no JavaScript
required — deployable as-is to Netlify, Vercel, Cloudflare Pages, or any host.

## Structure
```
index.html        Home (hero statement, trailer, featured episode, 3 themes, invite, signup)
about.html        Vision, orientation, bio, values, what the programme is not
watch.html        Six video series
ideas.html        Ideas & Research (articles, briefs, reading lists)
contribute.html   Structured contribution form
community.html    Email / WhatsApp Channel / LinkedIn / YouTube / events
contact.html      Official emails + media kit downloads
css/style.css     Single mobile-first stylesheet
assets/           Favicon + logo SVGs (v3 brand)
```

## Design principles (do not change without brand approval)
- **Mobile-first:** base CSS targets phones; media queries at 640px / 960px enhance upward.
  A large share of the audience is on Nigerian mobile connections — keep total page
  weight small (currently ~30 KB per page + one heading font).
- **Fonts:** Fraunces (headings only, `display=swap`) from Google Fonts; body text is
  system Georgia — zero download. Do not add more font files.
- **Colours:** Adire Indigo #1D2A57, Sunrise Gold #E8A11C, Warm Ivory #F7F1E3,
  Indigo Night #141D3D. Gold is accent-only, never a background.
- **The gold horizon rule** (`.horizon`) is the brand's signature device between sections.

## Things to replace before launch (search for "DEVELOPER" comments)
1. **Domain:** all schema/links assume `rethinkingafrica.org` — update if a different
   domain is registered.
2. **Email signup forms** (index.html): point the form `action` at MailerLite /
   ConvertKit / Mailchimp embedded form endpoint.
3. **Contribute form** (contribute.html): wire to Formspree, Google Forms, or a backend.
4. **Trailer + featured episode** (index.html): replace placeholders with YouTube
   embeds (use `loading="lazy"` on iframes).
5. **Social links:** confirm final YouTube handle, LinkedIn page, WhatsApp Channel URL.
6. **Media kit downloads** (contact.html): upload the bio PDF, photo ZIP, media profile.
7. **Concept note PDF** (about.html).

## SEO / structured data
- `index.html` includes JSON-LD **Organization + WebSite** schema (Google-recommended).
  Update `sameAs` with the final social profile URLs and keep the logo path valid.
- Each page has a unique `<title>` and meta description.
- Add a `sitemap.xml` and `robots.txt` at deploy time; submit to Google Search Console.

## Performance requirements
- Target: Lighthouse mobile performance ≥ 90 on a simulated slow 4G connection.
- Compress any future images to WebP ≤ 150 KB; always set width/height attributes.
- No analytics heavier than a lightweight option (e.g. Plausible or GA4 with
  consent); no autoplaying video on the homepage.

## Accessibility
- Colour contrast meets WCAG AA; keep it that way if adjusting colours.
- Focus states are styled (`:focus-visible`); all forms have labels; nav uses
  `aria-current="page"`.

## Added: portraits, News & Events (v1.1)
- `news.html` — Announcements, Blog, and Events with photo galleries. New nav item on all pages.
- Portrait sections on `index.html` (Meet Dr. Damola) and `about.html`.
- Replace `assets/portrait-placeholder.svg` and `assets/event-placeholder.svg` with real
  photos: WebP, max 150 KB each, correct alt text. Portrait recommended 800x1000px;
  event photos 1200x900px.
- Blog posts on news.html are static blocks; when publishing becomes frequent, migrate
  the blog to a lightweight CMS (e.g. Decap CMS on the same static host) rather than
  adding a heavy platform.

## v2.0 — Full advisor-recommendation build
- New pages: `african-voices.html` (Featured Voice, One Question for Africa,
  Rethinking Wall), `canada-2026.html` (Canada Conversations 2026 collection),
  `policies.html` (privacy/terms/copyright/consent), `editorial.html` (editorial,
  research, correction, AI-disclosure standards).
- Homepage rebuilt to the recommended flow: headline "Rethinking Africa. Reclaiming
  Intelligence. Reimagining the Future.", three primary buttons, click-to-play trailer
  (NEVER autoplay), latest episode, why-we-exist, six theme cards, rotating Question
  (random per visit, no timers), Featured African Voice, latest writing / From the
  Field, six contribute buttons, founder section, 4-field subscription form
  (first name / email / country / area of interest) + WhatsApp Channel button, partners.
- About page rebuilt to the six-section structure with approved copy and the
  founder's full biography (Dr Damola Adejumo-Ayibiowu — note: she/her throughout).
- Footer on all pages: founder line ("independent... initiative" wording until CAC
  registration is completed — do NOT call it a registered NGO/company), official
  email, policy links.
- Video embeds: use a thumbnail facade that loads the YouTube player only on click
  (e.g. lite-youtube-embed) to protect mobile performance.
- Legal: have the privacy policy reviewed for NDPR (Nigeria) compliance before launch.

## v2.1 — Founder portrait, full name, imagery
- Real portrait added: `assets/dr-damola-portrait.webp` (800x1000, 112 KB) with JPG
  fallback. Used on Home and About.
- Full name everywhere formal: Dr Oluwakemi Damola Adejumo-Ayibiowu ("Dr Damola" as
  the friendly short form). JSON-LD founder updated with alternateName.
- New "Africa in pictures" story strip on the homepage (3 images). IMAGE POLICY:
  photographs must show African capability and dignity (artisans, classrooms, cities,
  enterprise) — never crisis cliches. Preferred order of sourcing: (1) Dr Damola's own
  field photography / video b-roll stills, (2) iwaria.com (African free stock),
  (3) nappy.co, (4) unsplash.com/pexels.com searching African photographers.
  Every image: WebP, <=150 KB, meaningful alt text, real caption.
- Site-wide rule: maximum ~6 photos per page to protect mobile load time.

## v2.2 — Naming distinction policy (IMPORTANT)
Another scholar operates rethinkingafrica.org and a German initiative uses
"ReThinking Africa". The platform's complete public identity is therefore ALWAYS:

  **Rethinking Africa with Dr. Damola**

- Never publish, title, or tag anything as merely "Rethinking Africa".
- Header brand, page titles, meta descriptions, og:site_name, and JSON-LD all
  carry the full name (done in this build). JSON-LD includes a
  disambiguatingDescription — keep it.
- Domain in this build: **rethinkingafrica.africa**. If registration lands on
  rethinkingafrica.africa instead, run one global search-replace of
  "rethinkingafrica.africa" -> "rethinkingafrica.africa" (also updates the email
  addresses hello@/media@/partnerships@).
- Social handles are placeholders to SECURE with the distinguishing name:
  YouTube @RethinkingAfricaDrDamola, LinkedIn rethinking-africa-with-dr-damola.
  Register matching handles on all platforms even if unused, to prevent confusion.
- SEO note: because an established site shares the base name, always use the full
  name in YouTube channel name, video titles' channel branding, and anchor text of
  inbound links — this is how search engines learn to separate the two entities.

## v2.3 — Domain confirmed
Official domain: **rethinkingafrica.africa** (rethinking.africa was unavailable;
hyphenated re-thinking.africa deliberately rejected). All URLs and email addresses
(hello@ / media@ / partnerships@rethinkingafrica.africa) updated. If .com becomes
available later, register it and 301-redirect to the .africa domain.

## v3.0 — Hero portrait, theme illustrations, support section
- Hero redesigned: Dr Damola's circular headshot (assets/dr-damola-headshot.webp,
  40 KB) framed in the brand motif — gold ring with horizon lines extending either
  side, echoing the logo's sun. Text left / portrait right on desktop, stacked on
  mobile. Keep loading="eager" on this image only (it is above the fold).
- Six theme cards now carry lightweight inline SVG illustrations in brand colours
  (zero network cost). These may later be replaced by real photographs (same
  image policy: capability and dignity, WebP <=150 KB) — keep card layout.
- SUPPORT SECTION: "Give once / Give monthly / Sponsor an episode".
  Connect Paystack or Flutterwave for Nigerian cards + PayPal for the diaspora.
  LEGAL WORDING IS DELIBERATE: until CAC (or charity) registration, gifts are
  support for an independent initiative, NOT tax-deductible donations — do not
  change this wording. Publish an annual funds summary to honour the transparency
  promise in the section.
- Pending from Dr Damola: the "Interrupted Sciences" AI image series (indigenous
  clay-pot artisan re-imagined in a modern research environment). When supplied,
  these become the "Africa in pictures" strip and/or a before/after feature on
  the African Futures theme.


## v3.1 — Interrupted Science imagery (from CAAS 2026 deck)
- Five images extracted from Dr Damola's "From Clay Pots to Quantum Futures"
  presentation, optimised to WebP (97-142 KB each):
  interrupted-before / interrupted-after (homepage before-after feature),
  claypot-evolution, ifa-quantum, smart-city ("Africa in pictures" strip + Ideas).
- Homepage gained an "Interrupted Science" before/after section — this is the
  platform's visual thesis; keep it above the themes.
- Ideas page now leads with the CAAS 2026 paper as featured research; link its
  summary/brief when published.
- These are AI-generated speculative images from Dr Damola's own research — per
  the editorial policy, if used in videos or press they carry an AI-imaging
  disclosure. On the site the surrounding text already states the method.

## v3.2 — The Africa Lens Quiz (ad-funnel landing page)
- New page: quiz.html (NOT in main nav; it is the ad destination:
  rethinkingafrica.africa/quiz.html). 7 questions -> 5 profiles -> email gate ->
  result with recommended episode + "Join the Founding 1,000" YouTube CTA.
- CONNECT: the email gate must submit first name, email, AND the winning profile
  tag (KR/BB/SR/ST/FM) to the email provider, so subscribers are tagged by profile
  and enter the 7 Days of Rethinking automation. The manifesto PDF ("Seven Things
  Africa Was Taught to Stop Seeing") attaches to the welcome email.
- Homepage subscribe section reframed as "Join the Founding 1,000".
- Funnel: film -> quiz -> profile + manifesto -> 7-Day series -> Founding 1,000.

## v3.2 - Confirmed social handles
- YouTube:   @DrDamola.Africa   (youtube.com/@DrDamola.Africa)
- Instagram: @DrDamolaAfrica
- TikTok:    @DrDamolaAfrica
- Facebook:  @DrDamolaAfrica    (facebook.com/DrDamolaAfrica)
- X:         @DrDamolaAfrica
- LinkedIn:  company/rethinking-africa-with-dr-damola
All links and the JSON-LD sameAs array are updated. The YouTube handle uses a period
because the unpunctuated version was taken; it reads and sounds identical.
Channel/display name on EVERY platform stays "Rethinking Africa with Dr. Damola".
RA_FILE_EOF_7X2K9

echo "  writing about.html"
cat > "$ROOT/about.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>About | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="What Rethinking Africa is, why it exists, what it does, its intellectual approach, and its founder Dr Damola Adejumo-Ayibiowu.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
    <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html" aria-current="page">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>

<main>
<div class="hero"><div class="wrap"><h1>About Rethinking Africa</h1><p class="lede">Watch. Think. Contribute.</p></div></div>
<hr class="horizon">

<!-- 1. ABOUT RETHINKING AFRICA -->
<section><div class="wrap">
<span class="eyebrow">About Rethinking Africa</span>
<h2>An African-centred research, media and public-education platform</h2>
<p><strong>Rethinking Africa with Dr. Damola</strong> explores the ideas, systems and choices shaping Africa's development. Through research-based commentary, documentary storytelling, interviews, public conversations and creative media, the platform examines how Africans understand themselves, educate their children, organise their institutions, preserve their knowledge and imagine their future.</p>
<p style="font-family:'Fraunces',Georgia,serif;font-size:1.2rem;font-style:italic;margin-top:1.2rem">Africa is not empty of intelligence. Its challenge is that much of its intelligence has not been sufficiently recognised, refined, institutionalised, financed and transformed into collective power.</p>
<p style="margin-top:1.2rem">The platform therefore moves beyond simply describing Africa's problems. It asks how those problems were produced, what sustains them, what knowledge has been neglected and what practical alternatives can be built.</p>
<p style="margin-top:1rem">The full programme concept note is available for download: <a href="#">Programme Concept Note (PDF)</a>.</p>
</div></section>

<!-- 2. WHY WE EXIST -->
<section class="dark"><div class="wrap">
<span class="eyebrow">Why we exist</span>
<h2>Challenging an intellectual imbalance</h2>
<p>Africa is frequently presented through the language of crisis, poverty, corruption, dependency and failure. Although these challenges are real, they do not tell the complete African story. Across the continent, valuable knowledge remains hidden in communities, occupations, languages, cultural practices, indigenous institutions and the lived experiences of ordinary people.</p>
<p>At the same time, education and development systems may train Africans to admire what comes from elsewhere while distrusting what emerges from their own environments. Rethinking Africa was created to challenge that intellectual imbalance.</p>
<p>The purpose is not to romanticise the African past or reject knowledge from other parts of the world. It is to strengthen Africa's capacity to engage the world confidently, draw intelligently from global knowledge and participate without surrendering its voice, memory or agency.</p>
</div></section>
<hr class="horizon">

<!-- 3. WHAT WE DO -->
<section><div class="wrap">
<span class="eyebrow">What we do</span>
<h2>Serious research made public</h2>
<p>Rethinking Africa transforms serious research and lived African experience into accessible public knowledge: research-based video essays, interviews with scholars, practitioners and community knowledge holders, documentaries and field stories, short explainer videos, articles and policy insights, stories of African innovation and enterprise, and intergenerational conversations between elders and young people.</p>
<p style="margin-top:1.2rem"><strong>Every story begins with a question.</strong> Why does African education sometimes disconnect people from their environments? Why do major African projects continue to depend on imported expertise? Why do young people frequently reject the occupations and knowledge of previous generations? How can indigenous knowledge become modern science, industry and enterprise? How can Africa modernise without becoming a copy of another civilisation?</p>
</div></section>

<!-- 4. INTELLECTUAL APPROACH -->
<section class="dark"><div class="wrap">
<span class="eyebrow">Our intellectual approach</span>
<h2>How we think</h2>
<div class="grid">
<div class="terr"><h3>African-centred</h3><p>Africa is treated as a legitimate centre of knowledge, interpretation and possibility.</p></div>
<div class="terr"><h3>Evidence-based</h3><p>Arguments are supported by research, data, history, professional experience and community testimony.</p></div>
<div class="terr"><h3>Critical</h3><p>The platform confronts colonial legacies, global inequalities and internal African failures without sentimentality.</p></div>
<div class="terr"><h3>Constructive</h3><p>Criticism must lead towards alternatives, innovation and action.</p></div>
<div class="terr"><h3>Accessible</h3><p>Complex academic ideas are translated into language everyone can understand.</p></div>
<div class="terr"><h3>Future-oriented</h3><p>Not only what happened to Africa, but what Africa can now recover, rebuild and create.</p></div>
</div>
<p style="margin-top:1.4rem">Read our <a href="editorial.html">editorial and research standards</a>.</p>
</div></section>
<hr class="horizon">

<!-- 5. ABOUT DR DAMOLA -->
<section><div class="wrap">
<span class="eyebrow">The founder</span>
<h2>Meet Dr Damola</h2>
<p style="font-family:'Fraunces',Georgia,serif;font-size:1.15rem;color:var(--indigo);margin-bottom:1rem">Dr Oluwakemi Damola Adejumo-Ayibiowu, PhD</p>
<div class="portrait-row">
<img class="portrait" src="assets/dr-damola-portrait.webp" alt="Dr Oluwakemi Damola Adejumo-Ayibiowu" width="320" height="400" loading="lazy">
<div>
<p><strong>Dr Damola</strong> is a development economist, Afrocentric scholar, AI generalist, public policy strategist and gospel music artist with over 25 years of experience spanning government, academia and international consultancy. Her work is driven by purpose, truth and transformation, and it sits at the intersection of policy reform, decolonised knowledge systems, artificial intelligence and creative expression.</p>
<p>As a scholar, her research explores Afrocentric governance, African renaissance and the decolonisation of knowledge. She is a Senior Postdoctoral Fellow at the University of South Africa (UNISA), deepening her work on indigenous knowledge systems, policy innovation and how emerging technologies like AI can reshape Africa's development trajectory when grounded in local realities, asking not just what technology can do, but who it serves and how it aligns with Africa's renaissance agenda.</p>
</div>
</div>
<p style="margin-top:1.2rem">Her professional journey includes roles in national institutions such as the Central Bank of Nigeria and the Nigerian Revenue Service. Internationally, she has consulted for the World Bank, UNDP, the EU and IFAD on institutional reform, development evaluation and culturally grounded approaches to economic transformation.</p>
<p>She has published and presented across Africa, Europe and North America, and holds a PhD in Development Studies (UNISA), an MSc in Poverty Reduction and Development Management (University of Birmingham, UK) and a BSc in Economics (Obafemi Awolowo University, Nigeria). She is a Prosci&reg; Certified Change Management Practitioner and a member of AIKRN, CITN, NIM, ANAN and NES.</p>
<p>Beyond academia and policy, she is a songwriter and founder of the Oratorio Music Foundation (est. 1996), through which she has mentored young people and led campus-based gospel music initiatives. As the daughter of the legendary Nigerian comedian Baba Sala, she carries forward a family legacy of creative impact through music and comedy released under the name Oyindamola.</p>
<p>Across all she does, Dr Damola seeks to advance Africa-centred scholarship and AI applications that challenge dominant paradigms; reform public sector systems for equity, accountability and national growth; nurture Afrocentric leadership that fuses wisdom, technology and cultural values; and use music and mentorship to draw hearts back to God and inspire transformation.</p>
<p><strong>ORCID iD:</strong> <a href="https://orcid.org/0000-0001-5086-7364">0000-0001-5086-7364</a> &middot; <a href="publications.html">View all publications</a></p>
</div>
</section>

<!-- 6. JOIN THE CONVERSATION -->
<section class="dark"><div class="wrap">
<span class="eyebrow">Join the conversation</span>
<h2>Not a platform where one person speaks</h2>
<p>Rethinking Africa is a growing community of scholars, students, professionals, artists, entrepreneurs, policymakers, artisans, elders, young people and members of the African diaspora.</p>
<p>You are invited to propose a story or episode, participate in an interview, contribute a research reflection, recommend a scholar or practitioner, share a community innovation, identify neglected African knowledge, suggest solutions to development challenges, or partner on research, media and public-engagement projects.</p>
<p style="font-family:'Fraunces',Georgia,serif;font-size:1.2rem;font-style:italic;margin-top:1.2rem">Africa must not only be studied. Africa must speak, think, create and determine.</p>
<p style="margin-top:1.4rem"><a class="btn btn-solid" href="contribute.html">Contribute</a> <a class="btn btn-ghost" href="index.html#subscribe" style="margin-left:.5rem">Join the community</a></p>
</div></section>
</main>

<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body>
</html>
RA_FILE_EOF_7X2K9

echo "  writing african-voices.html"
cat > "$ROOT/african-voices.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>African Voices | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Featured African voices, conference conversations and the community wall on Rethinking Africa with Dr. Damola.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
    <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html" aria-current="page">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>

<main>
<div class="hero"><div class="wrap"><h1>African Voices</h1><p class="lede">Scholars, artisans, students, entrepreneurs, elders, policymakers and the diaspora. The platform is a table with many seats.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Featured voice</span>
<h2>This month's featured African voice</h2>
<p style="max-width:62ch">Each month one person: a scholar, an artisan, a student, an entrepreneur,
an elder, a policymaker, or someone in the diaspora. A photograph, a short biography, one thing they
said that stayed with us, and a clip of the conversation.</p>
<p style="margin-top:1.2rem"><a class="btn btn-navy" href="contribute.html">Recommend someone</a></p>

<!-- ===================================================================
     HOW TO ADD A FEATURED VOICE
     Uncomment this block, duplicate per person, replace the photo file.
     =================================================================== -->
<!--
<div class="portrait-row" style="margin-top:1.8rem">
<img class="portrait" src="assets/GUEST-PHOTO.webp" alt="Portrait of the featured guest" width="320" height="400" loading="lazy">
<div>
<p class="note" style="letter-spacing:.1em;text-transform:uppercase">Name, role, institution</p>
<p style="font-family:'Fraunces',Georgia,serif;font-size:1.25rem;font-style:italic;margin-top:.5rem">"The quotation."</p>
<p style="margin-top:.8rem">Two sentences of biography.</p>
</div>
</div>
-->
</div></section>

<section class="dark"><div class="wrap">
<span class="eyebrow">Conference conversations</span>
<h2>One Question for Africa</h2>
<p>Interviews recorded at conferences and public gatherings, where each guest answers one question that Africa must answer.</p>
<div class="grid" style="margin-top:1.4rem">
<div class="card"><h3>Canada Conversations 2026</h3><p>Conversations recorded with scholars and practitioners in Canada.</p><p style="margin-top:.7rem"><a href="canada-2026.html">Enter the collection</a></p></div>
<div class="card"><h3>More collections</h3><p>New conference collections will appear here as the programme travels.</p></div>
</div>
</div></section>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Voices from the community</span>
<h2>The Rethinking Wall</h2>
<p style="max-width:62ch">Readers answer one question each month. Selected responses are published
here, with permission, so the platform carries more than one voice.</p>

<!-- HOW TO ADD A RESPONSE: uncomment and duplicate one article block, with consent on file. -->
<!--
<article class="post"><div class="meta">Country, first name</div><p>"The selected response."</p></article>
-->

<p style="margin-top:1.4rem"><a class="btn btn-navy" href="contribute.html">Add your voice</a></p>
</div></section>
</main>

<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body>
</html>
RA_FILE_EOF_7X2K9

echo "  writing canada-2026.html"
cat > "$ROOT/canada-2026.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Canada Conversations 2026 | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="One Question for Africa: interviews recorded in Canada in 2026.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
    <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>

<main>
<div class="hero"><div class="wrap"><h1>One Question for Africa: Canada Conversations 2026</h1><p class="lede">Interviews recorded with scholars, practitioners and members of the diaspora in Canada.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">The collection</span>
<h2>Conversations</h2>
<p style="max-width:62ch">Interviews recorded with scholars, practitioners and members of the
diaspora in Canada. Each conversation answers one question that Africa must answer. The recordings
are being edited and will be published here.</p>

<!-- ===================================================================
     HOW TO ADD AN INTERVIEW
     Uncomment and duplicate one card per guest. Add the YouTube embed
     where the placeholder sits, using a click-to-play thumbnail.
     =================================================================== -->
<!--
<div class="card" style="margin-top:1rem">
<h3>Guest name</h3>
<p class="note">Institution, research field</p>
<div class="video-frame" style="margin:1rem 0"><div class="placeholder">Interview</div></div>
<p style="font-family:'Fraunces',Georgia,serif;font-style:italic">"Central quotation."</p>
</div>
-->

<p style="margin-top:1.4rem"><a class="btn btn-navy" href="quiz.html">Be told when they are published</a></p>
</div></section>
<section class="dark"><div class="wrap" style="text-align:center">
<h2>Were you part of these conversations?</h2>
<p style="max-width:52ch;margin:0 auto 1.4rem">Guests may request their approved photographs, quotations or corrections at any time.</p>
<a class="btn btn-solid" href="contact.html">Contact the programme</a>
</div></section>
</main>

<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body>
</html>
RA_FILE_EOF_7X2K9

echo "  writing community.html"
cat > "$ROOT/community.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Join the Community | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Email, WhatsApp Channel, LinkedIn and events for the Rethinking Africa with Dr. Damola community.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
        <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>
<main>
<div class="hero"><div class="wrap"><h1>Join the community</h1><p class="lede">Wherever you are, whether Lagos, Nairobi, London or Atlanta, there is a place in this conversation.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Stay connected</span>
<h2>Choose your channel</h2>
<div class="grid">
<div class="card"><h3>Email: 7 Days of Rethinking</h3><p>The free series plus regular updates, briefs and new episodes.</p><p style="margin-top:.7rem"><a href="quiz.html">Take the quiz and join the mailing list</a></p></div>
<div class="card"><h3>WhatsApp Channel</h3><p>Short updates and one powerful question at a time, built for African mobile life.</p><p style="margin-top:.7rem"><a href="#">Follow on WhatsApp</a></p></div>
<div class="card"><h3>LinkedIn Newsletter</h3><p>For researchers, professionals and policymakers.</p><p style="margin-top:.7rem"><a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">Subscribe on LinkedIn</a></p></div>
<div class="card"><h3>YouTube</h3><p>All episodes, series and shorts.</p><p style="margin-top:.7rem"><a href="https://www.youtube.com/@DrDamola.Africa">Subscribe on YouTube</a></p></div>
</div>
</div></section>
<section class="dark"><div class="wrap">
<span class="eyebrow">Coming together</span>
<h2>Events and public conversations</h2>
<p>Public dialogues, campus conversations and conference sessions will be announced here and on the mailing list. If your institution would like to host one, visit the <a href="contribute.html">Contribute</a> page.</p>
</div></section>
</main>
<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body></html>
RA_FILE_EOF_7X2K9

echo "  writing contact.html"
cat > "$ROOT/contact.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact and Media | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Official contacts and media kit for Rethinking Africa with Dr. Damola.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
        <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html" aria-current="page">Contact</a>
    </nav>
  </div>
</header>
<main>
<div class="hero"><div class="wrap"><h1>Contact &amp; media</h1><p class="lede">For partnerships, interviews, speaking invitations and press.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Reach us</span>
<h2>Official contacts</h2>
<div class="grid">
<div class="card"><h3>General enquiries</h3><p><a href="mailto:hello@rethinkingafrica.africa">hello@rethinkingafrica.africa</a></p></div>
<div class="card"><h3>Partnerships</h3><p><a href="mailto:partnerships@rethinkingafrica.africa">partnerships@rethinkingafrica.africa</a></p></div>
<div class="card"><h3>Interview &amp; press requests</h3><p><a href="mailto:media@rethinkingafrica.africa">media@rethinkingafrica.africa</a></p></div>
<div class="card"><h3>Speaking invitations</h3><p>Use the <a href="contribute.html">Contribute form</a> and choose "Invite Dr Damola to speak".</p></div>
</div>
</div></section>
<section class="dark"><div class="wrap">
<span class="eyebrow">Media kit</span>
<h2>Downloads for press and partners</h2>
<div class="grid">
<div class="card"><h3>Biography</h3><p>Approved short and long biography of Dr. Damola. <a href="#">Download (PDF)</a></p></div>
<div class="card"><h3>Approved photographs</h3><p>High-resolution portraits for press use. <a href="#">Download (ZIP)</a></p></div>
<div class="card"><h3>Programme logo</h3><p>Official logo package with usage guidelines. <a href="assets/logo-primary-stacked.svg">Download (SVG)</a></p></div>
<div class="card"><h3>One-page media profile</h3><p>The programme at a glance for editors and producers. <a href="#">Download (PDF)</a></p></div>
</div>
</div></section>
</main>
<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body></html>
RA_FILE_EOF_7X2K9

echo "  writing contribute.html"
cat > "$ROOT/contribute.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contribute | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Propose an episode, submit a story, recommend a guest or partner with Rethinking Africa with Dr. Damola.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
        <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html" aria-current="page">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>
<main>
<div class="hero"><div class="wrap"><h1>Contribute</h1><p class="lede">Propose, submit, recommend, challenge. The platform is built with its community, not just for it.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Ways to take part</span>
<h2>How you can contribute</h2>
<div class="grid">
<div class="terr"><h3>Propose an episode</h3><p>A strong observation, contradiction or human story.</p></div>
<div class="terr"><h3>Submit a lived experience</h3><p>A personal story that reveals a larger African question.</p></div>
<div class="terr"><h3>Recommend a guest</h3><p>Researchers, artisans, elders, officials, young innovators.</p></div>
<div class="terr"><h3>Contribute a research essay</h3><p>Evidence-based writing, including constructive disagreement.</p></div>
<div class="terr"><h3>Share an African innovation</h3><p>Enterprises, institutions or practices worth documenting.</p></div>
<div class="terr"><h3>Volunteer or partner</h3><p>Research, interviewing, production, or institutional partnership.</p></div>
</div>
</div></section>
<section class="dark"><div class="wrap">
<span class="eyebrow">Structured submission</span>
<h2>Share your story</h2>
<p style="margin-bottom:1.4rem">Use this form rather than unstructured messages; it helps the editorial team respond properly to every submission.</p>
<!-- ===================================================================
     DEVELOPER: set FORM_ENDPOINT below to the Formspree / Web3Forms URL.
     Nothing else on this page needs to change.
     =================================================================== -->
<form id="contribForm" novalidate>
<div class="field"><label for="c-name">Your name</label><input id="c-name" name="name" type="text" required></div>
<div class="field"><label for="c-email">Email</label><input id="c-email" name="email" type="email" required></div>
<div class="field"><label for="c-wa">WhatsApp number (optional)</label><input id="c-wa" name="whatsapp" type="tel" placeholder="+234 800 000 0000"></div>
<div class="field"><label for="c-country">Country</label><input id="c-country" name="country" type="text"></div>
<div class="field"><label for="c-type">Type of contribution</label>
<select id="c-type" name="type" required>
<option value="">Choose one...</option>
<option>Propose an episode</option>
<option>Submit a lived experience</option>
<option>Recommend a guest</option>
<option>Contribute a research essay</option>
<option>Share an African innovation</option>
<option>Volunteer as researcher or interviewer</option>
<option>Institutional partnership</option>
<option>Invite Dr Damola to speak</option>
</select></div>
<div class="field"><label for="c-msg">Your story, proposal or message</label><textarea id="c-msg" name="message" required></textarea></div>
<button class="btn btn-solid" type="submit" id="c-btn">Submit contribution</button>
<p class="note" id="c-status" style="margin-top:.9rem"></p>
</form>

<div id="c-thanks" style="display:none">
<h3 style="color:var(--ivory)">Thank you. Your contribution has arrived.</h3>
<p style="margin-top:.7rem">We read every submission. If it fits a current or planned episode, we will
write back to you. That can take a little time, because each one is read properly rather than sorted
by a machine.</p>
<p style="margin-top:1rem">While you wait, the quiz will tell you which kind of African future-builder
you are, and start the free seven-day series.</p>
<p style="margin-top:1.2rem"><a class="btn btn-solid" href="quiz.html">Take the quiz</a>
<a class="btn btn-ghost" href="https://www.youtube.com/@DrDamola.Africa?sub_confirmation=1" style="margin-left:.5rem">Subscribe on YouTube</a></p>
</div>

<script>
/* DEVELOPER: paste the form endpoint URL here. Formspree or Web3Forms both work. */
const FORM_ENDPOINT = "";          // Formspree / Web3Forms URL: stores every submission
const CONTRIB_LIST_ACTION = "";    // MailerLite "Contributors" form action: sends the acknowledgement

document.getElementById('contribForm').addEventListener('submit', function(e){
  e.preventDefault();
  const status = document.getElementById('c-status');
  const btn = document.getElementById('c-btn');
  const data = {
    name:     document.getElementById('c-name').value.trim(),
    email:    document.getElementById('c-email').value.trim(),
    whatsapp: document.getElementById('c-wa').value.trim(),
    country:  document.getElementById('c-country').value.trim(),
    type:     document.getElementById('c-type').value,
    message:  document.getElementById('c-msg').value.trim(),
    source:   'Contribute page'
  };

  if(!data.name || data.email.indexOf('@') < 1 || !data.type || !data.message){
    status.style.color = '#F0B345';
    status.textContent = 'Please complete your name, email, type of contribution and message.';
    return;
  }
  if(!FORM_ENDPOINT){
    status.style.color = '#F0B345';
    status.textContent = 'This form is not connected yet. Please write to hello@rethinkingafrica.africa.';
    return;
  }

  btn.disabled = true;
  status.style.color = '';
  status.textContent = 'Sending...';

  // Push the contributor into the MailerLite "Contributors" group so the
  // acknowledgement email is sent automatically.
  if (CONTRIB_LIST_ACTION){
    const f = document.createElement('form');
    f.action = CONTRIB_LIST_ACTION; f.method = 'post'; f.target = 'ml_contrib';
    [['fields[email]', data.email], ['fields[name]', data.name],
     ['fields[country]', data.country], ['fields[type]', data.type]].forEach(function(p){
      const i = document.createElement('input');
      i.type = 'hidden'; i.name = p[0]; i.value = p[1]; f.appendChild(i);
    });
    const sink = document.createElement('iframe');
    sink.name = 'ml_contrib'; sink.style.display = 'none';
    document.body.appendChild(sink); document.body.appendChild(f); f.submit();
  }

  fetch(FORM_ENDPOINT, {
    method: 'POST',
    headers: {'Content-Type':'application/json','Accept':'application/json'},
    body: JSON.stringify(data)
  }).then(function(r){
    if(!r.ok) throw new Error('failed');
    document.getElementById('contribForm').style.display = 'none';
    document.getElementById('c-thanks').style.display = 'block';
    document.getElementById('c-thanks').scrollIntoView({behavior:'smooth', block:'center'});
  }).catch(function(){
    btn.disabled = false;
    status.style.color = '#F0B345';
    status.textContent = 'Something went wrong. Please try again, or write to hello@rethinkingafrica.africa.';
  });
});
</script>
</div></section>
</main>
<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body></html>
RA_FILE_EOF_7X2K9

echo "  writing editorial.html"
cat > "$ROOT/editorial.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Editorial Standards | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="How Rethinking Africa verifies research, selects sources, handles corrections and protects contributors.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
    <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>

<main>
<div class="hero"><div class="wrap"><h1>Editorial Standards</h1><p class="lede">The platform sits between scholarship, journalism, documentary and public education. These standards keep it trustworthy.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Our standards</span>
<h2>How we work</h2>
<div class="grid">
<div class="terr"><h3>Research verification</h3><p>Claims are supported by credible research, historical records, data, field observation or community testimony before publication.</p></div>
<div class="terr"><h3>Source selection</h3><p>We favour primary sources, peer-reviewed work and named expertise, and clearly distinguish facts from interpretation and speculation.</p></div>
<div class="terr"><h3>Corrections</h3><p>Verified errors are corrected promptly and visibly on the relevant page or episode description. Corrections may be requested at hello@rethinkingafrica.africa.</p></div>
<div class="terr"><h3>Guest representation</h3><p>Guests are quoted in context, informed of how material will be used, and may review their approved photographs and quotations.</p></div>
<div class="terr"><h3>AI &amp; dramatisation disclosure</h3><p>Where artificial intelligence, reenactment or dramatisation is used, it is disclosed in the content itself.</p></div>
<div class="terr"><h3>Protection of contributors</h3><p>Submitted stories are handled confidentially; nothing is published without consent, and identities are protected on request.</p></div>
</div>
</div></section>
<section class="dark"><div class="wrap">
<span class="eyebrow">Citation policy</span>
<h2>References and reading lists</h2>
<p>Major episodes carry their references and reading lists on the <a href="ideas.html">Ideas</a> page, so viewers, students and researchers can verify sources and go deeper.</p>
</div></section>
</main>

<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body>
</html>
RA_FILE_EOF_7X2K9

echo "  writing ideas.html"
cat > "$ROOT/ideas.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Ideas and Research | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Articles, research summaries, reading lists and briefs from Rethinking Africa with Dr. Damola.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
        <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html" aria-current="page">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>
<main>
<div class="hero"><div class="wrap"><h1>Ideas &amp; Research</h1><p class="lede">The written spine of the programme. This is what distinguishes it from opinion-based channels.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Featured research</span>
<h2>From the CAAS 2026 conference</h2>
<div class="card" style="margin-bottom:2rem">
<img src="assets/claypot-evolution.webp" alt="The clay pot reimagined as advanced material science" style="width:100%;border-radius:3px;margin-bottom:1rem" loading="lazy">
<h3>From Clay Pots to Quantum Futures: Rethinking African Science, Innovation, and Global Belonging</h3>
<p class="note" style="margin:.3rem 0 .7rem">Dr Oluwakemi Damola Adejumo-Ayibiowu · CAAS Conference 2026</p>
<p>African knowledge was not pre-scientific; it was scientific, empirical, experimental and adaptive. What disrupted it was violent interruption, not internal failure. This paper uses speculative design and AI imaging to project indigenous sciences (the clay pot's thermodynamics, Ifá's binary combinatorics, Great Zimbabwe's engineering, Aroko's semiotic networks) into quantum-era futures, and proposes six epistemic principles of African scientific reasoning.</p>
<p style="margin-top:.7rem"><a href="#">Read the summary</a> · <a href="#">Download the brief (PDF)</a></p>
</div>
<span class="eyebrow">The library</span>
<h2>What you will find here</h2>
<div class="grid">
<div class="card"><h3>Articles &amp; policy reflections</h3><p>African-centred analysis of education, work, governance and culture.</p></div>
<div class="card"><h3>Research summaries</h3><p>Key academic findings, translated into accessible public knowledge.</p></div>
<div class="card"><h3>Episode reading lists &amp; references</h3><p>Every source used in an episode, listed so viewers can verify and go deeper.</p></div>
<div class="card"><h3>Downloadable briefs</h3><p>One-page research and policy briefs for educators, officials and practitioners.</p></div>
</div>
<p style="margin-top:1.6rem">Invited scholars contribute essays and evidence-based critiques. To propose a contribution, visit the <a href="contribute.html">Contribute</a> page.</p>
</div></section>
<section class="dark"><div class="wrap" style="text-align:center">
<h2>First publications arriving with the launch episodes</h2>
<p style="max-width:50ch;margin:0 auto 1.4rem">Join the mailing list to receive new briefs and reading lists as they are published.</p>
<a class="btn btn-solid" href="index.html#subscribe">Join the mailing list</a>
</div></section>
</main>
<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body></html>
RA_FILE_EOF_7X2K9

echo "  writing index.html"
cat > "$ROOT/index.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Rethinking Africa with Dr. Damola | Reclaiming Intelligence. Reimagining the Future.</title>
<meta name="description" content="A research-driven media platform exploring African development, knowledge, governance, culture and possibility from an African-centred perspective.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<meta property="og:site_name" content="Rethinking Africa with Dr. Damola">
<meta property="og:title" content="Rethinking Africa with Dr. Damola">
<meta property="og:description" content="A research-driven media platform founded by Dr Oluwakemi Damola Adejumo-Ayibiowu, exploring African development, knowledge, governance, culture and possibility.">
<meta property="og:type" content="website">
<meta property="og:url" content="https://rethinkingafrica.africa/">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Organization",
      "@id": "https://rethinkingafrica.africa/#org",
      "name": "Rethinking Africa with Dr. Damola",
      "alternateName": "Rethinking Africa with Dr Damola",
      "disambiguatingDescription": "The African-centred research and media platform founded and hosted by Dr Oluwakemi Damola Adejumo-Ayibiowu. Not affiliated with other initiatives using similar names.",
      "url": "https://rethinkingafrica.africa/",
      "logo": "https://rethinkingafrica.africa/assets/logo-primary-stacked.svg",
      "description": "An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.",
      "founder": {"@type": "Person", "name": "Dr Oluwakemi Damola Adejumo-Ayibiowu", "alternateName": "Dr Damola"},
      "email": "hello@rethinkingafrica.africa",
      "sameAs": [
        "https://www.youtube.com/@DrDamola.Africa",
        "https://www.instagram.com/DrDamolaAfrica",
        "https://www.tiktok.com/@DrDamolaAfrica",
        "https://www.facebook.com/DrDamolaAfrica",
        "https://x.com/DrDamolaAfrica",
        "https://www.linkedin.com/company/rethinking-africa-with-dr-damola"
      ]
    },
    {
      "@type": "WebSite",
      "@id": "https://rethinkingafrica.africa/#website",
      "url": "https://rethinkingafrica.africa/",
      "name": "Rethinking Africa with Dr. Damola",
      "publisher": {"@id": "https://rethinkingafrica.africa/#org"}
    }
  ]
}
</script>
</head>
<body>

<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
    <nav class="main" aria-label="Main">
      <a href="index.html" aria-current="page">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>

<main>
  <!-- 1. MAIN MESSAGE + TRAILER -->
  <div class="hero">
    <div class="wrap hero-grid">
      <div>
        <svg class="hero-anim" viewBox="0 0 560 470" role="img" aria-label="Rethinking Africa with Dr. Damola: the sun rising behind the African continent">
        <rect class="a-line" x="10" y="111" width="540" height="6" fill="#E8A11C"/>
        <g class="a-sun"><circle cx="390" cy="115" r="85" fill="#E8A11C"/></g>
        <g class="a-cont"><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></g>
      </svg>
      <p style="font-family:Arial,Helvetica,sans-serif;font-weight:700;font-size:.78rem;letter-spacing:.24em;text-transform:uppercase;color:#E8A11C;margin-bottom:1rem">Rethinking Africa with Dr. Damola</p>
        <h1>Rethinking Africa. Reclaiming Intelligence. Reimagining the Future.</h1>
        <p class="lede">A research-driven media platform exploring African development, knowledge, governance, culture and possibility from an African-centred perspective.</p>
        <div class="cta-row">
          <a class="btn btn-solid" href="watch.html">Watch the Latest Episode</a>
          <a class="btn btn-ghost" href="#subscribe">Join the Community</a>
          <a class="btn btn-ghost" href="contribute.html">Share an Idea</a>
        </div>
      </div>
      <figure class="hero-portrait">
        <div class="ring">
          <img src="assets/dr-damola-headshot.webp" alt="Dr Oluwakemi Damola Adejumo-Ayibiowu, smiling, in an indigo and gold adire-print dress" width="560" height="560" loading="eager">
        </div>
        <figcaption>Dr Oluwakemi Damola Adejumo-Ayibiowu</figcaption>
      </figure>
    </div>
  </div>
  <hr class="horizon">

  <!-- QUIZ BAND: primary destination for viewers arriving from video end cards -->
  <section style="background:#EFE8D6;padding:2.2rem 0">
    <div class="wrap" style="text-align:center">
      <span class="eyebrow">Start here</span>
      <h2 style="max-width:22ch;margin:0 auto .8rem">How were you taught to see Africa?</h2>
      <p style="max-width:52ch;margin:0 auto 1.4rem">Seven questions, about ninety seconds. Discover which of the five African future-building profiles is yours, and receive the free manifesto.</p>
      <a class="btn btn-navy" href="quiz.html">Take the Africa Lens Quiz</a>
      <p class="note" style="margin-top:.8rem">Free. No payment, ever.</p>
    </div>
  </section>
  <hr class="horizon">

  <!-- What the platform is + trailer (click-to-play, never autoplay) -->
  <section>
    <div class="wrap">
      <p style="max-width:64ch;font-size:1.1rem"><strong>Rethinking Africa with Dr. Damola</strong> brings research, lived experience and African voices together to examine the systems shaping the continent, and to explore practical pathways towards African agency, excellence and renewal.</p>
      <div class="video-frame" style="margin-top:1.6rem">
        <!-- DEVELOPER: click-to-play YouTube embed (thumbnail facade; loads player only on click). Never autoplay sound. -->
        <div class="placeholder">Programme trailer: press play</div>
      </div>
    </div>
  </section>

  <!-- 2. LATEST EPISODE -->
  <section class="dark">
    <div class="wrap">
      <span class="eyebrow">Latest episode</span>
      <h2>Trained Away</h2>
      <p>Why African education often prepares young people to leave local opportunities rather than transform them, and what an education designed from African realities would do instead.</p>
      <p style="margin-top:1.3rem"><a class="btn btn-solid" href="watch.html">Watch now</a></p>
    </div>
  </section>
  <hr class="horizon">

  <!-- 3. WHY RETHINKING AFRICA EXISTS -->
  <section>
    <div class="wrap">
      <span class="eyebrow">Why we exist</span>
      <h2>Africa is not empty of intelligence</h2>
      <p style="max-width:64ch">Its challenge is that much of its intelligence has not been sufficiently recognised, refined, institutionalised, financed and transformed into collective power. This platform moves beyond describing Africa's problems: it asks how they were produced, what sustains them, what knowledge has been neglected, and what practical alternatives can be built. <a href="about.html">Read more about the vision</a>.</p>
    </div>
  </section>


  <!-- INTERRUPTED SCIENCE - before / after -->
  <section class="dark">
    <div class="wrap">
      <span class="eyebrow">Interrupted science</span>
      <h2>This is not the past. This is interrupted science.</h2>
      <p style="max-width:64ch">The clay pot is not a symbol of poverty; it is an off-grid thermodynamic device, refined through generations of empirical experimentation. Using AI speculative imaging, we project what African sciences should look like today, had their development never been violently interrupted.</p>
      <div class="ba-grid">
        <figure>
          <span class="ba-label was">How the world sees it</span>
          <img src="assets/interrupted-before.webp" alt="Women carrying clay pots along a rural path, the so-called archaic depiction of African knowledge" width="900" height="675" loading="lazy">
          <figcaption>"Subsistence craft": the colonial framing of African knowledge.</figcaption>
        </figure>
        <figure>
          <span class="ba-label is">What it actually is</span>
          <img src="assets/interrupted-after.webp" alt="The same indigenous knowledge reimagined in an advanced research environment: African science continued into the future" width="900" height="675" loading="lazy">
          <figcaption>Thermodynamics, computation, engineering: scientific archives awaiting restoration.</figcaption>
        </figure>
      </div>
      <p style="font-family:'Fraunces',Georgia,serif;font-size:1.2rem;font-style:italic;margin-top:1.6rem">What was interrupted can be restored. What was deferred can be recovered.</p>
      <p style="margin-top:1.2rem"><a class="btn btn-solid" href="ideas.html">Read the research</a></p>
    </div>
  </section>
  <hr class="horizon">

  <!-- AFRICA IN PICTURES - visual story strip -->
  <section class="dark">
    <div class="wrap">
      <span class="eyebrow">Africa in pictures</span>
      <h2>The story we are rethinking</h2>
      <!-- DEVELOPER: replace placeholders with licensed photographs (WebP, <=150 KB each).
           Sources: Dr Damola's own field photos (preferred), iwaria.com, nappy.co,
           unsplash.com - choose images of African work, craft, learning and city life
           that show capability and dignity, never crisis cliches. -->
      <div class="gallery">
        <figure><img src="assets/claypot-evolution.webp" alt="The clay pot evolved: self-cooling zero-carbon material science for future African cities" loading="lazy"><figcaption>The Clay Pot Evolution: traditional wisdom, modern science.</figcaption></figure>
        <figure><img src="assets/ifa-quantum.webp" alt="The Ifá binary system visualised as a quantum computing core: 16 Odù, 256 states" loading="lazy"><figcaption>The Ifá Binary Core: a 1,000-year-old algorithmic engine.</figcaption></figure>
        <figure><img src="assets/smart-city.webp" alt="A future African smart city inspired by the dry-stone engineering of Great Zimbabwe" loading="lazy"><figcaption>From Great Zimbabwe to the smart city: built by Africa, for Africa.</figcaption></figure>
      </div>
    </div>
  </section>
  <hr class="horizon">

  <!-- 4. MAJOR THEMES -->
  <section class="dark">
    <div class="wrap">
      <span class="eyebrow">What we investigate</span>
      <h2>Six major themes</h2>
      <div class="grid cols3">
        <div class="theme-card"><svg viewBox="0 0 64 64" aria-hidden="true"><rect width="64" height="64" rx="8" fill="#F7F1E3" opacity="0.06"/><path d="M32 14 L56 24 L32 34 L8 24 Z" fill="#E8A11C"/><path d="M18 30 v10 c0 4 28 4 28 0 v-10 l-14 6 z" fill="#F7F1E3" opacity=".85"/><rect x="52" y="24" width="3" height="16" fill="#E8A11C"/></svg><h3>Education &amp; Knowledge</h3><p>How education shapes African identity, ambition, work and possibility.</p></div>
        <div class="theme-card"><svg viewBox="0 0 64 64" aria-hidden="true"><rect width="64" height="64" rx="8" fill="#F7F1E3" opacity="0.06"/><rect x="12" y="46" width="40" height="5" fill="#E8A11C"/><rect x="16" y="28" width="6" height="16" fill="#F7F1E3" opacity=".85"/><rect x="29" y="28" width="6" height="16" fill="#F7F1E3" opacity=".85"/><rect x="42" y="28" width="6" height="16" fill="#F7F1E3" opacity=".85"/><path d="M10 26 L32 12 L54 26 Z" fill="#E8A11C"/></svg><h3>Governance &amp; Institutions</h3><p>How African states can build credible, accountable and culturally grounded systems.</p></div>
        <div class="theme-card"><svg viewBox="0 0 64 64" aria-hidden="true"><rect width="64" height="64" rx="8" fill="#F7F1E3" opacity="0.06"/><path d="M22 24 c-4 14 2 24 10 24 s14-10 10-24 c-3 2 -17 2 -20 0 z" fill="#F7F1E3" opacity=".85"/><ellipse cx="32" cy="22" rx="11" ry="4" fill="#E8A11C"/><circle cx="49" cy="17" r="6" fill="#E8A11C"/><path d="M45 13 l8 8 M53 13 l-8 8" stroke="#1D2A57" stroke-width="1.6"/></svg><h3>Indigenous Knowledge &amp; Innovation</h3><p>How inherited knowledge can become contemporary science, enterprise and industry.</p></div>
        <div class="theme-card"><svg viewBox="0 0 64 64" aria-hidden="true"><rect width="64" height="64" rx="8" fill="#F7F1E3" opacity="0.06"/><path d="M14 44 L34 24 l6 6 -20 20 z" fill="#F7F1E3" opacity=".85"/><path d="M34 16 l14 -4 6 6 -4 14 -8 -8 z" fill="#E8A11C"/><circle cx="46" cy="46" r="7" fill="none" stroke="#E8A11C" stroke-width="3"/></svg><h3>Work, Production &amp; Excellence</h3><p>Why Africa imports expertise and how local capability can be strengthened.</p></div>
        <div class="theme-card"><svg viewBox="0 0 64 64" aria-hidden="true"><rect width="64" height="64" rx="8" fill="#F7F1E3" opacity="0.06"/><ellipse cx="32" cy="30" rx="13" ry="17" fill="#F7F1E3" opacity=".85"/><circle cx="27" cy="26" r="2.4" fill="#1D2A57"/><circle cx="37" cy="26" r="2.4" fill="#1D2A57"/><path d="M26 37 q6 4 12 0" stroke="#1D2A57" stroke-width="2" fill="none"/><path d="M32 8 v6 M20 12 l3 5 M44 12 l-3 5" stroke="#E8A11C" stroke-width="3"/><rect x="20" y="50" width="24" height="3" fill="#E8A11C"/></svg><h3>Culture, Identity &amp; African Agency</h3><p>How language, media, religion and global power shape African self-perception.</p></div>
        <div class="theme-card"><svg viewBox="0 0 64 64" aria-hidden="true"><rect width="64" height="64" rx="8" fill="#F7F1E3" opacity="0.06"/><rect x="12" y="30" width="9" height="20" fill="#F7F1E3" opacity=".85"/><rect x="25" y="22" width="9" height="28" fill="#F7F1E3" opacity=".85"/><rect x="38" y="14" width="9" height="36" fill="#F7F1E3" opacity=".85"/><circle cx="52" cy="14" r="5" fill="#E8A11C"/><rect x="10" y="52" width="44" height="3" fill="#E8A11C"/></svg><h3>African Futures</h3><p>How Africans can design cities, institutions, technologies and economies rooted in their realities.</p></div>
      </div>
    </div>
  </section>
  <hr class="horizon">

  <!-- 5. THE QUESTION AFRICA MUST ANSWER -->
  <section>
    <div class="wrap" style="text-align:center">
      <span class="eyebrow">The question Africa must answer</span>
      <h2 id="rotating-question" style="max-width:26ch;margin:0 auto 1.2rem">What knowledge did your parents possess that your generation failed to inherit?</h2>
      <a class="btn btn-navy" href="contribute.html">Submit your answer</a>
      <p class="note" style="margin-top:.9rem">Selected responses appear on the site with the contributor's permission.</p>
    </div>
  </section>

  <!-- 6. FEATURED AFRICAN VOICE -->
  <section class="dark">
    <div class="wrap">
      <span class="eyebrow">African voices</span>
      <h2>Many voices, one table</h2>
      <p style="max-width:60ch">Scholars, artisans, students, entrepreneurs, elders, policymakers
      and the diaspora. Each month this platform features one African voice and the knowledge they
      carry. If that is you, or someone you know, tell us.</p>
      <p style="margin-top:1.4rem"><a class="btn btn-solid" href="contribute.html">Recommend a voice</a>
      <a class="btn btn-ghost" href="african-voices.html" style="margin-left:.5rem">See the collection</a></p>
    </div>
  </section>
  <hr class="horizon">

  <!-- 7. LATEST WRITING & FROM THE FIELD -->
  <section>
    <div class="wrap">
      <span class="eyebrow">Ideas and research</span>
      <h2>The written work</h2>
      <p style="max-width:62ch">Articles, research summaries, reading lists and downloadable briefs
      sit alongside the episodes. This is what separates the platform from commentary: every claim
      can be traced to a source.</p>
      <p style="margin-top:1.4rem"><a class="btn btn-navy" href="ideas.html">Read the ideas</a>
      <a class="btn btn-navy" href="publications.html" style="margin-left:.5rem;background:transparent;color:var(--indigo);border-color:var(--gold)">Peer-reviewed publications</a></p>
    </div>
  </section>

  <!-- 8. WAYS TO CONTRIBUTE -->
  <section class="dark">
    <div class="wrap" style="text-align:center">
      <span class="eyebrow">Join the work</span>
      <h2>Africa's future cannot be imagined by one voice</h2>
      <p style="max-width:54ch;margin:0 auto 1.6rem">Bring your research, experience, question or story into the conversation.</p>
      <div class="cta-row" style="flex-wrap:wrap">
        <a class="btn btn-solid" href="contribute.html">Propose an Episode</a>
        <a class="btn btn-ghost" href="contribute.html">Recommend a Guest</a>
        <a class="btn btn-ghost" href="contribute.html">Submit an Article</a>
      </div>
      <div class="cta-row" style="flex-wrap:wrap;margin-top:.8rem">
        <a class="btn btn-ghost" href="contribute.html">Share an African Innovation</a>
        <a class="btn btn-ghost" href="contribute.html">Volunteer or Collaborate</a>
        <a class="btn btn-ghost" href="contribute.html">Invite Dr Damola</a>
      </div>
    </div>
  </section>
  <hr class="horizon">

  <!-- 9. ABOUT DR DAMOLA -->
  <section>
    <div class="wrap">
      <span class="eyebrow">The founder</span>
      <h2>Meet Dr Damola</h2>
      <p style="font-family:'Fraunces',Georgia,serif;font-size:1.15rem;color:var(--indigo);margin-bottom:1rem">Dr Oluwakemi Damola Adejumo-Ayibiowu</p>
      <div class="portrait-row">
        <img class="portrait" src="assets/dr-damola-portrait.webp" alt="Dr Oluwakemi Damola Adejumo-Ayibiowu, wearing an indigo and gold adire-print dress" width="320" height="400" loading="lazy">
        <div>
          <p>Dr Damola is a development economist, Afrocentric scholar, AI generalist, public policy strategist and gospel music artist with over 25 years of experience across government, academia and international consultancy. Through Rethinking Africa she brings scholarship out of restricted academic spaces and into public conversation.</p>
          <p style="margin-top:1rem"><a class="btn btn-navy" href="about.html">Read the full story</a></p>
        </div>
      </div>
      <p style="margin-top:1.6rem;max-width:64ch"><em>For scholars, students, policymakers, professionals, creators, community leaders, members of the diaspora, and everyone committed to Africa's intellectual and developmental renewal.</em></p>
    </div>
  </section>

  <!-- 10. NEWSLETTER SUBSCRIPTION -->
  <section class="dark" id="subscribe">
    <div class="wrap" style="text-align:center">
      <span class="eyebrow">Join the community</span>
      <h2>Join the Founding 1,000</h2>
      <p style="max-width:56ch;margin:0 auto 1.4rem">Be among the first thousand members of a movement to recover African intelligence and agency. Discover African-centred perspectives grounded in research, watch conversations with scholars and practitioners, and receive new episodes, articles and event invitations, beginning with the free <strong>7 Days of Rethinking</strong> series.</p>
      <!-- DEVELOPER: wire to email provider; keep fields to exactly these four -->
      <!-- DEVELOPER: replace action with your MailerLite / ConvertKit embedded form URL.
           This is a normal HTML form post. It needs no server of our own. -->
      <form action="REPLACE_WITH_MAILING_LIST_ACTION" method="post" style="max-width:460px;margin:0 auto;text-align:left">
        <div class="field"><label for="s-name">First name</label><input id="s-name" name="fields[name]" type="text" required></div>
        <div class="field"><label for="s-email">Email</label><input id="s-email" name="fields[email]" type="email" required></div>
        <div class="field"><label for="s-wa">WhatsApp number (optional)</label><input id="s-wa" name="fields[whatsapp]" type="tel" placeholder="+234 800 000 0000"></div>
        <div class="field"><label for="s-country">Country</label><input id="s-country" name="fields[country]" type="text"></div>
        <div class="field"><label for="s-interest">Area of interest</label>
          <select id="s-interest" name="fields[interest]">
            <option>Education &amp; Knowledge</option>
            <option>Governance &amp; Institutions</option>
            <option>Indigenous Knowledge &amp; Innovation</option>
            <option>Work, Production &amp; Excellence</option>
            <option>Culture, Identity &amp; African Agency</option>
            <option>African Futures</option>
          </select></div>
        <div style="text-align:center;margin-top:1.2rem">
          <button class="btn btn-solid" type="submit">Subscribe</button>
          <a class="btn btn-ghost" href="quiz.html" style="margin-left:.5rem">Take the quiz first</a>
        </div>
      </form>
      <p class="note" style="margin-top:.9rem">No spam. Unsubscribe any time.</p>
    </div>
  </section>
  <hr class="horizon">


  <!-- SUPPORT THE INITIATIVE -->
  <section class="dark support-band">
    <div class="wrap" style="text-align:center">
      <span class="eyebrow">Support the work</span>
      <h2>Help this initiative grow</h2>
      <p style="max-width:56ch;margin:0 auto 1.6rem">Rethinking Africa with Dr. Damola is an independent initiative. Your support funds research, production, translation and the documentation of African knowledge, and it keeps this platform free for students and communities across the continent.</p>
      <div class="cta-row" style="flex-wrap:wrap">
        <!-- DEVELOPER: connect Paystack/Flutterwave (Nigeria) and PayPal (diaspora) -->
        <a class="btn btn-solid" href="#">Give once</a>
        <a class="btn btn-ghost" href="#">Give monthly</a>
        <a class="btn btn-ghost" href="contact.html">Sponsor an episode</a>
      </div>
      <p class="note" style="margin-top:1rem;max-width:60ch;margin-left:auto;margin-right:auto">Gifts support an independent educational initiative and are not tax-deductible charitable donations. A summary of how funds are used is published annually on this site.</p>
    </div>
  </section>
  <hr class="horizon">

  <!-- 11. PARTNERS -->
  <section>
    <div class="wrap" style="text-align:center">
      <span class="eyebrow">Institutions &amp; partners</span>
      <h2>Partner with Rethinking Africa</h2>
      <p style="max-width:56ch;margin:0 auto 1.4rem">Universities, research centres, cultural institutions, media organisations and development bodies are invited to collaborate on research, media and public-engagement projects.</p>
      <a class="btn btn-navy" href="contact.html">Start a conversation</a>
    </div>
  </section>
</main>

<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>

<script>
// Rotating question: one question chosen per visit. No timers, no motion.
(function(){
  var qs=[
    "What knowledge did your parents possess that your generation failed to inherit?",
    "What is one thing African education trains us to leave behind?",
    "Can Africa modernise without becoming someone else?"
  ];
  var el=document.getElementById('rotating-question');
  if(el){el.textContent=qs[Math.floor(Math.random()*qs.length)];}
})();
</script>
</body>
</html>
RA_FILE_EOF_7X2K9

echo "  writing news.html"
cat > "$ROOT/news.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>News and Events | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Announcements, blog posts, and events from Rethinking Africa with Dr. Damola.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
        <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html" aria-current="page">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>
<main>
<div class="hero"><div class="wrap"><h1>News &amp; Events</h1><p class="lede">Announcements, reflections from the road, and the conversations we joined across Africa and the diaspora.</p></div></div>
<hr class="horizon">

<section><div class="wrap">
<span class="eyebrow">Announcements</span>
<h2>Latest announcements</h2>

<!-- ===================================================================
     HOW TO ADD AN ANNOUNCEMENT
     Copy one whole <div class="announce"> block, paste it directly BELOW
     this comment so the newest sits at the top, then edit the date and text.
     Delete the "nothing yet" block below once a real announcement exists.
     =================================================================== -->

<div class="announce"><span class="meta">Announcement</span>
<p><strong>The 7 Days of Rethinking series is open.</strong> The free email series is
accepting subscribers now, ahead of the channel launch. <a href="quiz.html">Take the
quiz</a> to join it.</p></div>

<div class="announce"><span class="meta">Announcement</span>
<p><strong>Launch week is coming.</strong> The first episodes of Rethinking Africa will
arrive together rather than one at a time. Dates will be announced here and to the
mailing list first.</p></div>

</div></section>

<section class="dark"><div class="wrap">
<span class="eyebrow">Blog</span>
<h2>From the desk of Dr. Damola</h2>

<!-- ===================================================================
     HOW TO ADD A BLOG POST
     Copy one whole <article class="post"> block, paste it directly BELOW
     this comment so the newest is first, then edit the date, title and summary.
     Set href to the article page when one exists.
     =================================================================== -->

<p style="max-width:60ch">Written reflections between episodes: the thinking behind the
programme, notes from the field, and essays that did not fit inside a video. The first
pieces arrive with the launch.</p>
<p style="margin-top:1.2rem"><a class="btn btn-solid" href="quiz.html">Get them by email</a></p>

</div></section>
<hr class="horizon">

<section><div class="wrap">
<span class="eyebrow">Events</span>
<h2>Events we attended and hosted</h2>
<p style="max-width:64ch">Conferences, campus conversations and public dialogues,
documented so the community can follow the programme's journey. Photographs and
write-ups from each gathering will appear here.</p>

<!-- ===================================================================
     HOW TO ADD AN EVENT
     Uncomment the block below and duplicate it for each event.
     Replace the image files with real photographs: WebP, 150 KB maximum,
     saved into the assets folder. Write a real caption for every photo.
     =================================================================== -->
<!--
<h3 style="margin-top:1.8rem">Event name, City, Month 2026</h3>
<p class="note">One line on the event and Dr Damola's role in it.</p>
<div class="gallery">
<figure><img src="assets/EVENT-PHOTO-1.webp" alt="Describe what the photo shows" loading="lazy"><figcaption>Caption</figcaption></figure>
<figure><img src="assets/EVENT-PHOTO-2.webp" alt="Describe what the photo shows" loading="lazy"><figcaption>Caption</figcaption></figure>
<figure><img src="assets/EVENT-PHOTO-3.webp" alt="Describe what the photo shows" loading="lazy"><figcaption>Caption</figcaption></figure>
</div>
-->

<p style="margin-top:1.6rem"><a class="btn btn-navy" href="canada-2026.html">See the Canada Conversations collection</a></p>
</div></section>

<section class="dark"><div class="wrap" style="text-align:center">
<h2>Never miss an announcement</h2>
<p style="max-width:50ch;margin:0 auto 1.4rem">News, events and new episodes go to the mailing list first.</p>
<a class="btn btn-solid" href="index.html#subscribe">Join the mailing list</a>
</div></section>
</main>
<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body></html>
RA_FILE_EOF_7X2K9

echo "  writing policies.html"
cat > "$ROOT/policies.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Privacy, Terms and Copyright | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Privacy policy, terms of use, copyright and consent information.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
    <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>

<main>
<div class="hero"><div class="wrap"><h1>Privacy, Terms &amp; Copyright</h1><p class="lede">How this platform protects visitors, contributors and its own work.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Privacy policy</span>
<h2>Your data</h2>
<p>We collect only what the subscription and contribution forms request (name, email, country and area of interest) and use it solely to send the newsletter, respond to submissions and improve the programme. We do not sell or share personal data. You may unsubscribe or request deletion at any time by writing to hello@rethinkingafrica.africa.</p>
<!-- DEVELOPER/LEGAL: expand this policy to meet NDPR (Nigeria) and, where relevant, GDPR requirements before launch. -->
</div></section>
<section class="dark"><div class="wrap">
<span class="eyebrow">Terms of use</span>
<h2>Using this site</h2>
<p>Content is provided for public education. Visitors may share and quote materials with attribution and a link. Submitting a contribution grants the programme permission to review it; nothing is published without the contributor's consent.</p>
</div></section>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Copyright &amp; consent</span>
<h2>Ownership and participation</h2>
<p>© Rethinking Africa with Dr. Damola. Episodes, articles, graphics and the programme identity are protected. Guests and contributors retain rights over their own words and images; interview and photograph consent is obtained before publication, and any participant may request corrections or removal of their contribution.</p>
<p style="margin-top:1rem">Media and interview enquiries: <a href="mailto:media@rethinkingafrica.africa">media@rethinkingafrica.africa</a>.</p>
</div></section>
</main>

<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body>
</html>
RA_FILE_EOF_7X2K9

echo "  writing publications.html"
cat > "$ROOT/publications.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Publications | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Peer-reviewed articles, books and chapters by Dr Oluwakemi Damola Adejumo-Ayibiowu on Afrocentric governance, migration, indigenous knowledge and African development.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
<style>
  .pub{border-bottom:1px solid #DCD3BC;padding:1.1rem 0}
  .pub:last-child{border-bottom:0}
  .pub .yr{font-family:Arial,Helvetica,sans-serif;font-size:.72rem;letter-spacing:.16em;color:var(--gold);font-weight:700}
  .pub .ti{font-family:'Fraunces',Georgia,serif;font-size:1.08rem;color:var(--indigo);margin:.3rem 0;line-height:1.35}
  .pub .src{font-size:.94rem;color:var(--ink-soft)}
  .pub .doi{display:inline-block;font-family:Arial,Helvetica,sans-serif;font-size:.8rem;margin-top:.4rem;word-break:break-all}
  .dark .pub{border-color:rgba(232,161,28,.3)}
  .dark .pub .ti{color:var(--ivory)}
  .dark .pub .src{color:#C6C9DA}
  .idbox{background:#FFFDF7;border-left:4px solid var(--gold);border-radius:3px;padding:1rem 1.2rem;margin-top:1.2rem}
</style>
</head>
<body>

<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 64 64" aria-hidden="true"><rect width="64" height="64" rx="10" fill="#1D2A57"/><g transform="translate(7,5) scale(0.135)"><circle cx="300" cy="90" r="100" fill="#E8A11C"/><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
    <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html" aria-current="page">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>

<main>
<div class="hero"><div class="wrap"><h1>Publications</h1><p class="lede">Peer-reviewed research on Afrocentric governance, migration, indigenous knowledge and African development.</p></div></div>
<hr class="horizon">

<section><div class="wrap narrow">
<span class="eyebrow">Author</span>
<h2>Dr Oluwakemi Damola Adejumo-Ayibiowu</h2>
<div class="idbox">
<p><strong>ORCID iD:</strong> <a href="https://orcid.org/0000-0001-5086-7364">0000-0001-5086-7364</a></p>
<p style="margin-top:.5rem;font-size:.92rem;color:var(--ink-soft)">Department of Development Studies, University of South Africa. For copies of any article not openly available, write to <a href="mailto:research@rethinkingafrica.africa">research@rethinkingafrica.africa</a>.</p>
</div>
</div></section>

<section class="dark"><div class="wrap narrow">
<span class="eyebrow">Peer-reviewed journal articles</span>
<h2>Journal articles</h2>

<div class="pub"><div class="yr">2026</div>
<p class="ti">Beyond Push and Pull: An Afrocentric Critique of Globalization, Migration, and Free Trade</p>
<p class="src"><em>Global Perspectives</em>, 7(1). University of California Press. Published 1 June 2026.</p>
<a class="doi" href="https://doi.org/10.1525/gp.2026.162017">doi.org/10.1525/gp.2026.162017</a>
</div>

<div class="pub"><div class="yr">2026</div>
<p class="ti">From Local Mastery to Constrained Circulation: African Food Innovation and the Problem of Internal Circulation</p>
<p class="src"><em>African Journal of Agriculture, Nutrition and Hospitality</em>, 3(2), 129–148.</p>
<a class="doi" href="https://doi.org/10.31920/3050-2276/2026/v3n2a6">doi.org/10.31920/3050-2276/2026/v3n2a6</a>
</div>

<div class="pub"><div class="yr">2026</div>
<p class="ti">Neoliberalism, Culture, and Democratic Erosion: Rethinking Sovereignty in Africa</p>
<p class="src"><em>African Renaissance</em>, 23(1), 37–56. March 2026.</p>
<a class="doi" href="https://doi.org/10.31920/2516-5305/2026/23n1a2">doi.org/10.31920/2516-5305/2026/23n1a2</a>
</div>

<div class="pub"><div class="yr">2025</div>
<p class="ti">Revisiting Migration and Globalization in Africa: A Structural and Afrocentric Analysis of Economic Marginalization</p>
<p class="src"><em>Journal of African Foreign Affairs</em>, 12(2), 97–116.</p>
<a class="doi" href="https://doi.org/10.31920/2056-5658/2025/v12n2a5">doi.org/10.31920/2056-5658/2025/v12n2a5</a>
</div>

<div class="pub"><div class="yr">2025</div>
<p class="ti">The Ultimate Other versus the Inferior Other: An Afrocentric Analysis of Ethnic-Stereotyping and Afrophobia</p>
<p class="src"><em>African Identities</em>, 23(1), 160–175. Taylor &amp; Francis.</p>
<a class="doi" href="https://doi.org/10.1080/14725843.2023.2250082">doi.org/10.1080/14725843.2023.2250082</a>
</div>

<div class="pub"><div class="yr">2025</div>
<p class="ti">Unveiling the Path to African Renaissance: A Critical Examination of Development Agendas, Cultural Perspectives, and Afrocentric Solutions</p>
<p class="src"><em>African Renaissance</em>, 22(1), 355–373.</p>
<a class="doi" href="https://doi.org/10.31920/2516-5305/2025/22n1a17">doi.org/10.31920/2516-5305/2025/22n1a17</a>
</div>

<div class="pub"><div class="yr">2025</div>
<p class="ti">Exploring the Characteristics of Afrocentricity in Relation to Good Governance</p>
<p class="src"><em>African Journal of Public Administration and Environmental Studies</em>, 4(1), 289–306.</p>
<a class="doi" href="https://doi.org/10.31920/2753-3182/2024/v4n1a14">doi.org/10.31920/2753-3182/2024/v4n1a14</a>
</div>

<div class="pub"><div class="yr">2024</div>
<p class="ti">A Review of the Literature on Infrastructure Financing in Africa: Afrocentric Innovations for Nigeria</p>
<p class="src"><em>African Journal of Development Studies</em>, 14(1), 333–355.</p>
<a class="doi" href="https://doi.org/10.31920/2634-3649/2024/v14n1a16">doi.org/10.31920/2634-3649/2024/v14n1a16</a>
</div>

<div class="pub"><div class="yr">2023</div>
<p class="ti">Understanding Good Governance: Voices of Rural People in South-Western Nigeria</p>
<p class="src"><em>International Journal of Research in Business and Social Science</em>, 12(10), 121–131.</p>
<a class="doi" href="https://doi.org/10.20525/ijrbs.v12i10.3108">doi.org/10.20525/ijrbs.v12i10.3108</a>
</div>

<div class="pub"><div class="yr">2016</div>
<p class="ti">A Theoretical Basis for Good Governance</p>
<p class="src"><em>Africanus: Journal of Development Studies</em>, 45(2), 1–27. Unisa Press.</p>
<a class="doi" href="https://doi.org/10.25159/0304-615X/1179">doi.org/10.25159/0304-615X/1179</a>
</div>

</div></section>
<hr class="horizon">

<section><div class="wrap narrow">
<span class="eyebrow">Books and chapters</span>
<h2>Books and book chapters</h2>

<div class="pub"><div class="yr">2026</div>
<p class="ti">Toward Cultural Democracy: Decolonizing African Governance Beyond Liberalism and Neoliberalism</p>
<p class="src">In S. O. Oloruntoba &amp; Y. Samy (Eds.), <em>Elgar Companion to Democracy and Development in Africa</em> (pp. 99–117). Edward Elgar Publishing.</p>
<!-- DEVELOPER: chapter DOI to be added once confirmed from Elgar -->
</div>

<div class="pub"><div class="yr">2021</div>
<p class="ti">Migration, Globalization, and Xenophobia in Africa: A Historical Survey</p>
<p class="src">In M. A. Mafukata (Ed.), <em>Impact of Immigration and Xenophobia on Development in Africa</em> (pp. 18–37). IGI Global. ISBN 9781799870999.</p>
</div>

<div class="pub"><div class="yr">2021</div>
<p class="ti">Alien Must Go: Reappraising the Challenges of Migrant Integration in Africa from an Ubuntu Perspective</p>
<p class="src">In M. A. Mafukata (Ed.), <em>Impact of Immigration and Xenophobia on Development in Africa</em> (pp. 111–129). IGI Global. ISBN 9781799870999.</p>
</div>

<div class="pub"><div class="yr">2020</div>
<p class="ti">Good Governance and Rural Development in Africa: Finding the Missing Link</p>
<p class="src">In M. A. Mafukata &amp; K. A. Tshikolomo (Eds.), <em>African Perspectives on Reshaping Rural Development</em>. IGI Global.</p>
<a class="doi" href="https://doi.org/10.4018/978-1-7998-2306-3">Volume doi.org/10.4018/978-1-7998-2306-3</a>
</div>

<div class="pub"><div class="yr">2020</div>
<p class="ti">Democracy, Decentralization and Rural Development in Africa: Learning from Within</p>
<p class="src">In M. A. Mafukata &amp; K. A. Tshikolomo (Eds.), <em>African Perspectives on Reshaping Rural Development</em>. IGI Global. ISBN 9781799823063.</p>
</div>

<div class="pub"><div class="yr">2018</div>
<p class="ti">Black and Bold: Success Inspiration from Baba Sala for African Youths</p>
<p class="src">Lagos: LPPH. ISBN 9781099668906.</p>
</div>

<div class="pub"><div class="yr">2018</div>
<p class="ti">An Afrocentric Critique of the Discourse of Good Governance and its Limitations as a Means of Addressing Development Challenges in Nigeria</p>
<p class="src">Doctoral thesis, University of South Africa.</p>
</div>

<div class="pub"><div class="yr">2016</div>
<p class="ti">Integrated Tax Administration System (ITAS) Made Easy</p>
<p class="src">Lagos: FIRS / Skeen Publishing.</p>
</div>

</div></section>

<section class="dark"><div class="wrap narrow">
<span class="eyebrow">Conference proceedings</span>
<h2>Proceedings</h2>
<div class="pub"><div class="yr">2023</div>
<p class="ti">Afrocentricity as a Theory for Good Governance in Africa</p>
<p class="src"><em>Proceedings of the International Conference on Public Administration and Development Alternatives (IPADA)</em>. ISBN 978-0-9921971-9-3 (print); 978-0-9921971-8-6 (e-book).</p>
</div>
<div class="pub"><div class="yr">2026</div>
<p class="ti">From Clay Pots to Quantum Futures: Rethinking African Science, Innovation, and Global Belonging</p>
<p class="src">Canadian Association of African Studies (CAAS) Conference, 2026.</p>
</div>
</div></section>
<hr class="horizon">

<section><div class="wrap narrow">
<span class="eyebrow">Public and media writing</span>
<h2>Selected media articles</h2>
<div class="pub"><div class="yr">2020</div>
<p class="ti">La démocratie à l'occidentale en Afrique est juste une manière de renforcer l'idéologie néolibérale</p>
<p class="src">Ritimo.org, 15 April 2020. Published in French.</p>
<a class="doi" href="https://www.ritimo.org/La-democratie-a-l-occidentale-en-Afrique-est-juste-une-maniere-de-renforcer-l">Read the article</a>
</div>
<div class="pub"><div class="yr">2020</div>
<p class="ti">Demokrati av vestlig type er bare en måte å fremme den nyliberale agendaen i Afrika</p>
<p class="src">Attac.no, 13 February 2020. Published in Norwegian.</p>
</div>
</div></section>

<section class="dark"><div class="wrap narrow" style="text-align:center">
<h2>Working with this research</h2>
<p style="max-width:54ch;margin:0 auto 1.4rem">Educators, students and researchers are welcome to use this work. For reading lists, teaching materials or a copy of any article, write to us.</p>
<a class="btn btn-solid" href="contact.html">Request materials</a>
</div></section>
</main>

<footer class="site">
  <div class="wrap">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body>
</html>
RA_FILE_EOF_7X2K9

echo "  writing quiz.html"
cat > "$ROOT/quiz.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>The 90-Second Africa Lens Quiz | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Seven questions. Seven things you were never told about African knowledge, and why they stopped. Find out which African future-builder you are.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
<style>
  .quiz-shell{max-width:660px;margin:0 auto;padding:0 1.1rem}
  .qcard{background:#FFFDF7;border:1px solid #E4DCC8;border-radius:6px;padding:1.5rem;margin-top:1.4rem}
  .qnum{font-family:Arial,sans-serif;font-size:.7rem;letter-spacing:.2em;text-transform:uppercase;color:var(--gold);margin-bottom:.5rem}
  .qtext{font-family:'Fraunces',Georgia,serif;font-size:1.3rem;color:var(--indigo);margin-bottom:1.1rem;line-height:1.3}
  .opt{display:block;width:100%;text-align:left;background:#F7F1E3;border:2px solid #E4DCC8;border-radius:4px;
       padding:.9rem 1rem;margin-bottom:.7rem;font-family:Georgia,serif;font-size:1rem;color:var(--ink);cursor:pointer}
  .opt:hover{border-color:var(--gold);background:#FFF9EC}
  .qbar{height:5px;background:#E4DCC8;border-radius:3px;margin-top:1.4rem;overflow:hidden}
  .qbar span{display:block;height:100%;background:var(--gold);width:0;transition:width .35s ease}
  .hidden{display:none}

  .insight{background:var(--indigo);border-radius:6px;padding:1.3rem;margin-top:1rem;color:#E8E3D4;animation:rise .35s ease-out both}
  @keyframes rise{from{opacity:0;transform:translateY(10px)}to{opacity:1;transform:none}}
  .insight .tag{font-family:Arial,sans-serif;font-size:.68rem;letter-spacing:.2em;text-transform:uppercase;color:var(--gold);display:block;margin-bottom:.7rem}
  .insight .pic{width:100%;max-width:100%;display:block;margin:0 auto 1.1rem;border-radius:5px;border:1px solid rgba(232,161,28,.35)}
  .insight p{font-size:1.02rem;line-height:1.6;margin:0 0 .8rem}
  .insight .why{background:rgba(232,161,28,.14);border-left:3px solid var(--gold);padding:.8rem 1rem;border-radius:3px;margin-top:.9rem}
  .insight .why strong{color:var(--gold);display:block;font-family:Arial,sans-serif;font-size:.72rem;letter-spacing:.14em;text-transform:uppercase;margin-bottom:.35rem}
  .insight .why p{margin:0;font-size:.98rem}

  .profile-name{font-family:'Fraunces',Georgia,serif;font-size:2rem;color:var(--gold);line-height:1.15}
  .rarity{display:inline-block;background:rgba(232,161,28,.18);border:1px solid var(--gold);color:var(--gold);
          font-family:Arial,sans-serif;font-size:.72rem;letter-spacing:.12em;text-transform:uppercase;padding:.35rem .8rem;border-radius:20px;margin-bottom:1rem}
  .sharebox{background:#F7F1E3;border-left:4px solid var(--gold);padding:1rem;border-radius:3px;text-align:left;color:var(--ink);margin-top:1.2rem;font-size:.95rem}
  .tabs{display:flex;gap:.5rem;margin-bottom:1rem}
  .tabs button{flex:1;padding:.6rem;border:2px solid #E4DCC8;background:#F7F1E3;border-radius:4px;
               font-family:Arial,sans-serif;font-size:.85rem;cursor:pointer;color:var(--ink)}
  .tabs button.on{border-color:var(--gold);background:#FFF3DC;font-weight:700}
  @media (prefers-reduced-motion:reduce){.insight{animation:none}}
</style>
</head>
<body>

<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 64 64" aria-hidden="true"><rect width="64" height="64" rx="10" fill="#1D2A57"/><g transform="translate(7,5) scale(0.135)"><circle cx="300" cy="90" r="100" fill="#E8A11C"/><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
    <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" aria-current="page" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>

<main>
  <div class="hero" style="padding:2.2rem 0">
    <div class="wrap" style="text-align:center">
      <h1 style="font-size:clamp(2rem,6.5vw,3.4rem);color:var(--ivory);max-width:16ch;margin:0 auto;line-height:1.05">The 90-Second<br><span style="color:var(--gold)">Africa Lens Quiz</span></h1>
      <p style="font-family:'Fraunces',Georgia,serif;font-size:clamp(1.05rem,2.6vw,1.3rem);color:#D8D3C4;margin:1.1rem auto 0;max-width:30ch;font-style:italic">How were you taught to see Africa?</p>
      <p class="lede" style="margin-top:.9rem;font-size:1rem">Seven questions. After each one, something Africa built, and the reason you never heard about it.</p>
</div>
  </div>
  <hr class="horizon">

  <section style="padding-top:.6rem">
    <div class="quiz-shell">

      <div id="q-intro" class="qcard" style="text-align:center">
        <p class="qtext" style="margin-bottom:.6rem">There are no wrong answers here.</p>
        <p style="margin-bottom:1.3rem">It takes about ninety seconds. You will learn seven things you were probably never taught.</p>
        <button class="btn btn-solid" onclick="startQuiz()">Begin</button>
        <p class="note" style="margin-top:.9rem">Free. No payment, ever.</p>
      </div>

      <div id="q-card" class="qcard hidden">
        <div class="qnum" id="q-num"></div>
        <div class="qtext" id="q-text"></div>
        <div id="q-opts"></div>
        <div class="qbar"><span id="q-bar"></span></div>
      </div>

      <div id="q-insight" class="insight hidden">
        <span class="tag">What you were never told</span>
        <div id="i-pic"></div>
        <p id="i-text"></p>
        <div class="why"><strong>So why did it stop?</strong><p id="i-why"></p></div>
        <div style="margin-top:1.1rem"><button class="btn btn-solid" onclick="nextQuestion()" id="i-btn">Continue</button></div>
      </div>

      <div id="q-gate" class="qcard hidden">
        <p class="qnum" style="text-align:center">Your profile is ready</p>
        <p class="qtext" style="text-align:center">Where should we send it?</p>
        <p style="margin-bottom:1.3rem;text-align:center">You will get your full profile and a short free guide, <em>Seven Things Africa Was Taught to Forget</em>.</p>

        <div class="field"><label for="g-name">Your name</label><input id="g-name" type="text"></div>
        <div class="field"><label for="g-email">Email address</label><input id="g-email" type="email" placeholder="you@example.com"></div>
        <div class="field"><label for="g-wa">WhatsApp number</label><input id="g-wa" type="tel" placeholder="+234 800 000 0000"></div>
        <div class="field"><label for="g-country">Country</label><input id="g-country" type="text"></div>

        <div class="field">
          <label>Which do you prefer we use?</label>
          <div class="tabs">
            <button type="button" id="tab-email" class="on" onclick="pick('email')">Email</button>
            <button type="button" id="tab-wa" onclick="pick('wa')">WhatsApp</button>
          </div>
        </div>

        <p class="note" id="g-hint" style="margin-bottom:1rem">Give either one, or both. Both helps us reach you if one fails.</p>

        <div style="text-align:center">
          <button class="btn btn-solid" onclick="revealResult()">Show my profile</button>
        </div>
        <p class="note" style="margin-top:.8rem;text-align:center">We will never share your details. Leave any time.</p>
      </div>

      <div id="q-result" class="qcard hidden" style="text-align:center;background:var(--indigo);border-color:var(--indigo)">
        <p class="qnum">Your African future-builder profile</p>
        <span class="rarity" id="r-rarity"></span>
        <p class="profile-name" id="r-name"></p>
        <p id="r-desc" style="color:#E8E3D4;margin:1rem 0 1.2rem"></p>
        <p id="r-strength" style="color:#F7F1E3;font-family:'Fraunces',Georgia,serif;font-style:italic;font-size:1.1rem;margin-bottom:1.5rem"></p>

        <p style="color:#D8D3C4;margin-bottom:1rem">Everything else lives on the channel. New episodes come out regularly, and subscribing is how you get them.</p>
        <a class="btn btn-solid" href="https://www.youtube.com/@DrDamola.Africa?sub_confirmation=1">Subscribe on YouTube</a>
        <a class="btn btn-ghost hidden" id="r-wa" href="#" style="margin-left:.5rem">Get it on WhatsApp</a>

        <div class="sharebox">
          <strong>One question to carry with you:</strong>
          <p id="r-question" style="margin-top:.4rem"></p>
        </div>

        <p id="r-delivery" style="color:#A8AEC6;font-size:.85rem;margin-top:1.3rem"></p>
        <p style="color:#A8AEC6;font-size:.85rem;margin-top:.4rem">Africa must not only be studied. Africa must speak, think, create and determine.</p>
      </div>

    </div>
  </section>
</main>

<footer class="site">
  <div class="wrap">
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa &middot; &copy; 2026 Rethinking Africa with Dr. Damola.</p>
  </div>
</footer>

<script>
/* ============================================================
   CONFIGURATION - the developer fills in these three lines only.
   Everything below works on plain static HTML. No server needed.
   ============================================================ */
const CONFIG = {
  // Where form submissions are sent. Paste ONE endpoint URL.
  // Works with Formspree, Web3Forms, Netlify Forms, Basin, Getform,
  // or any provider that accepts a JSON POST.
  SIGNUP_ENDPOINT: "",          // e.g. "https://formspree.io/f/xxxxxxx"

  // The WhatsApp number that receives opt-in messages, digits only,
  // including country code and no plus sign.
  WHATSAPP_NUMBER: "",          // e.g. "2348012345678"

  // Optional: a MailerLite / ConvertKit embedded form action URL.
  // If set, the subscriber is also pushed straight into the mailing list.
  MAILING_LIST_ACTION: ""
};
/* ============================================================ */

/* Illustrations: simple inline SVG, brand colours, no network cost. */
const PIC = {
book:  '<img class="pic" src="assets/q1-knowledge.webp" alt="African signs and symbols shown as a living information system" loading="lazy">',
school:'<img class="pic" src="assets/q2-classroom.webp" alt="A colonial-era classroom: children face a blackboard showing Europe, while through the window behind them a blacksmith, an indigo dyer and farmers work" loading="lazy">',
pot:   '<img class="pic" src="assets/q3-claypot.webp" alt="A woman carrying a clay water pot" loading="lazy">',
binary:'<img class="pic" src="assets/q4-ifa.webp" alt="The sixteen principal Odu of Ifa, each built from marks that are either present or absent" loading="lazy">',
stone: '<img class="pic" src="assets/q5-stone.webp" alt="Stone architecture rising into a modern African city" loading="lazy">',
money: '<img class="pic" src="assets/q6-diaspora.webp" alt="A woman sending money from a cold city at night, and the home it reaches at sunrise" loading="lazy">',
sun:   '<img class="pic" src="assets/q7-evolution.webp" alt="The clay pot principle continued into a modern research laboratory" loading="lazy">'
};

const QUESTIONS = [
{
 q:"Growing up, were you taught that knowledge from Europe or America was better than knowledge from Africa?",
 opts:[["Yes, clearly",{KR:2,ST:1}],["Nobody said it, but I felt it",{KR:1,ST:1}],["No, both were respected at home",{BB:1,SR:1}],["I never thought about it this way",{FM:1}]],
 pic:'book',
 text:"Six hundred years ago, Timbuktu in Mali was a city of scholars. Families kept libraries in their homes. Hundreds of thousands of handwritten books on medicine, astronomy, mathematics and law. Students came from far away to study there. It was a university city before many European ones existed.",
 why:"In 1591 an invading army destroyed the scholarly community and its leading scholars were killed or taken away. Later, under French colonial rule, the schools that replaced it taught a different story, and many manuscripts were carried off to Europe. Families hid what was left in boxes and buried them. The books survived. The universities did not."
},
{
 q:"Did your education bring you closer to your own community, or take you further away from it?",
 opts:[["Much further away",{KR:2}],["A bit of both",{BB:2}],["Closer. I was lucky",{SR:1,KR:1}],["I was schooled far from home",{BB:1,FM:1}]],
 pic:'school',
 text:"Before colonial schooling, most African children learned a trade, a craft or a body of knowledge from the people around them. Farming, weaving, building, healing, trading. Learning happened inside the community and stayed there.",
 why:"Colonial schools were built for a stated purpose: to produce clerks and messengers who could serve an administration, not builders, inventors or owners. Children were taught in a foreign language, about foreign places, and were punished for speaking their own. When independence came, the flags changed. In many countries the syllabus did not. If school made you feel your home had nothing to teach you, that was the design working, not you failing."
},
{
 q:"You see a clay water pot in a village. What do you think?",
 opts:[["Something traditional, worth keeping",{ST:2}],["Poverty, honestly. That is what I was taught",{KR:2}],["Technology nobody bothered to invest in",{FM:2,SR:1}],["I use one. I never thought about it",{BB:1,KR:1}]],
 pic:'pot',
 text:"A clay pot keeps water cold in extreme heat with no electricity at all. Water passes slowly through the clay wall, and as it evaporates on the outside it pulls heat away from the water inside. It is real science, worked out over generations by testing which clay, which thickness, which shape kept water coldest.",
 why:"Nobody funded it. No laboratory studied it, no company improved it, no patent protected it, no university taught it. It was called craft instead of science, so it stayed the same size for centuries. Today engineers in Europe and the Gulf use exactly this cooling principle in modern buildings, and it is described as an innovation."
},
{
 q:"An elder starts explaining traditional knowledge to you. What is your first instinct?",
 opts:[["Record it before it disappears",{KR:2}],["Ask how we could test and prove it",{SR:2}],["Retell it so young people care",{ST:2}],["Introduce them to someone who could use it",{BB:2}]],
 pic:'binary',
 text:"Every computer and phone in the world runs on binary: everything reduced to two states, on or off, 1 or 0, and then combined to build anything. The Ifa system of the Yoruba works on exactly the same principle. Each mark is one of two states. Four marks make one figure. Sixteen figures combine into 256 outcomes, each attached to a body of memorised verses. It is a binary information system, held in trained human memory, over a thousand years old.",
 why:"It was labelled superstition. Missionaries and colonial officials discouraged it, converts were told to abandon it, and it was never allowed into a single university mathematics department. So the same logic that became the computer in one part of the world was called witchcraft in another. Nobody in Africa was invited to the meeting where binary became a machine."
},
{
 q:"What worries you most about Africa today?",
 opts:[["Education, and knowledge being lost",{KR:2}],["Government and weak institutions",{SR:2}],["Identity, and the stories told about us",{ST:2}],["Technology, and being left behind again",{FM:2}]],
 pic:'stone',
 text:"Great Zimbabwe is a city of stone walls up to eleven metres high, built without any cement. The stones are cut so precisely that they hold each other in place, and have done for about eight hundred years. It was the centre of a wealthy trading kingdom connected to the Indian Ocean.",
 why:"When Europeans found it, they refused to believe Africans had built it. Colonial authorities pushed the story that foreigners must have done it. Treasure hunters dug through the site for gold and threw away the very layers of soil that held the proof, destroying the evidence. Later archaeologists who said plainly that Africans built it were pressured to stay quiet. The building was African. So was the truth. Both were buried."
},
{
 q:"Do you live in Africa, or outside it?",
 opts:[["In Africa",{SR:1,KR:1}],["Outside Africa",{BB:2}],["Between the two",{BB:2,FM:1}],["Getting ready to leave",{BB:1,ST:1}]],
 pic:'money',
 text:"The money Africans abroad send home every year is now larger than all the foreign aid the continent receives. It arrives with no conditions, no consultants and no forms. It pays school fees, builds houses, buries parents and starts businesses.",
 why:"Nothing stopped this one, and that is the point. It is the clearest proof that Africans already fund Africa. What is missing is not money or willingness. It is the institutions that would turn millions of small private acts into schools, factories and companies that outlive the person who paid for them."
},
{
 q:"Finish this sentence. Africa's future will be built mainly by...",
 opts:[["Recovering what was interrupted",{KR:2}],["Fixing the systems we live inside",{SR:2}],["Changing the stories we tell ourselves",{ST:2}],["Building what has never existed",{FM:2}]],
 pic:'sun',
 text:"Notice the pattern in everything you just read. None of it failed. None of it was disproved. Each one was interrupted: invaded, defunded, renamed, ridiculed or buried. And in every case the knowledge itself survived, in a pot, in a memory, in a wall, in a hidden box.",
 why:"That is the whole argument of this platform. Africa is not empty of intelligence. Its intelligence was never recognised, protected, funded or passed on properly. That is not a tragedy you inherit. It is unfinished work, and unfinished work can be continued by whoever decides to pick it up."
}
];

const PROFILES = {
 KR:{name:"The Knowledge Recoverer", rarity:"About 1 in 4 people",
  desc:"You feel the loss of what is disappearing. Your instinct is to find it, write it down and keep it, before the last person who remembers is gone.",
  strength:"Your strength is saving memory before it closes.",
  q:"What did your grandparents know that your generation did not learn?"},
 BB:{name:"The Bridge Builder", rarity:"About 1 in 5 people",
  desc:"You live between two worlds, and that is not confusion, it is an advantage. Your instinct is to connect people, money and ideas that would otherwise never meet.",
  strength:"Your strength is standing in two places at once.",
  q:"Who do you know on each side who has never met the other?"},
 SR:{name:"The System Reformer", rarity:"About 1 in 5 people",
  desc:"You know that good intentions are not enough, because systems decide what happens long before individuals do. Your instinct is rules, standards and institutions that work.",
  strength:"Your strength is building what outlasts you.",
  q:"Which broken system near you was designed by someone who never had to live inside it?"},
 ST:{name:"The Story Restorer", rarity:"About 1 in 6 people",
  desc:"You understand that people slowly become the story told about them. Your instinct is words, images and culture that give people back their confidence.",
  strength:"Your strength is changing what people believe they are allowed to want.",
  q:"Whose story about Africa are you still repeating without checking?"},
 FM:{name:"The Future Maker", rarity:"About 1 in 8 people",
  desc:"Recovering the past is not enough for you. You want to build things that have never existed anywhere, starting from African ground.",
  strength:"Your strength is refusing the options you were given.",
  q:"What would you build if you stopped waiting for permission?"}
};

let idx = 0, scores = {KR:0,BB:0,SR:0,ST:0,FM:0}, mode = 'email';
const el = id => document.getElementById(id);

function pick(m){
  mode = m;
  el('tab-email').classList.toggle('on', m==='email');
  el('tab-wa').classList.toggle('on', m==='wa');
}

function startQuiz(){
  el('q-intro').classList.add('hidden');
  el('q-card').classList.remove('hidden');
  render();
}

function render(){
  const item = QUESTIONS[idx];
  el('q-num').textContent = 'Question ' + (idx+1) + ' of ' + QUESTIONS.length;
  el('q-text').textContent = item.q;
  const box = el('q-opts'); box.innerHTML = '';
  item.opts.forEach(function(o){
    const b = document.createElement('button');
    b.className = 'opt'; b.textContent = o[0];
    b.onclick = function(){
      for (const k in o[1]) scores[k] += o[1][k];
      showInsight(item);
    };
    box.appendChild(b);
  });
  el('q-bar').style.width = (idx / QUESTIONS.length * 100) + '%';
}

function showInsight(item){
  el('i-pic').innerHTML = PIC[item.pic];
  el('i-text').textContent = item.text;
  el('i-why').textContent = item.why;
  el('i-btn').textContent = (idx === QUESTIONS.length - 1) ? 'See my profile' : 'Continue';
  el('q-card').classList.add('hidden');
  el('q-insight').classList.remove('hidden');
  el('q-insight').scrollIntoView({behavior:'smooth', block:'center'});
}

function nextQuestion(){
  el('q-insight').classList.add('hidden');
  idx++;
  if (idx < QUESTIONS.length){ el('q-card').classList.remove('hidden'); render(); }
  else { el('q-gate').classList.remove('hidden'); el('q-gate').scrollIntoView({behavior:'smooth', block:'center'}); }
}

function revealResult(){
  const name = el('g-name').value.trim();
  const email = el('g-email').value.trim();
  const wa = el('g-wa').value.replace(/[^0-9+]/g,'');
  const country = el('g-country').value.trim();
  const hasEmail = email.indexOf('@') > 0;
  const hasWa = wa.length >= 8;

  if (!hasEmail && !hasWa){
    el('g-hint').textContent = 'Please give an email address or a WhatsApp number so we can send your profile.';
    el('g-hint').style.color = '#B03A2E';
    (mode === 'wa' ? el('g-wa') : el('g-email')).focus();
    return;
  }

  let best='KR', max=-1;
  for (const k in scores){ if (scores[k] > max){ max = scores[k]; best = k; } }
  const p = PROFILES[best];
  window.quizProfile = best;

  /* ---- SEND THE DATA (works on static hosting) ---- */
  const payload = {
    name: name,
    email: email,
    whatsapp: wa,
    country: country,
    preferred_channel: mode,
    quiz_profile: best,
    quiz_profile_name: p.name,
    source: 'Africa Lens Quiz'
  };

  if (CONFIG.SIGNUP_ENDPOINT){
    fetch(CONFIG.SIGNUP_ENDPOINT, {
      method: 'POST',
      headers: {'Content-Type':'application/json', 'Accept':'application/json'},
      body: JSON.stringify(payload)
    }).catch(function(){ /* never block the result on a network error */ });
  }

  if (CONFIG.MAILING_LIST_ACTION && hasEmail){
    const f = document.createElement('form');
    f.action = CONFIG.MAILING_LIST_ACTION; f.method = 'post'; f.target = 'ml_sink';
    [['fields[email]',email],['fields[name]',name],['fields[country]',country],
     ['fields[profile]',p.name]].forEach(function(pair){
      const i = document.createElement('input');
      i.type='hidden'; i.name=pair[0]; i.value=pair[1]; f.appendChild(i);
    });
    const sink = document.createElement('iframe');
    sink.name='ml_sink'; sink.style.display='none';
    document.body.appendChild(sink); document.body.appendChild(f); f.submit();
  }

  /* ---- SHOW THE RESULT ---- */
  el('r-rarity').textContent = p.rarity;
  el('r-name').textContent = p.name;
  el('r-desc').textContent = p.desc;
  el('r-strength').textContent = p.strength;
  el('r-question').textContent = p.q;

  /* WhatsApp opt-in: the reader messages us, which is the compliant way
     to start a WhatsApp conversation and cannot get the number blocked. */
  const waBtn = el('r-wa');
  if (CONFIG.WHATSAPP_NUMBER && (mode === 'wa' || hasWa)){
    const msg = encodeURIComponent(
      'Hello Dr Damola. I just took the Africa Lens Quiz. My profile is ' +
      p.name + '. Please send me my guide.');
    waBtn.href = 'https://wa.me/' + CONFIG.WHATSAPP_NUMBER + '?text=' + msg;
    waBtn.classList.remove('hidden');
  }

  el('r-delivery').textContent = hasEmail
    ? 'Your guide is on its way to ' + email + '.'
    : 'Tap the WhatsApp button above and we will send your guide straight away.';

  el('q-gate').classList.add('hidden');
  el('q-result').classList.remove('hidden');
  el('q-result').scrollIntoView({behavior:'smooth', block:'start'});
}
</script>
</body>
</html>
RA_FILE_EOF_7X2K9

echo "  writing watch.html"
cat > "$ROOT/watch.html" << 'RA_FILE_EOF_7X2K9'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Watch | Rethinking Africa with Dr. Damola</title>
<meta name="description" content="Episodes of Rethinking Africa with Dr. Damola, organised into six series.">
<link rel="icon" type="image/svg+xml" href="assets/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Fraunces:opsz,wght@9..144,600;9..144,700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">
</head>
<body>
<header class="site">
  <div class="wrap">
    <a class="brand" href="index.html" aria-label="Rethinking Africa home">
      <svg viewBox="0 0 560 470" aria-hidden="true"><rect x="10" y="111" width="60" height="7" fill="#E8A11C"/><rect x="480" y="111" width="60" height="7" fill="#E8A11C"/><circle cx="390" cy="115" r="85" fill="#E8A11C"/><g transform="translate(90,25)"><path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#F7F1E3"/><ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/></g></svg>
      <span>Rethinking Africa<br><em style="font-weight:400;font-size:.72rem;letter-spacing:.06em;color:#E8A11C;font-style:italic">with Dr. Damola</em></span>
    </a>
        <nav class="main" aria-label="Main">
      <a href="index.html">Home</a>
      <a href="quiz.html" style="color:#E8A11C">Take the Quiz</a>
      <a href="watch.html" aria-current="page">Watch</a>
      <a href="ideas.html">Ideas</a>
      <a href="publications.html">Publications</a>
      <a href="african-voices.html">African Voices</a>
      <a href="news.html">News &amp; Events</a>
      <a href="contribute.html">Contribute</a>
      <a href="about.html">About</a>
      <a href="contact.html">Contact</a>
    </nav>
  </div>
</header>
<main>
<div class="hero"><div class="wrap"><h1>Watch</h1><p class="lede">Episodes organised into clear series, from full investigations to one powerful question.</p></div></div>
<hr class="horizon">
<section><div class="wrap">
<span class="eyebrow">Series</span>
<h2>The programme's six series</h2>
<div class="grid">
<div class="card"><h3>Rethinking Africa: Main Episodes</h3><p>Full-length investigations moving from a visible story to the system beneath it.</p><p style="margin-top:.7rem"><a href="https://www.youtube.com/@DrDamola.Africa">Watch the playlist</a></p></div>
<div class="card"><h3>African Voices</h3><p>Interviews with researchers, artisans, entrepreneurs, elders and young people.</p><p style="margin-top:.7rem"><a href="https://www.youtube.com/@DrDamola.Africa">Watch the playlist</a></p></div>
<div class="card"><h3>One Question for Africa</h3><p>Short videos built around a single question you cannot un-ask.</p><p style="margin-top:.7rem"><a href="https://www.youtube.com/@DrDamola.Africa">Watch the playlist</a></p></div>
<div class="card"><h3>Research Made Public</h3><p>Academic findings translated into accessible public knowledge.</p><p style="margin-top:.7rem"><a href="https://www.youtube.com/@DrDamola.Africa">Watch the playlist</a></p></div>
<div class="card"><h3>African Futures</h3><p>What African cities, schools, industries and institutions could become.</p><p style="margin-top:.7rem"><a href="https://www.youtube.com/@DrDamola.Africa">Watch the playlist</a></p></div>
<div class="card"><h3>Conference Conversations</h3><p>Roundtables, debates and public dialogues from events and gatherings.</p><p style="margin-top:.7rem"><a href="https://www.youtube.com/@DrDamola.Africa">Watch the playlist</a></p></div>
</div>
</div></section>
<section class="dark"><div class="wrap" style="text-align:center">
<h2>New episodes first</h2>
<p style="max-width:50ch;margin:0 auto 1.4rem">Subscribe on YouTube and join the mailing list to be notified when new investigations are released.</p>
<a class="btn btn-solid" href="https://www.youtube.com/@DrDamola.Africa">Subscribe on YouTube</a>
</div></section>
</main>
<footer class="site">
  <div class="wrap">
    <img src="assets/logo-dark-stacked.svg" alt="Rethinking Africa with Dr. Damola logo" style="width:200px;height:auto;margin:0 auto 1.4rem;display:block" loading="lazy">
    <div class="links">
      <a href="https://www.youtube.com/@DrDamola.Africa">YouTube</a>
      <a href="https://www.instagram.com/DrDamolaAfrica">Instagram</a>
      <a href="https://www.tiktok.com/@DrDamolaAfrica">TikTok</a>
      <a href="https://www.facebook.com/DrDamolaAfrica">Facebook</a>
      <a href="https://x.com/DrDamolaAfrica">X</a>
      <a href="https://www.linkedin.com/company/rethinking-africa-with-dr-damola">LinkedIn</a>
      <a href="community.html">WhatsApp</a>
      <a href="policies.html">Privacy &amp; Terms</a>
      <a href="editorial.html">Editorial Standards</a>
      <a href="contact.html">Contact</a>
    </div>
    <p>An independent African-centred research, media and public-education initiative founded by Dr Oluwakemi Damola Adejumo-Ayibiowu.</p>
    <p style="margin-top:.5rem">hello@rethinkingafrica.africa · © 2026 Rethinking Africa with Dr. Damola. All rights reserved.</p>
  </div>
</footer>
</body></html>
RA_FILE_EOF_7X2K9

echo "  writing assets/event-placeholder.svg"
cat > "$ROOT/assets/event-placeholder.svg" << 'RA_FILE_EOF_7X2K9'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 300" width="400" height="300">
  <rect width="400" height="300" fill="#141D3D"/>
  <circle cx="200" cy="120" r="45" fill="#E8A11C" opacity="0.85"/>
  <rect x="40" y="150" width="320" height="3" fill="#E8A11C"/>
  <text x="200" y="200" text-anchor="middle" font-family="Arial, sans-serif" font-size="14" letter-spacing="3" fill="#F7F1E3">EVENT PHOTO</text>
</svg>
RA_FILE_EOF_7X2K9

echo "  writing assets/favicon.svg"
cat > "$ROOT/assets/favicon.svg" << 'RA_FILE_EOF_7X2K9'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="64" height="64">
  <!-- Favicon v3 — continent + sun only -->
  <rect width="64" height="64" rx="10" fill="#1D2A57"/>
  <g transform="translate(7,5) scale(0.135)">
    <circle cx="300" cy="90" r="100" fill="#E8A11C"/>
    <path d="M70,12
             C95,2 130,-2 155,4
             C170,10 175,38 195,35
             C215,32 230,32 250,37
             C258,38 260,40 263,45
             C275,72 288,100 298,124
             C303,132 310,137 317,140
             C330,142 345,140 357,144
             C350,162 337,182 327,198
             C315,215 302,232 297,247
             C300,262 300,274 296,285
             C290,302 282,311 275,318
             C268,335 260,362 255,374
             C245,388 220,402 200,400
             C190,396 182,377 173,352
             C166,330 163,310 161,293
             C159,275 160,257 161,242
             C158,230 152,220 147,212
             C148,200 149,192 148,187
             C138,180 128,176 117,174
             C105,177 90,180 80,180
             C68,180 55,178 46,174
             C40,169 36,166 34,162
             C24,148 16,138 13,128
             C14,120 17,114 20,110
             C16,102 15,98 15,95
             C22,80 28,68 35,57
             C45,44 53,32 62,24
             C65,20 68,15 70,12 Z"
          fill="#F7F1E3"/>
  </g>
</svg>
RA_FILE_EOF_7X2K9

echo "  writing assets/logo-dark-stacked.svg"
cat > "$ROOT/assets/logo-dark-stacked.svg" << 'RA_FILE_EOF_7X2K9'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 530" width="720" height="530">
  <!-- Reversed stacked logo v3 -->
  <rect width="720" height="530" fill="#1D2A57"/>

  <g transform="translate(193,15) scale(0.62)">
    <g transform="translate(90,25)">
      <rect x="-80" y="88" width="520" height="4" fill="#E8A11C"/>
      <circle cx="300" cy="90" r="85" fill="#E8A11C"/>
      <path d="M70,12
               C95,2 130,-2 155,4
               C170,10 175,38 195,35
               C215,32 230,32 250,37
               C258,38 260,40 263,45
               C275,72 288,100 298,124
               C303,132 310,137 317,140
               C330,142 345,140 357,144
               C350,162 337,182 327,198
               C315,215 302,232 297,247
               C300,262 300,274 296,285
               C290,302 282,311 275,318
               C268,335 260,362 255,374
               C245,388 220,402 200,400
               C190,396 182,377 173,352
               C166,330 163,310 161,293
               C159,275 160,257 161,242
               C158,230 152,220 147,212
               C148,200 149,192 148,187
               C138,180 128,176 117,174
               C105,177 90,180 80,180
               C68,180 55,178 46,174
               C40,169 36,166 34,162
               C24,148 16,138 13,128
               C14,120 17,114 20,110
               C16,102 15,98 15,95
               C22,80 28,68 35,57
               C45,44 53,32 62,24
               C65,20 68,15 70,12 Z"
            fill="#F7F1E3"/>
      <ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#F7F1E3"/>
    </g>
  </g>

  <g text-anchor="middle" fill="#F7F1E3">
    <text x="360" y="345" font-family="Georgia, 'Times New Roman', serif"
          font-size="26" letter-spacing="10" font-weight="400">RETHINKING</text>
    <text x="360" y="413" font-family="Georgia, 'Times New Roman', serif"
          font-size="72" letter-spacing="8" font-weight="700">AFRICA</text>
    <rect x="252" y="435" width="216" height="3" fill="#E8A11C"/>
    <text x="360" y="477" font-family="Georgia, 'Times New Roman', serif"
          font-size="28" font-style="italic" font-weight="500" letter-spacing="1">with Dr. Damola</text>
  </g>
</svg>
RA_FILE_EOF_7X2K9

echo "  writing assets/logo-horizontal.svg"
cat > "$ROOT/assets/logo-horizontal.svg" << 'RA_FILE_EOF_7X2K9'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1100 230" width="1100" height="230">
  <rect width="1100" height="230" fill="#F7F1E3"/>
  <g transform="translate(18,10) scale(0.42)"><g transform="translate(90,25)">
    <rect x="-80" y="88" width="520" height="4" fill="#E8A11C"/>
    <circle cx="300" cy="90" r="85" fill="#E8A11C"/>
    <path d="M70,12 C95,2 130,-2 155,4 C170,10 175,38 195,35 C215,32 230,32 250,37 C258,38 260,40 263,45 C275,72 288,100 298,124 C303,132 310,137 317,140 C330,142 345,140 357,144 C350,162 337,182 327,198 C315,215 302,232 297,247 C300,262 300,274 296,285 C290,302 282,311 275,318 C268,335 260,362 255,374 C245,388 220,402 200,400 C190,396 182,377 173,352 C166,330 163,310 161,293 C159,275 160,257 161,242 C158,230 152,220 147,212 C148,200 149,192 148,187 C138,180 128,176 117,174 C105,177 90,180 80,180 C68,180 55,178 46,174 C40,169 36,166 34,162 C24,148 16,138 13,128 C14,120 17,114 20,110 C16,102 15,98 15,95 C22,80 28,68 35,57 C45,44 53,32 62,24 C65,20 68,15 70,12 Z" fill="#1D2A57"/>
    <ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#1D2A57"/>
  </g></g>
  <g fill="#1D2A57">
    <text x="290" y="112" font-family="Georgia, serif" font-size="54" letter-spacing="5" font-weight="700">RETHINKING AFRICA</text>
    <rect x="293" y="132" width="150" height="3" fill="#E8A11C"/>
    <text x="293" y="172" font-family="Georgia, serif" font-size="27" font-style="italic" font-weight="500">with Dr. Damola</text>
  </g></svg>
RA_FILE_EOF_7X2K9

echo "  writing assets/logo-primary-stacked.svg"
cat > "$ROOT/assets/logo-primary-stacked.svg" << 'RA_FILE_EOF_7X2K9'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 720 530" width="720" height="530">
  <!-- Primary stacked logo v3 — Africa silhouette redrawn from real coastal
       geography (Tangier, Tunis, Nile delta, Red Sea, Horn at Cape Guardafui,
       Mozambique curve, Cape Agulhas, Gulf of Guinea, Dakar bulge).
       Sun rises behind the Red Sea / Gulf of Aden — the true east. -->
  <rect width="720" height="530" fill="#F7F1E3"/>

  <g transform="translate(193,15) scale(0.62)">
    <g transform="translate(90,25)">
      <!-- Horizon behind everything -->
      <rect x="-80" y="88" width="520" height="4" fill="#E8A11C"/>
      <!-- Sun behind the continent, over the Red Sea -->
      <circle cx="300" cy="90" r="85" fill="#E8A11C"/>
      <!-- Continent -->
      <path d="M70,12
               C95,2 130,-2 155,4
               C170,10 175,38 195,35
               C215,32 230,32 250,37
               C258,38 260,40 263,45
               C275,72 288,100 298,124
               C303,132 310,137 317,140
               C330,142 345,140 357,144
               C350,162 337,182 327,198
               C315,215 302,232 297,247
               C300,262 300,274 296,285
               C290,302 282,311 275,318
               C268,335 260,362 255,374
               C245,388 220,402 200,400
               C190,396 182,377 173,352
               C166,330 163,310 161,293
               C159,275 160,257 161,242
               C158,230 152,220 147,212
               C148,200 149,192 148,187
               C138,180 128,176 117,174
               C105,177 90,180 80,180
               C68,180 55,178 46,174
               C40,169 36,166 34,162
               C24,148 16,138 13,128
               C14,120 17,114 20,110
               C16,102 15,98 15,95
               C22,80 28,68 35,57
               C45,44 53,32 62,24
               C65,20 68,15 70,12 Z"
            fill="#1D2A57"/>
      <!-- Madagascar -->
      <ellipse cx="333" cy="312" rx="15" ry="36" transform="rotate(15 333 312)" fill="#1D2A57"/>
    </g>
  </g>

  <g text-anchor="middle" fill="#1D2A57">
    <text x="360" y="345" font-family="Georgia, 'Times New Roman', serif"
          font-size="26" letter-spacing="10" font-weight="400">RETHINKING</text>
    <text x="360" y="413" font-family="Georgia, 'Times New Roman', serif"
          font-size="72" letter-spacing="8" font-weight="700">AFRICA</text>
    <rect x="252" y="435" width="216" height="3" fill="#E8A11C"/>
    <text x="360" y="477" font-family="Georgia, 'Times New Roman', serif"
          font-size="28" font-style="italic" font-weight="500" letter-spacing="1">with Dr. Damola</text>
  </g>
</svg>
RA_FILE_EOF_7X2K9

echo "  writing assets/portrait-placeholder.svg"
cat > "$ROOT/assets/portrait-placeholder.svg" << 'RA_FILE_EOF_7X2K9'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 400 500" width="400" height="500">
  <rect width="400" height="500" fill="#1D2A57"/>
  <circle cx="200" cy="185" r="75" fill="#F7F1E3" opacity="0.9"/>
  <path d="M80,420 C80,330 140,290 200,290 C260,290 320,330 320,420 L320,500 L80,500 Z" fill="#F7F1E3" opacity="0.9"/>
  <rect x="60" y="440" width="280" height="3" fill="#E8A11C"/>
  <text x="200" y="472" text-anchor="middle" font-family="Arial, sans-serif" font-size="16" letter-spacing="3" fill="#F7F1E3">DR. DAMOLA</text>
</svg>
RA_FILE_EOF_7X2K9

echo "  writing css/style.css"
cat > "$ROOT/css/style.css" << 'RA_FILE_EOF_7X2K9'
/* Rethinking Africa with Dr. Damola — mobile-first stylesheet
   Base styles target small phones; media queries enhance upward. */
:root{
  --indigo:#1D2A57;
  --indigo-night:#141D3D;
  --gold:#E8A11C;
  --ivory:#F7F1E3;
  --ink:#2A3350;
  --ink-soft:#5A6280;
}
*{margin:0;padding:0;box-sizing:border-box}
html{scroll-behavior:smooth}
body{
  font-family:Georgia,'Times New Roman',serif; /* system serif: zero download */
  color:var(--ink);
  background:var(--ivory);
  line-height:1.65;
  font-size:1.02rem;
}
h1,h2,h3{font-family:'Fraunces',Georgia,serif;color:var(--indigo);line-height:1.15}
h1{font-size:1.9rem}
h2{font-size:1.5rem;margin-bottom:1rem}
h3{font-size:1.12rem}
p+p{margin-top:.9rem}
a{color:var(--indigo)}
:focus-visible{outline:3px solid var(--gold);outline-offset:3px}
img,svg{max-width:100%;height:auto}

.eyebrow{
  font-family:Arial,Helvetica,sans-serif;font-weight:700;
  font-size:.7rem;letter-spacing:.2em;text-transform:uppercase;
  color:var(--gold);display:block;margin-bottom:.8rem;
}
.wrap{max-width:1020px;margin:0 auto;padding:0 1.1rem}
section{padding:2.6rem 0}

/* Header / nav */
header.site{background:var(--indigo);padding:.8rem 0}
header.site .wrap{display:flex;flex-wrap:wrap;align-items:center;gap:.6rem 1rem}
.brand{display:flex;align-items:center;gap:.6rem;text-decoration:none}
.brand svg{width:56px;height:47px;flex:none}
.brand span{
  color:var(--ivory);font-family:'Fraunces',Georgia,serif;
  font-weight:700;font-size:1.02rem;letter-spacing:.04em;
}
nav.main{width:100%;display:flex;flex-wrap:wrap;gap:.2rem .9rem}
nav.main a{
  color:var(--ivory);text-decoration:none;
  font-family:Arial,Helvetica,sans-serif;font-size:.78rem;
  letter-spacing:.1em;text-transform:uppercase;padding:.3rem 0;
}
nav.main a[aria-current="page"],nav.main a:hover{color:var(--gold)}

/* Buttons */
.btn{
  display:inline-block;font-family:Arial,Helvetica,sans-serif;font-weight:700;
  font-size:.88rem;letter-spacing:.05em;text-decoration:none;cursor:pointer;
  padding:.85rem 1.5rem;border-radius:3px;border:2px solid var(--gold);
}
.btn-solid{background:var(--gold);color:var(--indigo)}
.btn-ghost{background:transparent;color:var(--ivory)}
.btn-navy{background:var(--indigo);color:var(--ivory);border-color:var(--indigo)}

/* Hero */
.hero{background:var(--indigo);color:var(--ivory);text-align:center;padding:3rem 0}
.hero h1{color:var(--ivory);max-width:22ch;margin:0 auto 1rem}
.hero h1 em{color:var(--gold);font-style:italic}
.hero p.lede{max-width:52ch;margin:0 auto 1.8rem;color:#D8D3C4}
.hero .mark{width:130px;margin:0 auto 1.6rem;display:block}
.cta-row{display:flex;flex-direction:column;gap:.8rem;align-items:center}

/* Horizon device */
.horizon{position:relative;height:3px;background:var(--gold);border:0}
.horizon::after{
  content:"";position:absolute;left:50%;top:50%;width:12px;height:12px;
  border-radius:50%;background:var(--gold);transform:translate(-50%,-50%);
}

/* Cards & grids: single column on mobile */
.grid{display:grid;grid-template-columns:1fr;gap:1.1rem;margin-top:1.6rem}
.card{background:#FFFDF7;border:1px solid #E4DCC8;border-radius:4px;padding:1.2rem}
.card h3{margin-bottom:.4rem}
.card p{font-size:.95rem;color:var(--ink-soft)}
.terr{border-left:3px solid var(--gold);padding:.3rem 0 .3rem 1rem}

/* Video embed */
.video-frame{position:relative;padding-top:56.25%;background:var(--indigo-night);border-radius:4px;overflow:hidden}
.video-frame iframe,.video-frame .placeholder{position:absolute;inset:0;width:100%;height:100%;border:0}
.video-frame .placeholder{display:flex;align-items:center;justify-content:center;color:var(--ivory);font-family:Arial,sans-serif;font-size:.8rem;letter-spacing:.15em;text-transform:uppercase}

/* Dark sections */
.dark{background:var(--indigo-night);color:#E8E3D4}
.dark h2,.dark h3{color:var(--ivory)}
.dark a{color:var(--gold)}

/* Forms */
form .field{margin-bottom:1rem}
label{display:block;font-family:Arial,sans-serif;font-size:.92rem;letter-spacing:.06em;text-transform:uppercase;color:var(--indigo);margin-bottom:.4rem;font-weight:700}
/* Labels inside dark sections must be light, or they vanish into the background */
.dark label,.hero label{color:var(--ivory)}
.dark .note,.hero .note{color:#D8D3C4}
input,select,textarea{color:#1B2233}
input::placeholder,textarea::placeholder{color:#6E7590}
input:focus,select:focus,textarea:focus{border-color:var(--gold);outline:2px solid rgba(232,161,28,.35);outline-offset:1px}
.field{margin-bottom:1.15rem}
input,select,textarea{
  width:100%;padding:.8rem .9rem;border:1px solid #C9C0A8;border-radius:3px;
  background:#FFFDF7;font-family:Georgia,serif;font-size:1rem;color:var(--ink);
}
textarea{min-height:130px}
.signup-inline{display:flex;flex-direction:column;gap:.7rem;max-width:460px;margin:0 auto}
.note{font-size:.82rem;color:var(--ink-soft)}
.dark .note{color:#A8AEC6}

/* Footer */
footer.site{background:var(--indigo-night);color:#A8AEC6;padding:2.4rem 0;font-size:.88rem;text-align:center}
footer.site a{color:var(--ivory);text-decoration:none;margin:0 .55rem;font-family:Arial,sans-serif;font-size:.75rem;letter-spacing:.12em;text-transform:uppercase}
footer.site a:hover{color:var(--gold)}
footer.site .links{margin-bottom:1rem}

/* ===== Enhancements for larger screens ===== */
@media (min-width:640px){
  h1{font-size:2.5rem}
  h2{font-size:1.8rem}
  .cta-row{flex-direction:row;justify-content:center}
  .grid{grid-template-columns:1fr 1fr}
  .signup-inline{flex-direction:row}
  nav.main{width:auto;margin-left:auto}
}
@media (min-width:960px){
  h1{font-size:3rem}
  .grid.cols3{grid-template-columns:1fr 1fr 1fr}
  section{padding:3.6rem 0}
}
@media (prefers-reduced-motion:reduce){html{scroll-behavior:auto}}

/* ===== Portraits, galleries, news (added) ===== */
.portrait-row{display:grid;grid-template-columns:1fr;gap:1.4rem;align-items:center;margin-top:1.4rem}
.portrait{width:100%;max-width:320px;border-radius:4px;border-bottom:4px solid var(--gold);display:block;margin:0 auto}
.gallery{display:grid;grid-template-columns:1fr 1fr;gap:.7rem;margin-top:1.4rem}
.gallery img{width:100%;aspect-ratio:4/3;object-fit:cover;border-radius:3px}
.gallery figcaption{font-size:.78rem;color:var(--ink-soft);margin-top:.25rem}
.dark .gallery figcaption{color:#A8AEC6}
.post{border-bottom:1px solid #DCD3BC;padding:1.3rem 0}
.post:last-child{border-bottom:0}
.post .meta{font-family:Arial,sans-serif;font-size:.72rem;letter-spacing:.14em;text-transform:uppercase;color:var(--gold);margin-bottom:.35rem}
.post h3{margin-bottom:.35rem}
.post p{font-size:.96rem;color:var(--ink-soft)}
.announce{background:#FFFDF7;border-left:4px solid var(--gold);border-radius:3px;padding:1rem 1.2rem;margin-top:1rem}
.announce .meta{font-family:Arial,sans-serif;font-size:.72rem;letter-spacing:.14em;text-transform:uppercase;color:var(--gold)}
@media (min-width:640px){
  .portrait-row{grid-template-columns:320px 1fr}
  .gallery{grid-template-columns:repeat(3,1fr)}
}


/* ===== Hero with founder portrait (v3 design) ===== */
.hero-grid{display:grid;grid-template-columns:1fr;gap:2rem;align-items:center;text-align:center}
.hero-portrait{position:relative;width:min(64vw,270px);margin:0 auto}
.hero-portrait .ring{
  width:100%;aspect-ratio:1/1;border-radius:50%;
  border:4px solid var(--gold);padding:8px;background:rgba(232,161,28,.08);
}
.hero-portrait img{width:100%;height:100%;border-radius:50%;object-fit:cover;display:block}
.hero-portrait::before,.hero-portrait::after{
  content:"";position:absolute;top:50%;height:3px;width:16vw;max-width:90px;
  background:var(--gold);transform:translateY(-50%);
}
.hero-portrait::before{right:100%;margin-right:14px}
.hero-portrait::after{left:100%;margin-left:14px}
.hero-portrait figcaption{
  margin-top:.9rem;font-family:Arial,Helvetica,sans-serif;font-size:.72rem;
  letter-spacing:.18em;text-transform:uppercase;color:#D8D3C4;
}
@media (min-width:820px){
  .hero-grid{grid-template-columns:1.15fr .85fr;text-align:left}
  .hero-grid .cta-row{justify-content:flex-start}
  .hero-grid h1,.hero-grid p.lede{margin-left:0}
}

/* ===== Theme cards with illustrations ===== */
.theme-card{background:rgba(247,241,227,.05);border:1px solid rgba(232,161,28,.3);border-radius:4px;padding:1.2rem;text-align:left}
.theme-card svg{width:54px;height:54px;display:block;margin-bottom:.8rem}
.theme-card h3{color:var(--ivory);font-size:1.05rem;margin-bottom:.35rem}
.theme-card p{font-size:.92rem;color:#C6C9DA}

/* ===== Support section ===== */
.support-band{background:linear-gradient(160deg,var(--indigo) 0%,var(--indigo-night) 100%)}


/* ===== Interrupted Science before/after ===== */
.ba-grid{display:grid;grid-template-columns:1fr;gap:1rem;margin-top:1.6rem}
.ba-grid figure{margin:0}
.ba-grid img{width:100%;border-radius:4px;display:block}
.ba-label{
  display:inline-block;font-family:Arial,Helvetica,sans-serif;font-weight:700;
  font-size:.7rem;letter-spacing:.18em;text-transform:uppercase;
  padding:.35rem .7rem;border-radius:3px;margin-bottom:.5rem;
}
.ba-label.was{background:rgba(247,241,227,.15);color:#D8D3C4}
.ba-label.is{background:var(--gold);color:var(--indigo)}
.ba-grid figcaption{font-size:.85rem;color:#C6C9DA;margin-top:.5rem}
@media (min-width:640px){.ba-grid{grid-template-columns:1fr 1fr;gap:1.4rem}}


/* ===== Hero welcome animation (logo builds itself on arrival) ===== */
.hero-anim{width:150px;margin:0 auto 1.4rem;display:block}
@media (min-width:820px){.hero-anim{margin-left:0}}
.hero-anim .a-line{transform-origin:center;transform:scaleX(0);animation:ra-line 1s ease-out .2s forwards}
.hero-anim .a-sun{opacity:0;transform:translateY(70px);animation:ra-sun 1.4s ease-out .8s forwards}
.hero-anim .a-cont{opacity:0;animation:ra-fade .9s ease-out 1.5s forwards}
@keyframes ra-line{to{transform:scaleX(1)}}
@keyframes ra-sun{to{opacity:1;transform:translateY(0)}}
@keyframes ra-fade{to{opacity:1}}
@media (prefers-reduced-motion:reduce){
  .hero-anim .a-line,.hero-anim .a-sun,.hero-anim .a-cont{animation:none;opacity:1;transform:none}
}
RA_FILE_EOF_7X2K9

cat > "$ROOT/MISSING-IMAGES.txt" << 'RA_FILE_EOF_7X2K9'
These image files are binary and are not included in the rebuild script.
Copy them into the assets folder from the original site package
(rethinking-africa-website.zip) or re-upload them.

assets/claypot-evolution.webp
assets/dr-damola-headshot.webp
assets/dr-damola-portrait.jpg
assets/dr-damola-portrait.webp
assets/ifa-quantum.webp
assets/interrupted-after.webp
assets/interrupted-before.webp
assets/q1-knowledge.webp
assets/q2-classroom.webp
assets/q3-claypot.webp
assets/q4-ifa.webp
assets/q5-stone.webp
assets/q6-diaspora.webp
assets/q7-evolution.webp
assets/smart-city.webp

Until they are present, pages will show broken image placeholders.
Everything else — all pages, styles, logos and documentation — is complete.
RA_FILE_EOF_7X2K9


echo ""
echo "Done."
echo "  27 text files written"
echo "  15 image files still needed - see $ROOT/MISSING-IMAGES.txt"
echo ""
echo "To preview locally:  cd $ROOT && python3 -m http.server 8000"
