#!/usr/bin/env node
/* Lists the English text on a page that is not yet in i18n/source.json.
 *   node i18n/extract.js about.html [more.html ...]          -> prints JSON to paste
 *   node i18n/extract.js --write about.html [more.html ...]  -> adds it to source.json
 * Picks up: <title>, meta descriptions, alt/aria-label/placeholder text, and the
 * inner HTML of text blocks (headings, paragraphs, list items, labels, buttons,
 * links, captions, table cells...). Inline tags stay inside the text so a
 * sentence is translated as a whole. HTML comments and scripts are skipped. */
const fs = require("fs");
const path = require("path");
const SITE = path.join(__dirname, "..", "site");
const srcFile = path.join(__dirname, "source.json");

const args = process.argv.slice(2);
const write = args[0] === "--write";
const pages = write ? args.slice(1) : args;
const source = JSON.parse(fs.readFileSync(srcFile, "utf8"));
// The build only applies shared (_common) text plus the page's own entries,
// so only those count as already covered.
const knownFor = (page) => new Set([...Object.values(source._common || {}), ...Object.values(source[page] || {})]);

const BLOCKS = "h1|h2|h3|h4|p|li|label|figcaption|button|td|th|dt|dd|blockquote|summary|option|caption|legend";
const INLINE = "a|span|strong|em|small|b|i";
const hasWords = (s) => /[A-Za-z]{2,}/.test(s.replace(/<[^>]+>/g, "").replace(/&[a-z]+;/g, ""));

for (const page of pages) {
  let html = fs.readFileSync(path.join(SITE, page), "utf8").replace(/\r\n/g, "\n");
  html = html.replace(/<!--[\s\S]*?-->/g, (m) => " ".repeat(m.length))
             .replace(/<script[\s\S]*?<\/script>/g, (m) => " ".repeat(m.length))
             .replace(/<svg[\s\S]*?<\/svg>/g, (m) => " ".repeat(m.length));
  const found = [];
  const known = knownFor(page);
  // Brand and network names stay as they are in every language.
  const KEEP = /^(YouTube|Instagram|TikTok|Facebook|X|LinkedIn|WhatsApp|ORCID|Google Scholar|ResearchGate|Academia\.edu)$/;
  const NAMES = ["Rethinking Africa with Dr. Damola", "Dr Oluwakemi Damola Adejumo-Ayibiowu", "hello@rethinkingafrica.africa",
    "media@rethinkingafrica.africa", "partnerships@rethinkingafrica.africa"];
  const knownList = [...known, ...NAMES].sort((a, b) => b.length - a.length);
  const leftover = (s) => { let r = s; for (const k of knownList) if (k.length > 3) r = r.split(k).join(" "); return r; };
  const add = (s) => {
    if (!s || found.includes(s) || known.has(s)) return;
    const text = s.replace(/^>|<\/[a-z0-9]+>$/gi, "").replace(/^(alt|aria-label|placeholder|title|content)="|"$/g, "");
    if (KEEP.test(text.trim()) || /Rethinking Africa<br>/.test(text)) return;
    if (!hasWords(leftover(text))) return;
    found.push(s);
  };

  const t = html.match(/<title>([\s\S]*?)<\/title>/); if (t) add(`<title>${t[1]}</title>`);
  for (const m of html.matchAll(/<meta (?:name="description"|property="og:(?:description|title)") content="([^"]*)"/g)) add(`content="${m[1]}"`);
  for (const m of html.matchAll(/\b(alt|aria-label|placeholder|title)="([^"]*[A-Za-z]{2,}[^"]*)"/g)) {
    if (/^https?:/.test(m[2])) continue;
    add(`${m[1]}="${m[2]}"`);
  }
  // Text blocks: take the innermost block (no nested block inside).
  const blockRe = new RegExp(`<(${BLOCKS})(\\s[^>]*)?>([\\s\\S]*?)</\\1>`, "g");
  const blockSpans = [];
  for (const m of html.matchAll(blockRe)) {
    let inner = m[3];
    if (new RegExp(`<(${BLOCKS})[\\s>]`).test(inner)) continue; // has nested blocks; children are caught on their own
    blockSpans.push([m.index, m.index + m[0].length]);
    const trimmed = inner.trim();
    if (trimmed) add(`>${trimmed}</${m[1]}>`);
  }
  // Inline elements that are not inside a block (nav links, eyebrow spans, buttons as links).
  const inlineRe = new RegExp(`<(${INLINE})(\\s[^>]*)?>([^<]*(?:<(?!/\\1>)[^<]*)*)</\\1>`, "g");
  for (const m of html.matchAll(inlineRe)) {
    if (blockSpans.some(([a, b]) => m.index >= a && m.index < b)) continue;
    const trimmed = m[3].trim();
    if (trimmed && !/<(div|section)/.test(trimmed)) add(`>${trimmed}</${m[1]}>`);
  }

  const key = page.replace(/\.html$/, "");
  const out = {};
  // Continue numbering after the page's highest existing id, never reuse one.
  const used = Object.keys(source[page] || {}).map((k) => +k.split(".").pop()).filter((n) => !Number.isNaN(n));
  let next = used.length ? Math.max(...used) + 1 : 1;
  found.forEach((s) => { out[`${key}.${String(next++).padStart(3, "0")}`] = s; });
  if (write) {
    source[page] = { ...(source[page] || {}), ...out };
    console.log(`${page}: ${found.length} new text pieces added`);
  } else {
    console.log(JSON.stringify({ [page]: out }, null, 2));
  }
}
if (write) fs.writeFileSync(srcFile, JSON.stringify(source, null, 2) + "\n", "utf8");
