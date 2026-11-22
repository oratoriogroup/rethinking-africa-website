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

**Done (November 2026).** The click-to-play facade is built (`js/video.js`). The
YouTube player loads only when a visitor presses play. Nothing autoplays.

What remains is to add the video IDs. In `index.html`, find the two `data-yt=""`
attributes (the trailer and "Trained Away") and put each video's 11-character
YouTube ID between the quotes. Until an ID is added, the box links to the channel.

---

## TASK 6 — Search visibility

1. ~~Add `sitemap.xml` and `robots.txt`.~~ Done. Add new pages to `sitemap.xml` when you create them.
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
