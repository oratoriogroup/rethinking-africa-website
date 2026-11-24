# Emailing quiz results with EmailJS
## Rethinking Africa with Dr. Damola

When someone finishes the Africa Lens Quiz, they type their email address.
The site emails them their seven answers and their profile.
Only after that email has been sent does the profile appear on screen.

EmailJS does the sending. It is free for up to 200 emails a month.
Setup takes about ten minutes and is done once.

---

## Step 1 — Create the account

Go to **emailjs.com** and sign up. Use the email address that should own the account.

## Step 2 — Connect the sending inbox

1. Open **Email Services** and choose **Add New Service**.
2. Pick **Gmail** (or the provider of the inbox you want emails to come from).
3. Sign in to that inbox when asked and allow EmailJS to send email.
4. Save. Copy the **Service ID**. It looks like `service_ab12cd3`.

## Step 3 — Create the email template

1. Open **Email Templates** and choose **Create New Template**.
2. In the template settings, set these:
   - **To Email:** `{{to_email}}`
   - **From Name:** `Rethinking Africa with Dr. Damola`
   - **Reply To:** `hello@rethinkingafrica.africa`
   - **Subject:** `{{subject}}`
3. Choose **Edit Content**, then **Code Editor**, and paste the whole of `i18n/emailjs-template.html`
   (in the project's `i18n` folder). Click **Apply Changes**.

   The template has no fixed wording of its own. The quiz sends every sentence
   (greeting, headings, button text, motto and the subject line) in the reader's
   language, plus the text direction for Arabic. To change the wording, edit the
   `mail...` lines in the `UI` list in `quiz.html` and their translations in `i18n/`,
   not the template.

4. Save. Copy the **Template ID**. It looks like `template_xy98zw7`.

## Step 4 — Copy the public key

Open **Account**, then **General**. Copy the **Public Key**.

## Step 5 — Put the three values into the site

Open `quiz.html`. Near the top of the script, fill in:

```js
EMAILJS_PUBLIC_KEY:  "paste public key here",
EMAILJS_SERVICE_ID:  "paste service ID here",
EMAILJS_TEMPLATE_ID: "paste template ID here"
```

These values are safe to have in the website. EmailJS designs the public key to be visible.

## Step 6 — Protect the account

In EmailJS, open **Account**, then **Security**. If it offers a list of allowed
domains, add `rethinkingafrica.africa`. This stops other websites from using your
sending allowance. Also switch on any rate limit it offers, such as one email every
few seconds.

---

## Test

Take the quiz with your own email address. The email should arrive within a minute.
If it is not in the inbox, check Promotions and Spam.
