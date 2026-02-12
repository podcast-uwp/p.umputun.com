---
title: "Not Only by the Walk..."
date: 2016-08-10T14:20:40-05:00
draft: false
tags: ["miscellaneous", "tech topics"]
slug: nie-tolko-po-pokhodkie
---

They say that our people are easy to recognize anywhere in the world. There they go, unsmiling, and in their face you can read readiness to fight back against the whole world, which is plotting another dirty trick against them. And, as it turns out, you don't even need to look at the walk, this can be understood from the "virtual walk" too.

Today, after reading a comment on my commit on [github](https://github.com/jpetazzo/dockvpn/commit/fe9732cf30995f6f8b3b5b7f010a70964112b8bd#commitcomment-18587258) I immediately sensed our people, even before looking at the name. He wrote such a sarcastic comment on the line where I renamed the erroneous name of my dockerhub repository to the actual one: "Very useful change".

Another person, in my place, wouldn't even understand what that was about. That is, what can possibly be commented on a line that fixes a typo/misprint and how can its usefulness be evaluated? But you and I are also like that, and also unsmilingly ready for the world's attack on us, so this caused no illusions for me - it was clear that the guy wanted to say something unflattering with this and does it in this, our way.

Returning to the history of the issue - long, long ago, when I wrote the post ["Your Own VPN in 3 Minutes"](http://p.umputun.com/2014/08/12/svoi-sobstviennyi-vpn-za-3-minuty/) it explained how to set up this thing from the [original code](https://github.com/jpetazzo/dockvpn) which was kindly written by user jpetazzo. This post, to my surprise, turned out to be quite popular. However, after some time all this thing stopped working with modern client versions. The problem was with the size of something-there (I don't remember the details, it was long ago) and people started complaining to me that my recipe for setting up VPN in 3 minutes no longer works.

I wrote to the author about the problem and without waiting for a fix I forked his project and changed a couple of lines there. Then, when it turned out that building the container from source code every time is problematic for some readers, I added automatic container building and forgot about it for 2 years.

So, what outraged the commenter, you ask? What did I, so good and not wishing harm but bringing benefit, cause his sarcastic remark? After my passive-aggressive question "what was that about," he explained (also in our people's style) that from his point of view I offended the author and his license, that very jpetazzo who made the original container. And that I didn't write in big letters who the author is in my fork and named the project the same as the original.

As you can guess, the last thing I wanted to do was vilely appropriate someone else's product. I'm not a big specialist in github etiquette, but encountering repository forks I've never seen any additional indication "and here's the original" and no renaming. It seemed to me that since github clearly and directly writes this (at the top, "forked from jpetazzo/dockvpn"), then repeating this again makes no sense, though maybe I'm wrong and this is customary in good society.

At the same time, the project author apparently doesn't care - my fork has been living for a couple of years and caused him no complaints, until, to its misfortune, it caught the eye of "our people." And our people can't silently pass by such flagrant "injustice" and joyfully uncocks their machine gun at the first signs of what in their worldview is yet another confirmation of the vileness and injustice surrounding us everywhere.

_Just in case, I added to the readme once more, in bold letters, where the project's legs grow from, in case this is actually necessary._

---

_This post was translated from the [Russian original](/2016/08/10/nie-tolko-po-pokhodkie/) with AI assistance and reviewed by a human._
