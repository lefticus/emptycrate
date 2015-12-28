---
layout: blog_post
title: When to use reinterpret_cast<> vs. static_cast<>
published: true
date: '2009-04-01 05:00:00'
redirect_from:
- content/when-use-reinterpretcast-vs-staticcast/
- node/4410/
- import_node/388/
tags:
- Programming
- C++
- Best Practices
---

The boost developers mailing list [recently discussed](http://lists.boost.org/Archives/boost/2009/03/149507.php) the differences between `reinterpret_cast<>` and `static_cast<>` C++ casting operators. 

The [general consensus](http://lists.boost.org/Archives/boost/2009/03/149671.php) is that `reinterpret_cast<>` provides virtually no guarantees, does not have portable behavior and should only be used when you are trying to perform a cast that you should basically not be performing in the first place. The only legitimate use for `reinterpret_cast<>` seems to be converting between integral types and back, for instance, from a `char *` to an `int` and back to a `char *`. `static_cast<>` should be used for virtually anything that `dynamic_cast<>` and `const_cast<>` cannot do.
