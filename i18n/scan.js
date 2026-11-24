#!/usr/bin/env node
/* Looks for English left on the translated pages.
 *   node i18n/scan.js
 * Lists visible text and alt/aria-label/placeholder/title/description text
 * that still reads as English. Brand names, emails, citations kept on purpose
 * (i18n/source.json "_keep") and lone proper nouns are ignored. */
const fs = require("fs");
const path = require("path");
const SITE = path.join(__dirname, "..", "site");
const source = JSON.parse(fs.readFileSync(path.join(__dirname, "source.json"), "utf8"));
const keepText = new Set();
for (const id of source._keep || []) {
  for (const p of Object.keys(source)) if (source[p] && source[p][id]) keepText.add(source[p][id].replace(/<[^>]+>/g, " ").replace(/\s+/g, " ").trim());
}
// Whole words only, counting letters such as ƙ and ɗ as part of a word (so Hausa "Haƙƙin" is not "in").
const EN = /(?<!\p{L})(the|and|of|to|your|you|with|for|is|are|this|that|our|we|from|on|in|be|will|what|how|why|read|join|watch|see|more|about)(?!\p{L})/giu;
const IGNORE = /Rethinking Africa|Dr\.? Damola|hello@|media@|research@|partnerships@|Oratorio|Africa Lens|Trained Away|YouTube|Instagram|TikTok|Facebook|LinkedIn|WhatsApp|doi\.org|ORCID/g;
let total = 0;
for (const lang of ["fr", "ha", "ar", "sw"]) {
  for (const file of fs.readdirSync(path.join(SITE, lang)).filter((f) => f.endsWith(".html"))) {
    let html = fs.readFileSync(path.join(SITE, lang, file), "utf8")
      .replace(/<!--[\s\S]*?-->/g, " ").replace(/<script[\s\S]*?<\/script>/g, " ").replace(/<svg[\s\S]*?<\/svg>/g, " ")
      .replace(/<head>[\s\S]*?<title>/, "<title>").replace(/<\/title>[\s\S]*?<\/head>/, "</title>");
    const bits = [];
    for (const m of html.matchAll(/\b(?:alt|aria-label|placeholder|title)="([^"]+)"/g)) bits.push(m[1]);
    const text = html.replace(/<[^>]+>/g, "\n").split("\n").map((s) => s.replace(/&[a-z#0-9]+;/g, " ").trim()).filter(Boolean);
    bits.push(...text);
    const hits = [];
    for (const b of bits) {
      const norm = b.replace(/\s+/g, " ").trim();
      if ([...keepText].some((k) => k.includes(norm) || norm.includes(k))) continue;
      const stripped = norm.replace(IGNORE, " ");
      const n = (stripped.match(EN) || []).length;
      if (n >= 2 && !hits.includes(norm)) hits.push(norm);
    }
    if (hits.length) { total += hits.length; console.log(`${lang}/${file}:`); hits.slice(0, 6).forEach((h) => console.log("   " + h.slice(0, 110))); }
  }
}
console.log(total ? `${total} English-looking piece(s) found` : "No English left on any translated page.");
