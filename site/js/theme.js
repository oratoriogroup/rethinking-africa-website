/* Light and dark mode for Rethinking Africa with Dr. Damola.
 * - Loaded in <head>, before the page is drawn, so there is no flash of the wrong theme.
 * - Until the reader chooses, the site follows their phone or computer setting
 *   (and changes with it, e.g. when a phone switches to dark mode at night).
 * - The sun/moon button in the header switches theme; the choice is remembered
 *   on this device (localStorage).
 * - Without JavaScript the site simply stays in the light theme and the button stays hidden. */
(function () {
  var KEY = "ra-theme";
  var root = document.documentElement;
  var system = window.matchMedia ? window.matchMedia("(prefers-color-scheme: dark)") : null;

  function saved() { try { return localStorage.getItem(KEY); } catch (e) { return null; } }
  function store(t) { try { localStorage.setItem(KEY, t); } catch (e) {} }
  function preferred() {
    var s = saved();
    if (s === "dark" || s === "light") return s;
    return system && system.matches ? "dark" : "light";
  }

  function apply(theme) {
    root.setAttribute("data-theme", theme);
    var btn = document.querySelector(".theme-btn");
    if (btn) btn.setAttribute("aria-pressed", theme === "dark" ? "true" : "false");
  }

  apply(preferred());
  root.classList.add("js");   // scripts are running: the menu can use its drawer

  // Text effects (js/textfx.js) will animate the headline in: hide it until they start,
  // so it does not flash first. css/style.css shows it anyway after 1.5s as a fallback.
  if (!(window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches)) root.classList.add("fx");

  // Follow the device setting while the reader has not chosen.
  if (system) {
    var onSystem = function () { if (!saved()) apply(preferred()); };
    if (system.addEventListener) system.addEventListener("change", onSystem);
    else if (system.addListener) system.addListener(onSystem);   // older Safari
  }

  function wire() {
    var btn = document.querySelector(".theme-btn");
    if (!btn) return;
    apply(root.getAttribute("data-theme"));
    btn.addEventListener("click", function () {
      var next = root.getAttribute("data-theme") === "dark" ? "light" : "dark";
      var calm = window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
      if (!calm) {
        root.classList.add("theme-changing");
        setTimeout(function () { root.classList.remove("theme-changing"); }, 400);
      }
      store(next);
      apply(next);
    });
  }
  if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", wire);
  else wire();
})();
