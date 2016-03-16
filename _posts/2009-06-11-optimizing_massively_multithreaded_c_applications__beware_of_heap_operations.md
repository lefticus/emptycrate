---
layout: blog_post
title: Optimizing Massively Multithreaded C++ Applications - Beware of Heap Operations
published: true
date: '2009-06-11 05:00:00'
redirect_from:
- content/optimizing-massively-multithreaded-c-applications-beware-heap-operations/
- node/4388/
- import_node/436/
- node/436/
tags:
- Threads
- RAII
- Programming
- perftools
- Optimization
- Google
- GDB
- C++
---

While debugging my massively multithreaded C++ application I would notice times where the application would seem to pause for a few moments. During one of these pauses I halted the application and attached to it with the debugger ([GDB](http://www.gnu.org/software/gdb/)). From within GDB I listed (`info threads`), switched to (`thread `) and looked at the stack (`bt`) of each thread running. I saw something surprising and very telling. Nearly every single thread that was supposed to be performing work was actually blocked on a mutex inside of either `malloc` or `free`. 

It turns out that the standard C library, as provided by GNU, is not very good at multithreaded heap operations on multi-core systems. The system that I am developing on is a quad core hyperthreaded xeon. It also turns out that one of my most important libraries ([SNMP++](http://www.agentpp.com/snmp_pp3_x/snmp_pp3_x.html)) does *a lot* of heap operations with `new()`. 

**But I Don't Use `new()`, I Create My Objects On The Stack!** 

Is that right? Do you never use `std::string` or `std::vector`? It turns out that most of the standard containers use dynamic memory allocation internally. They must, to manage data that is dynamically sized and larger than the stack. They use [RAII](/RAII.html) techniques to hide that from the user. 

**The Solution**

It seems that people smarter than I noticed this long before I. There are several solutions out there but most of them are commercial in nature. With one exception: [google-perftools](http://code.google.com/p/google-perftools/). The perftools are totally free for non-commercial and commercial use. Also, they worked the best of the two tools that I tried. Specifically, you are looking for the [tcmalloc](http://google-perftools.googlecode.com/svn/trunk/doc/tcmalloc.html) library. Tcmalloc does a runtime replacement of your `malloc` and `free` calls with high performance versions that are tuned to multi-core systems. I cannot fully quantify the performance changes I saw, but I can say that my application went from pausing on occasion for significant periods of time to running flawlessly with no pausing.
