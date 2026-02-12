# Dual-Language Blog Support (Russian + English)

## Overview

Add multilingual support to p.umputun.com so the blog serves content in both Russian and English. Russian remains the primary language. English translations are created manually via a dedicated translation skill. The blog gets `/ru/` and `/en/` URL prefixes, with bare URLs defaulting to Russian. A language switcher in the sidebar lets readers switch between languages.

This also includes a `translate-post` Claude Code skill that translates Russian posts to English while preserving the author's tone and style.

## Context

**Architecture decisions (from brainstorm):**
- Hugo multilingual mode with `/ru/` and `/en/` prefixes
- `defaultContentLanguage = "ru"`, `defaultContentLanguageInSubdir = true`
- Bare URLs default to Russian — homepage `/` redirects to `/ru/` (Hugo native), individual post bare URLs handled via Cloudflare `_redirects` (Hugo does NOT auto-redirect per-post bare URLs)
- Existing `*.md` files stay as-is (Russian), translations as `*.en.md`
- Untranslated posts do NOT appear in `/en/` listing
- Language switcher widget in sidebar next to theme toggle
- No server-side language detection — Russian default, manual switch only

**Files to modify:**
- `config.toml` — multilingual config, per-language menus and params
- `themes/hyde-hyde/i18n/ru.toml`, `themes/hyde-hyde/i18n/en.toml` — translation strings
- `themes/hyde-hyde/layouts/partials/sidebar.html` — language switcher
- `themes/hyde-hyde/layouts/partials/footer/remark42.html` — dynamic locale + URL normalization
- `themes/hyde-hyde/layouts/index.html` — dynamic locale, i18n strings
- `themes/hyde-hyde/layouts/partials/page-single/post-meta.html` — "мин." → i18n
- `themes/hyde-hyde/layouts/partials/page-single/post-related.html` — heading → i18n
- `themes/hyde-hyde/layouts/partials/page-single/content.html` — ToC label → i18n
- `themes/hyde-hyde/layouts/404.html` — error page → i18n
- `content/pages/about.md` — remove hardcoded `url: /about`
- `content/pages/about.en.md` — English about page
- `static/_redirects` — Cloudflare Pages redirect rules for bare URLs

**Hardcoded strings requiring i18n extraction (8 strings in 5 files):**
- `post-meta.html` — "мин."
- `post-related.html` — "Related Articles"
- `page-single/content.html` — "Table of Content"
- `404.html` — 3 strings (heading, message, link text)
- `index.html` — "Комментарии: "

Note: `sidebar/copyright.html` "Built with Hugo..." is behind `showBuiltWith` param which is not set — skip i18n for this dead code.

**Constraints:**
- All existing links MUST keep working via Cloudflare `_redirects` rules
- RSS feeds for both languages separately
- Remark42 comments shared per-post (same thread for `/ru/` and `/en/` URLs)
- Cloudflare Pages deployment unchanged (just `hugo` build)
- Hugo 0.145.0 has full multilingual support, no upgrade needed

## Development Approach

- No Go code — this is Hugo templates + config + a skill file
- **Testing**: verify by running `hugo` (build must succeed) and `hugo server -D` (visual check)
- Complete each task fully before moving to the next
- Run `hugo` after each task to verify no build errors

## Implementation Steps

### Task 1: Add Hugo multilingual configuration

**Files:**
- Modify: `config.toml`

- [x] add `defaultContentLanguage = "ru"` and `defaultContentLanguageInSubdir = true` to top level
- [x] add `[languages.ru]` section with `languageName = "Русский"`, `weight = 1`, `title = "Umputun тут был"`, `languageCode = "ru-ru"`, params (description, longDescription)
- [x] add `[languages.en]` section with `languageName = "English"`, `weight = 2`, `title = "Umputun was here"`, `languageCode = "en-us"`, English params
- [x] move current `[[menu.main]]` entries under `[[languages.ru.menu.main]]` with same content
- [x] add `[[languages.en.menu.main]]` with English translations of menu items: "Home" (`url = "/"`), "Weekly Podcast by Umputun", "Radio-T Podcast", "YouTube Channel", "Support on Patreon"
- [x] remove top-level `languageCode`, `title` (now per-language)
- [x] add per-language `dateformat` — keep `"2006-02-01"` for Russian, use `"Jan 02, 2006"` for English
- [x] run `hugo` — must build without errors. Verify `public/ru/` and `public/en/` output directories exist
- [x] verify that menu `url = "/"` for "Home" resolves correctly per-language (i.e., English "Home" goes to `/en/`, not `/ru/`). If not, use `pageRef` instead

### Task 2: Create i18n translation files

**Files:**
- Create: `themes/hyde-hyde/i18n/ru.toml`
- Create: `themes/hyde-hyde/i18n/en.toml`

Use Hugo's i18n TOML format with `[key] / other = "value"` structure:
```toml
[minutes]
other = "мин."
```

- [x] create `ru.toml` with keys: `minutes` ("мин."), `relatedArticles` ("Похожие статьи"), `tableOfContents` ("Оглавление"), `comments` ("Комментарии"), `notFound` ("404: Страница не найдена"), `notFoundMessage` ("Извините, такой страницы не существует."), `headHome` ("На главную")
- [x] create `en.toml` with same keys in English: `minutes` ("min"), `relatedArticles` ("Related Articles"), `tableOfContents` ("Table of Contents"), `comments` ("Comments"), `notFound` ("404: Page not found"), `notFoundMessage` ("Sorry, we've misplaced that URL or it's pointing to something that doesn't exist."), `headHome` ("Head back home")
- [x] run `hugo` — must build without errors

### Task 3: Replace hardcoded strings with i18n calls in templates

**Files:**
- Modify: `themes/hyde-hyde/layouts/partials/page-single/post-meta.html`
- Modify: `themes/hyde-hyde/layouts/partials/page-single/post-related.html`
- Modify: `themes/hyde-hyde/layouts/partials/page-single/content.html`
- Modify: `themes/hyde-hyde/layouts/404.html`
- Modify: `themes/hyde-hyde/layouts/index.html`

- [x] `post-meta.html`: replace `мин.` with `{{ i18n "minutes" }}`
- [x] `post-related.html`: replace `Related Articles` with `{{ i18n "relatedArticles" }}`
- [x] `content.html`: replace `Table of Content` with `{{ i18n "tableOfContents" }}`
- [x] `404.html`: replace heading with `{{ i18n "notFound" }}`, message with `{{ i18n "notFoundMessage" }}`, link text with `{{ i18n "headHome" }}`
- [x] `index.html`: replace `Комментарии:` with `{{ i18n "comments" }}:`
- [x] run `hugo` — must build without errors

### Task 4: Make Remark42 locale and URL dynamic

**Files:**
- Modify: `themes/hyde-hyde/layouts/partials/footer/remark42.html`
- Modify: `themes/hyde-hyde/layouts/index.html`

Remark42 comments must be shared across languages — both `/ru/` and `/en/` versions of a post should show the same comment thread. Normalize the URL to always use the `/ru/` path.

- [x] in `footer/remark42.html`: change `locale: 'ru'` to `locale: '{{ .Site.Language.Lang }}'`
- [x] in `footer/remark42.html`: add `url` parameter that normalizes to Russian path: `url: '{{ .RelPermalink | replaceRE "^/en/" "/ru/" }}'`
- [x] in `index.html` remark42 counter script: change `locale: 'ru'` to `locale: '{{ .Site.Language.Lang }}'`
- [x] in `index.html` remark42 counter: ensure `data-url` attributes on comment count spans use normalized Russian URLs
- [x] run `hugo` — verify remark42 config shows correct locale and URL normalization in both language versions

### Task 5: Add language switcher to sidebar

**Files:**
- Modify: `themes/hyde-hyde/layouts/partials/sidebar.html`
- Modify: `themes/hyde-hyde/assets/scss/hyde-hyde/_sidebar.scss`

- [x] add language switcher widget in `sidebar-bottom` div, next to theme toggle button
- [x] use Hugo's `.IsTranslated` and `.Translations` to link to translated version of current page when available
- [x] when no translation exists for current page, link to the other language's homepage
- [x] display as simple text link: "EN" / "RU" (compact, no flags)
- [x] add minimal CSS styling in `_sidebar.scss` to match the theme toggle button aesthetic
- [x] run `hugo` — verify switcher renders on both `/ru/` and `/en/` pages
- [x] verify SCSS compilation succeeds (hugo_extended required)
- [x] verify switcher links to correct translated page when translation exists

### Task 6: Fix about page URLs and create English version

**Files:**
- Modify: `content/pages/about.md`
- Create: `content/pages/about.en.md`

The existing `about.md` has `url: /about` hardcoded, which conflicts with language prefixes.

- [x] remove `url: /about` from `content/pages/about.md` frontmatter (let Hugo handle URL with language prefix)
- [x] verify the about page is now accessible at `/ru/about/` (not `/about`)
- [x] update any menu entries that reference `/about` to work with the new URL structure
- [x] create `content/pages/about.en.md` with English translation of frontmatter and content
- [x] run `hugo` — verify `/en/about/` has the English about page and `/ru/about/` has the Russian one

### Task 7: Add Cloudflare `_redirects` for bare URLs

**Files:**
- Create: `static/_redirects`

Hugo only generates a homepage redirect (`/` → `/ru/`). Individual post bare URLs (e.g., `/2024/03/05/tg-spam/`) will 404 without explicit redirects. Cloudflare Pages supports a `_redirects` file.

- [x] create `static/_redirects` with wildcard rule: `/:year/:month/:day/:slug/ /ru/:year/:month/:day/:slug/ 301`
- [x] add redirect for `/about` → `/ru/about/`
- [x] add redirect for `/tags/*` → `/ru/tags/:splat`
- [x] add redirect for `/page/*` → `/ru/page/:splat` (pagination)
- [x] run `hugo` — verify `_redirects` is copied to `public/`
- [x] verify the redirect rules syntax matches [Cloudflare Pages _redirects format](https://developers.cloudflare.com/pages/configuration/redirects/)

### Task 8: Verify existing URL compatibility

- [x] run `hugo` and verify `public/ru/` contains all posts from `content/posts/`
- [x] verify `public/en/` listing is empty (no translations yet)
- [x] verify RSS feeds exist: `public/ru/index.xml` and `public/en/index.xml`
- [x] verify homepage redirect: `public/index.html` redirects to `/ru/`
- [x] verify `public/_redirects` file contains the bare URL rules
- [x] start `hugo server` and manually test: homepage, a post page, about page, tags page
- [x] verify Russian site looks identical to current production

### Task 9: Create translate-post skill

**Files:**
- Create: `.claude/skills/translate-post/SKILL.md`

- [x] create skill directory `.claude/skills/translate-post/`
- [x] write SKILL.md with frontmatter (`name: translate-post`, `description`, `user-invocable: true`)
- [x] define workflow: accept post filename or slug → read Russian `.md` → translate to English → write `.en.md`
- [x] include translation guidelines: preserve author's tone (direct, opinionated, conversational), keep code blocks/links/images unchanged, translate frontmatter title and tags, keep slug identical
- [x] include instruction to reference `new-post` skill's `references/writing-style.md` for tone guidance
- [x] include quality checklist: natural English (not translationese), technical terms stay in English, Russian cultural references get brief explanations in parentheses

### Task 10: Update project documentation

- [x] update `CLAUDE.md` with multilingual notes (content structure, i18n files location, how to add translations)
- [x] update this plan — mark completed, move to `docs/plans/completed/`

## Technical Details

**Hugo multilingual content linking**: files with same base name are automatically linked across languages. `20240305-tg-spam.md` (ru) ↔ `20240305-tg-spam.en.md` (en). Hugo's `.Translations` provides access to the other language version in templates.

**URL structure after migration:**
```
/                           → redirect to /ru/ (Hugo native)
/ru/                        → Russian homepage
/en/                        → English homepage (only translated posts)
/ru/2024/03/05/tg-spam/    → Russian post
/en/2024/03/05/tg-spam/    → English post (only if .en.md exists)
/2024/03/05/tg-spam/       → redirect to /ru/2024/03/05/tg-spam/ (via Cloudflare _redirects)
```

**i18n file format** (Hugo TOML):
```toml
# themes/hyde-hyde/i18n/en.toml
[minutes]
other = "min"

[relatedArticles]
other = "Related Articles"
```

**Language switcher template logic:**
```html
{{ if .IsTranslated }}
  {{ range .Translations }}
    <a href="{{ .RelPermalink }}">{{ .Language.LanguageName }}</a>
  {{ end }}
{{ else }}
  {{ range .Site.Home.AllTranslations }}
    {{ if ne .Language.Lang $.Site.Language.Lang }}
      <a href="{{ .RelPermalink }}">{{ .Language.LanguageName }}</a>
    {{ end }}
  {{ end }}
{{ end }}
```

**Remark42 comment sharing**: comments are keyed by URL. Since `/ru/` and `/en/` have different URLs, comments won't be shared automatically. Normalize the `url` parameter in remark42 config to always use the Russian path: `url: '{{ .RelPermalink | replaceRE "^/en/" "/ru/" }}'`. This ensures one comment thread per post regardless of which language version the reader is viewing.

**Cloudflare Pages `_redirects` format:**
```
# bare post URLs → Russian version
/:year/:month/:day/:slug/ /ru/:year/:month/:day/:slug/ 301

# bare pages
/about /ru/about/ 301
/about/ /ru/about/ 301
/tags/* /ru/tags/:splat 301
/page/* /ru/page/:splat 301
```

## Post-Completion

**Manual verification:**
- browse `/ru/` pages — must look identical to current site
- browse `/en/` pages — empty listing, about page works
- test language switcher on both Russian and English pages
- test old bookmarked URLs (bare paths) — must redirect to `/ru/`
- verify RSS readers continue to work with existing feed URLs
- check Remark42 comments load correctly on both language versions
- deploy to Cloudflare Pages and verify production `_redirects` work
