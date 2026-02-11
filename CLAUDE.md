# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal blog of Umputun at https://p.umputun.com/ — a Hugo static site in Russian, using the hyde-hyde theme.

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

## Production Deployment

Production site is served by **Cloudflare Pages** (project: `p-umputun-com`):
- Build command: `hugo`
- Build output: `public/`
- Production branch: `master` (automatic deployments enabled)
- Build system: Version 2
- Hugo version is determined by Cloudflare's build environment

The Dockerfile/docker-compose setup is used for CI validation only, not production deployment.

## Architecture

- **config.toml** — Hugo site configuration (theme, menus, params, Remark42 comments integration)
- **themes/hyde-hyde/** — customized hyde-hyde theme (layouts, assets, static files)
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

## Notes

- Content is in Russian
- Comments powered by Remark42 (enabled via `Remark42 = true` in config)
- `public/` is gitignored — generated output only
- Hugo version in Docker: 0.145.0 (pinned in Dockerfile)
- A successful `hugo` build with no errors is the closest thing to a "test" for this project
