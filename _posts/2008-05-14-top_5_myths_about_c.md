---
layout: blog_post
title: Top 5 Myths About C++
published: true
date: '2008-05-14 21:03:15'
redirect_from:
- content/top-5-myths-about-c
- node/4295
- import_node/308
tags:
- C++
- Programming
- Nobody Understands
---

We've now completed 5 articles in the "Nobody Understands C++" series so here we are going to recap the misconceptions we have covered.

1.  **You shouldn't use all the language features of C++, that just makes your code too complicated!** Wrong, [we learned](/content/nobody-understands-c-intro) that by using some of the less used features of C++ we can make our code much more succinct.
2.  **C++ is susceptible to memory leaks, buffer overruns and is an unsafe language!** Wrong, by putting to use [RAII techniques](/content/nobody-understands-c-part-2-raii) we avoid explicit memory allocation, the use of pointers and potential buffer overruns.
3.  **C++ relies on C style macros for reusable code segments.** Wrong, by using [templates](/content/nobody-understands-c-part-3-templates) you create typesafe reusable components while avoiding the text-copying problems of C macros.
4.  **C++ is an Object Oriented Programming language.** Partially wrong, C++ does support OOP techniques but it also supports procedural and functional programming paradigms. In fact, the C++ standard library is largely designed around [functional programming techniques](/content/nobody-understands-c-part-4-functional-programming).
5.  **Using C++ templates causes code bloat!** Wrong, C++ templates make possible programming techniques which would otherwise require an [insurmountable amount of code](/content/nobody-understands-c-part-5-template-code-bloat). The misuse of those techniques may cause a lot of object code to be generated.

