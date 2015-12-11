---
layout: blog_post
title: Swig Starter Kit 0.0.1
published: true
date: '2008-11-28 10:30:53'
redirect_from:
- content/swig-starter-kit-001/
- node/4318/
- import_node/343/
tags:
- Swig Starter Kit
- Lua
- Changelog
- C++
---

I just put up the first release of a new project, [Swig Starter Kit](http://swigstarterkit.googlecode.com), on [google code](http://code.google.com). The Swig Starter Kit starts with the sample C++ class: ` class Script_Interface {   public:     Script_Interface();     ~Script_Interface();      int get_a_value(); };`
And shows how you can go about utilizing that C++ class from Lua: ` require ('SwigStarterKit');  var = SwigStarterKit.Script_Interface(); print (var:get_a_value());`
The point of the project is to provide a simple example of how you might use [SWIG](http://www.swig.org) to integrate C++ and a scripting language. This release provides an extremely simple C++ class (just one method) and has an example of using that class with [Lua](http://www.lua.org). It has both a Lua library example and an embedded Lua example. This release uses autoconf, future support for cmake is planned, to provide more usable examples. Also, support for additional swig supported languages is planned.
