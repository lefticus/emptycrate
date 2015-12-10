---
layout: blog_post
title: ChaiScript Performance Updates
published: true
date: '2009-08-09 16:18:49'
redirect_from:
- content/chaiscript-performance-updates
- node/4394
- import_node/439
tags:
- Optimization
- ChaiScript
---

[ChaiScript](http://www.chaiscript.com) is a trivially easy to use scripting language designed for integration with C++. I have been working on it with [Jon](http://jonathanturner.org/) for the past several months now, and we have reached the point of doing performance optimizations and minor bug fixes. Over the past week I have been profiling the [ChaiScript](http://www.chaiscript.com) runtime dispatch engine and found a few places to perform optimizations. Using [Valgrind](http://valgrind.org/), an application that monitors function calls and relative runtime's of functions, I generated a "callgrind" call graph log, opened the log with [kcachegrind](http://kcachegrind.sourceforge.net) and analyzed the list of most called and most expensive functions. The result of the analysis was that the `Boxed_Value::Object_Cache::cull` and `dispatch` functions were the most costly. I was able to drastically reduce the cost of dispatch by reducing the amount of exceptions thrown to determine the appropriate function to dispatch to. Also, I modified the cull process to run 1/5 as often as it was. Now, ChaiScript scripts execute in 1/3 the time (10 seconds vs 30 seconds for a particularly long script). I was able to confirm that cull and dispatch are no longer the most costly functions during execution by re-running the analysis. The performance enhancements are available in the [source-only 1.2 release](http://chaiscript.googlecode.com) posted yesterday.
