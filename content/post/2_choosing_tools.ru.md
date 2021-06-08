---
date: 2019-06-27
title: Немного о выборе инструментов
slug: choosing-tools
tags: [
    "tools",
    "development"
]
---

Хочу поделиться опытом, полученным мною довольно давно, но урок из него я усвоил крепко.  
Возникла у меня на одном из проектов необходимость развернуть приложение в контейнерах. Сервисов было немного - три или четыре штуки всего. Вероятность резкого масштабирования в будущем также была очень мала. Но по условиям задачи необходимо было раскидать сервисы по 2 машинам, на одной всякого рода фоновые ресурсоемкие задачи, а на другой машине все остальное, что должно отвечать максимально быстро на запросы от пользователей.  
До этого было уже достаточно опыта в использовании docker swarm и был некоторый опыт с kubernetes. Для текущий задачи kubernetes был сильным оверхедом, в то время как в docker swarm не хватало некоторых возможностей (например не было аналога helm) и отпугивали многочисленные баги, с некоторыми из которых довелось ранее дела поиметь и самому тоже.  
Ну и решил я обратить внимание на Nomad. Прочитал документацию, посмотрел доклады на тему его внедрения и использования, пообщался с теми, у кого уже опыт был (а таких нашлось аж целый один человек), почитал различные статьи, поигрался с кластером несколько вечеров. В целом впечатление создалось, что все должно быть намного проще, чем в кубе и удобнее чем в docker swarm.  
Поскольку на проекте не было выделенного devops, то внедрение предполагалось своими силами. Ну и начали строить новую инфраструктуру на базе Nomad (Consul кстати говоря уже был внедрен до этого, поэтому времени немного сэкономили).  
Ну и конечно же очень быстро начали попадаться подводные камни и ломать пальцы на ногах. Сначала развалился кластер, и поднять его по официальной документации не выходило. В итоге потеря времени, данных, пусть и тестовых, но завтра это могут быть реальные. Затем выяснилось, что нет настройки частной сети. Способы решения проблемы есть, но они костыльные и не всегда работают. Отсутствует возможность запускать задачи в нужном порядке, что оказалось крайне сложным в нашем проекте, так как некоторые сервисы зависели от других. И еще менее значительные но многочисленные проблемы, которых по условиям задачи, как раз и хотели избежать. В итоге, потратив неделю, мы решили от Nomad отказаться.  
Какой главный вывод отсюда? Самый подходящий инструмент - это тот, по которому есть экспертиза в команде. А если все же нужен другой, неизведанный, то ищите эту экспертизу или будьте готовы потратить время на ее приобретение.