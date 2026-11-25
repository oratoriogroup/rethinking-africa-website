/* Text effects for Rethinking Africa with Dr. Damola.
 * 1. Headlines rise in: the big heading at the top of each page appears letter
 *    by letter (word by word in Arabic, whose letters join and must not be split).
 * 2. Rotating word: <span class="rotate" data-words="A|B|C">A</span> cycles
 *    through its words, each sliding up into place.
 * Screen readers hear the full heading once (aria-label); the moving parts are hidden from them.
 * Visitors who asked their device to reduce motion, and browsers without JavaScript,
 * simply see the normal text. To remove these effects, delete this file's <script>
 * tag and the "Text effects" section in css/style.css. */
(function () {
  if (window.matchMedia && window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;
  var root = document.documentElement;
  var byWord = (root.lang || "").slice(0, 2) === "ar";
  var STEP = byWord ? 90 : 28;   // ms between letters (or words)
  var START = 150;               // ms before the first letter
  var heads = document.querySelectorAll(".hero h1");

  // Screen readers get the heading as written (with the first rotating word).
  Array.prototype.forEach.call(heads, function (h) {
    var copy = h.cloneNode(true);   // line breaks count as spaces
    Array.prototype.forEach.call(copy.querySelectorAll("br"), function (b) { b.parentNode.replaceChild(document.createTextNode(" "), b); });
    h.setAttribute("aria-label", copy.textContent.replace(/\s+/g, " ").trim());
  });

  /* ----- 2. Rotating word (set up first, so the headline treats it as one piece) ----- */
  var rotators = [];
  Array.prototype.forEach.call(document.querySelectorAll(".rotate[data-words]"), function (el) {
    var words = el.getAttribute("data-words").split("|").filter(Boolean);
    if (words.length < 2) return;
    var track = document.createElement("span");
    track.className = "rotate-track";
    words.concat(words[0]).forEach(function (w) {   // the first word again at the end, for a seamless loop
      var s = document.createElement("span");
      s.textContent = w;
      track.appendChild(s);
    });
    el.textContent = "";
    el.appendChild(track);
    el.setAttribute("aria-hidden", "true");
    rotators.push({ el: el, track: track, n: words.length, i: 0 });
  });
  function sizeRotators() {   // keep the box as wide as the longest word, so the line never jumps
    rotators.forEach(function (r) {
      var w = 0;
      Array.prototype.forEach.call(r.track.children, function (s) { w = Math.max(w, s.getBoundingClientRect().width); });
      r.el.style.width = Math.ceil(w) + "px";
      r.track.style.transform = "translateY(" + (-r.i * r.track.firstChild.offsetHeight) + "px)";
    });
  }
  if (rotators.length) {
    sizeRotators();
    window.addEventListener("resize", sizeRotators);
    if (document.fonts && document.fonts.ready) document.fonts.ready.then(sizeRotators);
    setTimeout(function () {
      setInterval(function () {
        rotators.forEach(function (r) {
          r.i++;
          r.track.classList.remove("snap");
          r.track.style.transform = "translateY(" + (-r.i * r.track.firstChild.offsetHeight) + "px)";
          if (r.i === r.n) {   // reached the repeated first word: jump back to the start unseen
            setTimeout(function () {
              r.track.classList.add("snap");
              r.i = 0;
              r.track.style.transform = "translateY(0)";
            }, 700);
          }
        });
      }, 2600);
    }, 1800);
  }

  /* ----- 1. Headlines rise in ----- */
  var n = 0;
  function piece(text, cls) {
    var s = document.createElement("span");
    s.className = cls;
    s.textContent = text;
    s.style.animationDelay = (START + n++ * STEP) + "ms";
    return s;
  }
  function split(node) {
    Array.prototype.slice.call(node.childNodes).forEach(function (c) {
      if (c.nodeType === 3) {
        var frag = document.createDocumentFragment();
        c.textContent.split(/(\s+)/).forEach(function (part) {
          if (!part) return;
          if (/^\s+$/.test(part)) { frag.appendChild(document.createTextNode(part)); return; }
          if (byWord) { frag.appendChild(piece(part, "fx-ch")); return; }
          var word = document.createElement("span");
          word.className = "fx-word";
          Array.prototype.forEach.call(part, function (ch) { word.appendChild(piece(ch, "fx-ch")); });
          frag.appendChild(word);
        });
        node.replaceChild(frag, c);
      } else if (c.nodeType === 1) {
        if (c.classList.contains("rotate")) {
          // Keep the rotating word and the punctuation right after it on one line.
          var group = document.createElement("span");
          group.className = "fx-word";
          node.insertBefore(group, c);
          group.appendChild(c);
          c.classList.add("fx-ch");
          c.style.animationDelay = (START + n++ * STEP) + "ms";
          var next = group.nextSibling, lead = next && next.nodeType === 3 && next.textContent.match(/^[^\s]+/);
          if (lead) {
            next.textContent = next.textContent.slice(lead[0].length);
            Array.prototype.forEach.call(lead[0], function (ch) { group.appendChild(piece(ch, "fx-ch")); });
          }
        }
        else if (c.tagName !== "BR") split(c);
      }
    });
  }
  Array.prototype.forEach.call(heads, function (h) {
    n = 0;
    split(h);
    h.classList.add("fx-rise");
    Array.prototype.forEach.call(h.children, function (c) { if (c.tagName !== "BR") c.setAttribute("aria-hidden", "true"); });
  });
})();
