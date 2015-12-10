---
layout: blog_post
title: 'Blogging the C++ Language: auto storage class'
published: true
date: '2006-08-30 12:36:29'
redirect_from:
- content/blogging-c-language-auto-storage-class
- node/4246
- import_node/244
tags:
- Programming
---

The auto storage class means the compiler decides when the variable is created and destroyed. This is opposed to static which is only created once. Auto is the default storage class. So:

    auto int i = 5;

is the same as:

    int i = 5;
