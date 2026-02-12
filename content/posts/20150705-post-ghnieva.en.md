---
title: "Rant Post. IDEA How Long!"
date: 2015-07-05T14:20:40-05:00
draft: false
tags: ["geek stuff"]
slug: post-ghnieva
---


How can this be? How long must we suffer? This is about the walking shame and disgrace [described here](https://youtrack.jetbrains.com/issue/IDEA-131632). Look at this wailing of the peoples, whole 220 comments. I even had to unsubscribe from tracking this bug because too many tears were arriving in my email.

<!--more-->

In 2 words it's about the fact that with all modern versions of OSX Intellij IDEA allows you to choose two out of three characteristics:

- Normally rendered fonts
- Non-laggy navigation UI
- Non-flickering editor screen

![](/images/posts/idea-wtf.jpg#floatleft)
That is, getting all 3 characteristics at once, if you don't have a retina display, is impossible. Either it will lag, or flicker, or the fonts will be such that you'll tear your eyes out. And this is not about their free product, but about a quite and even very paid, commercial one. About a product that tens of thousands (by my estimates) of programmers sit in front of day and night. And this product, which many (including me) have for long years spoken about with love and pride (our people make it), is now met with anger and bile. And there's quite a good reason for this.

Look again at this ticket — it was opened on Oct 21, 2014, that is, about 7 months ago. Seven, dammit, months! In this time you could conceive and give birth to a premature but quite viable human, and here what? What fixes appeared there during this time? Yes, a special JDK appeared there in which fonts render better (also not great), no flickering at all, but the UI lags monstrously. It seems the authors themselves understand the inferiority of this solution and this special JDK is not included in the official release. Actually that's all, I don't observe any other visible progress on this issue.

What especially annoys and causes very pessimistic forecasts is the jetbrains position "it's not our fault, the bullet left our side, it's the new OSX/new JDK that are so crooked". Really? This product is of course not for housewives, but even for us, people close to the programming business, such an answer sounds like an excuse and unwillingness to drop everything and fix this bug incompatible with normal product use. This is for me a product, and the fact that the authors at the time chose one or another way of drawing their UI, which cannot survive an OS update and Java update — this is not the problem of everyone else, but the problem of the product! After all, look at competitors' products. Well, suppose NetBeans has a magic wand and sacred knowledge due to proximity to Oracle, but Eclipse also draws its UI without any problems.

And no, I'm not convinced by the answer "this is an AWT problem" (or whatever IDEA is drawn on). I repeat — this is the problem of the product from Jetbrains which became almost unusable for me. And if to solve this problem it's necessary to drop everything and rewrite what causes glitches and bugs — then should drop everything, rewrite and provide users with a product they can work with without shuddering. And they had 7 months for this, and where are the fixes?

I, on one hand am angry, and on the other genuinely don't understand the position of developers and bosses from jetbrains. They're not sitting idle and are building new, good things. But what do they think about this problem? Is the strategy "will do nothing, let them suffer" reasonable? Or are they doing something about the bug all these 7 months, not sleeping not eating, not seeing families, but not telling us? Or do they not consider this problem a problem at all? I have no answer to this, I only have a broken product for whose support I've been diligently paying for many years.

---

_This post was translated from the [Russian original](/2015/07/05/post-ghnieva/) with AI assistance and reviewed by a human._
