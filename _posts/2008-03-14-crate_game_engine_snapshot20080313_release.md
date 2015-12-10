---
layout: blog_post
title: Crate Game Engine snapshot-20080313 Release
published: true
date: '2008-03-14 07:09:48'
redirect_from:
- content/crate-game-engine-snapshot-20080313-release
- node/4270
- import_node/273
tags:
- Programming
- Crate Game Engine
- Changelog
---

This is the first release of the Crate Game Engine after the rewrite. The initial intention was that the engine would have a pluggable UI layer so that it would be possible for a game to be played either in text mode or graphical or 3d or any other number of possibilities. However, it was decided that the then-current architecture would not allow for that to really work. The new architecture is based on an MVC style asynchronous message passing architecture. With the Model, View and Controller components all being dynamically loadable at runtime. Also, the new version uses cmake instead of autoconf and relies heavily on boost. Currently the engine is not playable. However, the code compiles, the individual components are dynamically loaded and a set of test messages are pumped through the system to ensure that the general architecture is working as intended. Finally, source hosting has moved from source forge to google code. [Download](http://code.google.com/p/crategameengine/downloads/list)
