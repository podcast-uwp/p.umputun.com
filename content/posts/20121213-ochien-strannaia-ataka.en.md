---
title: Very Strange Attack Through WP
date: 2012-12-13T14:20:40-05:00
draft: false
tags: ["geek stuff"]
slug: ochien-strannaia-ataka
---

Here I had something strange happen. If you're aware, my service [uKeeper](http://www.ukeeper.com) receives a lot of letters from users, well just very many. And sends a lot too, but now we're talking specifically about receiving. So, I was thinking about all kinds of different mechanisms to counter possible abuse, and a lot of such things are implemented there. It understands suspicious activity, slows it down at all kinds of levels and at the same time keeps strict control and accounting of such villains. Until this week, most of all the protective intelligence was idle. Well yes, sometimes all kinds of small spam came, sometimes smart guys tried to guess the confirmation code, but all this was at the level of "kindergarten, pants on suspenders". But this week something strange happened.

I started receiving in noticeable quantities letters from WordPress <wordpress@vsegdasvezhie.ru>. Strange letters, like this one


		Date: Wed, 12 Dec 2012 20:41:27 +0000
		From: WordPress <wordpress@vsegdasvezhie.ru>
		Message-ID: <3454a710914021e9f8a267c6d21d0124@vsegdasvezhie.ru>
		X-Priority: 3
		X-Mailer: PHPMailer 5.2.1 (http://code.google.com/a/apache-extras.org/p/phpmailer/)
		MIME-Version: 1.0
		Content-Transfer-Encoding: 8bit
		Content-Type: text/plain; charset="UTF-8"

		A new comment on the post "Three antipasti. Photo recipe / vsegdasvezhie.ru" awaits your approval
		http://vsegdasvezhie.ru/tri-antipastyi-foto-retsept-gotovim-ru/

		Author : Online blackjack usa legal (IP: 173.44.37.242 , 173.44.37.242)
		Email : qeooyyzhhh@dfwbxq.com
		URL    : http://axentra.net/
		Whois  : http://whois.arin.net/rest/ip/173.44.37.242
		Comment:
		kazpywtfhebtwf{ijf, <a href="http://axentra.net/" rel="nofollow">Online Blackjack</a>, tJbeSKS, [url=http://axentra.net/]Us online blackjack[/url], BfZlKCw, http://axentra.net/ Online Blackjack, smwbUBn.

		Approve: http://vsegdasvezhie.ru/wp-admin/comment.php?action=approve&c=5470
		Trash: http://vsegdasvezhie.ru/wp-admin/comment.php?action=trash&c=5470
		Mark as spam: http://vsegdasvezhie.ru/wp-admin/comment.php?action=spam&c=5470
		Currently 5,418 comments awaiting approval. Please visit the moderation panel:
		http://vsegdasvezhie.ru/wp-admin/edit-comments.php?comment_status=moderated

They came quite often, several pieces per minute and of course caused legitimate concern in the computer brain of [uKeeper](http://www.ukeeper.com), which hurried to take measures and informed me about suspicious activity. I didn't investigate long, remembering that before cursing, you need to try to negotiate. Went to the site vsegdasvezhie.ru which turned out to be a Delivery Club site. Quite a nice product delivery site. After a short search, a contact form was found and various emails where to write.

Well and I wrote everything as it is:

_Good day. From your address wordpress@vsegdasvezhie.ru dozens and hundreds of letters come every hour, to one of my accounts drops@ukeeper.com, with text "[Natural products with delivery] please moderate: "Three antipasti. Photo recipe / vsegdasvezhie.ru". I ask, stop this outrage as quickly as possible. I wouldn't want to bring the matter to complaints to the abuse of your provider, but agree — a hundred such letters will drive anyone to boiling point. I hope for understanding and quick resolution of this unfortunate problem._

They answered me quite quickly, and I won't quote the kind Elena's answer here, she wrote it to me, not for the community of readers, but the essence was expressed approximately like this — _"We hasten to assure you that we have no relation to this resource and, accordingly, to spam attacks on your electronic mailbox."_ They also asked to forward such a letter for in-depth investigation, which I did without delay.

However, 3 days passed, and the situation didn't get fixed. Keeps sending and sending, this persistent robot. No use from its letters, no harm either, but agree — not right. And then I decided to read one of the spam letters to the end. In the process of reading I was surprised and when I got to the links to wp-admin I was completely surprised and went to open the link to this very wp-admin. Of course, as a true paranoiac, I did this from a specially raised, disposable VM. Well let it be on my OSX machine, but on VM linux — caution doesn't hurt and after going to a suspicious place I destroy this VM. In short, at the link turned out to be an admin login form to WP. After requesting password recovery to the address where all the spam from this wordpress came, I successfully received a new password, logged in and found myself in wp-admin as the most real administrator, with all possible rights. There really is a user drops registered, with the corresponding email and in options it says "Send letter" for any sneeze. Or more precisely for "Someone left a comment" and "Comment awaits moderation".

I don't like walking through other people's systems, even such strange ones as WP in which my uKeeper's email is registered as admin. All I did was remove my email replacing it with a fictitious one. I didn't delete the user, might come in handy :) Besides me there's one more admin there with a very strange email, looks like fake. I wrote to him that so and so, looks like your WP is hacked and kids are playing around there. Before leaving there, I cast a glance at what's going on there and shuddered. In general this looks like a phishing site, but some kind of crazy one. All its posts by title look like recipes, but the text of messages is pieces of some broken HTML. For example there's such a thing:
```
&nbsp;
div page
div header
table simpleTable" border="0
tbody
tr
td a href="http://vsegdasvezhie.ru/img http://vsegdasvezhie.ru/imgs/osen.jpg" alt="vsegdasvezhie.ru" width="140" height="145" border="0" hspace="5" vspace="5" //a a href="http://vsegdasvezhie.ru/img http://vsegdasvezhie.ru/imgs/nadpis.jpg" alt="vsegdasvezhie.ru" width="250" height="81" border="0" hspace="5" vspace="35" //a/td
td align="right
```
Just like that, this isn't a formatting error. And to each message hundreds of typical spam comments, well you know how it happens in WP. But here's something I can't understand. This vsegdasvezhie WP site is called "Natural products with delivery" and, apparently, opens the honest Delivery Club in an iframe. I.e., I needlessly puzzled them with my letter. But I don't understand — why all this? I.e., why such a site, I can imagine — maybe it's trying to plant something on you (I didn't check, just suppose). But why is WP needed at all if it's not visible? And most importantly, why did the attacker need to add drops@ukeeper.com to admins? Here my imagination stalls. Maybe he supposed that for each letter from this adminка about "New comment" uKeeper would in response go to the spam link in the letter and inflate some counters? Oh, what a strange way to make a bot inflate. Or expected that the response letter from uKeeper would be sent not to the incoming wordpress@vsegdasvezhie.ru, but to some other (which?) address and thus would send spam through my honest service? There's no answer for me, only questions.

---

_This post was translated from the [Russian original](/2012/12/13/ochien-strannaia-ataka/) with AI assistance and reviewed by a human._
