---
title: "Go or Not Go?"
date: 2016-05-03T14:20:40-05:00
draft: false
tags: ["geek stuff"]
slug: go-ili-nie-go
---

The goal of this post is to try to answer a number of questions I get from time to time. The most popular is **"is it worth learning?"**, the second most popular **"and how to do it?"** and the 3rd - "**it's crap**, how could you say anything good about it?"

![](/images/posts/zxo8z-201605-03124845-4tnxv.png#floatright)
Let's go point by point. To the question "is it worth learning," I'll boldly say - yes, it's worth it. And there are a couple of weighty reasons for this:

- It's a quite practical language and the ability to write in it will allow you to make something. This "something" can be made in other languages too, but it can also be done in Go. If we're talking about small home projects, then here in terms of practicality and speed of achieving results, Go, for me, is approximately on the same level as Python. However, if the project isn't the smallest and/or its development and maintenance may be required, then here I'd give preference to Go.

- Go is a **very simple** language. That is, completely, completely simple, simple as a door, straight as a railroad. Learning it can take from a couple of hours to a couple of weeks, depending on the learner's experience. At the same time the timeframes aren't fictitious, as with other languages that are simple in themselves, but to make something real in them you need to learn everything around them, their ecosystem, build systems, testing magic, minimal frameworks and libraries. With Go all this is noticeably simpler and, importantly, it doesn't particularly load the brain.

Now I'll try to expand, substantiate and answer for everything.

Writing small and medium projects in Go is surprisingly pleasant, fast and productive. I don't know how it will be with really large projects, I don't have much such experience yet, but with small and medium ones everything is fine. Since my practical contact with Go, I've written in it a whole bunch of things where I previously used python, and where it always seemed to me that it's too much for python, or where I used java and felt that java is overkill for such things. Not to brag, but to clarify, here's a short list:

- backend of what makes [news.radio-t.com](http://news.radio-t.com). This is a project not a projectlet, there's actually a lot going on behind the scenes.

- distribution and balancing system (a kind of special CDN) for podcasts. This thing was written many years ago in java and worked quite well until it broke. Touching it to fix it, I saw a lot of code there and most of it is quite low-level. No, the code there isn't bad, but the best code is, as known, code that doesn't need to be written. As a result, I rewrote this thing in Go in an evening and to achieve comparable performance I didn't even have to think. Everything almost immediately worked and works now.

- bot for our [gitter chat](http://chat.radio-t.com). It too was in java for many years and, honestly, it could have been rewritten in anything. There over the years many of the most complex things became obsolete, and what remained - it's quite simple. But writing it in Go was simple and pleasant.

- there's a slow process of writing a new version of [ukeeper v2](http://ukeeper.com) in Go. Here everything is somewhat more complex. This is a really large java project and it outgrew itself and its architecture. I've rolled up my sleeves a couple of times already and tried to break it into small parts, remove old junk and simplify everything possible. But the task is frighteningly large and essentially comes down to rewriting many parts using modern methods and technologies, plus thoughtful cutting off of excess. As an experiment I tried to write the main service, the one that does the main magic, in Go and the result was pleasantly surprising. The code is simple and almost direct, performance is more than enough, scalability galore. And writing this service took only a couple of weekends.

- there's a whole series of small and medium projects at work, which were either written from scratch, or as an upgrade from their py version that started getting out of control. There's a lot there, starting from an RMQ dispatcher with tricky forwarding to AWS resource management systems. There are more traditional systems for business tasks and computational systems and various other things.

In the process of such close communication with Go I noticed a whole series of features:

- in a Go project it's relatively easy to return yourself, even after spending several months doing something else and even in other languages. From my experience, for anything bigger than a 2-page python script, this is noticeably easier. Everything is direct, simple and painless.

- It's much simpler to introduce a new person to a Go project, even if this person isn't the most advanced specialist and doesn't have particular Go experience. This is a long and tedious topic that I sometimes touch on in the [podcast](https://radio-t.com).

- That your own Go code is easily readable - this is clear and pleasant. But, no less important, someone else's code is readable almost as easily as your own. This is actually very, very important, even if you work alone on your home projects, you'll have to communicate with someone else's code, at least in the form of libraries.

- In the process of working in Go I noticed that I don't need to search for answers on the internet as often as in python or java. No, there's nothing wrong with googling a problem, but if there's no such necessity then that's even better. In python, which I don't use constantly, I often had to search for quite trivial things that can be done in many ways and which I've already done correctly, but forgot how. In java, which is my main language, you have to search for strictly the opposite - non-trivial problems or problems with magic, of which there's plenty in big java (with all the useful enterprise frameworks).

- In terms of casualness Go for me even beats python. I mean all these preliminary... actions that need to be performed before you start writing code.

If by this point I've convinced you and your sleeves are rolled up, and fingers are hovering over the keyboard in an irresistible desire to try, then here's the answer to the question "how and what to learn?" First, I wouldn't recommend reading books about Go. Yes, there are a couple of worthy books that maybe are worth reading over time, but it will be much more practical to look through 3 resources:

1. [Go by Example](https://gobyexample.com) – very laconic, and about almost everything needed for a quick start.
2. [Learn X in Y minutes](https://learnxinyminutes.com/docs/go/) – a lovely way, my personal favorite.
3. [How to Write Go Code](https://golang.org/doc/code.html) - also short and sweet.

I'm not sure this will suffice for those who've never programmed before, but if there was at least some experience in any language before (even experience in JS and PHP will do), then it should suffice.

About "it's crap, not a language." Here it's hard for me to argue and not only because I said this myself. The language, for connoisseurs, isn't actually the most... expressive. And at a glance, a program in Go looks strange, and for many unpleasant. However, you get used to how it looks quickly, well and this "bah" can be delivered about any new syntax too. I remember how python bothered me at first with its indents and java with its long constructions.

And about the language's sparseness there's no arguing either. Yes, it's like that. Yes, there's no much of what I wanted too. However, like everything practical in our field, Go is a compromise. And this compromise indeed looks not particularly attractive from the side. I fully understand critics of the language and in places share their position, except for their conclusion - "this is an unsuitable language, into the furnace with it." From my practical experience these compromises aren't as severe as they seem from the side. You can write code in Go, you can read code and both these processes are surprisingly pleasant. There's some special phenomenon here that I find difficult to describe. By all signs Go should have turned out to be a failure and a freak of nature, but in practice it's a really working tool quite suitable for an entire class of tasks.

I think that Go isn't another hipster tendency that will be forgotten if not tomorrow, then in a year. This is a real and genuine thing and it's here to stay.

_P.S. rereading everything I delivered here, I discovered with surprise that it turned out with a bias toward "all the good." No, I have a long list of "all the bad" too, and maybe I'll write about it separately. And I was also planning to tell how to live in Go in practice, i.e. in what and how to write, what and how to use. Maybe I'll get around to this too..._

---

_This post was translated from the [Russian original](/2016/05/03/go-ili-nie-go/) with AI assistance and reviewed by a human._
