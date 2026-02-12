---
title: "Quick and Easy Setup of Your Own DNS"
date: 2016-05-08T14:20:40-05:00
draft: false
tags: ["tech topics", "geek stuff"]
slug: bystro-i-prosto-podnimaiem-svoi-dns
---

Recently I started noticing some strange slowdowns in completely different cases related to the internet. Not only did casual page browsing begin to feel somewhat heavier, but also access to various resources not directly related to browsing. This slowdown was irregular and hard to classify, but over time it became irritating.

After simple investigations the suspected culprit was found - my provider's DNS server. It, in principle, works fast, but sometimes thinks hard. I was able to prove this to myself with [namebench](https://github.com/google/namebench), which checks resolution speed not with synthetic tests, but using the history of your internet browsing.

Despite the average speed being decent, peaks of slowdown reached almost a second, which is undoubtedly outrageous. Of course, the cheap and simple solution is to just change DNS to another one, for example google's 8.8.8.8 / 8.8.4.4 or opendns or some other to taste (namebench offers a list of alternatives), but since I took on this task, I decided to bring it to its logical end - set up my own caching DNS.

Installing [bind](https://www.isc.org/downloads/bind/) or its alternatives manually - that's not our way, of course. The easiest is to look for a suitable docker image and, if not found, make it yourself.

Fortunately, [one already exists](https://github.com/sameersbn/docker-bind) and it even works. There's bind and webmin for GUI management inside. I added a bit to its `docker-compose.yml`, to pass the password for webmin and disabled IPv6, which led to resolution errors. Here's what compose resulted in:

```
bind:
  image: sameersbn/bind:latest
  container_name: bind

  log_driver: "json-file"
  log_opt:
      max-size: "10m"
      max-file: "5"

  environment:
      - ROOT_PASSWORD=something-very-secure
  ports:
    - "53:53/udp"
    - "10000:10000"
  volumes:
    - ./data:/data
  restart: always
  command: /usr/sbin/named -4
```

*If IPv6 doesn't bother you, just remove the `command` line.*

To set this thing up, you just need to save this in a suitable place (for me `/srv/bind`) as `docker-compose.yml` and run it roughly like this:
```
cd /srv/bind
docker-compose up -d
```

After starting, point your DNS to the address of the computer that runs the container with bind and everything should work. If you, for some purposes, need to locally translate your internal names to addresses (and/or vice versa), this is also done almost easily through webmin. [Here](https://www.damagehead.com/blog/2015/04/28/deploying-a-dns-server-using-docker/) is an example of such use drawn both as pictures and with clear explanation.

As a result all this works, the problem of irregular slowdown disappeared and namebench joyfully suggests my own server, which, naturally, tears apart all remote options.

_P.S. I, of course, tried to use the DNS support provided by my [ZyWall USG20](https://www.zyxel.com/us/en/products_services/usg20_vpn_usg20w_vpn.shtml?t=p), but it worked slowly and somehow strangely._

---

_This post was translated from the [Russian original](/2016/05/08/bystro-i-prosto-podnimaiem-svoi-dns/) with AI assistance and reviewed by a human._
