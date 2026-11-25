/* Main menu for Rethinking Africa with Dr. Damola.
 * Wide screens (1024px and up, when the words fit): a row of links and dropdown menus. A dropdown opens on
 *   hover (mouse) or click/tap/Enter; one at a time; Escape or a click outside closes it.
 * Phones and tablets: the ☰ button slides the menu in as a drawer; the dropdowns become
 *   accordions; Escape, the × button, the dimmed backdrop or choosing a link closes it.
 * The dropdowns are <details> elements, so the menu still works without this script. */
(function () {
  var header = document.querySelector("header.site");
  if (!header) return;
  var nav = header.querySelector("nav.main");
  var btn = header.querySelector(".menu-btn");
  var closeBtn = header.querySelector(".nav-close");
  var scrim = header.querySelector(".nav-scrim");
  var groups = Array.prototype.slice.call(header.querySelectorAll(".nav-group"));
  var mq = window.matchMedia("(min-width:1024px)");
  var hover = window.matchMedia("(hover:hover) and (pointer:fine)");
  var lastFocus = null;
  // "wide" = the one-row menu is showing (wide screen, and the words fit on one line)
  var wide = { get matches() { return mq.matches && !header.classList.contains("nav-drawer"); } };

  // Long languages (e.g. Hausa) may not fit on one row: keep the drawer instead.
  var wrap = header.querySelector(".wrap");
  function fit() {
    header.classList.remove("nav-drawer");
    if (!mq.matches) return;
    if (wrap.scrollWidth > wrap.clientWidth + 1 || nav.getBoundingClientRect().height > 60) header.classList.add("nav-drawer");
  }
  fit();
  window.addEventListener("resize", fit);
  if (document.fonts && document.fonts.ready) document.fonts.ready.then(fit);

  function closeGroups(except) {
    groups.forEach(function (g) { if (g !== except) g.removeAttribute("open"); });
  }

  /* ----- Dropdowns ----- */
  groups.forEach(function (g) {
    g.addEventListener("toggle", function () { if (g.open && wide.matches) closeGroups(g); });
    var t;
    g.addEventListener("mouseenter", function () {
      if (!wide.matches || !hover.matches) return;
      clearTimeout(t); closeGroups(g); g.setAttribute("open", "");
    });
    g.addEventListener("mouseleave", function () {
      if (!wide.matches || !hover.matches) return;
      t = setTimeout(function () { g.removeAttribute("open"); }, 180);
    });
  });
  document.addEventListener("click", function (e) {
    if (wide.matches && !e.target.closest(".nav-group")) closeGroups();
  });

  /* ----- Drawer ----- */
  function setOpen(open) {
    header.classList.toggle("nav-open", open);
    document.documentElement.classList.toggle("nav-locked", open);
    if (btn) btn.setAttribute("aria-expanded", open ? "true" : "false");
    if (scrim) { if (open) scrim.removeAttribute("hidden"); else scrim.setAttribute("hidden", ""); }
    if (open) {
      lastFocus = document.activeElement;
      // Open the group holding the current page, so the reader sees where they are.
      groups.forEach(function (g) { if (g.hasAttribute("data-current")) g.setAttribute("open", ""); });
      setTimeout(function () { (closeBtn || nav).focus(); }, 50);
    } else if (lastFocus && lastFocus.focus) {
      lastFocus.focus();
    }
  }
  if (btn) btn.addEventListener("click", function () { setOpen(!header.classList.contains("nav-open")); });
  if (closeBtn) closeBtn.addEventListener("click", function () { setOpen(false); });
  if (scrim) scrim.addEventListener("click", function () { setOpen(false); });
  nav.addEventListener("click", function (e) {
    if (e.target.closest("a") && header.classList.contains("nav-open")) setOpen(false);
  });

  document.addEventListener("keydown", function (e) {
    if (e.key === "Escape") {
      if (header.classList.contains("nav-open")) { setOpen(false); return; }
      var open = groups.filter(function (g) { return g.open; })[0];
      if (open) { open.removeAttribute("open"); open.querySelector("summary").focus(); }
    }
    // Keep keyboard focus inside the drawer while it is open.
    if (e.key === "Tab" && header.classList.contains("nav-open")) {
      var f = Array.prototype.filter.call(nav.querySelectorAll("a, summary, button"), function (el) { return el.offsetParent !== null; });
      if (!f.length) return;
      var first = f[0], last = f[f.length - 1];
      if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
      else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
    }
  });

  // Growing past tablet width: put the drawer away and reset the dropdowns.
  var onWide = function () { fit(); if (wide.matches && header.classList.contains("nav-open")) { setOpen(false); closeGroups(); } };
  if (mq.addEventListener) mq.addEventListener("change", onWide); else if (mq.addListener) mq.addListener(onWide);
})();
