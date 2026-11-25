/* "Join the Founding 1,000" sign-up and pop-up panels (homepage).
 * Sign-up: the country code is joined to the WhatsApp number, the form is sent to the
 *   mailing list in the background, and the welcome message shows at once.
 *   Until the form's data-action holds the MailerLite URL, it says sign-ups open soon
 *   (it never pretends to have saved anyone's details).
 * Pop-ups: a button with data-open="id" opens <dialog id="id">; × or the backdrop closes it. */
(function () {
  var lang = (document.documentElement.lang || "en").slice(0, 2);
  var CLOSED = {
    en: "Sign-ups open very soon. Until then, reach us through the Contact page.",
    fr: "Les inscriptions ouvrent très bientôt. D’ici là, contactez-nous via la page Contact.",
    ha: "Rajista za ta buɗe nan ba da jimawa ba. Kafin nan, tuntuɓe mu ta shafin Tuntuɓa.",
    ar: "يُفتح التسجيل قريبًا جدًا. حتى ذلك الحين، تواصل معنا عبر صفحة التواصل.",
    sw: "Usajili utafunguliwa hivi karibuni. Hadi wakati huo, wasiliana nasi kupitia ukurasa wa Mawasiliano."
  };

  var form = document.querySelector(".join-form");
  if (form) {
    var status = form.querySelector(".form-status");
    var welcome = document.querySelector(".join-welcome");
    form.addEventListener("submit", function (e) {
      e.preventDefault();
      if (form.reportValidity && !form.reportValidity()) return;
      var action = form.getAttribute("data-action") || "";
      if (!/^https:\/\//.test(action)) { status.textContent = CLOSED[lang] || CLOSED.en; return; }
      var data = new FormData(form);
      var num = (data.get("fields[whatsapp]") || "").trim();
      if (num) data.set("fields[whatsapp]", (data.get("fields[whatsapp_code]") || "") + " " + num.replace(/^0/, ""));
      data.delete("fields[whatsapp_code]");
      data.append("fields[language]", lang);
      try { fetch(action, { method: "POST", body: data, mode: "no-cors" }).catch(function () {}); } catch (err) {}
      form.hidden = true;
      if (welcome) { welcome.hidden = false; welcome.setAttribute("tabindex", "-1"); welcome.focus(); }
    });
  }

  Array.prototype.forEach.call(document.querySelectorAll("[data-open]"), function (b) {
    var dlg = document.getElementById(b.getAttribute("data-open"));
    if (!dlg) return;
    b.addEventListener("click", function () {
      if (dlg.showModal) dlg.showModal(); else location.href = "contact.html";
    });
    dlg.addEventListener("click", function (e) { if (e.target === dlg || e.target.closest("[data-close]")) dlg.close(); });
  });
})();
