---
layout: blog_post
title: Optimizing Massively Multithreaded C++ Applications - Intro
published: true
date: '2009-06-08 05:00:00'
redirect_from:
- content/optimizing-massively-multithreaded-c-applications-intro/
- node/4385/
- import_node/433/
tags:
- Threads
- Programming
- Optimization
- C++
---

This is the beginning of short series of articles related to optimizing massively multithreadded C++ applications. I'm not entirely sure what the exact definition of "massively multithreaded" is, but for our purposes, let's assume at least twice as many threads as CPU cores. Having so many OS level threads may not be the most efficient way of handling concurrency, but it is legitimate if most of your threads spend most of their time waiting. They may be waiting on a timeout, as in a timer thread that fires on regular intervals, or a message processing thread that is waiting on IO. The application that I am currently optimizing and debugging has anywhere from 25 to 165 threads running depending on the current parameters of the system. All of them are waiting on something: timers, network IO or message queue condition variables that signal the arrival of new messages. There were several hurdles to getting this configuration to execute efficiently. For this intro article, I'm going to start with two links that I actually found after I had done most of the optimization, and were not directly useful to me. 

**Eliminate False Sharing** 

[This](http://www.ddj.com/go-parallel/article/showArticle.jhtmlarticleID=217500206&pgno=4&queryText=) article from Dr Dobb's Journal by Herb Sutter gets into pretty good detail about CPU cache line sharing and its effects on concurrency. 

**Intel Parallel Studio** 

I've never used [this](http://software.intel.com/en-us/intel-parallel-studio-home/) application, but it looks like it is directly related to the topic at hand.
