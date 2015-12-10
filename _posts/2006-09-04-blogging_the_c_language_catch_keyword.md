---
layout: blog_post
title: 'Blogging the C++ Language: catch keyword'
published: true
date: '2006-09-04 08:32:07'
redirect_from:
- content/blogging-c-language-catch-keyword
- node/4249
- import_node/247
tags:
- Programming
---

The `catch` keyword is used to catch an exception after a try block. For instance:

    try {
      do_something();
    } catch (const std::string &str) {
      //string was thrown
    } catch (int i) {
      //int was thrown
    }

if an int is thrown during the execution of `do_something()` the second catch block is executed. If a string is thrown, the first catch block is executed. If some other kind of exception is thrown the exception is bubbled up to the next level. If no appopriate catch block is found, the application terminates.
