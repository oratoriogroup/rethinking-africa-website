# Rethinking Africa with Dr. Damola — website

Static website for **Rethinking Africa with Dr. Damola** (rethinkingafrica.africa).

Plain HTML and one CSS file, by design. No framework, no build step.

## Layout

- `site/` — the website. Deploy this folder as-is (Netlify, Vercel or Cloudflare Pages).
- `handoff/HANDOFF-BRIEF.md` — project brief and hard rules. Read this first.
- `handoff/rebuild-rethinking-africa.sh` — backup script that regenerates the site files.

## Preview locally

```bash
cd site && python3 -m http.server 8000
```

## Languages

Every page is also published in French (`/fr/`), Hausa (`/ha/`), Arabic (`/ar/`, right to left) and Kiswahili (`/sw/`).
A pop-up on the first visit (`site/js/lang.js`) lets visitors pick a language; the globe button in the header changes it later.
The choice is remembered, so every page opens in that language.

The translated pages are generated, so do not edit `site/fr/` etc. by hand:

- English text to translate is listed in `i18n/source.json`; translations are in `i18n/<lang>.json` and `i18n/<lang>.pages.json`.
- Academic citations, paper titles and DOIs (ids listed under `_keep`) stay as published.
- After changing an English page:
  1. `node i18n/extract.js --write <page>.html` adds any new English text to `source.json`.
  2. Add the translations to the four language files.
  3. `node i18n/check.js` and `node i18n/build.js`, then `node i18n/scan.js` to confirm no English is left.
  4. Commit the result; pushing to `main` deploys it.
- A new page also needs adding to `PAGES` in `i18n/build.js` and to `sitemap.xml`.

## Outstanding configuration

Search the files for `DEVELOPER` to find every spot that still needs a form or mailing-list URL.
Full details are in `site/DEVELOPER-TASK-LIST.md`.

## Deploying on Vercel

1. In Vercel, choose **Add New → Project** and import `oratoriogroup/rethinking-africa-website`.
2. Set **Root Directory** to `site`.
3. Set **Framework Preset** to **Other**. Leave the build command and output directory empty.
4. Click **Deploy**, then test the temporary `*.vercel.app` address.
5. Only after testing, add `rethinkingafrica.africa` under **Settings → Domains** and update DNS as Vercel instructs.

`site/vercel.json` sets caching headers. `site/.vercelignore` keeps the internal `.md` guides off the public site.
