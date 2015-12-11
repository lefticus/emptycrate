---
layout: blog_post
title: 'Nobody Understands C++: Part 10: C++ Is Not an Object Oriented Programming
  Language'
published: true
date: '2010-04-16 10:57:07'
redirect_from:
- content/nobody-understands-c-part-10-c-not-object-oriented-programming-language/
- node/4406/
- import_node/458/
tags:
- Programming
- OOP
- Nobody Understands
- C++
---

In the context of the rest of the [Nobody Understands C++](/tags/nobody-understands) series, I feel like this one is redundant. But it seems like it needs to be said. C++ is not an object oriented programming language. [C++](http://en.wikipedia.org/wiki/C%2B%2B) is a [multi-paradigm](http://en.wikipedia.org/wiki/Multi-paradigm_programming_language) language that supports most of the major programming paradigms that have been widely accepted. Specifically, C++ supports:

-   [Procedural](http://en.wikipedia.org/wiki/Procedural_programming)
-   [Functional](http://en.wikipedia.org/wiki/Function-level_programming)
-   [Generic](http://en.wikipedia.org/wiki/Generic_programming) (AKA [templates](/tags/templates) in C++)
-   [Object Oriented](http://en.wikipedia.org/wiki/Object-oriented_programming)

Making the most of C++ means effectively utilizing each of these paradigms appropriately. Indeed, the [boost::function](http://www.boost.org/doc/libs/1_42_0/doc/html/function.html) library (part of the upcoming C++0x standard) **must** utilize procedural, object oriented and generic programming techniques to make the implementation possible. And it is through boost::function that the primary, easiest method of functional programming is possible in C++. Understanding the strengths and weaknesses of these individual paradigms and their use in C++ will make you a better programming in the other languages that you use.
