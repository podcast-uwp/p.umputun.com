---
title: "Dangers Lurking Everywhere"
date: 2012-11-27T14:20:40-05:00
draft: false
tags: ["back to the past"]
slug: opasnosti
---

Once again I'm writing about security issues, and again from personal experience.

So, since the founding of umputun.com site a year ago, its heart was (and is) the absolutely wonderful UBB forum. I wrote about how from the forum, modest HTML knowledge and some familiarity with Perl, you can cobble together a site in a day or two. That's how I made mine. I didn't think much about security issues, but tried not to do obvious stupid things. Well, not giving the user under which the web server runs access where it shouldn't, closing everything possible through the firewall, etc. Standard security measures adopted on not-very-secret servers. Combined with regular backups, it seemed to me that I could sleep peacefully, the enemy shall not pass.

But not quite. Trouble came from where we didn't expect. From applications not written by me, but absolutely necessary in daily life. Well, I already told you the ICQ story here, it didn't cause much harm, just spoiled my nerves. It seemed to me that I learned all the necessary lessons from that incident, told you about it, protected ICQ from all sides, and application security was now up to standard.

But the problem was dormant all this time, peacefully waiting for its turn. It started with a forum post where some fellow invited my visitors to his site (I don't really welcome this, but don't delete such postings), asked for help with PHP programming and casually mentioned that the UBB I use is full of holes. As proof, the fellow set himself Administrator access level in the forum.

This, however, is extremely dangerous. Let me explain. First, with these rights, you can write reviews and articles in any sections of the site (on my behalf), and second, modify any postings in the forum. And third, no, more about this later, it's too scary.

After reading this posting, I, for the first time in the whole year of the site and forum's existence, used my moderator rights. I deleted this message from the forum and destroyed the user (well, not physically) who sent this message. Maybe someone managed to read this text, but it lived on the site no more than 5-10 minutes. The next step was to find and patch the hole, and while searching and fixing, I made a rather drastic decision to temporarily close the forum.

Here I'll step away from the narrative and want to touch on the aspect of acceptability of publishing information about computer system vulnerabilities in open forums. I believe this is absolutely irresponsible and provocative, and even if done with good intentions (which, in general, was the case with me), the publisher of such things should think about what destructive consequences this can cause. Of course, they can object that leaving holes in systems is even worse, but here we plunge into the depths of the debate about who's to blame - the one who left the door open, or the one who climbed into the apartment. In the real world, this issue is regulated by criminal code, but in the virtual one, disputes don't subside. For me, this question doesn't arise. If something is poorly secured and I stumble upon it, the thought of breaking in (even to demonstrate vulnerability) doesn't occur to me. Sometimes I inform the system administrator, sometimes I just quietly leave.

So, continuing. My attempts to find a quick solution were unsuccessful. I couldn't find a description of the hole in my version of the forum anywhere, and installing a new version of UBB required just a massive amount of changes to the entire site. I had neither the strength, nor the time, nor the desire to arrange a revolution. There was a thought to block the address of the user who penetrated where he shouldn't, but obviously that's not a solution.

Long story short, after an hour I launched the forum and continued searching. And then the user who hacked me appeared under a new name, and again with excessive rights, though this time not administrator, but moderator. In his posting, he complained that instead of closing the hole, I deleted his message. To my request to send me information about the vulnerability he found, he kindly sent both a description of the hole and the fix method. True, he again posted all this directly in the forum, but the part describing the hole was deleted by me immediately. After that, I even added a clause to the forum registration conditions prohibiting the description of holes and other vulnerabilities on my forum.

After that, I fixed everything, tightened registration conditions, and took a number of other preventive measures. But the most dangerous consequence of this hack was that the password I used for posting coincided with the SSH server access password! And this isn't a forum for you, if such a password falls into wrong, malicious hands, the consequences can be catastrophic. And here, the blame lies entirely on the server administrator, i.e. on me. It's absolutely unacceptable, shortsighted and simply dangerous to use the same password for system login and for anything else. Well, now all suspicious passwords have been successfully replaced, and access to the system I've generally restricted to the local network, so I hope the enemy won't go further.


_If you haven't understood yet what this was - this was an experiment codenamed "back to the past", a republication of a note from my cozy little blog, almost 10 years aged._

---

_This post was translated from the [Russian original](/2012/11/27/opasnosti/) with AI assistance and reviewed by a human._
