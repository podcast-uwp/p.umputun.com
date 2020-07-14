---
title: "Всем миром для общей пользы"
date: 2015-11-26T14:20:40-05:00
draft: false
tags: ["для гиков", "подкасты"]
slug: vsiem-mirom-dlia-obshchiei-polzy
---

Не первый раз я практикую идею "а давайте, ребята, сделаем для общего блага ...", и вот опять. В нашем подкасте [радио-т](http://www.radio-t.com) есть незаменимый инструмент, позволяющий собирать новости, готовить их к выпуску, показывать что активно в данный момент, обновлять чат и всякое прочее. Он действительно незаменим, и я не представляю, как бы мы справлялись без него.

Этот замечательный [news.radio-t.com](http://news.radio-t.com) несколько лет назад был написан одним из наших слушателей (Alex T, @Sqrt) и долго служил нам верой и правдой. Однако, время идет, все развивается. Да и сопровождать этот сервис стало непросто, по ряду причин. Короче говоря, я решил все переделать и уже половину переделал.

Из монолитного PHP приложения с MYSQL, я хочу поменять это хозяйство на сервис(ы) бэкенда, собирающие новости и отдающими наружу рестообразный API. Там все не совсем чтоб просто, но на практике я написал весь этот бэкенд за день и у него есть вполне достаточный, как минимум для начала, API. И да, я его написал на Go :)

Теперь дело за второй частью - сделать к этому UI/фронтенд. Это совсем не моя область, и [мой фронтенд](http://master.radio-t.com:8778) конечно крут, но  ... несколько примитивен ;) Вот я и призываю тех, кто на этом деле собаку съел - приходите, помогите в нашем общем деле. Ниже я опубликовал API и экраны того, как оно сейчас. Эти экраны только для того, чтоб наметить необходимую функциональность, это **не руководство к дизайну** ни разу. Дерзайте, делайте красиво и удобно.

Да, и вот еще что - я бы хотел, чтоб клиентская сторона не была дикой, и была бы именно клиентской. В том смысле, что если вам хочется прикрутить туда какой nodejs, чтоб поверх API был более другой сервер, то эту идею я не поддержу. Что касается "дикости" - наверное не стоит это писать на какой-то экзотике, типа фреймворка который знают и умеет два с половиной человека. Этот продукт должен быть сопровождаем не только автором и я предполагаю не один год его жизни у нас в подкасте.

По поводу возможного _"а зачем я буду тратить на это свое время?"_ у меня только один ответ - если не ты, то кто? Ну и, конечно, автор(ы) будут публично похвалены и оглажены в подкасте. 

#### API 

    GET /api/v1/feeds - список фидов
    POST /api/v1/feeds - добавить фид {feedlink: url}
    DELETE /api/v1/feeds/:id - удалить фид

    GET /api/v1/news - все новости, кроме удаленных
    GET /api/v1/news/del - удалённые новости
    DELETE /api/v1/news/:id - удалить (пометить как удаленную)
    PUT /api/v1/news/undelete/:id - восстановить удаленную
    PUT /api/v1/news/move/:pos/:offset - двигать новость вверх/вниз

    PUT /api/v1/news/active/:id - пометить как активную
    GET /api/v1/news/active - взять текущую активную
    GET /api/v1/news/active/id - взять id текущей активной
    GET /api/v1/news/active/last/:hrs - список всех что были активны за последние hrs часов

    PUT /api/v1/news/nogeek/:id - пометить как обычную, негиковскую 
    PUT /api/v1/news/geek/:id - пометить как гиковскую

    POST /api/v1/news - добавить новость по ссылке, {link: url}

    PUT /api/v1/news/reload - форс-релоад из фидов (раз в 5 минут делает само)

_upd: все запросы на PUT/POST/DELETE теперь просят basic auth, test:test_

пример:
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

и еще один:
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

по поводу нескольких ts (тут их целых 3) могут быть резонные вопросы:

1. `activets` – момент активации новости
1. `ts` – время новости из rss
1. `ats` – когда новость добавлена в систему

#### Что у нас есть сегодня в старой системе

![](/images/posts/1bi40-201511-26155228-uer60.png)
Вроде тут все понятно. А то, что вычеркнул – это не потому что секрет какой, но я просто не помню что это было, и точно этого не надо. 

![](/images/posts/nvynb-201511-26155730-edcut.png)
Тоже все просто.

Это все было для админов, вот что видят обычные пользователи:
![](/images/posts/q0dgn-201511-26155839-ywrtw.png)

Вот вроде и все, что могу показать. Если надо еще деталей - спрашивайте в комментариях. И да, API доступен для ваших экспериментов на http://master.radio-t.com:8778. И CORS там пока работает, чтоб вы могли спокойно разрабатывать свою сторону.

__upd:__ по вашему совету сделал [github repo](https://github.com/umputun/rtnews-ui)
![](/images/posts/csgg1-201511-27122159-3geii.png)

Пара слов, чего я ожидаю в результате:

1. Некоторые запросы (все, что не GET) будут доступны только админу (простая basic auth на стороне nginx будет требовать этого)
1. То, что видит нормальный пользователь (не админ) это список, и активную тему. Ну плюс всякие визуальные плюшки, типа снипета, картинки, открытие полного content.
1. Админ часто двигает темы вверх вниз, это должно быть просто и удобно. Сейчас там прелестно работает drag–drop. И да, часто делается "подвинуть новость на самый вверх"
1. Админ может ошибиться и удалить не то. Хорошо бы показать "deleted" и разрешить "restore" (я добавлю restore в API)
1. Для тем гиковского выпуска не надо ничего особенного для админа, только пометить/очистить флаг. Для view этого надо ссылку на ручное переключения на "посмотреть только гиковские".

_5 Дек. 2015: __[новая версия уже тут!](https://news.radio-t.com)__ Спасибо всем неравнодушным, и конечно [Игорю Адаменко](https://github.com/igoradamenko), который придумал и реализовал весь этот UI. Всем, у кого остались замечательные идеи, рекомендую скооперироваться с автором нового фронтенда [на гитхабе](https://github.com/igoradamenko/rtnews-ui.git)._
