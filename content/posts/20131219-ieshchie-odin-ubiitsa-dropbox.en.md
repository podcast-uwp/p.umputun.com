---
title: "Yet Another Dropbox Killer"
date: 2013-12-19T14:20:40-05:00
draft: false
tags: ["tech topics"]
slug: ieshchie-odin-ubiitsa-dropbox
---

Today I received an email from ExpanDrive where they announced a [new product](http://www.expandrive.com/strongsync), which they described like this:


> We're excited to introduce Strongsync, a Dropbox-like sync app that connects directly to SFTP and Amazon S3. You stay in full control of your data and can easily sync data between all of your machines. Strongsync is currently available for Mac and Windows with Linux support coming early next year.


So we're talking about a kind-of Dropbox but with your own "base of operations" and full user control over everything. The idea is good, the idea is right. Yes, of course, we all know about [btsync](http://www.bittorrent.com/sync) which can also be used to set up something like a local cloud, but a centralized storage solution can have its own advantages.

<!--more-->

From these advantages, I expected the following:

- guaranteed locality of communications and understandable and verified traffic encryption method
- ability to place central storage in a reliable location (S3 or your own SFTP)
- clear path to creating storage backups
- space savings (deduplicated content-addressable data storage)
- ability to encrypt in central storage
- understandable way to share files
- data versioning in central storage
- decent performance

From potential downsides of such a centralized approach, the only thing that comes to mind is the need for a central place where all this will be stored. But S3 as such a place offers a solution, not the cheapest (100GB will cost at least $10/month), but more than reliable.

This was all theory, but practice turned out quite different. From things noticed immediately, first is sync speed. It's not fast at all. It seems there's a speed limit right in their sync program. On a local network, upload speed to server held firmly around 2.5 MB/s, speed in the other direction — up to 4 MB/s. There's no file encryption in storage. They lie there in a special tree, but despite strange names they're easy to find and open. Well yes, they never promised to encrypt data (only traffic) but you'd agree, it would be logical.

More of what's missing — no versioning, no sharing. But there is (unlike btsync) Finder integration and files are marked Dropbox-style with green checkmarks or an orange "in progress" indicator. By the way, this indicator is also confusing. Regardless of transmission direction there's always a down arrow, which hints to me that download is happening, but in reality it's just indication of data movement in any direction. This integration is done quite poorly and updates every other time. Clicking on files helps and then these badges get redrawn. Like in Dropbox, there's also a single directory (with subdirectories, of course) that can be synced. Having more than one simultaneously with different S3/SFTP is impossible. As for receiving/transmitting, it seems everything is strictly sequential, i.e., while one doesn't complete receive/transmit operation (also by files, sequentially), the second computer sits idle.

Now about the main thing — reliable system operation. The biggest surprise for me here was that in terms of reliability, this thing doesn't at all resemble a product you could charge money for. Unfortunately Strongsync is very, very rough beta, or maybe even something before that. It just breaks at every turn, constantly. Any non-trivial experiment instantly drives Strongsync crazy. For example, place a file on one connected computer and delete it during sync. Or create a conflict by editing a file on two different machines simultaneously. I, by the way, never managed to understand how this program resolves conflicts since it hung before the conflict reached the resolution stage. By "hung" I mean — stopped syncing in any direction. If you sign out and back in, some activity starts again, but very strangely — all files are marked as "transmitting," something goes over the network for a couple minutes, then everything quiets down leaving some files in "transmitting" state forever.

Understanding what exactly it's doing is also difficult. There's something like current operation indication, but it usually says "all delivered" while at the same time it's moving bytes back and forth. A couple times there was a mysterious message "Quota exceeded, upgrade." What quota, and what to upgrade — unclear. It seems completely out of place, there are no quotas (according to the description) here.

During my 15-minute quite trivial experiments, I seem to have completely broken this pony. Now no manipulations help restore synced state on the 2 connected machines, though to Strongsync's credit it did no harm, i.e., didn't delete anything extra. From the good, which isn't much — very economical CPU use, though I simply didn't reach the stage where there are hundreds of gigs, like in my btsync or Dropbox.

Conclusion and recommendation: **raw, very raw, monstrously raw.** Buying the program in this state is simply foolish. Selling the program in this state is the height of audacity. Though the idea is good and there's hope the authors will polish it. From their other product, ExpanDrive was, in its time, a very pleasant wrapper over FUSE and didn't cause such surprise with its incompleteness.

---

_This post was translated from the [Russian original](/2013/12/19/ieshchie-odin-ubiitsa-dropbox/) with AI assistance and reviewed by a human._
