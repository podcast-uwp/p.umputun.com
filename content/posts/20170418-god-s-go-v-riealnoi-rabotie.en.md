---
title: "A Year with Go in Real Work - Here Be Dragons."
date: 2017-04-18T14:20:40-05:00
draft: false
tags: ["geek stuff", "tech topics"]
slug: god-s-go-v-riealnoi-rabotie
---

![](/images/posts/zxo8z-201605-03124845-4tnxv.png#floatright)

About a year ago, in the post [Go or not Go?](http://p.umputun.com/2016/05/03/go-ili-nie-go/) I casually promised to tell how Go showed itself in real work. The time has come to fulfill my obligations.

Over the reporting period little has changed with the language itself, but there was noticeable improvement in the ecosystem - JetBrains took on Go in a big way and their [Gogland IDE](https://www.jetbrains.com/go/) reached the state of "this is usable." They're getting a decent thing going and it's clear that development is proceeding in the right directions. I switched to Gogland on my main work computer, where I spend 80% of my time. On the laptop I continue to use [Atom](http://atom.io) + [go-plus](https://atom.io/packages/go-plus) mainly because of Gogland's insatiable appetite, which really loves eating batteries.

Over this year I completed a fairly large project, entirely in Go. This is about two dozen services of varying degrees of complexity, responsible both for massive data processing operations and for quite non-trivial logic for analyzing this data on the fly and in preprocessing mode. All this machinery has REST (and not only) API and is covered with various system services most of which are also in Go.

In the project, besides me, a couple of programmers and a couple of business analysts work constantly. From time to time another one and a half programmers join for various non-core tasks. All programmers came to the project without any previous Go experience, the analysts (yes, they sometimes need to see code too) hadn't heard of Go before.

My subjective-expert feeling about Go, against the background of all the above:

- it's an outstanding language for introducing new people to a project. Even though I've already developed "best practices" and softer recommendations "how to do it nicely," transferring this experience to newcomers causes no problems. Even the slowest of these programmers become productive in the new language and in the new code base in the worst case within a week.

- Maintainability and code readability are very decent. With the exception of one service, all the rest are easy and pleasant to return to. After a year I can easily read my old code and, most importantly, colleagues' code. And the reverse is true.

- This exceptional service, with which things aren't very good - this is toward the language's shortcomings and/or my ability to cook all this. There was a certain logically not very complex processor that was conceived as a means of processing several dozen types of data in a general way. General approaches in Go aren't in the best state. Specifically in this project an attempt was made to actively use reflection to express this "generality" and the result, although it works, doesn't evoke warm feelings in me. Most likely this was a mistake. In the process of writing the code it felt like scratching the right ear with the left foot, and after half a year turned into mystical something. Most likely, I'll rewrite this part as soon as time appears, using less radical methods.

- After a year of using Go, I became very annoyed by champions of "the true path" who at every internet corner tell you that everything must be done only and exclusively with stdlib. I don't understand who all these people are and where they get time for constantly writing their own wheels. Certainly, the number of external dependencies in all my Go projects is incomparably less than in my projects in other languages, but they exist and (sometimes) can't be counted on the fingers of one hand (two hands usually suffice). Yes, I don't use any frameworks, but the idea of parsing routes with regexps, or the idea of refusing normal asserts in tests, or spinning up various code for sane flag and config parsing is alien to me.

- Go quite clearly pushes my design toward less deep abstractions. This, as far as I can judge, benefits the result in terms of code clarity and directness. Extraction of abstractions most often happens only when such necessity arises in reality.

- During this time I actively implemented an entire family of linters (code analyzers) into our build and testing process and made passing them a mandatory condition. They, on one hand, are really useful and, as it seems to me, absolutely necessary in life, but on the other - kill at the root the argument about instant compilation in Go. Well yes, my typical service compiles in a couple-three seconds, but then linters take 2 minutes. Not that this is a particular problem for me, but it's annoying. Especially annoying against the background that all unit tests are usually many times faster.

- The verbosity of code in terms of error handling turned out in practice to be more of a blessing than a curse. This, as my experience showed, doesn't reduce readability, but on the contrary - straightens the logic and allows you to easily imagine what exactly and how exactly is happening. I'm talking about someone else's code, or my own from 6 months ago, when reading and understanding it is of primary importance.

- My early attempts and recent attempts by one of the newly arrived colleagues to introduce "proper FP elements" into Go, I evaluate as a completely failed experiment. It was hard to resist these attempts, but they spawned monsters and freaks, which we, by general consensus, almost completely exterminated.

- Minimal FP elements turned out to be quite acceptable, and passing and returning functions - this is a common thing for us. From relatively complex results of early experiments, only the flow (pipeline) thing survived, but even it is on the verge of dramatic rewriting and significant simplification, caused by the appearance of sensible context in one of the relatively fresh versions of Go.

- Asynchronous programming in Go (goroutines and channels) during this time became not so much a means for achieving parallelism, but a means for concurrent design. Here there was a certain shift in the fundamental attitude toward goroutines - from "they're like threads, only lighter" to "they're building blocks for expressing thought and implementing logic and interaction." Such a switch in perception took time and in a week a person who came from java/python is unlikely to realize this.

- During this time I had to engage a couple of times in deep and thoughtful profiling of some critical services, in terms of response time and time to get the full result. The process doesn't particularly differ from similar work in Java and the field for optimization is also wide. Certainly, this isn't a simple task, if we're not talking about trivial optimizations, but in other languages it's no simpler either. Though the absence of a graphical variant of a profiler for Go, like my beloved JProfile in the alternative world, was stressful at first.

- The initial choice of gin was a mistake. I chose it exclusively because of its similarity to what I expected a year ago from such libraries, but the number of problems, especially after implementing vendoring, proved that this wasn't the best idea. Several months ago we completed the transition to lightweight chi which, from this point of view, is much more correct and direct, though the guy maintaining this chi is too... sharp and decisive.

- The fashionable in go-world ideas of including context in errors haven't taken root yet. I'm talking about things like [pkg/errors](https://dave.cheney.net/2016/06/12/stack-traces-and-the-errors-package). My critical errors unwind the stack at the logger level, and non-critical ones are logged right at the place of their occurrence and this suffices for now.

- No advanced loggers took root for me. We use a slightly extended version of the most primitive [The simplest thing that could possibly work](https://github.com/hashicorp/logutils), though the necessity to write `log.Print("[WARN] blah")` drives people who came from the world of structured loggers crazy for the first couple of weeks.

- The idea of automatic generation of new services proved quite viable. Essentially, we generate a service skeleton, including everything needed for the project, which is completely ready to work. There's a main with preliminary environment setup and minimal (and common) implementation of all our usual dependencies, a template for typical repository, a template for typical REST and other services. Plus all the wrapping in the form of Dockerfile, compose, CI configs, templates for monitoring, registration and so on.

- With step-by-step/interactive debugging things are still rough. Gogland is trying to bring this to human form, but for now it works very conditionally. For me, as a "veteran" of existence/survival in the go-world this already seems like a given, but it strains fresh people.

- A number of tasks were discovered that turned out to be practically impossible to transfer from a big enterprise language (java and special libraries / frameworks) to Go. Such an attempt was made by one of the fresh defectors not for fun, but as preparation for a new major release. It ran into insurmountable difficulties related to the absence of a whole range of libraries for Go in the area of certain financial calculations, as well as in unexpected places, like the absence of a decent SAML implementation for Go.

- Some of the libraries we have to use turned out to be quite... wild. For example, AWS Go SDK in terms of working with S3, EC2 and SQS - that's quite a gift. The version for java is also no fountain, but the Go version was definitely written by predators for strangers.

- An unexpected absence of decent solutions for fairly standard cases was discovered. For example, RPC implementation over RMQ. Yes, there's one, but it's easier to kill than to clean up.

- Some libraries, from those that are better to never write yourself, show excessive activity, sometimes crippling backward compatibility. This is rather the exception than the rule, but there are such authors who release too often and aren't very conservative. This isn't a particular problem for me (everything has long been reliably vendored) but there remains work in checking what's new there, why, and how it might affect me. In practice this isn't too painful because of the small number of dependencies, but after spring-boot with its lovingly selected, stable and compatible versions, this is of course a step into the past.

- The biggest practical WTF in Go for me was not at all the absence of generics or exceptions, but the absence of normal, strongly typed enums.

- I've noticed more than once how people new to Go try to use their experience from other languages in Go. The deceptive similarity with other C-like languages against the background of unwillingness to read even minimal documentation leads to amusing `select` in a loop with an active default. They, of course, are amusing from the side, but cause unjustified attacks like "in this your go my simple TCP reader suddenly ate all the CPU".

And in conclusion - with all of this my impression from a year ago "You can write code in Go, you can read code and both these processes are surprisingly pleasant" **remains unchanged**. Perhaps I was hasty with "Go is a very simple language. That is, completely, completely simple." Yes, it appears simple, but sometimes, beyond the boundaries of this simplicity, there be dragons.

---

_This post was translated from the [Russian original](/2017/04/18/god-s-go-v-riealnoi-rabotie/) with AI assistance and reviewed by a human._
