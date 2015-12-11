---
layout: blog_post
title: Pythons and Monkeys and Luas, oh my!
published: true
date: '2005-09-22 08:34:42'
redirect_from:
- content/pythons-and-monkeys-and-luas-oh-my/
- node/4182/
- import_node/25/
---

I've been investigating scripting langauges to use in the game engine. I've narrowed it to three possibilities:

-   Python
-   SpiderMonkey (Mozilla's javascript engine)
-   Lua

Python seems to be too big and heavy for what I need. Writing the glue code for accessing C++ object from python looks to be very heavy handed. I know one possibility is to use swig to generate it for me, but even that seems to be more complicated then I want. I like Lua, something about it appeals to me. Its simplicity. However, I think its datastructures might be a little too convoluted for me to appreceate. That is, there is only one data structure. It's called a Table. It is impressive what you can do with it, simulating classes and inheritance and stuff. Spider Monkey is my current favorite, but javascript is such a simple language, I'm not sure if it is what I want either. This decision is still up in the air, we will see. Right now I'm thinking that writing a shared library that does what I want for the game engine, then making a swig interface to that is the right answer. Then any language can be used for game scripting. Ironically, the one language that swig does not support is Lua. Well, I think that is the direction I will go, making the engine into a dll/so. Then the game executable will be something linked with the language engine of choice which calls the game files.
