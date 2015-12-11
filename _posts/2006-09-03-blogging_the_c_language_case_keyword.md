---
layout: blog_post
title: 'Blogging the C++ Language: case keyword'
published: true
date: '2006-09-03 07:13:59'
redirect_from:
- content/blogging-c-language-case-keyword/
- node/4248/
- import_node/246/
tags:
- Programming
---

The case keyword is used to label a section of a switch statement. For instance:

    switch (i) {
      case 1:
        //do something
        break;
      case 2:
        //do something else
        break;
    };

if `i==1` the first case is called, if 2, the second case, otherwise no code of the switch statement is executed. This example also illustrates the second use of break. In the last blog entry I mentioned that break was used to exit from a looping construct. It is also used to exit from a switch statement.
