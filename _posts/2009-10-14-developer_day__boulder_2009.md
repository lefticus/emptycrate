---
layout: blog_post
title: Developer Day - Boulder 2009
published: true
date: '2009-10-14 05:00:00'
redirect_from:
- content/developer-day-boulder-2009/
- node/4400/
- import_node/450/
- node/450/
tags:
- Programming
- Developer Day
- C++
---

This past Saturday I attended the Developer Day meeting in Boulder, CO. Overall the day was beneficial and interesting even tho it was more dynamic languages centric and very few things applied directly to my C++ development. I did present [ChaiScript](http://www.chaiscript.com) during a [lightning talk](http://en.wikipedia.org/wiki/Lightning_Talk). 

I'm not sure if I said anything coherent or not but a couple of people chatted with me about it afterward, so I guess it wasn't horrible. On the topic of ChaiScript, I did come up with many ideas for further ChaiScript development, features, etc during the meeting. The most significant, perhaps, would be to write an extension to ChaiScript that allows it to produce [cachegrind](http://valgrind.org/info/tools.html#cachegrind) compatible output for script analysis with [kcachegrind](http://kcachegrind.sourceforge.net/). 

A high point of the meeting for me was the "Playing Nicely with Others" talk by Jeremy Hinegardner. The point of his talk was to present several tools that work with 3 or more languages and provide methods for interoperation between languages. For example, [beanstalkd](http://wiki.github.com/kr/beanstalkd/faq) is a distributed asynchronous work queue with support for many different languages. Talking an idea from a talk later in the day, regarding email interfaces to applications, it would be possible to have a python process reading email from a server, pushing work units into beanstalkd and have ruby, C++ and perl applications on other hosts reading work units from the queue. Beanstalkd seems to provide everything you would need from a good work queue, such as timeouts and retries of work units. 

Sadly, the low point of the meeting was the closing keynote by [Bruce Eckel](http://www.bruceeckel.com/) on the archaeology of language features. I had read a [previous transcription](http://www.artima.com/weblogs/viewpost.jsp?thread=260578) of the talk before attending the meeting and was looking forward to it the most. Unfortunately, it seems that Mr. Eckel has either forgotten some of what he knew about C++ or perhaps his knowledge is just out of step with modern C++ development. His main points for failed language features were mostly incoherent. He argued that C++ carried with it cruft from C, for backward compatibility. While this is true, his main example (error handling) was meaningless. The "bad error handling" of C++ is available in his current favorite language, Python, and just about [every other language that exists](/content/nobody-understands-c-part-9-error-handling). 

His second point, that memory handling in C++ is nearly impossible to get right, is valid if you choose to manually manage your memory. Manual memory management in C++ is currently [strongly discouraged](/content/nobody-understands-c-part-6-are-you-still-using-pointers). The fact that direct memory access exists in the language is not a failing of the language. Direct memory access must exist in any language that needs to provide direct access to hardware resources. C++, as a systems language, has that requirement. 

The third point he made, that operator overloading is too hard, made no sense to me at all. The main argument I have always heard against operator overloading is that it's too easy for the user to abuse the overloads and make nonsensical or conflicting overloads. This would be true in any language that supported operator overloading. His argument was that operator overloading is too hard because you must provide versions for both stack and heap allocated objects. The only way this would be true is if you are intentionally trying to break pointer semantics with your operator overloads, and this is not something I have ever seen advocated. At this point during the talk I really wanted to ask him what he was talking about, but he has had far more experience with C++ than I have and is very well known in the industry so I let it go. In fact, operator overloads are actually easy to get right if you [follow the normal semantics](/content/nobody-understands-c-part-8-operator-overloading) for how they should work.
