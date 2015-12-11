---
layout: blog_post
title: Upcoming GCC 4.5 Features
published: true
date: '2010-04-06 17:22:04'
redirect_from:
- content/upcoming-gcc-45-features/
- node/4403/
- import_node/457/
tags:
- GCC
- C++
---

GCC 4.5.0 has frozen and the [release has made it to the](http://gcc.gnu.org/gcc-4.5/)[front page](http://gcc.gnu.org/). This is significant to me for 2 main reasons.
Faster Template Compiles
A major side project of mine, [ChaiScript](http://www.chaiscript.com) suffers from extremely long compile times. Part of the reason is because of 1000's of templates being instantiated for even the simplest project. GCC 4.5 has [made improvements](http://cpptruths.blogspot.com/2010/03/faster-meta-programs-using-gcc-45-and.html) in template compilation taking what used to be Really Bad (Geometric? Exponential? Not sure, didn't run it myself) to Really Good, or something approximating linear time, to add new template instantiations. This one improvement has huge implications for ChaiScript, probably negating the main single complaint that users of ChaiScript have. I would like to also take advantage of improvements in variadic templates, but I'm not sure if it makes sense, for portability reasons, to move ChaiScript there yet.
Profile Mode
Profile mode adds a runtime analysis to your project of common STL uses. The runtime analysis then provides suggestions for simple changes that could greatly affect your code performance. For instance, it may suggest replacing `std::vector` with `std::list` if it would be more appropriate. The idea would be to compile your application with profile mode enabled, check the output, make the suggested changes, then recompile without profile mode. The [examples provided](http://gcc.gnu.org/onlinedocs/libstdc++/manual/profile_mode.html) are impressive.
