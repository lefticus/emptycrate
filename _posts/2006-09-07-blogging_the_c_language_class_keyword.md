---
layout: blog_post
title: 'Blogging the C++ Language: class keyword'
published: true
date: '2006-09-07 15:28:42'
redirect_from:
- content/blogging-c-language-class-keyword/
- node/4250/
- import_node/248/
tags:
- Programming
---

The class keyword is used when declaring or defining a class or a templated class. For instance:

    template
    class bob
    {
      T myvariable;
    }

The above code defines a template class which expects a class parameter. Also, the class keyword can be used to declare a class when you do not want / need the definition. For example, when declaring a function:

    class bob;

    myFunc(bob *);
