---
layout: blog_post
title: Programming With Portability in Mind
published: true
date: '2009-05-04 05:00:00'
redirect_from:
- content/programming-portability-mind/
- node/4379/
- import_node/424/
- node/424/
tags:
- Visual Studio
- Programming
- Crossplatform
- C++
- Boost
---

Almost a year ago now I [promised](/content/crossplatform-c-part-1-intro) a series of articles on cross-platform C++. Since then, I have finished porting a relatively large C++ project that I wrote to Linux, Solaris, and Windows. I've learned that C++ is really quite portable and there are just a few guidelines that you should keep in mind. 

**Use the Appropriate Compiler** 

It's very tempting to use the [mingw](http://www.mingw.org/) compiler on Windows. Don't. Don't get me wrong, the project is amazing and has been a huge help for porting many applications between the Linux and Windows worlds. However, I was bitten twice, once I found the answer, once I did not. In the first case, I accidentally ended up with a distribution of mingw that did not support throwing of exceptions across compilation units. This caused me much grief and took a long time to track down that it was the compiler that was at fault. In the second case I was bitten by loadable module support as provided by GNU libtool. I'm still not certain what the root cause of the problem was, but GDB for Windows did not provide me enough information to debug the problem. By moving my code to Visual Studio I was provided with a debugger that was much more appropriate and geared to the platform that I was trying to debug. However, a move to Visual Studio all but necessitated a move away from libtool and towards my own dynamic module code. I spent far less time implementing this simple code than I did debugging the crashes caused by libtool on Windows. There is a free version of Visual C++, [Visual C++ Express Edition](http://www.microsoft.com/express/vc/), which is quite capable. I use it for most of my Windows development work. 

This brings me to a sub point: *Avoid heavy handed tools, such as GNU libtool*. If possible, try to not rely on autoconf and cousins all too much because they are all GCC centric and do not play well with Visual Studio. [CMake](http://www.cmake.org/) may be a better choice. 

**Avoid Compiler Specific Extensions** 

This one probably seems obvious, but the devil is in the details. Example: GCC provides `uint64_t`, `int64_t` and `long long` for 64 bit integer types. Visual C++ does not. Visual C++ provides `__int64` instead. The solution is to use boost's portable typemaps, such as `boost::uint64_t`. 

**Avoid OS Specific Features** 

This one may seem obvious as well but, particularly between different Unix like operating systems, it can be very difficult to tell. The key is to rely on the C Programming manpages to tell you what standards the function in question conforms to. If it is a Posix standard than you are likely good across most versions of Unix. The GNU/Linux manpages are very good about providing standards information. 

**Wrap Your OS Specific Calls** 

It's inevitable that you will need to make OS specific calls at some point in a sufficiently large application. Even in a small application you must make subtle decisions such as which slash ("/" or "\\") to use in file paths. When you do need to use OS specific features you should wrap them into your own API. This will allow you to provide a consistent set of classes to yourself and to the consumers of your application. You can then choose to provide OS specific implementations of each feature as you need them. *Better Yet...* Use a well established crossplatform API. [Boost](http://www.boost.org) provides basic file and network programming API's which work on many platforms. In fact, both of these Boost libraries are set to become part of the next C++ standard, so learning them now is probably a good idea. Also, [GTK](http://www.gtk.org), [QT](http://www.qtsoftware.com/), and [wxWidgets](http://www.wxwidgets.org/) each provides a rich set of crossplatform capabilities including libraries.. Note however, that there is the tendency in these tools to break my first rule about using the appropriate compiler; most of them prefer mingw over Visual C++ on Windows.
