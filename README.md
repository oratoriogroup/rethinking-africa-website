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
