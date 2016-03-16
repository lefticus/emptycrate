---
layout: blog_post
title: Swig Wrapper Working
published: true
date: '2005-11-29 22:24:30'
redirect_from:
- content/swig-wrapper-working/
- node/4209/
- import_node/89/
- node/89/
tags:
- C++
- SWIG
---

Today I got the Python [SWIG](http://swig.org) wrapper working. 

This took several code changes to get it to work smoothly, here are some lessons: `std::map` & `std::vector` are better supported than `std::list`. 

The stl interface wrappers (ie for `std::vector`) want to return a pointer to the templated type. Basically, this means that your generated python code for `std::list` would have a function like: `Player ** PlayerList.get()` instead of `Player * PlayerList.get()`. This is greatly oversimplified, but you get the point. 

I'm sure it should be simple enough to fix if the SWIG code can detect that it is already using a pointer type. It comes down to the fact that basically every get in SWIG generated code is a get by reference, so it wants to return a reference to your pointer... The `std::string` interface wrapper cannot handle pass by reference. Apparently that is not considered a major problem because strings in some languages are immutable. 

So, getting `void getastring(string &mystring);` to work right is a bit of a pain. It creates a `String *` type that is a little difficult to work with, so I removed the one `std::string&` that was in the library. 

The stl interface wrappers ARE smart enough to handle strings well. So the `std::vector::get` method returns a `String`, not a `String *`. However, `std::map` is NOT smart enough to handle this. The `std::map::get(key)` method returns a `String *`. I worked around this by removing any publicly visible non-string vectors and all maps.
