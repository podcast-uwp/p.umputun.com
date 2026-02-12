---
title: "Why Do We Need These Versions?"
date: 2016-05-16T14:20:40-05:00
draft: false
tags: ["geek stuff"]
slug: zachiem-nam-eti-viersii
---

Today I stumbled upon a small error that took half an hour to understand and 2 seconds to fix. Instead of deploying docker image `blah.com/supersystem:develop-2.0.3`, in compose due to inattention `blah.com/supersystem:develop-2.0.2` was written. This led to a strange thought - why do we even need these versions here?

I, personally, am used to versioning everything and never subjected this idea to deliberate doubt. The obvious arguments "can roll back to a version" and "always know what version is running" didn't cause any particular reflection until this moment. Now I'm asking myself - why do I need this except for headaches? Why do I need to know which exact develop version if for develop I always want to deploy the fresh one? And when work goes in parallel in several branches then I deploy test versions from branches, if I want to have several systems working in parallel with different versions. Same thing for master.

That is, if you always build `blah.com/supersystem:<branch|tag>` without any versions, this would be good and simple and there's no place for stupid errors. Release goes from tags, i.e. there the version will correspond to the tag and there will be "native version" like `blah.com/supersystem:2.0.3`.

Am I missing something, or is getting rid of this excessive versioning actually a good idea? I understand the practical advantages that my branch/tag is always unambiguously linked to head and any image built from any branch is always the freshest. In theory, I also understand what's lost - the ability to have multiple releases from each branch, however in practice I don't see why I might need this.

I haven't thought deeply about this, so reasoned arguments both for and against are strongly welcomed.

---

_This post was translated from the [Russian original](/2016/05/16/zachiem-nam-eti-viersii/) with AI assistance and reviewed by a human._
