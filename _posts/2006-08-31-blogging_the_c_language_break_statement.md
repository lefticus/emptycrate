---
layout: blog_post
title: 'Blogging the C++ Language: break statement'
published: true
date: '2006-08-31 13:18:46'
redirect_from:
- content/blogging-c-language-break-statement/
- node/4247/
- import_node/245/
- node/245/
tags:
- Programming
---

The `break` statement exits from innermost loop (do, while, or for). For instance:

    for (int i = 0; i++; i<10) {
      if (i == 3)
        break;
    }

When `i == 3` the for loop will exit and execution will resume after the closing `}` of the for loop.
