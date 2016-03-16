---
layout: blog_post
title: Reflections on Trusting Trust - by Ken Thompson
published: true
date: '2009-03-09 19:44:29'
redirect_from:
- content/reflections-trusting-trust-ken-thompson/
- node/4346/
- import_node/371/
- node/371/
tags:
- Security
- Programming
---

In 1984 the Communications of the ACM published an article, [Reflections on Trusting Trust](http://orkinos.cmpe.boun.edu.tr/~kosar/ken/index.html). Which is an amazing, and disturbing read about software trust. The article begins with the exercise, "create a program which can replicate itself." This leads deftly to the idea of modifying a compiler such that every time code is compiled it adds a security vulnerability. The author points out that this kind of problem in a compiler could and would be found rather quickly. However, it takes a compiler to compile a new compiler. 

With this in mind, and the techniques in place for writing self replicating code, one could write a compiler that detected when it was compiling a new compiler and inject its self replicating code into the new compiler. Thompson certainly makes you question just how much you can trust your code - unless you fully control every aspect of your system.
