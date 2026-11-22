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
