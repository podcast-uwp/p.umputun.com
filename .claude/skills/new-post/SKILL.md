---
name: new-post
description: "Create, write, and refine blog posts for p.umputun.com in the author's Russian conversational style. Helps with brainstorming, structuring, drafting, image management, and publishing. This skill should be used when user wants to create a new blog post or work on an existing draft."
user-invocable: true
---

# new-post skill

Create and write blog posts for p.umputun.com — a personal blog in Russian by Umputun.

## Quick Start

- `/new-post <topic>` — start a new post on the given topic
- `/new-post` — interactive brainstorm session to find a topic

## Writing Style

**Read `references/writing-style.md` before writing any content.** It contains extracted patterns from 48 existing posts: tone, structure, conventions, and representative examples.

Key points:
- Language: Russian, conversational, first person
- Tone: direct, opinionated, honest, dry humor
- No emoji, no clickbait, no "dear readers"
- Section headers in lowercase Russian
- Abbreviations: "т.е.", "т.к.", "т.д."

## Workflow

### Phase 1: Topic & Brainstorm

If the user provides a topic, discuss:
- What angle to take (technical how-to, project story, opinion piece, practical guide)
- Target audience (fellow developers, general readers, podcast listeners)
- Key points to cover
- Rough length estimate

If no topic provided, help brainstorm by asking:
- What have you been working on recently?
- Any problems solved that others might find useful?
- Any opinions on recent tech/events worth sharing?

### Phase 2: Create Post File

Generate the slug from the topic (English, lowercase, hyphenated). Use today's date:

```bash
make new_post POST_NAME=YYYYMMDD-slug
```

This creates `content/posts/YYYYMMDD-slug.md` with Hugo frontmatter scaffolding.

Set up the frontmatter:
```yaml
---
title: "Title in Russian"
slug: english-slug
date: YYYY-MM-DDTHH:MM:SS-06:00
draft: true
tags: ["для гиков"]
---
```

**Tag selection guide:**
- `["для гиков"]` — technical posts, programming, tools, services (~45% of posts)
- `["разное"]` — general topics, opinions, non-tech (~31%)
- `["назад в прошлое"]` — nostalgia, historical (~10%)
- Multiple tags possible: `["технические темы", "для гиков"]`

### Phase 3: Outline

Propose a structure based on post type:

**Technical project story:**
1. Opening: problem/context that led to the project
2. `<!--more-->` (for long posts)
3. `## TL;DR` (optional, for long posts)
4. `## история вопроса` / `## с чего все началось`
5. `## подход к решению` / `## детали реализации`
6. `## результаты`
7. Optional italic closing remark

**Opinion/commentary:**
1. Opening: state the thesis directly
2. `<!--more-->` (for long posts)
3. Main arguments as `##` sections
4. `## выводы` or closing paragraph
5. Optional italic caveat `_text_`

**Service/tool review:**
1. Opening: one-line summary verdict
2. `## TL;DR`
3. `## с чего все началось` — why you looked at this
4. Feature sections with `##`
5. `## странности и сложности` — honest problems
6. `## выводы`

**Practical guide:**
1. Opening: why this guide exists
2. Numbered or sectioned instructions
3. Practical recommendations with personal experience
4. Closing caveat about subjectivity

### Phase 4: Draft

Write sections iteratively, presenting each for review before continuing.

**Draft rules:**
- Follow `references/writing-style.md` strictly
- Write in Russian, matching the author's voice
- Use characteristic phrases naturally (don't force them)
- Keep paragraphs focused — one idea per paragraph
- Use `##` and `###` for structure (lowercase headers)
- Include code blocks with language tags where relevant
- Add links to referenced tools/projects
- Place `<!--more-->` after the first paragraph for longer posts

**After each section, ask:**
- Does this match what you had in mind?
- Should I expand, compress, or change the angle?
- Any specific details or anecdotes to add?

### Phase 5: Images

When images are needed:

**Single image per post:**
- Copy to `static/images/posts/filename.png`
- Reference: `![](/images/posts/filename.png)`

**Multiple images:**
- Create directory: `static/images/posts/<slug>/`
- Copy images there
- Reference: `![](/images/posts/<slug>/filename.png)`

**Float image (decorative, alongside text):**
```markdown
![](/images/posts/filename.png#floatright)
```

**Collapsible image gallery:**
```html
<details>
  <summary>Caption describing the images</summary>

![](/images/posts/<slug>/image1.png)
![](/images/posts/<slug>/image2.png)

</details>
```

If the user provides images that need resizing, use Python/Pillow:
```bash
python3 -c "from PIL import Image; img=Image.open('input.png'); img.thumbnail((1200, 1200)); img.save('output.png', optimize=True)"
```

### Phase 6: Review & Refine

Before marking as ready:
- Re-read the full draft for flow and tone consistency
- Check that section headers follow conventions (lowercase Russian)
- Verify all links work
- Ensure code blocks have language tags
- Check image references point to correct paths
- Verify frontmatter is complete and correct

### Phase 7: Preview & Publish

**Preview:**
```bash
hugo server -D
```
The draft post will be visible at `http://localhost:1313/`. If agent-browser is available, use it to screenshot and verify the post renders correctly.

**Publish:**
1. Set `draft: false` in frontmatter
2. Remind the user to commit:
   ```
   The post is ready. When you're satisfied, commit and push to master —
   Cloudflare Pages will deploy automatically.
   ```

## Working with Existing Drafts

If the user wants to work on an existing draft:
1. List drafts: search `content/posts/` for files with `draft: true`
2. Read the draft
3. Discuss what needs work
4. Apply the relevant phase (outline, draft, refine, images, publish)
