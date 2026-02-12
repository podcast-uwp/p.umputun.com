---
title: "How I Resurrected the Echo of Moscow Podcasts"
date: 2022-03-30T17:20:40-05:00
draft: false
tags: ["geek stuff"]
slug: how-echomsk-resurrected
---

After the Echo of Moscow radio station was casually shut down on March 5, 2022, I had an original idea — maybe I could... partially reopen it. In the spirit of a classic Russian movie line — "he breaks it, I fix it." Not the radio station itself, of course, but its podcasts.


## TLDR

It all worked out, though not without some adventures. Here are the results:

- [Podcast feed](https://feedmaster.umputun.com/rss/echo-msk)
- [Simple page](https://feedmaster.umputun.com/feed/echo-msk) for manual consumption
- Distribution on [Apple Podcasts](https://podcasts.apple.com/us/podcast/эхо-москвы/id300172145)
- [Telegram channel](https://t.me/echomsk_u), where feed-master uploads audio files

## background

This idea didn't come out of nowhere. The thing is, a long time ago — more than 10 years ago — I assembled something listenable from the radio station's scattered RSS feeds in the form of a combined podcast, what I called the "Proper Combined Feed of Selected Shows." There were tons of problems with the original feeds, and some were quite non-trivial. From what I remember, there were issues with episode naming, incorrect episode sequences, duplicates, and various other things along those lines. On top of that, subscribing to numerous podcasts back in those days was not for the faint of heart. As a result, my feed became the most popular place where regular people found podcast versions of the station's shows. There were some funny moments too: more than once, I received indignant complaints about the content of various shows, about sound quality, about the hosts' professionalism — basically about everything I had absolutely nothing to do with. At first, I tried to explain how things actually worked, but for "regular people" my explanations were either too complicated or unconvincing.

Going even deeper into the past, about 16 years ago I wrote a program called UPG that listened to the internet live stream and cut podcasts from it. I understand this is hard to believe now, but back then podcasts were still exotic, and radio stations ignored this trendy novelty. For several years, that's exactly how my Echo podcasts were built, though as far as I remember, it was always only for the geekiest users and wasn't meant for normal people.

## approach to the technical solution

I treated the shutdown of Echo as a technical problem that needed a technical solution. During the two weeks I was thinking it over, many shows appeared on YouTube in video format. This format, I should say, is rather odd — it's 90% talking heads, and if you extract just the audio, the listening experience doesn't suffer at all, in my opinion. So the task began to take shape: somehow get the update list from YouTube channels/playlists, extract video links from it, download the videos, extract audio, and package it all as a podcast.

A quick Google search led me to the [podsync](https://github.com/mxpv/podsync) project. Based on the description, it was very close to what I needed, but after a day of experiments, it turned out to be unusable. There were significant problems, both internal and external (under the hood it used youtube-dl). It sort of worked, but very slowly (videos took hours to download), required YouTube API access with mandatory registration (which I wanted to avoid), and it seemed to me that podsync wasn't quite ready for "production use." In unexpected situations, strange errors appeared, processing stopped, and figuring out what went wrong was very difficult. There was an option to roll up my sleeves and fix everything I could, but that wasn't straightforward either. After studying discussions around several relevant tickets, it seemed like the author and I had some conceptual disagreements, and the chances of my changes being accepted weren't great. Of course, I could have forked it and built whatever I wanted in my own sandbox, but if I'm going to sit down and code, I'd rather do it with a familiar codebase.

And I had one. It was [feed-master](https://github.com/umputun/feed-master), the modern incarnation of my UPG service. The first version of feed-master was in Python, and you can even find it in the [first commits](https://github.com/umputun/feed-master/commit/b8b7a562bf8112f427b79948a84f992856a8de67). Despite that commit being "only" 8 years ago, the project is at least 3 years older — it just wasn't on GitHub yet.

The current version of feed-master (in Go, of course) did a simple job — it assembled a correct feed for a combined podcast from multiple scattered ones, solving problems with the original feeds along the way. It was the one producing that very "Proper Combined Feed of Selected Shows." Naturally, the idea of teaching feed-master some YouTube magic — turning channels into separate podcasts and then merging them together — seemed very reasonable and, by my estimate, not too technically challenging. Looking ahead, I can pat myself on the back — I estimated the programming complexity almost correctly, though I badly underestimated the operational aspects. But more on that below.

## implementation details

After researching the question, it turned out that YouTube kindly provides video lists for all channels and playlists as Atom feeds. You get them like this: `GET https://www.youtube.com/feeds/videos.xml?channel_id=<ID>` for channels, and `https://www.youtube.com/feeds/videos.xml?playlist_id=<ID>` for playlists. The feed contains everything needed for video extraction, namely `yt:videoId`, plus additional information needed for building the podcast: titles, descriptions, author, links, and so on...

I didn't even consider writing video downloading myself. This entire project was originally a "weekend thing," and I needed to use ready-made solutions as much as possible. That's how I found the absolutely wonderful [yt-dlp](https://github.com/yt-dlp/yt-dlp), a fork of the famous [youtube-dl](https://github.com/ytdl-org/youtube-dl). It's smart, clever, can download videos, and using the well-known [ffmpeg](https://www.ffmpeg.org), extract audio from them.

So we take the YouTube feed, extract the latest N entries, check if we've already processed them, and for new entries call `yt-dlp` with audio extraction parameters. What we run is defined in the config, and currently it uses something like `yt-dlp --extract-audio --audio-format=mp3 --audio-quality=0 -f m4a/bestaudio "https://www.youtube.com/watch?v={{.ID}}" --no-progress -o {{.FileName}}`.

With `{{.FileName}}` I made my first mistake. Instead of making names corresponding to the unique `VideoID`, I generated them randomly as UUIDs. Apparently, my thinking was that metadata about processed episodes made file naming consistency unimportant, but as practice showed, it wasn't so. When everything worked correctly — yes, it didn't matter. There was a "pseudo-transaction" where first the file was downloaded, then the record was added to storage. As a store, I had been using boltdb (KV store) before, and for all YouTube stuff I simply added a section for new metadata. Unfortunately, assuming everything will always go smoothly is usually a bad idea, and my "pseudo-transactions" showed their ugly face when I restarted the process after metadata was updated but before file writing was complete. After that, I changed file names to SHA1 hash of channelID+videoID.

*Cryptography enthusiasts, please don't scold me for SHA1, but understand that these hashes have absolutely nothing to do with cryptography. I could probably have used the much-maligned MD5 or even simple CRC64. But since feed-master already used SHA1 for hashes before, I continued using it.*

After the file is extracted and saved, 2 key:value pairs are written to boltdb. The first is `pubdate_:videoID` with the value `feed.Entry` (from YouTube Atom) written to the "channelID" bucket, and the second is written to a shared "processed" bucket for all channels, with pubdate as the value (pubdate is the episode publication time). The first record is needed to retrieve a sorted list of episodes for building the RSS channel, and the second to understand whether a specific episode has already been processed.

Optimizations like understanding processed episodes by comparing their pubdate with the time of new episodes were considered but rejected because the source Atom feed doesn't treat time as linear and immutable — sometimes it changes, sometimes it goes backwards. And besides, a single common time wouldn't suffice — you'd need one per channel. And if so, it's simpler and more correct to not optimize without reason and just store identifiers of all processed episodes.

At the point where we have mp3 files on disk and metadata in bolt, building RSS is trivial. To make the process even more straightforward, I added the file path to the metadata, meaning everything needed to build a `channel>item` element is right there, and building an RSS podcast feed from these records for a single channel is no problem. And when all these RSS feeds are available, feed them to the main part of feed-master (the one that had been combining feeds for years), and we're done. To serve the generated RSS channels, I added a new endpoint `GET /yt/rss/{channelID}`, which builds on demand, even without caching. I could probably add a cache, but without it a request takes 10-20ms (including the network layer), so it's not a problem for now.

And the last thing I did was limit the Atom parsing "depth" (latest N entries) and the maximum number of episodes in the resulting RSS podcast (per channel). Understanding which episodes are stale and need deletion is very simple — take from the channelID bucket in reverse order (newest to oldest) and delete everything old (including the file) that's beyond the allowed maximum. Initially, I had full equality and a single `MaxItems` parameter for all channels, but I had to add per-channel overrides because some low-activity channels need only 5, while others need 50 or more. Essentially, I was trying to balance "fullness" by time, and using a time-based parameter (like "keep 2 weeks") would probably be more logical, but I don't really trust pubDate here, and this way is simpler and more direct, in my opinion.

At this point, the programming part of the project was essentially done, and it was time to launch.

## operational disaster

Let me remind you that I had been distributing the Echo of Moscow feed for many years, so I decided not to change anything to simplify life for existing subscribers. I had a very vague idea of the subscriber count — the numbers FeedBurner showed were always complete nonsense, and after they stopped supporting it, the nonsense stopped even updating.

But I had a machine on DigitalOcean and a ton of unused traffic, so I decided to set up a static file server there and point it at the directory with extracted files. Obviously, the feeds were now also served by my feed-master. Well, what could go wrong — everything is straightforward and simple, tested and working.

The moment I launched the new feed-master with the first few channels (there are 13 now, but only 2 at the start), a lot went wrong immediately:

- The audio extraction process was too much for this machine. It worked, but slowly and so heavily that HTTP requests timed out.
- Serving static files through my [reproxy](https://github.com/umputun/reproxy) was incredibly slow and maxed out the CPU.

Regarding the first point, it became clear that this situation was unsustainable and the heavy processing needed to be separated from the serving. So I quickly spun up another machine on DO, about 3x more powerful than the serving one. As for the second point, I consoled myself that reproxy wasn't written for serving static files in this mode and switched to the trusty nginx. Launched it on a separate machine, and basically, this was the first working version. It sort of worked. But barely. Have you ever seen nginx consume all resources? Or all IO get exhausted? Well, now I have too. It wasn't reproxy's fault after all — I was wrong to blame it.

But distribution started, updates were being downloaded, feeds were being built. So what if the machine was struggling — that's its job, to work. But I had nagging doubts that with this insane distribution rate, my unused 9TB of monthly traffic might not be enough. Thankfully, [vnstat](https://humdi.net/vnstat/) was at my fingertips, and DO also provides network activity monitoring. After looking at the results 8 hours into distribution, I nearly cried. It had served about 2TB in that time, and DO showed constant 1.5Gb network load.

It was nighttime, and consoling myself that "this is the initial rush, they'll download all the new episodes and calm down," I went to sleep. In the morning, it turned out my optimism was too... optimistic, and of the 9TB, 5 were already spent. Obviously, a month's worth wouldn't be enough, and there was a chance that 9TB wouldn't even last a day. Something had to be done. There weren't many options, but there were some:

- Ignore the excess traffic and pay when the bill comes. Maybe put out a call for help with payment, but from my experience, you can't count on that kind of help. A simple option, but quite expensive. An extra terabyte on DO costs $10, and we'd apparently need at least `4*30=120TB`, meaning $1,200 per month. And that's the most optimistic estimate. During the week the podcast was being distributed, there were days with 15TB, and besides, DO somehow... inaccurately counts excess traffic, and our numbers don't match. What I counted as 4TB, they somehow calculated as 7TB and change. So the real monthly cost would probably be around $3-5K. And no, I didn't want to restore the Echo podcast feed that badly.
- Write to DO and ask them not to count traffic from this instance since it's for a good cause. I did this and even got a response. In short, they have a program you can apply to if your project is about equality and against various discriminations (not sure I'd meet those criteria), and the most it offers is a one-time $1,000 credit. And as we calculated above, that would only last about a week if we're lucky.
- Close access and use it myself, plus share it by invitation with a couple dozen trusted friends. You can call me a selfish loner, but this was the most likely outcome. After all, I programmed it, I'll consume it!
- Find some mysteriously cheap or free way to distribute this volume. Cloudflare or CloudFront and other CDNs come to mind. But there's a problem here too — all of them, at least the ones I researched, aren't designed for serving massive mp3 files and are a poor fit for podcast distribution specifically. I read reports about how Cloudflare blocked the address that Apple Podcasts uses for collection. Besides, I don't think these providers would be thrilled about our atypical traffic. I asked Cloudflare support about this almost a week ago and received no answer.
- Complain about this problem and hope for kind souls. Despite this method seeming somewhat naive at first glance, it's the one that worked. Volunteers with sufficient capacity and generous (unlimited) traffic responded to my call.

## solving the operational problem

Now that we had a real CDN starting to take shape, we needed to figure out how to organize it all. Distributing mp3 files is simple — rsync to the rescue, and with `--delete`, anything we delete locally also gets deleted on the distribution servers, keeping their disks from overflowing. RSS for all channels could, in principle, be served from our master, but since we have this quasi-CDN, why not save the RSS locally and distribute it with the same rsync to all worker nodes.

As for the proxy/LB, there was no need to reinvent the wheel. I had previously written [RLB](https://github.com/umputun/rlb), which has been doing this for [our podcast](https://radio-t.com) for many years. It's not a traditional LB — all it does is maintain a list of live nodes and do HTTP redirects to them. For podcast distribution, that's more than enough. It can also assign different weights to different nodes, allowing load adjustment when needed.

Here the attentive reader might ask — "what about archives?" When feed-master starts deleting files, things could get unpleasant. I didn't immediately realize this was a problem until I noticed a file that had been removed from both the feed and disk showing up in requests from podcast clients. Obviously, all we could respond with was 404. As it turned out, many podcast clients aren't prepared for a previously visible episode to disappear. And this despite the episode no longer being in the RSS feed.

The solution was quite simple. One of our nodes turned out to have a large HDD, and its 2TB would be enough for many, many years of archives. All I did was add another rsync to /archive on this node, but without `--delete`. Yes, this node would accumulate the archive in addition to fresh content, and file duplicates would exist. But who cares? An extra 20GB of fresh files is nothing compared to the available 2TB. And all workers got `try_files $uri @rewrite;`, where `@rewrite` redirects to the archive node, modifying the URL in the process.

## adding peace of mind

Of course, for peace of mind we need to know if something goes wrong. For example, if a node stops responding or responds slowly. Or if a certificate is about to expire but hasn't renewed for some reason. Or if the master process crashes. For a simple and quick solution, I used [gatus](https://github.com/TwiN/gatus), whose capabilities are slightly extended by my [sys-agent](https://github.com/umputun/sys-agent). Everything started working almost immediately; the only problem was figuring out how to get the ID of a private Telegram channel where failure notifications go.

For network statistics, all workers run vnstat, which draws its simple and useful graphs every 5 minutes. And to observe distribution statistics at a higher level (files and nodes), the companion [rlb-stats](https://github.com/umputun/rlb-stats) runs alongside RLB.

For paranoid peace of mind, every place that could know the client's IP address diligently obfuscates it. I don't think anyone will come knocking with a soldering iron to get this information, but it's safer and more correct this way.

## the result

As a result, we have a [podcast feed](https://feedmaster.umputun.com/rss/echo-msk), a [simple page](https://feedmaster.umputun.com/feed/echo-msk) for manual consumption, and distribution on [Apple Podcasts](https://podcasts.apple.com/us/podcast/эхо-москвы/id300172145). There's also a [Telegram channel](https://t.me/echomsk_u) where feed-master uploads audio files. You can probably find it in other places too, for example on [Castbox](https://castbox.fm/channel/Эхо-Москвы-id25918?country=us).

In the first 5 days, we served audio files from this resurrected podcast over a million times (1.4M at the time of writing) and spent (for a good cause) over 50TB of traffic.

I hope the service has reached a level of full autonomy and can be left unattended. If something goes wrong, our monitoring will complain, and users won't stay silent either.

## how to help?

- If you have resources suitable for a distribution node (20GB disk, 1Gb connection, and unlimited traffic), get in touch with me on Telegram. Right now we have enough for distribution, but nobody knows how things will go.
- If you want and can help with programming, [feed-master's repo](https://github.com/umputun/feed-master) occasionally gets tickets labeled "help wanted."
- If you'd like to help financially, GitHub has [a place for that](https://github.com/sponsors/umputun) or there's [Patreon](https://www.patreon.com/umputun).
- If you want to help with hosting on DO and need droplets, here's a [referral link](https://m.do.co/c/229abb726d5d).
- Fix this article. There are probably typos, and commas are placed by ear. Fixes can be [submitted as a PR](https://github.com/podcast-uwp/p.umputun.com).

## final thanks

Huge thanks to the kind people who supported this initiative with their servers, time, and participation in development. Without you, none of this would have happened — you're truly amazing!

---

_This post was translated from the [Russian original](/2022/03/30/how-echomsk-resurrected/) with AI assistance and reviewed by a human._
