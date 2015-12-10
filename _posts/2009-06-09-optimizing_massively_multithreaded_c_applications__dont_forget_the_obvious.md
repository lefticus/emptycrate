---
layout: blog_post
title: Optimizing Massively Multithreaded C++ Applications - Don't Forget the Obvious
published: true
date: '2009-06-09 05:00:00'
redirect_from:
- content/optimizing-massively-multithreaded-c-applications-dont-forget-obvious
- node/4386
- import_node/434
tags:
- Threads
- Programming
- Optimization
- GCC
- C++
---

Let's not overcomplicate things here. If you have 160 threads all trying to run concurrently, even if they are doing little to no work, they are all still doing *some* work. There's no reason to make the threads work harder than they need to. Before we get too far, let's make sure that our compiler optimizations are enabled. It's possible that compiler optimizations can obscure debugging information or introduce runtime errors if you are doing things that are "tricky" in your C++ code. Be careful, at the first sign that the optimizations are causing problems, back them off. As far as I know, all optimizations are generally considered to be safe, but add to compile time and to the size of the compiled code. Hopefully, if you read this blog often, you do not try to be too clever in your code and are sticking to the spec. If you do not specify any compiler options to GCC you are telling the compiler to build for i386 architecture with no optimizations. Modern CPU's have far more capabilities than the i386 and taking advantage of them is a good idea. A good start is to enable the most common optimizations and tune the compiled code for a modern CPU architecture: ` gcc -O2 -mtune=pentium3`
More aggressively, you may enable higher optimizations and tell the compiler to *require* a particular architecture: ` gcc -O3 -march=pentium3`
The [optimization](http://gcc.gnu.org/onlinedocs/gcc-4.2.4/gcc/Optimize-Options.html#Optimize-Options) and [architecture](http://gcc.gnu.org/onlinedocs/gcc-4.2.4/gcc/Submodel-Options.html#Submodel-Options) options are available in the [documentation](http://gcc.gnu.org/onlinedocs/gcc-4.2.4/gcc/). If you have gcc 4.2 or above you can tell the compiler to fully optimize the code for the architecture it is currently building on. This doesn't result in very portable code, but for specific, high performance applications it may be worth it: ` gcc -O3 -march=native`
