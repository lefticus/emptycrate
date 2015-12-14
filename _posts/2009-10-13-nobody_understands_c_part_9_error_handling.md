---
layout: blog_post
title: 'Nobody Understands C++: Part 9: Error Handling'
published: true
date: '2009-10-13 05:00:00'
redirect_from:
- content/nobody-understands-c-part-9-error-handling/
- node/4399/
- import_node/449/
tags:
- Programming
- Nobody Understands C++
- Error Handling
- C++
---

I was recently at a talk where the speaker was discussing the history of C++. He argued that one problem with C++ was that its design requirements included backward compatibility with C code, and one fallout of this was the requirement to support all previous types of error handling as well as adding exceptions. That is, C++ supports:

1.  Returning of error codes.
2.  Error handling functions.
3.  Exception handling.

It is true that C++ supports all 3 of these mechanisms, as well as some other cruft left behind from C that unnecessarily encumbers the language. The speaker's point on this one particular case, however, is lost to the fact that every language supports the first two. There is nothing stopping you from returning an error code in Java, Python, Lua, Ruby, List, C, C++ or C\#. There is also nothing stopping you from writing a special function that abruptly ends execution and logs an error message in any of these languages. However, for those that support exceptions, exceptions are the preferred method and the others are frowned upon, just like it is in C++. The one point I will concede on this issue is that C++ is perhaps the only language that will allow you to throw any type whatsoever. ` try {   throw 1; } catch (int val) { }`

**Consistency** While the above code will compile without warning, it is probably not a good idea. It's generally a good idea to derive all of your exceptions from one of the `std::exception` subclasses. One reason to derive from the `std::exception` hierarchy is for consistency. If you guarantee that all exceptions in your system have the same base class, you can have high-level catch alls that are able to smartly clean up and restart your application or parts of your application. ` int main() {   bool cont = true;   while (cont)   {       try {       MyApplication app;       if (!app.go()) {         cont = false;       }     } catch (const std::exception &e) {       // Log the unhandled exception and restart the application for daemon       // or high-uptime applications     }   } }`

**Error Reporting** Another very strong reason to have `std::exception` as a base class for your exceptions is that the C++ runtime is able to detect an unhandled `std::exception` and dump the `.what()` description for you. This can be very helpful for debugging and particularly during the early stages of development.
