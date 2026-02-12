---
title: "Radio on RPi"
date: 2013-01-01T14:20:40-05:00
draft: false
tags: ["tech topics"]
slug: radio-on-pi
---

I've attached sound to my Pi, and now I'm trying to make a web-controlled internet radio receiver out of it. Everything already works, i.e., the chassis is in place. There's not much to write about really, a small web wrapper over the player and mixer that I screwed together in 10 minutes.

But I need help from client-side experts. I.e., I want to show this in a computer and phone browser, and for that I need a bit of HTML, a bit of CSS, and a touch of JS. If you happen to have nothing to do for the new year, then welcome to the spec:


	request: /list
	response: {"response":{"list":{"Jazz":"http://streaming208.radionomy.com:80/A-JAZZ-FM-WEB","FoxNews":"http://fnradio-shoutcast-32.ng.akacast.akamaistream.net/7/115/13873/v1/auth.akacast.akamaistream.net/fnradio-shoutcast-32","Mozart":"http://radio.skypherence.com:8000/radiomozart"}}}

	request: /play/FoxNews
	response: {"response":{"station":"http://fnradio-shoutcast-32.ng.akacast.akamaistream.net/7/115/13873/v1/auth.akacast.akamaistream.net/fnradio-shoutcast-32"}}

	request: /stop
	response: {"response":{"result":1}}

	request: /status
	response: {"response":{"status":"stop"}} #when silent
	response: {"response":{"status":"play","station":"FoxNews"}} #when playing

	request: /volume/4 #0-mute, 10-max
	response: {"response":{"level":"4"}}

Here's such a "mockup" in my head

![](/images/posts/IMG_2775.jpg)

 Everything here is clear without explanations, right? I'll be happy if someone is found and writes something. You can write to me at email which is umputun@gmail.com, or post wherever convenient for you.

 Happy holidays!

*RESULTS*

1. The first working and beautiful variant was proposed by [@yurtaev](https://twitter.com/yurtaev) and he is appointed **ChiefWebSpecialist** and in general, a cool dude! Thanks to everyone who sent their variants — I'll definitely look at them, but you don't have much chance against the ChiefWebSpecialist, I can hardly imagine something so simple and so suitable.
2. here are the **results** of all our creativity — [server part](https://gist.github.com/4440604) and [client part](https://gist.github.com/4432182)
3. [here](http://www.podcraft.ru/2013/01/web-umputun.html) someone launched this whole thing on Windows

---

_This post was translated from the [Russian original](/2013/01/01/radio-on-pi/) with AI assistance and reviewed by a human._
