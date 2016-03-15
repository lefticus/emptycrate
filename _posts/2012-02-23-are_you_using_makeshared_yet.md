---
layout: blog_post
title: Are You Using make_shared Yet?
published: true
date: '2012-02-23 09:46:55'
redirect_from:
- content/are-you-using-makeshared-yet/
- node/4421/
- import_node/474/
tags:
- C++
- Boost
- C++11
- Programming
---

Recently, while watching the [GoingNative](http://channel9.msdn.com/Events/GoingNative/GoingNative-2012) conference, I learned about the new `std::shared_ptr` helper function `std::make_shared`. 

In the [talk](http://channel9.msdn.com/Events/GoingNative/GoingNative-2012/STL11-Magic-Secrets) Stephan T. Lavavej discusses the performance improvements they've made. It seems `std::make_shared` can save a few extra allocations and a bit of memory overhead. This can be significant if you dynamically create lots of objects. Back in the real world I found myself wondering if boost supported this little gem for `boost::shared_ptr`. Seems it does. And has since 1.39.0 in 2009. How is it possible that I've overlooked this? Example usage: Instead of doing this:

    boost::shared_ptr ptr(new MyClass(param1, param2));
    std::shared_ptr ptr2(new MyClass(param1, param2));

Do this:

    boost::shared_ptr ptr = boost::make_shared(param1, param2);
    std::shared_ptr ptr2 = std::make_shared(param1, param2);

Where this really shines is if you have a function expecting a `shared_ptr`.

    void somefunc(const std::shared_ptr &ptr);

    // Instead of this:
    somefunc(std::shared_ptr(new MyClass(param1, param2)));

    // do this:
    somefunc(std::make_shared(param1, param2));

Similar functions exist for the other types of smart pointers. Related boost docs are [here](http://www.boost.org/doc/libs/1_39_0/libs/smart_ptr/smart_ptr.htm).
