---
layout: blog_post
title: Building Boost With Visual Studio
published: true
date: '2009-04-29 05:00:00'
redirect_from:
- content/building-boost-visual-studio/
- node/4376/
- import_node/414/
- node/414/
tags:
- Visual Studio
- Boost
---

Unfortunately, if you want to [download](http://www.boostpro.com/download) a pre-compiled Boost for Visual Studio, you are required to register for an account with boostpro.com. When I was looking to download Boost for Windows recently 1.38 was not yet available precompiled and I personally did not want to register for an account to download free software, so I built it myself. Fortunately, the process is very simple:

1.  Uncompress [boost](http://sourceforge.net/project/showfiles.php?group_id=7586&package_id=8041) into a known location.
2.  Download [boost-jam ntx86](http://sourceforge.net/project/showfiles.php?group_id=7586&package_id=72941) and extract the executable into your boost folder.
3.  Open the "Visual Studio Command Prompt" from the "Visual Studio Tools" menu on the Start Menu.
4.  CD to the directory you uncompressed Boost into.
5.  type: `bjam threading=multi --prefix=C:\boost install`

This will build everything except boost::python and will not have ICU support in boost::regex. Otherwise, it will install it into c:\\boost.
