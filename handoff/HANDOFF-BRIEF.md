# HANDOFF BRIEF
## Rethinking Africa with Dr. Damola — website codebase

Paste this into the new Claude Code session first, so it understands the project
before touching anything.

---

## What this is

A finished, static website for **Rethinking Africa with Dr. Damola**, an
African-centred research, media and public-education platform founded by
Dr Oluwakemi Damola Adejumo-Ayibiowu.

Live domain: **rethinkingafrica.africa** (owned by Dr Damola).

## How to restore the codebase

Two ways, in order of preference.

**1. Upload `rethinking-africa-website.zip` and unzip it.** Complete, including
images.

**2. Run `rebuild-rethinking-africa.sh`.** A single self-contained script that
regenerates every page, the stylesheet, the SVG logos and all documentation. Then
unzip `site-images.zip` into the site folder to restore the 15 photographs.

```
bash rebuild-rethinking-africa.sh
unzip site-images.zip -d site/
cd site && python3 -m http.server 8000
```

---

## Hard rules for whoever works on this next

1. **Do not rebuild this in WordPress, React, or any framework.** It is plain HTML
   and one CSS file deliberately. The audience is largely on Nigerian mobile data.
   Each page is around 30 KB and needs no JavaScript to render. This is a design
   decision, not a gap.

2. **Never shorten the name to "Rethinking Africa".** Another scholar runs a
   similarly named platform at rethinkingafrica.org. The full name
   *Rethinking Africa with Dr. Damola* must appear in every page title, the header,
   meta descriptions and the JSON-LD. The `disambiguatingDescription` in index.html
   exists for this reason — keep it.

3. **Do not change the wording about giving.** Gifts support an *independent
   initiative* and are explicitly *not tax-deductible donations*. This is a legal
   position pending CAC registration.

4. **Do not describe the platform as a registered NGO or company.** The footer
   wording is deliberate.

5. **Colours:** Adire Indigo `#1D2A57`, Indigo Night `#141D3D`, Sunrise Gold
   `#E8A11C`, Warm Ivory `#F7F1E3`. Gold is an accent only, never a background.

---

## Structure

```
index.html            Home — hero, quiz band, themes, Interrupted Science, founder
quiz.html             The Africa Lens Quiz — the main conversion page
watch.html            Episode series
ideas.html            Articles and research
publications.html     Peer-reviewed work with DOIs, ORCID
african-voices.html   Featured voices, conference collections, community wall
news.html             Announcements, blog, events
contribute.html       Structured contribution form
community.html        Email, WhatsApp, LinkedIn, events
about.html            Vision, approach, founder biography
contact.html          Contacts and media kit
canada-2026.html      Canada Conversations collection
policies.html         Privacy, terms, copyright
editorial.html        Editorial and research standards
css/style.css         Single mobile-first stylesheet
assets/               Images, logos, favicon
```

---

## The one outstanding job

The site is complete. What remains is **configuration, not code**. Search the files
for the word `DEVELOPER` to find every marked spot.

**quiz.html** — a CONFIG block at the top of the script:
```js
SIGNUP_ENDPOINT     = ""   // Formspree or Web3Forms URL
MAILING_LIST_ACTION = ""   // MailerLite embedded form action URL
WHATSAPP_NUMBER     = ""   // digits only, with country code
```

**contribute.html** — near the bottom of the script:
```js
FORM_ENDPOINT       = ""   // Formspree or Web3Forms URL
CONTRIB_LIST_ACTION = ""   // MailerLite "Contributors" form action
```

**index.html** — find `REPLACE_WITH_MAILING_LIST_ACTION` and replace it with the
MailerLite form action URL.

Also still to do: `sitemap.xml`, `robots.txt`, Google Search Console verification,
and the YouTube embeds on the homepage (use a click-to-play thumbnail facade; never
autoplay with sound).

**Important context:** a previous developer claimed the email automation could not
work because the domain and hosting are in different places. That is not correct.
The seven-day email series runs entirely inside MailerLite. The website's only job
is to pass a subscriber's details to MailerLite through a form URL. Static hosting
handles this normally. See `HOW-FORMS-WORK-ON-STATIC.md` in the site folder.

---

## Hosting

The site is currently on a third-party server. The recommendation is to move it to
Netlify, Vercel or Cloudflare Pages — free, faster, and with the account in
Dr Damola's own name. Deployment is a drag-and-drop of the `site` folder.

The domain is already hers, so repointing DNS is entirely within her control.

Set up the new host and test it on its temporary address **before** repointing the
domain.

---

## Documentation already inside the site folder

- `MASTER-SETUP-GUIDE.md` — the complete operations guide: accounts, quiz flow,
  welcome email, seven-day series, contributions
- `HOW-FORMS-WORK-ON-STATIC.md` — why static hosting handles forms, for the
  developer
- `DEVELOPER-TASK-LIST.md` — the numbered outstanding tasks and sign-off test
- `EDITING-GUIDE-FOR-DR-DAMOLA.md` — plain-English guide for editing page text
- `BRIEF-FOR-DEVELOPER.md` and `README-FOR-DEVELOPER.md` — deployment brief and
  technical notes

---

## Working preference

Dr Damola prefers plain, unpacked prose — one idea at a time rather than several
compressed together. Apply that to any copy written for the site.
