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

The Home and Quiz pages are also published in French (`/fr/`), Hausa (`/ha/`), Arabic (`/ar/`, right to left) and Kiswahili (`/sw/`).
A pop-up on the first visit (`site/js/lang.js`) lets visitors pick a language; the globe button in the header changes it later.

The translated pages are generated, so do not edit `site/fr/` etc. by hand:

- English text to translate is listed in `i18n/source.json`; translations are in `i18n/fr.json`, `ha.json`, `ar.json`, `sw.json`.
- After changing an English page or a translation, run `node i18n/check.js` and then `node i18n/build.js`, and commit the result.
- To translate another page, add it to `PAGES` in `i18n/build.js` and its text to the JSON files.

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
