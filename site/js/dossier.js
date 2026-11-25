/* Africa Lens Quiz: the PDF profile ("dossier").
 * window.RADossier.download(data) draws A4 pages on a canvas with the site's own fonts
 * (so Arabic, Hausa hooked letters and French accents all render correctly), turns each
 * page into a JPEG and wraps them in a small hand-written PDF. No library, no server.
 *
 * data = {
 *   key: "BB", name: "Ada", date: "25 November 2026", dir: "ltr" | "rtl",
 *   profile: { name, rarity, desc, strength, q },
 *   answers: [{ q: "question", a: "answer" }, ...],
 *   labels: { quiz, profile, question, transcript, questionOf, yourAnswer, motto, preparedFor }
 * } */
(function () {
  var W = 1240, H = 1754;                 // A4 at 150 dpi
  var M = 110;                            // page margin
  var C = { indigo: "#1D2A57", night: "#141D3D", gold: "#E8A11C", goldDeep: "#865B0A", ivory: "#F7F1E3",
            cloth: "#FBF7EE", ink: "#2A3350", soft: "#5A6280", line: "#E2D8C2", wash: "#FFF6E2" };
  var SLUG = { KR: "The-Knowledge-Recoverer", BB: "The-Bridge-Builder", SR: "The-System-Reformer", ST: "The-Story-Restorer", FM: "The-Future-Maker" };

  function cssVar(n) { return getComputedStyle(document.documentElement).getPropertyValue(n).trim(); }
  var SERIF = cssVar("--serif") || "Georgia, serif";
  var SANS = cssVar("--sans") || "Arial, sans-serif";

  function Page(rtl) {
    var c = document.createElement("canvas");
    c.width = W; c.height = H;
    var x = c.getContext("2d");
    x.fillStyle = C.ivory; x.fillRect(0, 0, W, H);
    x.textBaseline = "alphabetic";
    if (rtl) x.direction = "rtl";
    return { canvas: c, ctx: x, rtl: rtl };
  }
  function font(p, size, opts) {
    opts = opts || {};
    p.ctx.font = (opts.italic ? "italic " : "") + (opts.weight || 400) + " " + size + "px " + (opts.serif ? SERIF : SANS);
  }
  // Text at a left-hand x in page terms; mirrored for right-to-left pages.
  function text(p, s, x, y, color, align) {
    var ctx = p.ctx;
    ctx.fillStyle = color;
    if (align === "center") { ctx.textAlign = "center"; ctx.fillText(s, W / 2, y); return; }
    if (p.rtl) { ctx.textAlign = "right"; ctx.fillText(s, W - x, y); }
    else { ctx.textAlign = "left"; ctx.fillText(s, x, y); }
  }
  function wrap(p, s, maxW) {
    var words = String(s).split(/\s+/), lines = [], line = "";
    words.forEach(function (w) {
      var test = line ? line + " " + w : w;
      if (p.ctx.measureText(test).width > maxW && line) { lines.push(line); line = w; } else line = test;
    });
    if (line) lines.push(line);
    return lines;
  }
  function para(p, s, x, y, maxW, lh, color, align) {
    wrap(p, s, maxW).forEach(function (l, i) { text(p, l, x, y + i * lh, color, align); });
    return y + wrap(p, s, maxW).length * lh;
  }
  function round(ctx, x, y, w, h, r) {
    ctx.beginPath();
    ctx.moveTo(x + r, y); ctx.arcTo(x + w, y, x + w, y + h, r); ctx.arcTo(x + w, y + h, x, y + h, r);
    ctx.arcTo(x, y + h, x, y, r); ctx.arcTo(x, y, x + w, y, r); ctx.closePath();
  }
  function footer(p, d, n, total) {
    var ctx = p.ctx;
    ctx.fillStyle = C.line; ctx.fillRect(M, H - 150, W - 2 * M, 2);
    font(p, 26, { serif: true, italic: true });
    para(p, d.labels.motto, M, H - 100, W - 2 * M, 34, C.soft, "center");
    font(p, 22, { weight: 700 });
    text(p, "Rethinking Africa with Dr. Damola  ·  " + n + " / " + total, 0, H - 40, C.goldDeep, "center");
  }

  function emblem() {
    var svg = document.querySelector("header .brand svg");
    if (!svg) return Promise.resolve(null);
    var src = svg.outerHTML.replace("<svg", '<svg xmlns="http://www.w3.org/2000/svg" width="560" height="470"');
    var img = new Image();
    img.src = "data:image/svg+xml;charset=utf-8," + encodeURIComponent(src);
    return (img.decode ? img.decode() : Promise.resolve()).then(function () { return img; }, function () { return null; });
  }

  function cover(d, logo) {
    var p = Page(d.dir === "rtl"), ctx = p.ctx, maxW = W - 2 * M, y;
    // Indigo cover band with a gold selvedge
    ctx.fillStyle = C.indigo; ctx.fillRect(0, 0, W, 720);
    ctx.fillStyle = C.gold; ctx.fillRect(0, 720, W, 8);
    if (logo) { var lh = 120, lw = lh * 560 / 470; ctx.drawImage(logo, p.rtl ? W - M - lw : M, 80, lw, lh); }
    var tx = M + 120 * 560 / 470 + 26;
    font(p, 50, { serif: true, weight: 700 }); text(p, "Rethinking Africa", tx, 140, C.ivory);
    font(p, 32, { serif: true, italic: true, weight: 600 }); text(p, "with Dr. Damola", tx, 184, C.gold);
    // Profile
    font(p, 26, { weight: 700 }); text(p, d.labels.profile.toUpperCase(), M, 330, C.gold);
    font(p, 92, { serif: true, weight: 700 }); y = para(p, d.profile.name, M, 430, maxW, 98, C.ivory);
    // Rarity pill
    font(p, 26, { weight: 700 });
    var pw = ctx.measureText(d.profile.rarity).width + 56, px = p.rtl ? W - M - pw : M, py = y - 20;
    ctx.strokeStyle = C.gold; ctx.lineWidth = 2; round(ctx, px, py, pw, 56, 28); ctx.stroke();
    text(p, d.profile.rarity, M + 28, py + 37, C.gold);
    font(p, 26); text(p, d.labels.preparedFor, M, 680, "#C6C9DA");

    // Body
    y = 830;
    font(p, 34); y = para(p, d.profile.desc, M, y, maxW, 54, C.ink) + 40;
    // Strength
    font(p, 40, { serif: true, italic: true, weight: 600 });
    var sl = wrap(p, d.profile.strength, maxW - 100), sh = sl.length * 54 + 70;
    ctx.fillStyle = C.wash; round(ctx, M, y, maxW, sh, 24); ctx.fill();
    ctx.strokeStyle = C.gold; ctx.lineWidth = 3; ctx.stroke();
    sl.forEach(function (l, i) { text(p, l, M + 50, y + 70 + i * 54, C.indigo); });
    y += sh + 50;
    // One question to carry
    font(p, 40, { serif: true, weight: 700 });
    var ql = wrap(p, d.profile.q, maxW - 100), qh = ql.length * 52 + 120;
    ctx.fillStyle = "#FFFFFF"; round(ctx, M, y, maxW, qh, 24); ctx.fill();
    ctx.strokeStyle = C.line; ctx.lineWidth = 2; ctx.stroke();
    font(p, 26, { weight: 700 }); text(p, d.labels.question, M + 50, y + 62, C.goldDeep);
    font(p, 40, { serif: true, weight: 700 });
    ql.forEach(function (l, i) { text(p, l, M + 50, y + 118 + i * 52, C.indigo); });
    return p;
  }

  function transcript(d) {
    var pages = [], p, y, maxW = W - 2 * M;
    function newPage() {
      p = Page(d.dir === "rtl");
      p.ctx.fillStyle = C.indigo; p.ctx.fillRect(0, 0, W, 130);
      p.ctx.fillStyle = C.gold; p.ctx.fillRect(0, 130, W, 5);
      font(p, 28, { weight: 700 }); text(p, d.labels.quiz + "  ·  " + d.profile.name, M, 80, C.ivory);
      y = 240;
      pages.push(p);
    }
    newPage();
    font(p, 60, { serif: true, weight: 700 }); text(p, d.labels.transcript, M, y, C.indigo); y += 80;
    d.answers.forEach(function (a, i) {
      font(p, 36, { serif: true, weight: 700 }); var ql = wrap(p, a.q, maxW);
      font(p, 32, { weight: 700 }); var al = wrap(p, a.a, maxW - 60);
      var need = 60 + ql.length * 46 + 70 + al.length * 44 + 60;
      if (y + need > H - 190) newPage();
      font(p, 24, { weight: 700 }); text(p, d.labels.questionOf.replace("{n}", i + 1).replace("{total}", d.answers.length).toUpperCase(), M, y + 40, C.goldDeep);
      y += 60;
      font(p, 36, { serif: true, weight: 700 }); ql.forEach(function (l, k) { text(p, l, M, y + 40 + k * 46, C.indigo); });
      y += ql.length * 46 + 30;
      var bh = al.length * 44 + 76;
      p.ctx.fillStyle = "#FFFFFF"; round(p.ctx, M, y, maxW, bh, 18); p.ctx.fill();
      p.ctx.fillStyle = C.gold; p.ctx.fillRect(p.rtl ? W - M - 6 : M, y + 14, 6, bh - 28);
      font(p, 24, { weight: 700 }); text(p, d.labels.yourAnswer, M + 34, y + 40, C.soft);
      font(p, 32, { weight: 700 }); al.forEach(function (l, k) { text(p, l, M + 34, y + 84 + k * 44, C.ink); });
      y += bh + 34;
    });
    return pages;
  }

  /* ----- A minimal PDF: one full-page JPEG per page ----- */
  function jpegBytes(canvas) {
    var b64 = canvas.toDataURL("image/jpeg", 0.86).split(",")[1], bin = atob(b64), out = new Uint8Array(bin.length);
    for (var i = 0; i < bin.length; i++) out[i] = bin.charCodeAt(i);
    return out;
  }
  function pdf(canvases, title) {
    var parts = [], offset = 0, offs = [];
    function push(s) {
      var b;
      if (typeof s === "string") { b = new Uint8Array(s.length); for (var i = 0; i < s.length; i++) b[i] = s.charCodeAt(i) & 255; }
      else b = s;
      parts.push(b); offset += b.length;
    }
    function obj(id, body, stream) {
      offs[id] = offset;
      push(id + " 0 obj\n" + body + "\n");
      if (stream) { push("stream\n"); push(stream); push("\nendstream\n"); }
      push("endobj\n");
    }
    var n = canvases.length, kids = [], next = 4;
    push("%PDF-1.4\n%âãÏÓ\n");
    obj(1, "<< /Type /Catalog /Pages 2 0 R >>");
    canvases.forEach(function (c, i) { kids.push((next + i * 3) + " 0 R"); });
    obj(2, "<< /Type /Pages /Kids [" + kids.join(" ") + "] /Count " + n + " >>");
    obj(3, "<< /Title (" + title.replace(/[()\\]/g, "") + ") /Producer (Rethinking Africa with Dr. Damola) >>");
    canvases.forEach(function (c, i) {
      var pid = next + i * 3, iid = pid + 1, cid = pid + 2, img = jpegBytes(c);
      var draw = "q 595.28 0 0 841.89 0 0 cm /Im0 Do Q";
      obj(pid, "<< /Type /Page /Parent 2 0 R /MediaBox [0 0 595.28 841.89] /Resources << /XObject << /Im0 " + iid + " 0 R >> >> /Contents " + cid + " 0 R >>");
      obj(iid, "<< /Type /XObject /Subtype /Image /Width " + c.width + " /Height " + c.height + " /ColorSpace /DeviceRGB /BitsPerComponent 8 /Filter /DCTDecode /Length " + img.length + " >>", img);
      obj(cid, "<< /Length " + draw.length + " >>", draw);
    });
    var count = next + n * 3, xref = offset, x = "xref\n0 " + count + "\n0000000000 65535 f \n";
    for (var i = 1; i < count; i++) x += String(offs[i]).padStart(10, "0") + " 00000 n \n";
    push(x + "trailer\n<< /Size " + count + " /Root 1 0 R /Info 3 0 R >>\nstartxref\n" + xref + "\n%%EOF\n");
    return new Blob(parts, { type: "application/pdf" });
  }

  function fontsReady() {
    if (!document.fonts || !document.fonts.load) return Promise.resolve();
    var fams = [SERIF, SANS];
    return Promise.all([
      document.fonts.load("700 40px " + fams[0]), document.fonts.load("italic 600 40px " + fams[0]),
      document.fonts.load("400 30px " + fams[1]), document.fonts.load("700 30px " + fams[1])
    ]).catch(function () {});
  }

  function build(d) {
    return fontsReady().then(emblem).then(function (logo) {
      var pages = [cover(d, logo)].concat(transcript(d));
      pages.forEach(function (p, i) { footer(p, d, i + 1, pages.length); });
      return pdf(pages.map(function (p) { return p.canvas; }), "Africa Lens Profile - " + (SLUG[d.key] || "Profile").replace(/-/g, " "));
    });
  }

  window.RADossier = {
    filename: function (key) { return "Africa-Lens-Profile-" + (SLUG[key] || "Profile") + ".pdf"; },
    build: build,
    download: function (d) {
      return build(d).then(function (blob) {
        var url = URL.createObjectURL(blob), a = document.createElement("a");
        a.href = url; a.download = window.RADossier.filename(d.key);
        document.body.appendChild(a); a.click(); a.remove();
        setTimeout(function () { URL.revokeObjectURL(url); }, 4000);
        return blob;
      });
    }
  };
})();
