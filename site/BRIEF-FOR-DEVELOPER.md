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
