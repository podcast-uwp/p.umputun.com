---
title: "Lions on Red Square"
date: 2014-12-31T14:20:40-05:00
draft: false
tags: ["back to the past"]
slug: lions-around-us
---

First an anecdote: "On Red Square, a guy of very strange appearance is running in circles and screaming frantically. A policeman approaches him and asks — what are you doing, citizen? He answers — chasing away lions. The policeman looks around in surprise and says he doesn't see any lions, to which the guy responds — 'that's why you don't see them, because I chased them all away.'"

This is because paranoids (in the good sense of the word) protecting their home computer with various firewalls, everyone and their dog compares to that guy from the anecdote. Well indeed, you always ask yourself, who needs me with my iron friend. Surely there are more attractive victims in the network for potential hackers? And do they (hackers) even exist in nature, or is this just such a bogeyman of recent years?

About a week ago, browsing through my server logs, I was surprised to discover numerous traces of security system scanners. That is, someone was checking all ports for availability, and on open ones, tried various known techniques for hacking and bringing down the computer. So, for the first time, the question of protection from something paranoid-abstract turned into something really frightening. By the way, I have my whole local home network (of 4 computers) connected to the internet through a linux box running the standard linux firewall iptables. This beast logs information about all repelled attacks in the system log, and among all useful information, it also contains the ip address of the intruder. Having extracted it from there, I decided to try to deal with the invisible enemy.

In principle there are two paths here — administrative and technical. In the first case, finding out through which provider the intruder is connected to the internet, you can write him (the provider) a letter with a complaint and attached logs. In the second case, try to figure it out yourself. Which is what I decided to try.

First I tried to simply go to this address with a regular web browser. There was a quite sophisticated site selling something, and of course cheaper than everyone. Already good. After that, I set the scanner (ShadowSecure) to the address and ran it to scan. In about 10 minutes, the process completed, and the result was before me. I must say, I didn't expect this. 30 (thirty!) high-risk security holes were discovered. That is, through any of them, I theoretically could get access to full system control. Deciding to test theory with practice, I climbed into the first hole, and in a few minutes found myself inside the enemy computer. And the access was absolute, from remote service management to the ability to modify any system files. That is, the defeated opponent lay at my feet and quietly awaited his fate. Having wandered around the occupied territory for half an hour, I realized that this is not just a web server. It turned out to be also the file server of the whole firm, and all developers' projects were also on it. Well, in general, at this point I decided to stop my first hack in life and, without inflicting any damage on the enemy, return home.

This case struck me that it turns out lions on Red Square really do wander, and whoever doesn't chase them away can easily be eaten, and that people, in general, don't attach any importance to protection.

In other words, people, be vigilant, in the network there really are idiots crawling into other people's systems, and their goals are completely ignoble.

While I was writing this note, I glanced at the latest logs. There are enemy machinations again, and many at once. At first glance looks like a distributed attack, but need to check. In any case, every 1-2 sec. comes a service request (from different addresses), cut off by my firewall as incorrect.

So, I went hunting for lions. Hope to return with victory.

_If you haven't understood yet what this was — this was an experiment codenamed "back to the past", republication of a note from my cozy blog, 13 years vintage._

---

_This post was translated from the [Russian original](/2014/12/31/lions-around-us/) with AI assistance and reviewed by a human._
