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
