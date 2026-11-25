/* "How the world sees it / What it actually is" comparison, and image zoom.
 * [data-compare]: two pictures stacked; dragging the handle (or the arrow keys on the
 *   slider) reveals more of one or the other. Without this script they sit side by side.
 * .zoom-btn[data-zoom]: opens that picture large in a pop-up; Escape or × closes it. */
(function () {
  var L = { en: "Close", fr: "Fermer", ha: "Rufe", ar: "إغلاق", sw: "Funga" };
  var lang = (document.documentElement.lang || "en").slice(0, 2);

  Array.prototype.forEach.call(document.querySelectorAll("[data-compare]"), function (box) {
    var range = box.querySelector(".compare-range");
    if (!range) return;
    function set() { box.style.setProperty("--pos", range.value + "%"); }
    range.addEventListener("input", set);
    set();
    box.classList.add("is-ready");
  });

  var dlg, img;
  function open(src, alt) {
    if (!window.HTMLDialogElement) { window.open(src, "_blank"); return; }
    if (!dlg) {
      dlg = document.createElement("dialog");
      dlg.className = "lightbox";
      dlg.innerHTML = '<button type="button" class="lb-close" aria-label="' + (L[lang] || L.en) + '">&times;</button><img alt="">';
      img = dlg.querySelector("img");
      dlg.addEventListener("click", function (e) { if (e.target === dlg || e.target.closest(".lb-close")) dlg.close(); });
      document.body.appendChild(dlg);
    }
    img.src = src;
    img.alt = alt || "";
    dlg.showModal();
  }
  Array.prototype.forEach.call(document.querySelectorAll(".zoom-btn[data-zoom]"), function (b) {
    b.addEventListener("click", function () {
      var src = b.getAttribute("data-zoom");
      var match = document.querySelector('img[src="' + src + '"]');
      open(src, match ? match.alt : "");
    });
  });
})();
