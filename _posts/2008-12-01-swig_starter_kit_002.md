---
layout: blog_post
title: Swig Starter Kit 0.0.2
published: true
date: '2008-12-01 20:02:15'
redirect_from:
- content/swig-starter-kit-002
- node/4334
- import_node/344
tags:
- Templates
- Swig Starter Kit
- SWIG
- C++
- Changelog
---

Release 0.0.2 of [Swig Starter Kit](http://swigstarterkit.googlecode.com) was just released. This release sees the addition of template usage examples, including custom function templates and STL usage. Using a SWIG template declaration we are able to instantiate a specific template and use it from our script code. ` //SWIG Code %include  %include  %template(String_Vector) std::vector;`
We can now use the std container classes with our Lua code: ` var = SwigStarterKit.String_Vector();  var:push_back("Hello"); var:push_back("World");`
