#!/usr/bin/env node
/* Sanity check for the translation files:
 *   node i18n/check.js
 * - every file is valid JSON with no duplicate ids
 * - every id in source.json has a translation in each language (and no extras)
 * - translations of JavaScript strings keep their surrounding quotes and contain no stray " */
const fs = require("fs");
const path = require("path");
const dir = __dirname;
let bad = 0;

function dupes(file) {
  const text = fs.readFileSync(file, "utf8");
  const seen = {}, out = [];
  // only count keys within the same object level by tracking page sections
  let section = "";
  for (const m of text.matchAll(/^\s*"([^"]+)":\s*(\{)?/gm)) {
    if (m[2]) { section = m[1]; continue; }
    const k = section + "|" + m[1];
    if (seen[k]) out.push(m[1]); seen[k] = 1;
  }
  return out;
}

const source = JSON.parse(fs.readFileSync(path.join(dir, "source.json"), "utf8"));
const keep = new Set(source._keep || []);
const ids = {};
for (const page of Object.keys(source).filter((p) => p !== "_keep")) for (const id of Object.keys(source[page])) {
  if (keep.has(id)) continue;
  if (ids[id]) { console.log(`source.json: id "${id}" used in both ${ids[id]} and ${page}`); bad++; }
  ids[id] = page;
}
const d = dupes(path.join(dir, "source.json"));
if (d.length) { console.log("source.json duplicate ids:", d.join(", ")); bad++; }

for (const lang of ["fr", "ha", "ar", "sw"]) {
  const files = fs.readdirSync(dir).filter((f) => new RegExp(`^${lang}(\\.[\\w-]+)?\\.json$`).test(f));
  if (!files.length) { console.log(`${lang}: missing file`); continue; }
  let dict = {};
  try {
    for (const f of files) {
      const part = JSON.parse(fs.readFileSync(path.join(dir, f), "utf8"));
      for (const k of Object.keys(part)) if (k in dict) { console.log(`${lang}: id "${k}" appears in two files`); bad++; }
      Object.assign(dict, part);
      const dd = dupes(path.join(dir, f));
      if (dd.length) { console.log(`${f}: duplicate ids: ${dd.join(", ")}`); bad++; }
    }
  } catch (e) { console.log(`${lang}: invalid JSON: ${e.message}`); bad++; continue; }
  const missing = Object.keys(ids).filter((k) => !(k in dict));
  const extra = Object.keys(dict).filter((k) => !(k in ids));
  if (missing.length) { console.log(`${lang}: ${missing.length} missing: ${missing.join(", ")}`); bad++; }
  if (extra.length) { console.log(`${lang}: unknown ids: ${extra.join(", ")}`); bad++; }
  for (const id of Object.keys(ids)) {
    const en = source[ids[id]][id], tr = dict[id];
    if (tr === undefined) continue;
    if (/^".*"$/s.test(en) && !(/^".*"$/s.test(tr) && !tr.slice(1, -1).includes('"'))) {
      console.log(`${lang}: "${id}" must be one "quoted" string with no " inside`); bad++;
    }
    if (/^'.*'$/s.test(en) && !(/^'.*'$/s.test(tr) && !tr.slice(1, -1).includes("'"))) {
      console.log(`${lang}: "${id}" must be one 'quoted' string with no straight ' inside (use ’)`); bad++;
    }
    // attribute values must not contain a straight double quote
    if (/^[a-z-]+="/.test(en) && tr.slice(tr.indexOf('"') + 1, -1).includes('"')) {
      console.log(`${lang}: "${id}" has a " inside an attribute value`); bad++;
    }
    // keep the same leading/trailing markup (e.g. ">", "</a>")
    const lead = en.match(/^[^A-Za-z0-9"]*/)[0], trail = en.match(/(<\/[a-z0-9]+>|[">])*$/i)[0];
    if (lead.startsWith("<") || lead.startsWith(">")) { if (!tr.startsWith(lead.trim().slice(0, 1))) { console.log(`${lang}: "${id}" lost its leading markup`); bad++; } }
    if (trail && !tr.endsWith(trail)) { console.log(`${lang}: "${id}" should end with ${trail}`); bad++; }
  }
  console.log(`${lang}: ${Object.keys(dict).length} entries checked`);
}
process.exitCode = bad ? 1 : 0;
console.log(bad ? `${bad} problem(s)` : "all good");
