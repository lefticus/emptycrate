---
layout: blog_post
title: Tech Roundup
published: true
date: '2012-08-21 15:43:52'
redirect_from:
- content/tech-roundup/
- node/4424/
- import_node/477/
tags:
- technology
- Programming
---

I've been following a few different news sources lately and have found a few good articles and projects I thought I would share.

-   [Building QuickBooks: How Intuit Manages 10 Million Lines of Code](http://www.drdobbs.com/tools/building-quickbooks-how-intuit-manages-1/240003694). Dr Dobb's discusses the gigantic code base that is QuickBooks. There are lessons to be learned here about automated sanity checks, nightly unit tests and quickly compiling a large code base.
-   [Software Inventory](http://www.joelonsoftware.com/items/2012/07/09.html). Joel Spolsky gives us a fresh take on how to manage software as "inventory." Having worked on large projects with large bug databases and requested feature lists, this article rings true to me. The concept is simple
    1.  If your bug list is getting to big, you must stop new development and glean the bug list.
    2.  If the requested feature list is getting too long, you must filter it for features you will actually implement.
    3.  If the number of new features you've completed but have not yet shipped to customers gets too long, you must make a release.

    It's good advice, and particularly so for a small open source project where it's more time consuming for the developer to push out a release.
-   [Cling a C++11 Interpreter](http://solarianprogrammer.com/2012/08/14/cling-cpp-11-interpreter/) uses clang/llvm to provide a command line interpreter for C++11. It's a neat idea. I'm not sure how practical it will be in the long run.
-   [GCC Now Requires a C++ Compiler to Bootstrap](http://gcc.gnu.org/git/?p=gcc.git;a=commit;h=2b15d2ba7eb3a25dfb15a7300f4ee7a141ee8539). They say it will lead to code cleanups. The actual source listing makes it look like it's still all written in C, however.
-   [Go Is Now Used By Bitly](http://word.bitly.com/post/29550171827/go-go-gadget). Who knew? I had kind of forgotten the language existed. I should probably give it a try at some point.
-   [NaNs Just Don't Get No Respect](http://www.drdobbs.com/article/print?articleId=240005723&siteSectionName=cpp). Don't forget that NaN's actually have a use. You can use them almost kind of like a "null" value, but with CPU support. Some neat ideas are in there.

