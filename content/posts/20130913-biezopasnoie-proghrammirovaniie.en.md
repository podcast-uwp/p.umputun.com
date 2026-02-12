---
title: "Safe Programming"
date: 2013-09-13T14:20:40-05:00
draft: false
tags: ["back to the past"]
slug: biezopasnoie-proghrammirovaniie
---

This is about version control systems. Strangely enough, a huge number of quite decent programmers don't even suspect what these systems are and why they're needed at all. And of course, they don't understand what they're missing in life. Well then, I'll try to help them, to the best of my modest abilities.

When developing medium to large software systems, all developers face a number of problems related to version control. You want to store all past versions somewhere, somehow document changes, have the ability to go back (if necessary), easily compare versions, etc.

<!--more-->
And of course everyone finds some solutions. Like periodically archiving the entire project and saving all the zips on the side. Some non-lazy folks even attach some descriptions to the archives. To determine differences, people usually use diff.

I suffered like this myself until a couple years ago when I stumbled upon a version control system — MS SourceSafe. It was timely, because by then I was completely exhausted with archives and directories where various past versions lay, and was seriously thinking about writing something of my own, so that, first, I could bring order to this chaos, and second, simplify collaborative work on shared projects. Well, those who write programs will understand what I'm talking about. Many know the horror of losing your latest changes because someone didn't take the latest version, and many know the painstaking work of merging the work of two programmers into common files.

So, SourceSafe, in my opinion, is one of Microsoft's most successful programs. Everything it allows you to do is control file versions and facilitate collaborative work on them. The system is installed on a server and anyone interested, after installing the client part, can easily connect to the server and start working.

SourceSafe is part of VisualStudio, though it's sold separately too. Costs about $600.
This system stores all program texts in a database of its own format, and at user request can either give him the latest version (or a previous one), or accept a modified file version from him.

Well, let's start from the beginning. Work on a software project using SourceSafe happens like this. First of all, the programmer marks the files he wants to work with and does a check-out. This means the latest versions are copied to the program's working directory, and the system notifies everyone that the files are captured and being worked on. The concept of a working directory in this system is very important. This isn't a directory on the SourceSafe server, it's the place where working file copies are stored on the developer's local machine disk. That is, the programmer has just a copy, a working instance, and the master files are always on the SourceSafe server. I emphasize this because this concept is very important for understanding and working correctly with the system.

After making changes and appropriate checks, the programmer wants to save the current version. He does a check-in on the needed files, thereby updating the master copy on the server. At the same time, his local copy switches to read-only mode and can't be modified. That is, for editing it's always required that the file be in checked-out mode.

If a version conflict arises during check-in, which can happen if different programmers work on it simultaneously, the system will report the conflict and offer either automatic merge (conflict resolution) or manual mode. In this mode, all conflicts are visible. Essentially, it's an advanced version of diff with a nice interface.

All versions (and every check-out creates a new version) are saved on the server and automatically supplied with information about the date and author of the last change. Now finding who broke the whole, yesterday still working project is a matter of one minute.

Really key versions can be supplied with labels including descriptions of all changes. At any moment, you can find a past version (both with and without labels), see what changed, and if necessary return to it.

Another very useful feature is share. That is, any file from any project can be cloned into another project. At the same time, any change to a shared file automatically happens in all projects using it. If you want to break such automation, you can use the branch function, breaking the clone's dependency on its parent and turning the latter into a completely independent file.

Share is a very convenient means for creating libraries of frequently used files open for access to a group of programmers. Speaking of access, SourceSafe provides access control both at the project level and at the user level.

The system is also equipped with means for creating backup copies and restoring them.

Practically all functions are available through the command line, which allows easy automation of routine commands like daily archiving.

It's important to understand that SourceSafe is suitable for working with any source texts. It works at the text file level, and therefore what programming language is used doesn't matter at all. You can store not only program versions in it, but any text files, for example program descriptions.

When using the VisualStudio package, SourceSafe integrates organically into the work environment. When using other systems, it's necessary to use SourceSafe Explorer.

Of the known SourceSafe shortcomings, the main ones are slowdown when dealing with very large total text volumes (from 5-10 gigabytes it's already noticeable), and lack of support for remote mode work. That is, the SourceSafe server works normally only on a local network, and if there's a need to connect to it via TCP/IP from a remote computer, you should use the SourceOffSite add-on from SourceGear.

from the program description:
> SourceOffSite™ Professional Edition is specifically designed for companies with remote development teams and tele-commuters that need fast and secure read/write access to a centralized SourceSafe database via any TCP/IP connection. Microsoft endorses (product, case study) the use of SourceOffSite as a remote access solution for Visual SourceSafe.


In my opinion, using SourceSafe is absolutely necessary in any software projects and at all stages of work. It provides absolutely amazing flexibility for collaborative work, full control over versions, and a reliable system for creating backup versions.

---

_This post was translated from the [Russian original](/2013/09/13/biezopasnoie-proghrammirovaniie/) with AI assistance and reviewed by a human._
