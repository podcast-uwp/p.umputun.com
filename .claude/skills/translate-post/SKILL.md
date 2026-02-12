---
name: translate-post
description: "Translate Russian blog posts to English for p.umputun.com multilingual setup. Reads a Russian .md post, translates it preserving the author's tone and style, and writes the .en.md counterpart."
user-invocable: true
---

# translate-post skill

Translate Russian blog posts from p.umputun.com to English while preserving the author's voice and style.

## Quick Start

- `/translate-post <filename>` — translate a specific post (e.g., `20240305-tg-spam`)
- `/translate-post` — interactive: list recent posts and pick one to translate

## Workflow

### Step 1: Identify the Post

If a filename or slug is provided, locate the file in `content/posts/`. If not, list recent posts and ask which one to translate.

The source file is always `content/posts/YYYYMMDD-slug.md` (Russian).
The output file is `content/posts/YYYYMMDD-slug.en.md` (English).

Check that the `.en.md` file doesn't already exist. If it does, ask the user whether to overwrite or skip.

### Step 2: Read and Understand

1. Read the Russian source file completely
2. Read `references/writing-style.md` from the `new-post` skill (`.claude/skills/new-post/references/writing-style.md`) to understand the author's tone
3. Identify the post type: technical project story, opinion piece, service review, practical guide, or announcement

### Step 3: Translate

**Frontmatter:**
- Translate `title` to English
- Keep `slug` identical (already in English)
- Keep `date` identical
- Keep `draft` value identical
- Translate `tags`:
  - "для гиков" → "geek stuff"
  - "разное" → "miscellaneous"
  - "назад в прошлое" → "back to the past"
  - "технические темы" → "tech topics"

**Content translation rules:**
- Preserve the author's direct, opinionated, conversational tone — this is not formal translation
- The English version should read as if a bilingual person wrote it naturally in English
- Keep first person singular voice throughout
- Maintain the same paragraph structure and section headers
- Translate section headers to lowercase English equivalents
- Keep `<!--more-->` placement identical
- Keep all markdown formatting intact (bold, italic, links, code blocks, images)

**What stays unchanged:**
- Code blocks — do not translate code or commands
- Image references — keep paths identical
- URLs and links — keep identical
- Technical terms that are commonly used in English (Docker, Kubernetes, Go, etc.)
- Project names and tool names

**What gets translated:**
- All prose text
- Section headers (keep lowercase)
- Image alt text (if any)
- Inline descriptions around code blocks
- `_P.S. ..._` closing remarks
- `_UPD: ..._` update notes

**Russian cultural references and idioms:**
- When the text references something specific to Russian culture, add a brief parenthetical explanation if it wouldn't be obvious to an English reader
- Translate Russian idioms to natural English equivalents rather than literal translations
- "пришлось плясать с бубном" → "had to jump through hoops" (not "had to dance with a tambourine")
- "с горем пополам" → "with great difficulty" or "barely managed"
- "это не наш путь" → "that's not our way" (this one translates well literally)
- "забегая вперед" → "spoiler alert" or "looking ahead"

### Step 4: Write the Translation

Write the translated content to `content/posts/YYYYMMDD-slug.en.md`.

**AI translation footer (mandatory):**
At the end of every translated post, add:
```
---

_This post was translated from the [Russian original](/<year>/<month>/<day>/<slug>/) with AI assistance and reviewed by a human._
```
Use the `date` and `slug` from the frontmatter to construct the link. The link points to the Russian version at root (no `/ru/` prefix).

### Step 5: Verify

1. Run `hugo` to verify the build succeeds
2. Confirm the translated post appears at `/en/YYYY/MM/DD/slug/`
3. Verify the language switcher links the Russian and English versions

### Step 6: Present for Review

Show the user the translated post and ask for review. Highlight any passages where the translation was tricky or where cultural context was added.

## Quality Checklist

Before presenting the translation:

- [ ] reads as natural English, not "translationese"
- [ ] author's direct, opinionated tone is preserved
- [ ] technical terms remain in English (not back-translated)
- [ ] all code blocks are unchanged
- [ ] all image references are unchanged
- [ ] all links are unchanged
- [ ] section headers are lowercase
- [ ] frontmatter is complete and correct
- [ ] Russian idioms are translated to natural English equivalents
- [ ] cultural references have brief explanations where needed
- [ ] AI translation footer with link to Russian original is present
- [ ] `hugo` build succeeds with no errors
