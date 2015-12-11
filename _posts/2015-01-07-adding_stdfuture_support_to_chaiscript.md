---
layout: blog_post
title: Adding std::future support to ChaiScript
published: true
date: '2015-01-07 10:47:05'
redirect_from:
- content/adding-stdfuture-support-chaiscript/
- node/4602/
tags:
- ChaiScript
- C++11
- Threads
---

Yesterday I decided to look into adding `std::future` support to [ChaiScript](http://www.chaiscript.com). To be fair [future](http://en.cppreference.com/w/cpp/thread/future) is the return value of several other higher level threading constructs, so we don't want just "`std::future`," we want enough support to make it usable.

ChaiScript works very well with functions and function objects, so ideally we want something like:


    var f = run_in_a_thread(someFunction);
    // do something
    f.get(); // access the result value of someFunction, which was run in a separate thread


The C++ std function that fits the bill is `std::async`. It takes a Function object and returns an `std::future<ReturnType>` instantiation.

For our uses, we're going to force the async to always run in a thread, just so we have predictability. To make this easier to implement, we'll use a lambda to do the actual async call. Unfortunately, we do have to help ChaiScript determine the signature of the lambda, so that muddies up the syntax a little:


    chai.add(fun<std::future<Boxed_Value> (const std::function<Boxed_Value> &)>(
      [](const std::function<Boxed_Value> &t_bv) {
        return std::async(std::launch::async, t_func);
      }
      ), "async");


That takes care of `async` but still doesn't give us any support for actually accessing the value of the `std::future`.


    chai.add(fun(&std::future<Boxed_Value>::get), "get");


Done. Now our example becomes:


    def someFunction() {
      // do something
    }

    var f = async(someFunction); // Yes! ChaiScript *can* automatically convert someFunction into an std::function<> object
    // do something
    f.get(); // access the result value of someFunction, which was run in a separate thread


Just like magic, `someFunction` is now running in a separate thread. Well, not 100% magic. If you're going to have multiple writers on shared data you still need to provide the same protections for your data that you would have to in C++ directly. And, just like any other ChaiScript code - if it's highly performance critical code - write a high level function in C++ and expose it to ChaiScript. Then you can use ChaiScript's `future` support to call the C++ function.

The complete implementation and examples can be seen on [github](https://github.com/ChaiScript/ChaiScript/commit/52d03a66b15358e8fd2caeb5b063044c8aa839d2). The complete implementation includes more in depth support for `std::future` and some tests, but still fits in 50 lines of code.
