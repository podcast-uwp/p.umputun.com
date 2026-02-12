---
title: "Yet Another Home Cloud - BitTorrent Sync"
date: 2013-06-18T14:20:40-05:00
draft: false
tags: ["tech topics"]
slug: ieshchie-odno
---

The home cloud theme isn't new for me and not long ago I wrote about a quite decent representative of this growing product family [Seafile](/2013/03/26/seafile-dlia-domashniegho-oblaka/). In [Radio-T podcast](http://www.radio-t.com) we've also discussed similar topics more than once or twice and mentioned today's hero [BitTorrent Sync](http://labs.bittorrent.com/experiments/sync.html) in detail, but taking a thoughtful look at it one more time will probably be useful.

At first glance, [BitTorrent Sync](http://labs.bittorrent.com/experiments/sync.html) lies somewhat in a different plane. The authors call it a secure, automatic file synchronization tool, but if you dig deeper we'll find here exactly what we want from a local, home cloud. No, not everything we wanted 100%, but very, very close to that.


The conceptual technology description [can be read](http://labs.bittorrent.com/experiments/sync/technology.html) in a foreign language, but essentially it's a distributed system with P2P synchronization. Something resembling regular torrents, but much more suitable for home-cloud application. The program exists for everything I know (including [my favorite RPi](/p/2012/12/27/raspberry-pi/)) and probably works on all of it. I only tried OSX, RPi (ARM), and Linux (i386 and x64) versions, but judging by everything, for other systems including Windows, BitTorrent Sync (aka btsync) works quite well.

The current program status is hard for me to determine, but probably it's something like experimental beta version. I've been watching this product since April 2013 and experimenting with it a lot and actively. During the reporting period, a considerable quantity of bugs and problems were found, some of them were [absolutely critical](https://plus.google.com/104578309919492528255/posts/A2jt7x3zffL), but those harsh times have passed and today I see nothing that could keep me from warm words and hot recommendations. The latest version at time of writing was 1.1.15 and everything I write here refers to this version specifically.

![](/images/posts/btsync-transfers.png)
Installing BitTorrent Sync is elementary under any system, as is setup. For OSX and Win versions there's a simple but sufficient GUI and minimal, Dropbox-type activity indication. For other versions there's a decent and fully functional web-ui. Any directory anywhere on your disk can be added to btsync in a couple clicks and assign this directory a "Shared secret" (can be entered manually or generated automatically). This shared secret is a unique key to your directory without knowledge of which synchronization is impossible. Everything btsync transmits/receives is protected by this key and AES 256bit encryption. Here the question will surely arise about how reliable such protection is. Indeed, instead of the usual name and password, there seems to be only a password. Besides, there's no trace of 2-factor authorization here either, but despite this, the degree of security is high and accidentally or intentionally guessing your Shared secret is practically impossible. On the btsync forum this question was raised multiple times and you can read details [here](http://forum.bittorrent.com/topic/20208-how-secure-is-this-random-number/), or [here](http://forum.bittorrent.com/topic/19222-can-someone-just-guess-shared-secrets/) or [there](http://forum.bittorrent.com/topic/17732-security/).

![](/images/posts/btsync-add.png)
There are three types of sharing — full, read-only, and one-time in variants for full access and for reading. That is, not three but a whole four variants. Full is probably clear — everyone who has the full access shared secret can do anything with the data — add, delete, and change. Yes, and of course, each shared directory can have any depth structure, i.e., subdirectories are also supported. And second — there can be more than one shared directory. Not sure how many there can be maximum, but one of my RPis distributes 9 different podcast directories.

In the "read-only" variant, everything is also quite expected — enter the read-only shared secret (can be found by clicking on Folders/Advanced) and get yourself a read-only data copy. No file modifications will pass in this case and this method works great for content delivery and "broadcasting." I, for example, distribute podcasts to listeners and e-books in my work team this way.

The one-time sharing variant is actually an interesting thing when a secret is generated for one use within 24 hours. I still vaguely understand when I might need this, but for example, if you want to distribute/share something and control the distribution list — these one-time secrets will probably be very relevant.

![](/images/posts/btsync-menu.png#floatright)

File synchronization happens after initial indexing is completed. This process for large directories can take time, however it's incomparably faster than a similar procedure in Dropbox. Even the smallest of my computers (RPi) completed indexing all podcasts (about 35GB) in less than an hour. On a normal computer this of course happens much faster. After this, all your devices start sharing files and maintain this home cloud in an up-to-date state.

Transfer speed depends on how many participants in your personal cloud. As with using regular torrents, here data exchange happens simultaneously with many computers. In my home network, 3 Macs and 2 RPis live with btsync and after adding files to one of them I can observe how other computers start receiving files first from the source of changes, and then, as delivery to other machines in the network progresses, from these machines too. That is, in practice all this works not just fast, but very fast. I didn't conduct measurements with stopwatch in hand, but by feel this all works much faster than through Dropbox.

From the perspective of CPU load and disk activity, in recent btsync versions there's constant and steady improvement and on any relatively modern computers, BitTorrent Sync activity is barely noticeable and doesn't interfere with normal work. On my oldest iMac c2d in standby mode btsync is less than 1% CPU, and in sync mode no more than 15-20% of one core. Even on RPi, BitTorrent Sync works quite tolerably and the latest versions allow using this mini-computer as a full-fledged participant in your home cloud. By the way, all podcasts are distributed through btsync by precisely an RPi with connected external disk and it handles this task excellently.

![](/images/posts/btync_advanced.png#floatright)

A couple more words for paranoids. You can make btsync a completely closed system. I don't remember how it is by default, but if you disable all "Use ..." and "Search ..." options and specify a list of your machines in "Use predefined hosts" then BitTorrent Sync will work completely locally without giving anything to the evil and dangerous internet. But even if you don't do all this, your files still won't end up on btsync servers and, if you believe what they claim, no data from your files is stored with them. In my opinion, it's better to take measures from your side too if data privacy concerns you very much. I did exactly that for all personal data — canceled all network exit options and generally closed btsync access to the big world. Most likely these measures are excessive, but I feel calmer this way.

Comparing BitTorrent Sync with Dropbox or Seafile head-to-head is probably not quite fair, since BitTorrent Sync doesn't do some of what makes Dropbox/Seafile good. There's no ability to send someone a link to a specific file in the cloud, no versioning, no built-in collaborative document work, and no mobile client yet (it's in development/testing). Yes, BitTorrent Sync looks like a narrower solution, but I don't like complex combines and prefer simple solutions. So I have the lovely [CloudApp](http://getcloudapp.com) for quick sharing, and Time Machine for versioning and backups. All this coexists beautifully with BitTorrent Sync and causes me no inconvenience, but on the contrary — a feeling of the correctness of such an approach.

If you look at BitTorrent Sync as a data delivery tool, then in skilled hands it can be useful in many places. People are already building social networks, local intranets, chats and forums and various other things around it. There's no problem building on its basis a simple but very real cloud storage with data somewhere in [S3](http://aws.amazon.com/s3/) and backups in [Glacier](http://aws.amazon.com/glacier/).

Support for BitTorrent Sync is very decent and readily accepts and reacts to bug reports. Fixes come out quickly, problems are acknowledged, and you can feel the developers' desire to bring the product to ideal state.

From the bad (thought long about what's bad) I can only complain that in early versions there were absolutely monstrous problems that could cause the worst thing such systems can do — data loss. But it seems these problems are in the past and lately I don't find anything that critical. The last unpleasantness I had with btsync happened literally a couple days ago when I tried switching to the freshest version and discovered that due to protocol incompatibility on my side and on the side of numerous podcast recipients, this version can cause 100% CPU load in some cases. In less than 2 days the problem was solved by developers and the fix delivered.

Summing up: BitTorrent Sync completely displaced other programs for building local clouds (Seafile and AeroFS) from my home network and began the steady process of moving what was stored in Dropbox to btsync. I'm not forcing this process and probably full transition isn't possible yet (many mobile programs are conveniently integrated into Dropbox), but probably I won't need a paid account anymore and what I have in free will be more than enough.

---

_This post was translated from the [Russian original](/2013/06/18/ieshchie-odno/) with AI assistance and reviewed by a human._
