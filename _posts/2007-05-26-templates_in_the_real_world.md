---
layout: blog_post
title: Templates in the Real World
published: true
date: '2007-05-26 09:15:54'
redirect_from:
- content/templates-real-world
- node/4260
- import_node/261
tags:
- Programming
- C++
- Templates
---

Let's say I'm doing some cryptography work. I've just received a signed message from another machine and I want to validate the signature. I have a few options:

1.  Hard code the signature validator I want to use into the message object.
2.  Use a boost function object
3.  A Function Template

