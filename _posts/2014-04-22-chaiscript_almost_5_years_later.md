---
layout: blog_post
title: ChaiScript (almost) 5 Years Later
published: true
date: '2014-04-22 14:36:32'
redirect_from:
- content/chaiscript-almost-5-years-later
- node/4599
tags:
- C++
- ChaiScript
---

July 13, 2009 Reddit covered Release 1.0 of ChaiScript. Many things changed in the last 5 years. Features added, dependencies removed, and performance increased. With all of the changes, we decided it was time to provide a 5 year retrospective and give the world a second first-look at ChaiScript.

To start with, we've celebrated 5 years with a brand new website with organized examples (in progress) and documentation links: <http://chaiscript.com>

And a continuous integration system: [![Build Status](https://travis-ci.org/ChaiScript/ChaiScript.png?branch=master)](https://travis-ci.org/ChaiScript/ChaiScript) [![Coverage Status](https://coveralls.io/repos/ChaiScript/ChaiScript/badge.png?branch=master)](https://coveralls.io/r/ChaiScript/ChaiScript?branch=master)

Features Added
--------------

### Function Objects

It is now trivially easy to create a function in ChaiScript and call that function from C++.

```
chaiscript::ChaiScript chai;

chai.eval("def func() { print(\"Hello World\"); } ");

std::function<void ()> f = chai.eval<std::function<void ()> >("func");
f(); // prints "Hello World" via the func() method defined in ChaiSript
```

See Also:

-   [docs](http://chaiscript.com/docs/5/index.html#functionobjects)
-   [functor_cast_test.cpp](https://github.com/ChaiScript/ChaiScript/blob/master/unittests/functor_cast_test.cpp)
-   [functor_creation_test.cpp](https://github.com/ChaiScript/ChaiScript/blob/master/unittests/functor_creation_test.cpp)

### Exceptions

ChaiScript can throw exceptions which can be caught in C++ and C++ can throw exceptions which can be caught in ChaiScript.


    // From C++ Example
    chaiscript::ChaiScript chai;
      
    try {
      chai.eval("throw(1.0)", chaiscript::exception_specification<int, double>());
    } catch (const double e) {
      if (e == 1.0)
      {
        // success
      }
    }
    //



    // From ChaiScript Example
    // multiple catches with guards on the values
    try {
      throw(3)
    }
    catch(e) : e < 3 
    {
      // Should never get called
    }
    catch {
      // what does get called
    }


See Also:

-   [docs](http://chaiscript.com/docs/5/index.html#exceptions)
-   [eval_catch_exception_test.cpp](https://github.com/ChaiScript/ChaiScript/blob/master/unittests/eval_catch_exception_test.cpp)
-   [exception.chai](https://github.com/ChaiScript/ChaiScript/blob/master/unittests/exception.chai)
-   [exception_guards.chai](https://github.com/ChaiScript/ChaiScript/blob/master/unittests/exception_guards.chai)

### Thread Safety

ChaiScript can be used safely from multiple threads simultaneously, by default. It is possible to disable thread safety for enhanced performance.

See Also:

-   [multithreaded_test.cpp](https://github.com/ChaiScript/ChaiScript/blob/master/unittests/multithreaded_test.cpp)

### Loadable Modules

C++ libraries can be compiled as loadable modules and loaded dynamically with ChaiScript at runtime. The default behavior is for the ChaiScript standard library to now be compiled and loaded this way, reducing on re-compile times.

Reduced Dependencies
--------------------

ChaiScript now requires only a C++11 compliant compiler, the previous boost requirement has been completely removed. It is header only (with the option of precompiling the standard library into a loadable module for reduced compile times).

Tested and supported compilers: clang 3.4+, g++4.6+, MSVC 2013+.

Enhanced Performance
--------------------

Depending on the test run, ChaiScript 5.3 is between 10 and 20 times faster than ChaiScript 1.0.

Language Enhancements
---------------------

-   `elseif` was split into `else if` like a C++ programmer would expect it to be
-   `<<` operator support added and implemented for numerics
-   `continue` statement [support](https://github.com/ChaiScript/ChaiScript/blob/master/unittests/continue_for.chai) [added](https://github.com/ChaiScript/ChaiScript/blob/master/unittests/continue_while.chai).
-   `break` statement support added
-   `switch` statement support added
-   `?:` ternary operator support added
-   function introspection upport. Functions can be queried for arity, parameter types, etc.
-   arithmetic types now perfectly match the target system. Conversions during arthmetic operations are the same, also.
-   arithmetic type suffixes `f`, `ul`, `u`, etc added
-   inheritance of methods tracked and handled
-   object lifetime and scoping rules now match C++
-   countless bug fixes and improvements

Automated Testing
-----------------

ChaiScript currently has 322 unit tests. ChaiScript 1.0 had only 72 tests. The new testing framework is integrated with the build system and run with every check-in via [Travis-CI](https://travis-ci.org/ChaiScript/ChaiScript).

Be sure to check the [unit tests](https://github.com/ChaiScript/ChaiScript/tree/master/unittests) to verify any details about how to use ChaiScript.
