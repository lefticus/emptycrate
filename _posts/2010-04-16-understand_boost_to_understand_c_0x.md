---
layout: blog_post
title: Understand Boost to Understand C++ 0x
published: false
date: '2010-04-16 21:23:07'
redirect_from:
- import_node/464/
- node/464/
- node/4407/
---

I've met some people who think that [boost](http://www.boost.org) should not be used, at all. They have lots of reasons: size, complexity, compile time. But there's one positive reason to use boost that trumps all of the negatives: C++ 0x. Some 14 boost libraries have been approved for C++0x and will be in the next official version of C++. By getting familiar with them now, you can get a leg up as the new compilers are released. We'll reference the [final committee draft](http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2010/n3092.pdf) sections that are implemented in boost.

1.  [system](http://www.boost.org/doc/libs/release/libs/system/index.html) - system error support (19.5)
2.  [tuple](http://www.boost.org/doc/libs/release/libs/tuple/doc/tuple_users_guide.html) - like std::pair, but N, instead of 2 elements (20.4)
3.  [type_traits](http://www.boost.org/doc/libs/release/libs/type_traits/doc/html/index.html) - inspect types at compile time (20.7.2)
4.  [ref](http://www.boost.org/doc/libs/1_42_0/doc/html/ref.html) - holder of references to objects (20.8.4)
5.  [bind](http://www.boost.org/doc/libs/release/libs/bind/bind.html) - used to find functor arguments (20.8.10)
6.  [function](http://www.boost.org/doc/libs/release/doc/html/function.html) - function object holder (20.8.14)
7.  [hash](http://www.boost.org/doc/libs/1_42_0/doc/html/hash.html) - hashing functions for unordered containers (20.8.15)
8.  [smart_ptr](http://www.boost.org/doc/libs/release/libs/smart_ptr/smart_ptr.htm) - reference counted pointers (20.9.11)
9.  [date_time](http://www.boost.org/doc/libs/1_42_0/doc/html/date_time.html) (20.10) (looser relationship)
10. [array](http://www.boost.org/doc/libs/1_42_0/doc/html/array.html) (23.3.1)
11. [unordered](http://www.boost.org/doc/libs/1_42_0/doc/html/unordered.html) - higher efficiency unsorted containers, using hashing functions (23.5)
12. [random](http://www.boost.org/doc/libs/1_42_0/libs/random/index.html) - portable random number generator (26.5)
13. [regex](http://www.boost.org/doc/libs/1_42_0/libs/regex/doc/html/index.html) - regular expression processor (28)
14. [thread](http://www.boost.org/doc/libs/1_42_0/doc/html/thread.html) - threads and futures for C++ (30)

