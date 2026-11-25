/* Carousels for Rethinking Africa with Dr. Damola.
 * Markup: <div class="carousel" data-carousel aria-labelledby="…"><div class="carousel-track"> slides </div></div>
 * The track is a normal scrollable row (CSS scroll-snap), so it swipes on phones and
 * works without this script. The script adds previous/next buttons, dots and arrow keys,
 * and hides them when every slide already fits on screen. */
(function () {
  var L = {
    en: ["Previous", "Next", "Slide {n} of {m}"],
    fr: ["Précédent", "Suivant", "Diapositive {n} sur {m}"],
    ha: ["Na baya", "Na gaba", "Shafi {n} cikin {m}"],
    ar: ["السابق", "التالي", "الشريحة {n} من {m}"],
    sw: ["Iliyotangulia", "Inayofuata", "Slaidi {n} kati ya {m}"]
  };
  var lang = (document.documentElement.lang || "en").slice(0, 2);
  var t = L[lang] || L.en;
  var rtl = document.documentElement.dir === "rtl";
  var calm = window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var arrow = '<svg viewBox="0 0 24 24" aria-hidden="true"><path d="M14.5 5.5 8 12l6.5 6.5"/></svg>';

  Array.prototype.forEach.call(document.querySelectorAll("[data-carousel]"), function (root) {
    var track = root.querySelector(".carousel-track");
    var slides = Array.prototype.slice.call(track.children);
    if (slides.length < 2) return;
    root.setAttribute("role", "region");
    root.setAttribute("aria-roledescription", "carousel");
    track.setAttribute("tabindex", "0");
    slides.forEach(function (s, i) {
      s.setAttribute("role", "group");
      s.setAttribute("aria-roledescription", "slide");
      s.setAttribute("aria-label", t[2].replace("{n}", i + 1).replace("{m}", slides.length));
    });

    var ui = document.createElement("div");
    ui.className = "carousel-ui";
    var prev = document.createElement("button");
    prev.type = "button"; prev.className = "car-btn car-prev"; prev.setAttribute("aria-label", t[0]); prev.innerHTML = arrow;
    var next = document.createElement("button");
    next.type = "button"; next.className = "car-btn car-next"; next.setAttribute("aria-label", t[1]); next.innerHTML = arrow;
    var dots = document.createElement("div");
    dots.className = "car-dots";
    var dotEls = slides.map(function (s, i) {
      var d = document.createElement("button");
      d.type = "button"; d.className = "car-dot";
      d.setAttribute("aria-label", t[2].replace("{n}", i + 1).replace("{m}", slides.length));
      d.addEventListener("click", function () { go(i); });
      dots.appendChild(d);
      return d;
    });
    ui.appendChild(prev); ui.appendChild(dots); ui.appendChild(next);
    root.appendChild(ui);

    var current = 0;
    function go(i) {
      i = Math.max(0, Math.min(slides.length - 1, i));
      var s = slides[i];
      // Scroll the track itself (not the page) so the slide's start edge lines up.
      var start = rtl ? (track.getBoundingClientRect().right - s.getBoundingClientRect().right)
                      : (s.getBoundingClientRect().left - track.getBoundingClientRect().left);
      var from = track.scrollLeft, by = rtl ? -start : start;
      track.scrollBy({ left: by, behavior: calm ? "auto" : "smooth" });
      // Safety net: some browsers ignore smooth scrolling; then jump straight there.
      setTimeout(function () { if (Math.abs(track.scrollLeft - from) < 2 && Math.abs(by) > 2) track.scrollLeft = from + by; }, 450);
    }
    function update() {
      // The current slide is the one whose start edge is nearest the track's start edge.
      var tr = track.getBoundingClientRect(), best = 0, bestD = Infinity;
      slides.forEach(function (s, i) {
        var r = s.getBoundingClientRect();
        var d = Math.abs(rtl ? (tr.right - r.right) : (r.left - tr.left));
        if (d < bestD) { bestD = d; best = i; }
      });
      current = best;
      dotEls.forEach(function (d, i) { d.setAttribute("aria-current", i === current ? "true" : "false"); });
      var max = track.scrollWidth - track.clientWidth;
      var pos = Math.abs(track.scrollLeft);
      prev.disabled = pos < 4;
      next.disabled = pos > max - 4;
      root.classList.toggle("is-static", max < 4);   // everything fits: no controls needed
    }
    prev.addEventListener("click", function () { go(current - 1); });
    next.addEventListener("click", function () { go(current + 1); });
    track.addEventListener("keydown", function (e) {
      if (e.key !== "ArrowLeft" && e.key !== "ArrowRight") return;
      e.preventDefault();
      var forward = (e.key === "ArrowRight") !== rtl;
      go(current + (forward ? 1 : -1));
    });
    var raf;
    track.addEventListener("scroll", function () { cancelAnimationFrame(raf); raf = requestAnimationFrame(update); }, { passive: true });
    window.addEventListener("resize", update);
    update();
  });
})();
