---
layout: blog_post
title: C++ Error Handling
published: true
date: '2006-05-04 13:01:07'
redirect_from:
- content/c-error-handling/
- node/4231/
- import_node/220/
tags:
- Programming
---

I'm not going to address exceptions, per se, if that's what you are thinking about. You can find tons of info on exceptions in other places. I recently needed to build a very robust & multithreaded app for work. During the development of it I came across 2 functions I had never heard of before.

1.  `set_terminate()`
2.  `set_unexpected()`

It seems that in the case of a thread calling `exit()` the parent process does NOT have its terminate method called. Instead, it is called for the thread. This means that the rare error that calls exit directly (namely "pure virtual method called" with GCC) must be handled by the terminate method of a thread. In the case that a segfault or other signal may occur it is helpful to register for a `SIGSEGV` signal handler. A signal handler is another last-chance place to catch and log errors.
