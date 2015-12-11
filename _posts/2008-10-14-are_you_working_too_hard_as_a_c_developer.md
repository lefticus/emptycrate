---
layout: blog_post
title: Are You Working Too Hard as A C++ Developer?
published: true
date: '2008-10-14 22:30:23'
redirect_from:
- content/are-you-working-too-hard-c-developer/
- node/4319/
- import_node/318/
tags:
- Programming
- C++
- Articles
---

There is probably a multitude of ways that you can work too hard as a C++ developer, but there are two specific ones that I would like to focus on:

1.  Reinventing the Wheel
2.  Using C++ Where It Shouldn't Be Used

**Reinventing the Wheel** Most C++ developers I have encountered seem bent on reinventing the wheel instead of building off of the work of others. Building code in house can be very gratifying. You have the thrill of building from scratch and the knowledge of full control. Building from scratch also means taking on huge time and cost risk for debugging and maintaining code, a price that has often been paid already by others. For most any difficult feature or data structure that you need to implement, you should ask yourself three questions:

1.  Does this feature already exist in the standard library?
2.  Is it in [Boost](http://Boost.org)?
3.  Has Anyone Else Done It?

**Using C++ Where It Shouldn't Be Used** C++ isn't the perfect language for every situation. It is a very versatile language, but sometimes other languages are better suited to the task at hand. A method that may work well for your project:

1.  C++
2.  Lua
3.  Perl/Python/C\#/Java/Javascript

[SWIG](http://swig.org) can be [used](/content/so-you-want-embed-scripting-language-your-application) as the glue to pull the pieces together. Dynamic languages and scripting languages provide for faster prototyping and building of user interfaces than C++, on average.
