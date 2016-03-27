---
layout: blog_post
title: ChaiScript 6 Years Later
published: true
date: '2015-07-17 16:50:21'
redirect_from:
- content/chaiscript-6-years-later/
- node/4605/
tags:
- ChaiScript
- C++
---

It's been a little more than a year since our [last update](/content/chaiscript-almost-5-years-later).

In the past year there has been a heavy focus on ChaiScript performance and correctness, with a side of features.

ChaiScript 5.7.1 was just released and 5.3.0 was available at the time of the last update.

Performance
===========

Using our [standard battery](https://github.com/ChaiScript/ChaiScript/tree/develop/contrib/codeanalysis) of performance tests (which have been added to recently, but for the sake of comparing apples to apples we only compared tests that were possible across version comparisons).

All comparisons are made on Ubuntu 14.04 with g++ 4.8

Past Year
---------

ChaiScript 5.3.0

-   17.84s test runtime
-   2141408k during test
-   24.25s to execute Multithreaded tests

ChaiScript 5.7.1

-   2.37s test runtime (7.52x faster)
-   4948k during test (432x less)
-   0.15s to execute Multithreaded tests (161x faster)

ChaiScript 1.0
--------------

Just for the fun of it we also compared to ChaiScript 1.0. For that case, our performance comparisons were **76x** *faster*.

Things have come a long way in the last 6 years.

Correctness
===========

We spent over 30 days running [AFL](http://lcamtuf.coredump.cx/afl/) which automatically breeds new input files for your application. It generated over 2000 input files that caused ChaiScript to crash. For the most part these crashes were simply unhandled exceptions. Some were uninitialized `std::shared_ptr` objects. One or two would have been actual memory corruption. All in all, these came down to about 20 different cases that needed to be fixed.

-   Let unhandled exceptions propogate to user
-   Report eval_error when break statement is not in loop
-   Fix handling of 0 length scripts closes \#193
-   Don't crash on arity mismatch - Specifically affects the case where no overloads exist for a given function
-   Fix error printing for `bind` calls
-   Handle unexpected continue statement
-   Check arity during bind
-   Don't allow arith conversion on variadic function
-   Correct `bind` parameter match count
-   Add in expected Boxed_Value exception cases
-   Check access to AST, don't allow `;` in func def
-   Don't attempt arithmetic unary `&` call
-   Don't crash on 0 param call to `bind`
-   Catch errors during member function dispatch
-   Properly handle type of `const bool &`

Features
========

User Defined Conversions
------------------------

You can now define your own automatic type conversions. They can be specified in either ChaiScript or C++.


    // In chaiscript 
    add_type_conversion(type("string"), type("Type_Info"), fun(s) { return type(s); });

    // This looks simple, but it takes the string "string" and using the registered
    // conversion above, automatically converts that into a Type_Info object, which then
    // allows the Type_Info.name() function to be called

    assert_equal("string".name(), "string");



    // C++
    chai.add(chaiscript::type_conversion<TestBaseType, Type2>([](const TestBaseType &t_bt) { return Type2(t_bt); }));
    // Adds a conversion from TestBaseType to Type2 using the lambda provided.


New `class` syntax
------------------

Added new `class` syntax. (The old way still works).


    // old way
    def MyClass::MyClass() { /* constructor */ }
    attr MyClass::a; // add a variable

    // new way
    class MyClass {
      def MyClass() { /* constructor */ }
      var a;
    };



`method_missing` support
------------------------

You can now add your own `method_missing` functions that are called automatically in the case that a method call attempt is made, but no method by that name exists. This has been put to use to allow dynamically adding values to ChaiScript defined types:


    var o2 = Dynamic_Object();
    o2.a = 15


`future` support
----------------

You can now create `std::future` objects inside of ChaiScript.


    var f := async(someFunction);
    var f2 := async(someFunction2);

    // someFunction and someFunction2 are running in parallel now
    f.get();
    f2.get();


Full Support for Move-Only Types
--------------------------------

This means that many object copies are completely eliminated during normal use also.
