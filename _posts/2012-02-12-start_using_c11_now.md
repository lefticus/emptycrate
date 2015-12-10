---
layout: blog_post
title: Start Using C++11 Now
published: true
date: '2012-02-12 21:47:45'
redirect_from:
- content/start-using-c11-now
- node/4418
- import_node/471
tags:
- Crossplatform
- C++11
- C++
---

Every major platform and compiler now supports some aspect of the new C++ standard accepted in 2011. This means it is currently possible to write code that uses some of C++11 while maintaining cross-platform compatibility. Why should you care?

1.  By enabling C++11 compatibility with your compiler you are future proofing your code. You will be able to catch any portability errors sooner and be ready for the full move.
2.  Previously there was some risk in using C++11 (C++0x) features. The standard was not yet finalized and it was unknown how the features might change. This is no longer the case.
3.  Some features of C++11 such as `auto` and lambda expressions are too useful to ignore.

For an up to date list of C++11 features that are supported by various compilers, see this list maintained by Scott Meyers: http://www.aristeia.com/C++11/C++11FeatureAvailability.htm The open source compilers are much further ahead than Microsoft's. Microsoft is making headway but some very interesting and important features such as variadic templates will not be available until sometime after [VC++11](http://blogs.msdn.com/b/vcblog/archive/2011/09/12/10209291.aspx). The latest version of the standard is [available for free](http://open-std.org/jtc1/sc22/wg21/docs/papers/2012/n3337.pdf). It's technically a draft still but is 100% correct with what the final release will be.
