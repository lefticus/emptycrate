---
layout: blog_post
title: 'Blogging the C++ Language: asm'
published: true
date: '2006-08-29 13:37:52'
redirect_from:
- content/blogging-c-language-asm
- node/4245
- import_node/243
tags:
- Programming
---

There's not a whole lot to say here. The asm() statement lets you inject assembly language code into your C++ program. This is a huge topic in itself, but outside of this conversation. The syntax and meaning of the assembly language you insert is dependent on your compiler and platform. The example provided in C++ In a Nutshell is:

    asm("mov 4, %eax"); // GNU on Intel IA32
    asm("mov eax, 4"); // Borland on Intel IA32

It is important to note that many compilers offer expanded support for asm with code block and other nice features.
