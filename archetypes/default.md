---
title: "{{ .TranslationBaseName | replaceRE "^[0-9]{8}-" "" | replaceRE "-" " " | title }}"
slug: {{ .TranslationBaseName | replaceRE "^[0-9]{8}-" ""  }}
date: {{ .Date }}
draft: true
---

