---
title: "Cloudflare DNS"
slug: cloudflare-dns
date: 2023-09-09T13:39:48-05:00
draft: false
tags: ["geek stuff"]
---

First impressions of Cloudflare DNS and other Cloudflare services. Overall, it's quite a geeky thing — very advanced in some areas, but with some unexpected quirks.

## TL;DR

After the first week since the big migration, Cloudflare looks like a pretty solid set of services — very easy transfer, reasonable pricing, but with some quirks. Technically, it takes some effort to get it working the way you want, but it's not as hard as it seems, though it is quite odd.

## how it all started

A long time ago, in a galaxy far, far away, I used GoDaddy for all my domains. I don't even remember what I used before that, but GoDaddy seemed modern, attractive, and quite affordable by comparison — at first glance. Of course, in 2023 this sounds funny, but in the early 2000s it was normal and many people used GoDaddy for their domains without a second thought. Pretty quickly I realized that GoDaddy was a disgrace: terrible support, constant attempts to trick me into something, technical glitches, and unexpected charges for things they added themselves. Despite my careful attention, I still lost one domain purely due to an error on their side. Support was completely helpless and basically said "this happens sometimes, but we can't do anything about it." That was the last straw, and I decided it was time for a change.

My first choice was [Gandi](https://www.gandi.net/en-US). I managed to transfer several domains there without much trouble, though it took a long time. But the slow process was caused by GoDaddy's sluggishness, not Gandi's. Overall, Gandi was a pretty decent registrar — reliable and predictable. Their DNS management is made for normal people and doesn't raise any questions if you've done this sort of thing at least once. Prices were reasonable, no glitches, and their reputation in internet circles was "a decent registrar." The only weird thing was when they changed their authorization system and forced me to create a new account. That was a bit odd, but everything worked out.

After a couple of years, I noticed a similar service from AWS — [Route53](https://aws.amazon.com/route53/). I had been using AWS for work for a while, though personal projects were there too. For work, Route53 was undoubtedly the best option since everything else was also in AWS. I transferred all work domains there, and for those where transfer wasn't possible for various reasons, I used Route53 hosted zones. Overall, everything worked and continues to work beautifully, and the integration with other AWS services is a killer feature. There's a lot of stuff that regular DNS providers don't offer — conditional resolution, monitoring, DNS-level failover, and other things needed for work projects.

But even for personal sites and domains, Route53 seemed more than attractive. Reasonable price, flexibility, rock-solid reliability. Over many years of use, not a single DNS issue came up. Over time, most of my personal domains ended up in Route53 and lived there happily for years.

## something went wrong

Over the past year, the "presence" of my personal projects on AWS began shrinking and compressed down to just Route53. Before that, I had a couple of fairly active projects there that used various AWS resources, and the overall cost seemed perfectly adequate. I was paying somewhere around $100-200 per month, but it was justified. I never really looked into the details of these expenses and just paid for everything. But recently, I moved all my projects to other platforms, and only Route53 remained. The last bill I received was about $40, and it was the first one after migrating everything else. Meaning, for hosting about a dozen zones, I paid $40 per month. That was a bit of a surprise, considering I wasn't using any additional services beyond DNS. Upon closer examination of the bill and past billing details, I discovered that the price isn't stable at all and depends on the number and type of queries. There's no deception here — everything is [described in detail](https://aws.amazon.com/route53/pricing/) — but I never expected that DNS query volumes could be so high and, most importantly, so unstable. Without any action on my part, the number of DNS queries can vary from month to month by literally an order of magnitude (I discovered this when I analyzed billing details for the whole year). This situation seemed unhealthy to me, and while $40 per month isn't a lot, I fundamentally dislike such instability and unpredictability.

## migrating to Cloudflare

Cloudflare was never something I actually used, though I'd heard a lot of good things about it. In my mind, it was primarily associated with CDN. But not long ago, when I needed to set up a tunnel for an app hosted on my intranet, their Zero Trust worked perfectly for that. That said, to use any Cloudflare service, you need to register what they call a "Website," which essentially requires using their DNS. Beyond NS records, they provide a full set of domain registration and transfer services. For registration, they charge the minimum possible price with no markup.

The process of transferring domains to Cloudflare is a bit unusual but essentially simple and fast. The odd part — unlike everyone else, they do it "from the other end." First, you create a "Website" for the domain, change NS records at the old registrar to point to Cloudflare, and only then transfer the domain. The domain transfer itself happens very quickly (minutes), not over several days as is usually the case. Overall, transferring the first domain took me a few minutes, and within an hour everything was working.

### quirks, difficulties, and peculiarities

The first difficulty and oddity was how to actually migrate all existing records from Route53 to Cloudflare. After registration, Cloudflare tries to pull the list of all records and adds them automatically. Unfortunately, this works rather unreliably. In my case, it only pulled some of the records, and even among those it pulled, it couldn't properly recognize some CNAME records. I'm not sure whose fault this is, but the fact that it couldn't figure out to add a `.` suffix to CNAMEs that Route53 returns as `feed-master.umputun.com. 1800 CNAME jess.umputun.com` is simply embarrassing. And given that it could only retrieve a portion of even those records, the reliability of automatic import isn't very inspiring. I realized this wasn't going to work and decided to do everything manually. Not manually in the sense of "adding everything by hand," but doing the import on the Cloudflare side. There's no built-in way to export a zone from Route53 (Cloudflare, by the way, has a one-click export), so I had to write a small script that does it and also adds `.` at the end of CNAME records. Here's what our collaborative effort with ChatGPT produced:

```bash
#!/bin/bash

export AWS_ACCESS_KEY_ID=********************
export AWS_SECRET_ACCESS_KEY=****************************************

zonename=$1

hostedzoneid=$(aws route53 list-hosted-zones --output json | jq -r ".HostedZones[] | select(.Name == \"$zonename.\") | .Id" | cut -d'/' -f3)
aws route53 list-resource-record-sets --hosted-zone-id $hostedzoneid --output json | jq -jr '.ResourceRecordSets[] | if .Type == "CNAME" and (.ResourceRecords[0]?.Value | test("\\.$") | not) then "\(.Name) \t\(.TTL) \t\(.Type) \t\(.ResourceRecords[0]?.Value). \n" else "\(.Name) \t\(.TTL) \t\(.Type) \t\(.ResourceRecords[]?.Value)\n" end'
```

After that, I simply copied the output and pasted it into Cloudflare's import form. All records were added without issues, but all A and CNAME records automatically got "Proxied" mode, and that's the source of another oddity. The thing is, Cloudflare is primarily a CDN, and proxying is their pride and feature. But in practice, far from all sites are ready for this. The number of unexpected problems that can arise is enough for a separate article. In my case, I didn't want all my domains to be proxied, and I had to disable it manually. It's not that hard, but here's what surprised me — you can't do it for all records at once. Well, you actually can, but only through the API, not the web interface. Overall, it's not a huge problem, but it's still strange that such a basic feature isn't available through the web interface.

I'm somewhat oversimplifying here — proxying isn't some useless thing you just need to turn off. In many cases it's a very useful feature, for example for DDoS protection, speeding up site loading, or hiding the site's public IP. In my case, I switched some domains back to proxied mode, but only after figuring out what it actually is and how it works. There's quite a bit of specifics there, and if you don't know what it is, it's better not to touch it.

## additional features

Beyond DNS, Cloudflare provides many other services that can be useful. For example, they provide a free certificate for all registered domains. It's not a huge feature in the era of Let's Encrypt, but it's still nice that it's done automatically and for free. They also offer many other services — DDoS protection, WAF, and other security features. Among those I actually found useful is their Pages service. It's a simple, free hosting for static sites that runs on their CDN. Overall, it's similar to GitHub Pages, but if you already have a domain with them, it can be convenient. In my case, I moved all my small static project sites there (for example https://repoxy.io, https://tg-spam.umputun.dev, and about a dozen others), and it works pretty well. And this very site you're reading now also lives there.

An attempt to move https://radio-t.com to Pages showed that it's not so simple for more complex projects. The pages part is just static content, and you can build virtually anything there. In our case, we didn't even need to do much manually since the site runs on Hugo and Cloudflare Pages can build that out of the box. However, there's also a backend, and that's more complicated. In our case, it's a relatively simple API, but still, it's not static. Anyway, that's a topic for a separate conversation, but overall it can be done if you really want to, though it's not that straightforward.

## conclusions

Overall, I liked the result and mostly liked the process. It's quite an advanced thing with many interesting features, but it's more for geeks than for normal people.

---

_This post was translated from the [Russian original](/2023/09/09/cloudflare-dns/) with AI assistance and reviewed by a human._
