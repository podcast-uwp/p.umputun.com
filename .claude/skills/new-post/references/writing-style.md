# Writing Style Guide — p.umputun.com

Extracted from analysis of 48 posts (2014–2024). Use this as the reference for tone, structure, and conventions when drafting posts.

## Language & Tone

- **Language**: Russian
- **Voice**: first person singular, direct, opinionated, honest
- **Tone**: conversational, as if explaining to a friend who is technically literate. Not academic, not formal, not clickbait
- **Humor**: dry, self-deprecating, occasional irony. Never forced jokes
- **Honesty**: openly admits mistakes, wrong predictions, and limitations. Uses qualifiers like "на мой вкус", "насколько я могу судить", "из моего опыта"
- **Opinions**: stated directly, without hedging excessively. "Я бы не советовал", "это было последней каплей", "результат приятно удивил"

## Structural Patterns

### Frontmatter
```yaml
---
title: "Title in Russian"
slug: english-slug
date: 2024-03-05T13:27:08-06:00
draft: false
tags: ["для гиков"]  # or ["разное"], ["назад в прошлое"]
---
```

Tags distribution: "для гиков" (~45%), "разное" (~31%), "назад в прошлое" (~10%), "технические темы" (rare, often combined).

### Post Structure

**Opening paragraph**: sets context — either a personal story, a problem statement, or background. Gets straight to the point without preamble. No "dear readers" or meta-commentary about writing the post.

**`<!--more-->`**: placed after the first paragraph (used in ~19% of posts, mainly longer ones). Creates the homepage excerpt.

**Sections with `##`**: lowercase headers in Russian. Common headers:
- `## TL;DR` or `## TLDR` — brief summary near the top (optional, used in longer posts)
- `## история вопроса` / `## с чего все началось` — background section
- `## детали реализации` / `## аспекты реализации` — technical details
- `## результаты` / `## выводы` — conclusions
- `## что дальше` — future plans

**Subsections with `###`**: for breaking down large sections. Also lowercase.

**Conclusion**: brief, honest assessment. Often uses:
- "в целом" / "по большому счету" — hedging for balanced take
- "это не наш путь" — characteristic phrase for not giving up
- Italic closing remark with `_text_` for personal reflection or caveat

### Length
- Range: 100–4,250 words (median ~900 words)
- Short posts (< 500 words): announcements, migrations, brief opinions
- Medium posts (500–1,500 words): reviews, opinions, how-tos
- Long posts (1,500+ words): deep technical write-ups, project stories

## Writing Conventions

### Technical Content
- Code blocks with language tags: ` ```bash `, ` ```go `, ` ```toml `
- Inline code for commands, filenames, parameters: `yt-dlp`, `reproxy`, `boltdb`
- Links to tools/projects: inline markdown `[tool name](url)`
- Abbreviations: "т.е.", "т.к.", "т.д."
- "Ну и" as a casual connector is common
- Numbers: mixed — digits for technical values, words for casual usage

### Images
- Single image: `![](/images/posts/filename.png)`
- Float right: `![](/images/posts/filename.png#floatright)` — used for decorative images alongside text
- Multiple images in a post: stored in `static/images/posts/<slug>/` subdirectory
  - Referenced as `![](/images/posts/<slug>/filename.png)`
- Collapsible image galleries (rare):
  ```html
  <details>
    <summary>Caption text</summary>

  ![](/images/posts/<slug>/image.png)

  </details>
  ```

### Links
- Inline markdown: `[descriptive text](url)`
- Internal cross-references to other posts: `[post title](https://p.umputun.com/YYYY/MM/DD/slug/)`
- GitHub project links are common

### Updates
- In-post updates marked with italic: `_UPD: date — update text._`
- Placed inline near the relevant section, not at the end

## Voice Examples

### Opening paragraphs (representative samples)

**Technical project story** (tg-spam):
> В последнее время в Telegram стало много спама, и, вероятно, все, кто управляет относительно большими каналами, сталкивались с этой проблемой.

**Service review** (cloudflare-dns):
> Первые впечатления от Cloudflare DNS и прочих сервисов от Cloudflare. В целом, весьма гиковская штука, местами очень продвинутая, но есть и некоторые неожиданные нюансы.

**Advocacy/opinion** (go-ili-nie-go):
> Цель этого поста попытаться ответить на ряд вопросов которые я получаю время от времени.

**Personal narrative** (how-echomsk-resurrected):
> После того как 5 Марта 2022 года радиостанция «Эхо Москвы» была легко и непринужденно закрыта, мне пришла в голову оригинальная мысль — а может мне её… приоткрыть.

**Brief announcement** (moving-again-to-hugo):
> С момента последнего переезда этого блога прошло около пяти лет. За это время я смог убедиться, что переход на мою диковинную конфигурацию никак не помог делу писания постов, но даже имел противоположный эффект.

**Practical guide** (guns-new-user):
> Последние пару месяцев меня активно спрашивают местные читатели и слушатели на тему первого оружия. Популярность этого вопроса вполне понятна и даже ожидаема на фоне того, что происходит.

### Characteristic phrases and patterns
- "это не наш путь" — refusal to give up
- "с горем пополам" — difficulty overcome
- "пришлось плясать с бубном" — dealing with unnecessary complexity
- "не самая лучшая идея" — understatement for bad decision
- "штука эта весьма..." — evaluative opener
- "забегая вперед" — foreshadowing a result
- "не бахвальства ради, но прояснения для" — preemptive modesty
- italic postscript `_P.S. ..._ ` — personal reflection closing

### What NOT to do
- No "dear readers" or meta-talk about the blog itself
- No clickbait titles or artificial cliffhangers
- No excessive formatting (bold used sparingly, mostly for emphasis in lists)
- No emoji
- No English words when a Russian equivalent exists (exception: technical terms without good Russian translations)
- No "мы" when referring to personal work — always "я"
- Section headers are lowercase (not title case, not uppercase)
