---
title: "All Hands for the Common Good"
date: 2015-11-26T14:20:40-05:00
draft: false
tags: ["geek stuff", "podcasts"]
slug: vsiem-mirom-dlia-obshchiei-polzy
---

This isn't the first time I've practiced the idea "come on, folks, let's build something for the common good ...", and here we go again. In our podcast [Radio-T](http://www.radio-t.com) there's an indispensable tool that allows us to collect news, prepare them for the show, display what's currently active, update the chat and all sorts of other things. It's truly indispensable, and I can't imagine how we'd manage without it.

This wonderful [news.radio-t.com](http://news.radio-t.com) was written several years ago by one of our listeners (Alex T, @Sqrt) and served us faithfully for a long time. However, time passes, everything evolves. And maintaining this service has become difficult for a number of reasons. In short, I decided to redo everything and have already redone half of it.

From a monolithic PHP application with MYSQL, I want to change this setup to backend service(s) that collect news and expose a REST-like API. It's not exactly simple there, but in practice I wrote this whole backend in a day and it has a quite sufficient API, at least to start with. And yes, I wrote it in Go :)

Now the second part remains — to build a UI/frontend for this. This is absolutely not my area, and [my frontend](http://master.radio-t.com:8778) is of course cool, but ... somewhat primitive ;) So I'm calling on those who've really mastered this — come help with our common cause. Below I've published the API and screens of how it is now. These screens are only to outline the necessary functionality, this is **not a design guide** at all. Go ahead, make it beautiful and convenient.

Oh, and one more thing — I'd like the client side not to be wild, and to be actually client-side. In the sense that if you want to attach some nodejs so that on top of the API there's yet another server, I won't support that idea. As for "wildness" — probably shouldn't write this in some exotic framework that two and a half people know and can use. This product should be maintainable not only by the author and I expect more than one year of its life in our podcast.

Regarding the possible _"why would I spend my time on this?"_ I have only one answer — if not you, then who? Well, and of course, the author(s) will be publicly praised and acknowledged in the podcast.

#### API

    GET /api/v1/feeds - list of feeds
    POST /api/v1/feeds - add feed {feedlink: url}
    DELETE /api/v1/feeds/:id - delete feed

    GET /api/v1/news - all news except deleted
    GET /api/v1/news/del - deleted news
    DELETE /api/v1/news/:id - delete (mark as deleted)
    PUT /api/v1/news/undelete/:id - restore deleted
    PUT /api/v1/news/move/:pos/:offset - move news up/down

    PUT /api/v1/news/active/:id - mark as active
    GET /api/v1/news/active - get current active
    GET /api/v1/news/active/id - get id of current active
    GET /api/v1/news/active/last/:hrs - list of all that were active in the last hrs hours

    PUT /api/v1/news/nogeek/:id - mark as regular, non-geek
    PUT /api/v1/news/geek/:id - mark as geek

    POST /api/v1/news - add news by link, {link: url}

    PUT /api/v1/news/reload - force-reload from feeds (automatically does it every 5 minutes)

_upd: all PUT/POST/DELETE requests now ask for basic auth, test:test_

example:
```
http GET master.radio-t.com:8778/api/v1/news/active/id
HTTP/1.1 200 OK
Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With
Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
Access-Control-Allow-Origin: *
Application-Name: rt-news
Connection: keep-alive
Content-Length: 33
Content-Type: application/json
Date: Thu, 26 Nov 2015 22:47:17 GMT
Org: Radio-T
Server: nginx/1.9.7
X-Powered-By: go-json-rest

{
    "id": "5657741292d7e8a4ace10c5a"
}
```

and one more:
```
http GET master.radio-t.com:8778/api/v1/news/active

HTTP/1.1 200 OK
Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With
Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS
Access-Control-Allow-Origin: *
Application-Name: rt-news
Connection: keep-alive
Content-Length: 676
Content-Type: application/json
Date: Thu, 26 Nov 2015 22:49:01 GMT
Org: Radio-T
Server: nginx/1.9.7
X-Powered-By: go-json-rest

{
    "active": true,
    "activets": "2015-11-26T22:43:20.24Z",
    "ats": "2015-11-26T21:05:21.239Z",
    "content": "",
    "del": false,
    "feed": "http://www.instapaper.com/folder/1733843/rss/470308/Epogj3Ubs5DdJJnUdVD2HUAKSk",
    "geek": false,
    "id": "5657741292d7e8a4ace10c5a",
    "link": "http://techcrunch.com/2014/07/07/mit-and-dropbox-alums-launch-inbox-a-next-generation-email-platform/",
    "pic": "",
    "position": 6,
    "snippet": "Founded by Dropbox and MIT alums, a new startup called Inbox is launching out of stealth today, hoping to power the next generation of email applications.…",
    "title": "MIT And Dropbox Alums Launch Inbox, A Next-Generation Email Platform | TechCrunch",
    "ts": "2014-07-08T18:10:23Z",
    "votes": 0
}
```

regarding several timestamps (there are 3 here), reasonable questions may arise:

1. `activets` – moment of news activation
1. `ts` – news time from rss
1. `ats` – when news was added to the system

#### What we have today in the old system

![](/images/posts/1bi40-201511-26155228-uer60.png)
Everything seems clear here. What I crossed out — it's not because it's some secret, I just don't remember what it was, and definitely don't need it.

![](/images/posts/nvynb-201511-26155730-edcut.png)
Also all simple.

This was all for admins, here's what regular users see:
![](/images/posts/q0dgn-201511-26155839-ywrtw.png)

That seems to be all I can show. If you need more details - ask in the comments. And yes, the API is available for your experiments at http://master.radio-t.com:8778. And CORS is enabled there for now, so you can calmly develop your side.

__upd:__ following your advice created a [github repo](https://github.com/umputun/rtnews-ui)
![](/images/posts/csgg1-201511-27122159-3geii.png)

A few words on what I expect as a result:

1. Some requests (everything that's not GET) will be available only to admin (simple basic auth on the nginx side will require this)
1. What a normal user (non-admin) sees is a list and the active topic. Plus various visual goodies, like snippet, picture, opening full content.
1. Admin often moves topics up and down, this should be simple and convenient. Currently drag-drop works beautifully there. And yes, often done is "move news to the very top"
1. Admin can make a mistake and delete the wrong thing. Would be good to show "deleted" and allow "restore" (I'll add restore to the API)
1. For geek episode topics don't need anything special for admin, just mark/clear flag. For view this needs a link for manual switching to "view only geek".

_Dec 5, 2015: __[new version is already here!](https://news.radio-t.com)__ Thanks to all who cared, and of course [Igor Adamenko](https://github.com/igoradamenko), who designed and implemented this whole UI. Everyone who has great ideas left, I recommend cooperating with the new frontend author [on github](https://github.com/igoradamenko/rtnews-ui.git)._

---

_This post was translated from the [Russian original](/2015/11/26/vsiem-mirom-dlia-obshchiei-polzy/) with AI assistance and reviewed by a human._
