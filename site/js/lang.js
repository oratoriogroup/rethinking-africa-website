/* Language chooser for Rethinking Africa with Dr. Damola.
 * - First visit: a pop-up asks which language the visitor prefers.
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
    var u = new URL(link.href);
    return location.origin + u.pathname + location.hash;
  }

  function go(code) {
    store(code);
    if (code === current) { close(); return; }
    var url = versionFor(code);
    if (url) location.href = url;
    else close(); // this page is not translated yet
  }

  // Remembered choice: open the matching version of this page if there is one.
  var pref = saved();
  if (pref && pref !== current) {
    var target = versionFor(pref);
    if (target && target !== location.href) { location.replace(target); return; }
  }

  var dialog;
  function build() {
    dialog = document.createElement("dialog");
    dialog.className = "lang-dialog";
    dialog.setAttribute("aria-labelledby", "lang-title");
    var html = '<button type="button" class="lang-close" aria-label="Close">&times;</button>' +
      '<p class="lang-title" id="lang-title">Choose your language</p>' +
      '<p class="lang-hints">' + LANGS.slice(1).map(function (l) {
        return '<span lang="' + l.code + '"' + (l.code === "ar" ? ' dir="rtl"' : "") + ">" + l.hint + "</span>";
      }).join(" · ") + "</p><div class=\"lang-list\">";
    LANGS.forEach(function (l) {
      html += '<button type="button" class="lang-option' + (l.code === current ? " is-current" : "") +
        '" data-lang="' + l.code + '" lang="' + l.code + '"' + (l.code === "ar" ? ' dir="rtl"' : "") + ">" + l.name + "</button>";
    });
    dialog.innerHTML = html + "</div>";
    dialog.addEventListener("click", function (e) {
      var b = e.target.closest("[data-lang]");
      if (b) go(b.getAttribute("data-lang"));
      else if (e.target.closest(".lang-close") || e.target === dialog) close();
    });
    dialog.addEventListener("cancel", function () { if (!saved()) store(current); });
    document.body.appendChild(dialog);
  }
  function open() {
    if (!dialog) build();
    if (typeof dialog.showModal === "function") dialog.showModal(); else dialog.setAttribute("open", "");
  }
  function close() {
    if (!saved()) store(current);
    if (dialog) { if (typeof dialog.close === "function") dialog.close(); else dialog.removeAttribute("open"); }
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

  if (!pref) open();
})();
