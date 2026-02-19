# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal blog of Umputun at https://p.umputun.com/ — a multilingual Hugo static site (Russian primary, English secondary), using the hyde-hyde theme. Russian is the default language served at root `/`, English at `/en/`. This preserves the original URL format (e.g., `/2024/11/18/slug/`) for backward compatibility and Remark42 comment thread URLs.

## Build & Run

Site generation is Docker-based:

```bash
# build the hugo docker image
docker-compose build hugo_p

# generate the site (output goes to public/)
docker-compose run --rm hugo_p
```

CI runs the same commands via `.github/workflows/ci-build.yml`.

## Local Development

```bash
# start local dev server with live reload (http://localhost:1313)
hugo server

# start with drafts enabled
hugo server -D

# generate static site locally (output to public/)
hugo

# generate minified production build (same as Docker entrypoint)
hugo --minify
```

Requires Hugo installed locally. The Docker image pins Hugo 0.145.0; for consistency, use a compatible version.

There are no automated tests or linters — verify changes by running `hugo server` and checking the site visually in a browser.

## Creating Content

```bash
# create a new post (POST_NAME should follow pattern YYYYMMDD-slug)
make new_post POST_NAME=20240305-my-post
```

Posts live in `content/posts/` as markdown files. Post filenames use the `YYYYMMDD-slug.md` convention. Permalinks are `/:year/:month/:day/:slug`.

Pages (like About) are in `content/pages/`.

## Multilingual Setup

The site uses Hugo's built-in multilingual mode with `defaultContentLanguage = "ru"` and `defaultContentLanguageInSubdir = false` — Russian content is served at root `/`, English at `/en/`.

**Content structure:**
- Russian posts: `content/posts/YYYYMMDD-slug.md` (existing files, no changes needed)
- English translations: `content/posts/YYYYMMDD-slug.en.md` (same base name with `.en` suffix)
- Pages follow the same pattern: `about.md` (Russian), `about.en.md` (English)
- Hugo automatically links files with the same base name across languages

**Adding a new English translation:**
1. Use the `translate-post` skill: it reads a Russian `.md`, translates it, and writes the `.en.md` file
2. Or manually create `content/posts/YYYYMMDD-slug.en.md` with translated content
3. Only posts with an `.en.md` file appear in the `/en/` listing — untranslated posts are excluded

**i18n strings:** `themes/hyde-hyde/i18n/ru.toml` and `en.toml` contain UI string translations (minutes, comments, related articles, etc.)

**Language switcher:** sidebar widget links to the translated version of the current page when available, or to the other language's homepage when no translation exists.

**Remark42 comments:** shared across languages by stripping the `/en/` prefix from the URL for English pages, so both language versions show the same comment thread. Russian pages already use the root URL format matching the original pre-multilingual URLs.

**Cloudflare `_redirects`:** `static/_redirects` contains redirect rules for old `/ru/` URLs pointing to root. This file is copied to `public/` during build.

## Production Deployment

Production site is served by **Cloudflare Pages** (project: `p-umputun-com`):
- Build command: `hugo`
- Build output: `public/`
- Production branch: `master` (automatic deployments enabled)
- Build system: Version 2
- Hugo version is determined by Cloudflare's build environment

The Dockerfile/docker-compose setup is used for CI validation only, not production deployment.

## Architecture

- **config.toml** — Hugo site configuration (multilingual config, per-language menus and params, Remark42 comments integration)
- **themes/hyde-hyde/** — customized hyde-hyde theme (layouts, assets, static files)
- **themes/hyde-hyde/i18n/** — translation strings for Russian (`ru.toml`) and English (`en.toml`)
- **static/_redirects** — Cloudflare Pages redirect rules (redirects old `/ru/` URLs to root)
- **static/404.html** — language-detecting 404 redirector (JS detects `/en/` prefix, redirects to the appropriate language-specific Hugo 404 page)
- **static/images/** — site images
- **updater/** — legacy auto-deploy service (production now uses Cloudflare Pages)
- **Dockerfile** — Hugo build container for CI validation
- **exec.sh** — entrypoint that runs `hugo --minify` inside the container

## Hugo Migration Notes

Pitfalls discovered when upgrading from Hugo 0.73.0 to modern versions:
- `.URL` on `MenuEntry` and `Pager` objects is NOT deprecated — only `.Page.URL` should become `.RelPermalink`
- `.Site.Author` removed in v0.124.0 — use `.Site.Params.author` instead
- `.Site.DisqusShortname` removed — check `.Site.Params` instead
- `.Summary` in modern Hugo returns HTML — use `| plainify` for plain text output
- `_internal/google_analytics_async.html` template removed
- Hugo markdown produces `<img>` without `width`/`height` — floated images with `shape-outside` need explicit `max-width` in CSS to prevent layout race conditions (text overlaps on first load, works on cached refresh)

## Notes

- Content is in Russian (primary) and English (translations)
- Comments powered by Remark42 (enabled via `Remark42 = true` in config, shared across languages)
- `public/` is gitignored — generated output only
- Hugo version in Docker: 0.145.0 (pinned in Dockerfile)
- A successful `hugo` build with no errors is the closest thing to a "test" for this project
