---
layout: blog_post
title: Game Loading
published: true
date: '2005-11-09 07:54:36'
redirect_from:
- content/game-loading/
- node/4201/
- import_node/82/
tags:
- C++
- XML
- Game Programming
---

Last night I proved the expat is going to work for me by getting game object models loading. Still missing a few pieces, like loading of actions and connections from the .xml file. I expect in the next day or few to have game loading fully working and be able to release a new version. This time I will also release a windows build to go with it. 

For those of you that care... I realized last night that I have to load the entire object model into memory *before* I can add any connections. This is because connections can be forward referencing in the XML. "But why allow forward references," you might ask? Well, how often in the real world do you see two rooms where you can only move in one direction between them? More to the point, rooms are likely to have to reference each other. 

Anyone curious about the game file format can follow it on the [webcvs interface](http://cvs.sourceforge.net/viewcvs.py/emptycrate/crategameengine/examples/xml/Maze.xml?view=markup).
