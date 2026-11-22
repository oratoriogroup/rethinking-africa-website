# EDITING YOUR OWN SITE
## A plain-English guide for Dr Damola

You do not need to be a programmer to change the words on this website.
Everything is written in plain files. This guide explains what lives where,
and how to change it safely.

---

## Which file is which page

| If you want to change... | Open this file |
|---|---|
| The front page | `index.html` |
| The quiz questions or results | `quiz.html` |
| Episode listings | `watch.html` |
| Articles and research | `ideas.html` |
| Featured voices, community wall | `african-voices.html` |
| Announcements, blog posts, events | `news.html` |
| The contribution form page | `contribute.html` |
| Newsletter, WhatsApp, events | `community.html` |
| Your story and biography | `about.html` |
| Contacts and media kit | `contact.html` |
| Canada Conversations | `canada-2026.html` |
| Privacy and terms | `policies.html` |
| Editorial standards | `editorial.html` |
| Colours, fonts, spacing (all pages at once) | `css/style.css` |

---

## The one rule for editing text

Open the file, find the words you want to change, and type over them.
**Only change the words between the angle brackets, never the brackets themselves.**

```
<h2>Trained Away</h2>
     ^^^^^^^^^^^^  change this
^^^^              leave this alone
```

If you see something in square brackets like `[Guest name]` or `[Date]`, that is a
placeholder waiting for you to replace it, including the brackets.

---

## Adding a new blog post or announcement

Open `news.html`. Find an existing post block, which looks like this:

```html
<article class="post"><div class="meta">[Date] · Reflection</div>
<h3><a href="#">Your headline here</a></h3>
<p>Your one-line summary here.</p></article>
```

Copy the whole block, paste it directly above the others so the newest is on top,
then change the date, headline and summary. That is the entire process.

Announcements work the same way, using the `announce` blocks near the top.

---

## Adding a new event with photographs

In `news.html`, find the events section. Copy the heading, the description line and
the `gallery` block. Replace the placeholder image names with your own photographs.

Before uploading any photograph: shrink it first. A photo straight from a phone can
be 5 MB, which will make the page slow for people on mobile data. Aim for under
150 KB. Free tools such as squoosh.app do this in a few seconds.

---

## Changing the quiz

Open `quiz.html` and scroll to the bottom, to the part beginning `const QUESTIONS`.
Each question sits on its own lines with its four answers. You can reword any
question or answer by typing over the text inside the quotation marks.

The letters `KR`, `BB`, `SR`, `ST`, `FM` are the five profiles
(Knowledge Recoverer, Bridge Builder, System Reformer, Story Restorer, Future Maker),
and the numbers are how many points that answer gives each profile. If you are not
comfortable with that part, change only the wording and leave the numbers alone.

The profile descriptions are just below, under `const PROFILES`, and are safe to edit
freely.

---

## What NOT to change without help

- Anything inside `<script>` tags, apart from the quiz wording described above
- The block near the top of `index.html` beginning `application/ld+json`
  (this is what tells Google who you are)
- File names, or the `assets` and `css` folder names
- The word `class="..."` inside any tag; that is what applies the styling

---

## Always keep a copy

Before you edit anything, save a copy of the folder somewhere safe, dated.
If an edit goes wrong, you simply put the old file back. This single habit will
save you every time.

---

## The easiest long-term setup

Ask your developer to put the site on **GitHub connected to Netlify**. It sounds
technical but the experience is simple: you open the file in a web page, type your
change, press a green button, and the live site updates itself in about a minute.
Every previous version is saved automatically, so nothing can be permanently broken.

That setup costs nothing and means you never have to wait for someone else to fix a
typo or publish an announcement.

---

## When to call the developer instead

- The site goes down, or the domain stops working
- Forms stop delivering email
- You want a whole new page or section
- Anything involving payments, the newsletter system, or the video embeds
