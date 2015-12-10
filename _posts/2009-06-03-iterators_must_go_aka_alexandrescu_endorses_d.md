---
layout: blog_post
title: Iterators Must Go (aka, Alexandrescu endorses D)
published: true
date: '2009-06-03 05:00:00'
redirect_from:
- content/iterators-must-go-aka-alexandrescu-endorses-d
- node/4382
- import_node/427
tags:
- Programming
- D
- C++
- Boost
---

[Andrei Alexandrescu](http://erdani.org/) gave the keynote speech at [Boostcon](http://www.boostcon.com/) 2009. The speech's title was "Iterators Must Go." I did not have the opportunity to attend this year's Boostcon, but the slides of the keynote are available [online](http://www.boostcon.com/site-media/var/sphene/sphwiki/attachment/2009/05/08/iterators-must-go.pdf). The talk is an interesting look at the nature of iterators in C++, their shortcommings, and a proposal for how to fix the problems via a replacement of iterators with "ranges." Ranges provide a range checked memory safe approach to iterating over elements in a container. There is a discussion of the usage of ranges in C++ on the [D mailing list](http://www.mail-archive.com/digitalmars-d@puremagic.com/msg09909.html). While the concept is interesting, what was more interesting to me are the last couple of slides where Alexandrescu states that [D](http://www.digitalmars.com/d/2.0/index.html)'s standard library already supports this "range" notion. He also states that he is working on a book, "The D Programming Language," that is due to be published soon. Perhaps if I had been paying attention I would have already known that Alexandrescu was involved in the development of D. Personally, I had not taken D seriously before. I did not see any compelling advantages to using it. However, now that I know Alexandrescu has been working on the language and seems to be endorsing it, I will have to take it more seriously. For those who do not know, Alexandrescu quite literally wrote the book on [Modern C++ Design](http://www.amazon.com/gp/product/0201704315?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0201704315)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=0201704315). His ideas have shaped the current C++ landscape. If he is taking an active interest in a new language, it's worth considering it.
