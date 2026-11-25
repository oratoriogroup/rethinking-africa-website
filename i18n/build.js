#!/usr/bin/env node
/* Builds translated copies of the English pages.
 *
 *   node i18n/build.js
 *
 * For each language below, every page in PAGES is read from site/,
 * its English text is swapped for the translation in i18n/<lang>.json,
 * and the result is written to site/<lang>/<page>.
 *
 * i18n/source.json holds { "_common": {id: english}, "index.html": {id: english}, ... }:
 * each id names an exact piece of English text on the page.
 * i18n/<lang>.json holds { id: translation }. An id with no translation stays
 * in English, and the script lists any English text it could not find on the
 * page, so edits to the English pages are caught.
 *
 * Run it again after changing an English page or a translation.
 * It also stamps the shared header and footer (i18n/layout/) into every English
 * page and refreshes their hreflang links.
 */
const fs = require("fs");
const path = require("path");

const SITE = path.join(__dirname, "..", "site");
const BASE = "https://rethinkingafrica.africa";

const LANGS = {
  fr: { dir: "ltr" },
  // Cormorant Garamond and Lato have no Hausa hooked letters, so load just those
  // six letters from Noto (a few KB, via Google Fonts' text= subsetting).
  ha: { dir: "ltr", fonts: "https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&family=Noto+Serif:wght@600;700&display=swap&text=%C9%93%C9%97%C6%99%C6%81%C6%8A%C6%98" },
  ar: { dir: "rtl", fonts: "https://fonts.googleapis.com/css2?family=Noto+Naskh+Arabic:wght@600;700&family=Noto+Sans+Arabic:wght@400;600;700&display=swap" },
  sw: { dir: "ltr" }
};
const PAGES = [
  "index.html", "quiz.html", "about.html", "watch.html", "ideas.html", "publications.html",
  "african-voices.html", "news.html", "contribute.html", "community.html", "contact.html",
  "canada-2026.html", "policies.html", "editorial.html"
];

const ALT_START = "<!--i18n:alternates-->";
const ALT_END = "<!--/i18n:alternates-->";

/* Language pages always use the full file name (/fr/index.html, not /fr/):
   vercel.json has trailingSlash:false, which turns /fr/ into /fr, and at /fr
   the page's relative links would resolve to the English pages. */
function pageUrl(lang, page) {
  if (lang === "en") return `${BASE}/${page === "index.html" ? "" : page}`;
  return `${BASE}/${lang}/${page}`;
}

function alternates(page) {
  const links = ["en", ...Object.keys(LANGS)].map(
    (l) => `<link rel="alternate" hreflang="${l}" href="${pageUrl(l, page)}">`
  );
  links.push(`<link rel="alternate" hreflang="x-default" href="${pageUrl("en", page)}">`);
  return `${ALT_START}\n${links.join("\n")}\n${ALT_END}`;
}

function setAlternates(html, page) {
  const block = alternates(page);
  const re = new RegExp(`${ALT_START}[\\s\\S]*?${ALT_END}`);
  return re.test(html) ? html.replace(re, block) : html.replace("</head>", `${block}\n</head>`);
}

/* Links to pages that exist in the language folder stay relative;
   everything else (assets, css, js, untranslated pages) points up one level. */
function fixPaths(html) {
  return html.replace(/\b(href|src)="(?!https?:|#|mailto:|tel:|data:|\.\.\/|\/)([^"]+)"/g, (m, attr, url) => {
    const file = url.split("#")[0].split("?")[0];
    if (attr === "href" && PAGES.includes(file)) return m;
    return `${attr}="../${url}"`;
  });
}

/* Shared header and footer: i18n/layout/header.html and footer.html are the one
   source for every page. Edit those files (not a page's own copy), then rebuild.
   The current page's menu link gets aria-current="page". */
const LAYOUT = path.join(__dirname, "layout");
const HEADER = fs.readFileSync(path.join(LAYOUT, "header.html"), "utf8").replace(/\r\n/g, "\n").trim();
const FOOTER = fs.readFileSync(path.join(LAYOUT, "footer.html"), "utf8").replace(/\r\n/g, "\n").trim();

function setLayout(html, page) {
  // Mark this page's own menu link, and open-highlight the menu group that holds it.
  const header = HEADER
    .replace(new RegExp(`(<a class="(?:nav-link|mi)[^"]*" href="${page.replace(".", "\\.")}")`), `$1 aria-current="page"`)
    .replace(/<details class="nav-group" data-pages="([^"]*)"/g, (m, list) =>
      list.split(" ").includes(page) ? `${m} data-current` : m);
  const out = html
    .replace(/<header class="site">[\s\S]*?<\/header>/, () => header)
    .replace(/<footer class="site">[\s\S]*?<\/footer>/, () => FOOTER);
  if (!/<header class="site">/.test(html) || !/<footer class="site">/.test(html)) {
    console.warn(`${page}: no <header class="site"> or <footer class="site"> to replace`);
    problems++;
  }
  return out;
}

let problems = 0;

// English pages: apply the shared header/footer and keep their hreflang links current.
for (const page of PAGES) {
  const file = path.join(SITE, page);
  const html = fs.readFileSync(file, "utf8");
  const eol = html.includes("\r\n") ? "\r\n" : "\n";
  const next = setAlternates(setLayout(html.replace(/\r\n/g, "\n"), page), page).replace(/\n/g, eol);
  if (next !== html) fs.writeFileSync(file, next, "utf8");
}

const source = JSON.parse(fs.readFileSync(path.join(__dirname, "source.json"), "utf8"));
// Ids listed in _keep stay in their original language on purpose (academic citations, paper titles, DOIs).
const keep = new Set(source._keep || []);

for (const [lang, cfg] of Object.entries(LANGS)) {
  // <lang>.json plus any <lang>.<part>.json files, merged.
  const files = fs.readdirSync(__dirname).filter((f) => new RegExp(`^${lang}(\\.[\\w-]+)?\\.json$`).test(f));
  if (!files.length) { console.warn(`skip ${lang}: no ${lang}.json`); continue; }
  const dict = Object.assign({}, ...files.map((f) => JSON.parse(fs.readFileSync(path.join(__dirname, f), "utf8"))));
  fs.mkdirSync(path.join(SITE, lang), { recursive: true });

  for (const page of PAGES) {
    let html = fs.readFileSync(path.join(SITE, page), "utf8").replace(/\r\n/g, "\n");
    const common = source._common || {};
    const ids = { ...common, ...(source[page] || {}) };
    // Longest English first, so a short phrase never breaks a longer sentence containing it.
    const order = Object.keys(ids).sort((a, b) => ids[b].length - ids[a].length);
    const missing = [];
    for (const id of order) {
      const en = ids[id];
      if (!(id in dict)) { if (!keep.has(id)) console.warn(`${lang}: no translation for "${id}"`); continue; }
      if (!html.includes(en)) { if (!(id in common)) missing.push(en); continue; }
      html = html.split(en).join(dict[id]);
    }
    html = html.replace('<html lang="en">', `<html lang="${lang}" dir="${cfg.dir}">`);
    html = fixPaths(html);
    if (cfg.fonts) {
      html = html.replace(/<link rel="stylesheet" href="\.\.\/css\/style\.css[^"]*">/,
        (m) => `<link href="${cfg.fonts}" rel="stylesheet">\n${m}`);
    }
    html = html.replace(/<meta property="og:url" content="[^"]*">/, `<meta property="og:url" content="${pageUrl(lang, page)}">`);
    html = setAlternates(html, page);
    html = `<!-- Generated by i18n/build.js from site/${page}. Edit the English page or i18n/${lang}.json, then rebuild. -->\n` + html;
    fs.writeFileSync(path.join(SITE, lang, page), html, "utf8");
    if (missing.length) {
      problems += missing.length;
      console.warn(`${lang}/${page}: ${missing.length} translation(s) not found in the English page:`);
      missing.forEach((m) => console.warn("   - " + m.slice(0, 90)));
    }
    console.log(`built ${lang}/${page}`);
  }
}
if (problems) { console.warn(`\n${problems} unmatched entries (English text changed?).`); process.exitCode = 1; }
