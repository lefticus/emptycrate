---
layout: blog_post
title: Program Code Spell Checking
published: true
date: '2008-04-24 15:31:40'
redirect_from:
- content/program-code-spell-checking
- node/4287
- import_node/296
tags:
- Programming
---

I had noticed some references lately from Stroustrup (the inventor of c++) about not liking camel casing. He prefers underscores between words in variable names: `myFunctionName` vs `my_function_name`. The best reference I can find to this is from [Stroustrup's C++ FAQ page](http://www.stroustrup.com/bs_faq2.html#Hungarian). I initially disagreed with him, having grown up first with BASIC, moving to Java and C++ later. However, while mocking up some C++ code in a Google Docs document I discovered something quite by accident: underscores work with spell checking! I had always thought that spell checking program code was futile. However, a properly configured spell checker could be set up to ignore single character "words" and treat "_" characters as spaces. In fact, the spell checker built into [Firefox](http://www.mozilla.org/) is configured this way by default. I'm now sold on doing personal development with underscores separating words in variable/function/class names, so that it will be possible to run a spell checker against my code, and increase the professional feel of it.
