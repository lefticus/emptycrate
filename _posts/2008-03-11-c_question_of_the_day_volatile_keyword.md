---
layout: blog_post
title: 'C++ Question of the Day: Volatile Keyword'
published: true
date: '2008-03-11 11:25:23'
redirect_from:
- content/c-question-day-volatile-keyword/
- node/4265/
- import_node/272/
tags:
- Programming
- C++
- Threads
- Question of the Day
---

Jon asks:

> Do you remember from somewhere(possibly a Sutter talk?) what happens in the below?
>
>     volatile int x;
>
>     Thread #1:
>        Write 1 to x
>        Read x
>
>     Thread #2:
>        Write 2 to x
>        Read x

Yes, I do remember the talk but am not sure who it was by. First, let's start with what the volatile keyword does.

`volatile`
> "The volatile qualifier tells the compiler to avoid certain optimizations because the object's value can change in unexpected ways" (C++ In A Nutshell, pg 325)

In tight loops such as the ones in the example above the compiler is likely to take an optimization and store the value for x in a CPU register. CPU registers are not shared between threads or other CPU's, meaning that Thread \#1 would probably never know about changes Thread \#2 made and vice versa. 

With the volatile qualifier in use, however, the compiler should not cache x in a CPU register and should instead fetch it from and write it to memory each time it is accessed. Now that we have covered the utility of volatile, let's remember the point of the talk in question. The speaker demonstrated that by sharing a variable so closely between two threads you destroy multithreaded performance. 

For each write to the variable x, the CPU's must pause momentarily while the CPU's caches are synchronized. Code such as the above would probably result in very little if any speed difference on a multicore versus a single core processor. So, while the code would work and probably do what you expect (a possible exception is the [Itanium](http://softwarecommunity.intel.com/articles/eng/2596.htm) processor from intel), it would probably not gain you anything with regards to performance.
