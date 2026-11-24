/* Language chooser for Rethinking Africa with Dr. Damola.
 * - Every time someone arrives on the site (opens a link, types the address,
 *   opens a new tab) or refreshes the page, a pop-up asks which language they want.
 * - Moving between pages of the site does not show it again; the chosen
 *   language is kept from page to page.
 * - A language button in the header reopens it at any time.
 * - The choice is remembered on this device (localStorage).
 * - Translated versions of a page are found from its <link rel="alternate" hreflang> tags,
 *   so pages that are not translated yet simply stay in English.
 * The page works fully without this script; it only adds the chooser. */
(function () {
  var KEY = "ra-lang";
  var LANGS = [
    { code: "en", name: "English", hint: "Choose your language" },
    { code: "fr", name: "Français", hint: "Choisissez votre langue" },
    { code: "ha", name: "Hausa", hint: "Zaɓi harshenka" },
    { code: "ar", name: "العربية", hint: "اختر لغتك" },
    { code: "sw", name: "Kiswahili", hint: "Chagua lugha yako" }
  ];
  var current = (document.documentElement.lang || "en").slice(0, 2);

  function store(code) { try { localStorage.setItem(KEY, code); } catch (e) {} }
  function saved() { try { return localStorage.getItem(KEY); } catch (e) { return null; } }

  function versionFor(code) {
    var link = document.querySelector('link[rel="alternate"][hreflang="' + code + '"]');
    if (!link) return null;
    // Stay on this host (works on the Vercel address as well as the real domain).
    var path;
    try { path = new URL(link.href).pathname; }
    catch (e) { path = link.getAttribute("href").replace(/^https?:\/\/[^/]+/, ""); } // very old browsers
    return location.protocol + "//" + location.host + path + location.hash;
  }

  function go(code) {
    store(code);
    if (code === current) { close(); return; }
    var url = versionFor(code);
    if (url) location.href = url;
    else close(); // this page is not translated yet
  }

  // Is this a fresh arrival (link from elsewhere, typed address, new tab) or a refresh,
  // rather than a click from another page of this site?
  function isArrival() {
    var nav = performance.getEntriesByType && performance.getEntriesByType("navigation")[0];
    if (nav && nav.type === "reload") return true;
    var fromHere = false;
    try { fromHere = document.referrer && new URL(document.referrer).origin === location.origin; } catch (e) {}
    return !fromHere;
  }
  var arrival = isArrival();

  // Moving around the site: keep the remembered language, opening the matching
  // version of this page if there is one. (On arrival the pop-up decides instead.)
  var pref = saved();
  if (!arrival && pref && pref !== current) {
    var target = versionFor(pref);
    if (target && target !== location.href) { location.replace(target); return; }
  }

  /* The pop-up is a plain fixed overlay rather than <dialog>, so it shows
     correctly in every phone browser, including Opera Mini, older Android
     browsers and the in-app browsers of WhatsApp, Facebook and Instagram. */
  var overlay, lastFocus;
  function build() {
    overlay = document.createElement("div");
    overlay.className = "lang-overlay";
    overlay.setAttribute("hidden", "");
    var html = '<div class="lang-dialog" role="dialog" aria-modal="true" aria-labelledby="lang-title">' +
      '<button type="button" class="lang-close" aria-label="Close">&times;</button>' +
      '<p class="lang-title" id="lang-title">Choose your language</p>' +
      '<ul class="lang-list">';
    LANGS.forEach(function (l) {
      var rtl = l.code === "ar" ? ' dir="rtl"' : "";
      html += '<li><button type="button" class="lang-option' + (l.code === current ? " is-current" : "") +
        '" data-lang="' + l.code + '" lang="' + l.code + '"' + rtl + '>' +
        '<span class="lang-name">' + l.name + '</span>' +
        (l.code === "en" ? "" : '<span class="lang-hint">' + l.hint + '</span>') +
        '</button></li>';
    });
    overlay.innerHTML = html + "</ul></div>";
    overlay.addEventListener("click", function (e) {
      var b = e.target.closest ? e.target.closest("[data-lang]") : null;
      if (b) go(b.getAttribute("data-lang"));
      else if ((e.target.closest && e.target.closest(".lang-close")) || e.target === overlay) close();
    });
    document.addEventListener("keydown", function (e) {
      if (overlay.hasAttribute("hidden")) return;
      if (e.key === "Escape") close();
      if (e.key === "Tab") { // keep keyboard focus inside the pop-up
        var f = overlay.querySelectorAll("button"), first = f[0], last = f[f.length - 1];
        if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
        else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
      }
    });
    document.body.appendChild(overlay);
  }
  function open() {
    if (!overlay) build();
    lastFocus = document.activeElement;
    overlay.removeAttribute("hidden");
    document.documentElement.classList.add("lang-open"); // stop the page scrolling behind it
    var cur = overlay.querySelector(".is-current") || overlay.querySelector(".lang-option");
    if (cur && cur.focus) cur.focus();
  }
  function close() {
    if (!saved()) store(current);
    if (overlay) overlay.setAttribute("hidden", "");
    document.documentElement.classList.remove("lang-open");
    if (lastFocus && lastFocus.focus) lastFocus.focus();
  }

  // Header button
  var header = document.querySelector("header.site .wrap");
  if (header) {
    var btn = document.createElement("button");
    btn.type = "button";
    btn.className = "lang-btn";
    btn.setAttribute("aria-label", "Language / Langue / Harshe / اللغة / Lugha");
    btn.innerHTML = '<svg viewBox="0 0 24 24" aria-hidden="true"><circle cx="12" cy="12" r="9.5" fill="none" stroke="currentColor" stroke-width="1.8"/><path d="M2.5 12h19M12 2.5c2.8 3 2.8 16 0 19M12 2.5c-2.8 3-2.8 16 0 19" fill="none" stroke="currentColor" stroke-width="1.8"/></svg><span>' + current.toUpperCase() + "</span>";
    btn.addEventListener("click", open);
    var nav = header.querySelector("nav.main");
    header.insertBefore(btn, nav);

    // If logo, menu and button do not fit on one line, use the two-row layout.
    var site = header.parentNode, brand = header.querySelector(".brand");
    var fit = function () {
      site.classList.remove("stacked");
      if (!nav || !brand || !window.matchMedia("(min-width:1320px)").matches) return;
      var top = brand.getBoundingClientRect().top;
      var navOff = Math.abs(nav.getBoundingClientRect().top - top) > 20;
      var btnOff = Math.abs(btn.getBoundingClientRect().top - top) > 30;
      var navTwoLines = nav.getBoundingClientRect().height > 60;
      if (navOff || btnOff || navTwoLines) site.classList.add("stacked");
    };
    fit();
    window.addEventListener("resize", fit);
    if (document.fonts && document.fonts.ready) document.fonts.ready.then(fit);
  }

  if (arrival) open();
})();
