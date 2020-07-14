---
title: Gmail без глупостей
date: 2012-11-26T14:20:40-05:00
draft: false
tags: ["технические темы"]
slug: gmail-biez-ghlupostiei
---

После трагического угасания Sparrow, я столкнулся с необходимостью поиска некого решения для почты, позволяющего держать мой Gmail открытым в виде отдельного приложения. Не вдаваясь в философские споры "как правильно" и "надо в браузере" только скажу, что мне так неудобно. При моем use case почта должна быть отдельной программой и точка. Перепробовав все, до чего смог дотянутся, я пришел к неутешительному выводу - нет достойных почтовых клиентов для мака. Нет, конечно есть удобный Mail.app и у меня к нему нет никаких существенных претензий, однако я принципиально разделяю рабочую почту от личной и Mail.app уже сидит на рабочем Exchange и паре IMAP.

В результате своих изысканий я пришел к выводу, что лучшим решением будет держать почту в отдельном браузере и пользоваться вебовским Gmail. Из того, что хотелось "починить" у меня в списке было: убрать рекламу, убрать (по возможности) лишние элементы с экрана, иметь некую видимую индикацию нового письма. К слову, я ничего против рекламы не имею, но в письмах оно занимает слишком много места и сужает видимую область письма весьма существенно. Ну и для очистки совести - у меня есть и платный акаунт, тот что без рекламы, но я им не пользуюсь по ряду исторических причин. Так что за отсутствие рекламы я уже заплатил и не надо меня за это совестить.

Итак, я рассматривал 3 варианта:

1. Использование [MailPlane](http://mailplaneapp.com). Этим я пользовался довольно долго, но со временем туда начали добавлять разное излишнее, стабильность стала ухудшаться на глазах и даже самые свежие версии преотвратно работали с двойной гугловой авторизацией.
2. Использовать другой бразуер (мой основной Safari) в режиме "приложения". На практике это условно работающее решение. Можно запустить Chrome в таком виде и при помощи пары расширений убрать из gmail все лишнее, однако держать дополнительный прожорливый браузер не самая хорошая идея. К тому же ссылки из этого "приложения" открываются в хроме, что совсем не то, что я хотел.
3. Использовать [Fluid](http://fluidapp.com) для вынесения Gmail в отдельную программу и его возможности для кастомизации. На этом я и остановился и с Gmail под Fluid живу последние несколько месяцев.

В результате получилось то, что вы видите на картинке. Добиться такого вида несложно, однако вам понадобится платная версия Fluid.

![](/images/posts/gmail.png)

Далее по пунктам, что и куда добавлять:

* В Window/Userscripts найти Gmail и поменять код, который там есть на приведенный ниже. Цель этого действия - починить индикатор новых писем в Dock Badge (начиная с версии 1.6 он не работает из коробки):

``` javascript Dock Badge
function updateDockBadge() {
    //console.log("Running check for unread messages…");
    var oldBadge = window.fluid.dockBadge;
    var newBadge = '';

    var myItems = document.getElementsByClassName("n0");

    for (var i = 0; i < myItems.length; i++) {
        var myTitle = myItems[i].title;
        var pos = myTitle.search("Inbox")
        if (pos >= 0) {
            var matches = myTitle.match(/\((\d*)\)/);
            if (matches) {
                newBadge = matches[1];
            }
        }
    }

    window.fluid.dockBadge = newBadge
    if (newBadge != '' && newBadge > oldBadge) {
        window.fluid.playSound("Basso")
        window.fluid.requestUserAttention(true);
    }
}

setInterval(updateDockBadge, 5000);
```

* Добавить стили в Windows/Userstyles:

``` css спрятать рекламу
.mq { display:none; } .N92wfe { border-top:none; } .nH.PS { margin: 52px 0 44px 52px !important; } .Zs { display:none; } .u5 { display:none; }


.adC { display:none; }
.z0DeRc { display:none; }
.oM { display:none; }
.u7 { display:none; }
.nH.PS { display:none; }
.ao8 table tr td.Bu + td.Bu { display:none; }
td.Bu.yPPMxf { display:none !important; }
td.Bu.y3  { display:none !important;}
```

``` css Спрятать черный заголовок
.aiw .qp { margin-top: -25px; }
#gbgs1{display: none !important}
```

``` css Сделать conversation приятнее на вид
.apN .hx {
  padding-left: 2px !important;
}
.if {
  margin: 3px 8px 8px 2px !important;
}
.hx .adn, .hx .adu, .hx .adf {
  padding-left: 4px !important;
}

/* "Display images" margin */
.B0, div.acS, .bC, .adc, .gY, .adc, .gS, .ac7, div.h9, div.adI {
  margin-left: 0px !important;
}
.B0, .ac7, .acS, .gS, .adp, .h9 {
  margin-right: 10px !important;
}

.Bk,
.hx .ky .Bk,
.hx .kv .Bk,
.hx .h7 .Bk,
.hx .kQ .Bk,
.xG3.G2 {
  border: 1px solid #BBB !important;
  border-bottom-color: #BBB !important;
  -webkit-border-radius: 7px;
  border-radius: 7px;
  border-image: initial;
  background-color: white !important;
}

.Bk .G2 {
  border-top-width: 0 !important;
}

.hx .h7 .Bk,
.hx .kv .Bk,
.hx .ky .Bk {
  margin-bottom: 4px !important;
  border-radius: 7px !important;
}

.kQ .G2 {
  height: 12px !important;
}

/* closed messages */
.hx .kQ .Bk,
.hx .kQ .Bk .G2 {
  height: 8px !important;
  padding: 0 !important;
  margin: 0 0 -4px 0 !important;
}

.kv .Bk .G2,
.kQ .Bk .G2 {
  background-color: transparent !important;
}

.hx .kQ .Bk .G2 {
  border-bottom: 0 !important;
  border-radius: 7px !important;
}

/* contents */
/* header */
.hI, .ig, .iv, .hF, .aju {
  padding-top: 4px !important;
  overflow: hidden !important; /* mostly for left edge */
  border-radius-top-right: 7px;
}
/* gradient stuff - being replaced by
  http://userstyles.org/styles/70673/gmail-messages-with-gradient-header
  */
.hI, .ig, .iv, .hF, .aju {
  /* gradient for message header */

  /* For WebKit (Safari, Google Chrome etc) */
  xbackground: -webkit-gradient(linear, left top, left bottom, from(#edeeef), to(#fff)) !important;
  /* For Mozilla/Gecko (Firefox etc) */
  xbackground-image: -moz-linear-gradient(#edeeef, #fff) !important;
  /* For Internet Explorer 5.5 - 7 */
  xfilter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#EEEEEEFF, endColorstr=#FFFFFFFF);
  /* For Internet Explorer 8 */
  x-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#EEEEEEFF, endColorstr=#FFFFFFFF)";
}

/* Adjust padding around the image for the author - override gradient style. */
.adf .aju {
  padding-bottom: 0 !important;
}

/* padding around the person's image */
.adf.ads, .adn.ads {
  padding-left: 0 !important;
}
/* Center photo better */
.aju {
  cursor: pointer;
  float: left !important;
  padding: 4px 4px 0 4px !important;
  /* Make gradient background and message selection look right */
  border-top-right-radius: 0 !important;
  border-bottom-left-radius: 7px !important;
  border-top-left-radius: 7px !important;
}

/* Don't waste 44px in each message just for the photo */
.hx .nH .gs {
  margin-left: 4px !important;
}

/* message header */
.hx .gE {
  padding-left: 4px !important;
  border-top-right-radius: 7px !important;
}

/* Attachment */
.hq {
    margin: 5px 0;
}
.hr {
    margin: 5px 0 0 5px;
}


/* was 12px */
.hI, .ig, .hF {
  padding-bottom: 4px !important;
}

/* selected message */
.ads {
  border: 1px solid transparent;
}
.ads.adt {
  border: 1px solid #4D90F0;
  border-radius: 7px;
}

/* number of elided messages */
.adx {
  background-color: rgba(255, 255, 255, 0.5) !important;
  top: -10px !important;
}

/* forgot what this is.  See .aju */
.G0 .J-Zh-I.G1, .aju  {
  border-right: 0!important;
  margin-right: 0!important;
  -webkit-border-bottom-right-radius: 0;
  -moz-border-radius-bottomright: 0;
  border-bottom-right-radius: 0;
  -webkit-border-top-right-radius: 7px;
  -moz-border-radius-topright: 7px;
  border-top-right-radius: 7px;
}
/* reply area */
.gA.gt.ac5 {
  border-radius: 0 0 7px 7px !important;
}
/* embedded video, maps, docs, etc */
.gs .hi {
  margin-bottom: -5px !important;
  margin-left: -5px !important;
}
.hi, .gB {
  border-bottom-left-radius: 7px !important;
  border-bottom-right-radius: 7px !important;
}

/* Message title */
.hI, .ig, .iv, .hF {
  padding-top: 1px !important;
}

/* message collapsed */
.hI, .ig, .hF {
  padding-bottom: 0 !important;
}
.gE .cf {
  margin-top: 1px !important;
  margin-bottom: 0 !important;
}

/* message controls, right side of header */
.acX {
  padding-right: 6px !important;
}
.acX .aaq {
  margin-top: 2px !important;
  margin-right: 0 !important;
  min-width: auto;
}

/* message body */
.hx .h7 .Bk .G2 .adn {
  padding-bottom: 4px !important;
}

/* expand-collapse widget */
.ajV, .ajU {
  padding: 10px 0 1px !important;
}

/* reply box at end */
.amr div.nr {
  margin: 1px 8px 8px -1px !important;
  padding: 0;
  cursor: pointer;
}
```

Все это надо дeлать, указывая паттерн подходящий вашему URL. В моем случае это \*mail.google.com\* и \*gmail.com\*

Результат хотя и не идеален, но вполне удовлетворителен. Основная проблема, с которой пришлось примириться, это медленная начальная загрузка. Да, у меня там много писем и gmail задумывается секунд на 20-30 при запуске, однако это происходит только один раз и потом скорость удовлетворительная, хотя конечно, те времена когда Gmail "летал", увы, прошли безвозвратно.

Все это стили и скрипты я накопал на просторах интернетов, некоторые немного поменял. Авторство принадлежит авторам которых я, к сожалению, не вспомню. Если у вас есть полезные скрипты/стили - поделитесь с народом. Комментарии открыты для всех.

P.S. _Переключить gmail в 3х колоночный режим можно из Settings/Labs/Preview Pane_
