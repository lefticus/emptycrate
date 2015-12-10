---
layout: blog_post
title: Milestone 3 Critiques
published: true
date: '2005-11-16 07:49:47'
redirect_from:
- content/milestone-3-critiques
- node/4205
- import_node/85
---

Milestone 3 was met with some justified criticisms yesterday that I thought I would address here. First and foremost, the text based frontend to the engine (which is what anyone hoping to play a game would be using right now) is severly limited in its capabilities. There is exactly one verb currently supported: go If you are in a room and see 2 exists, North and South and you want to go South, type: go south typing anything other than: "go " is likely to cause a crash or some other undesired behavior. Secondly, there may be a misunderstanding as to the goal of the engine. The best way I can put it is: The Crate Game Engine is designed to make multiplayer adventure game / board game hybrids trivially easy to create. That means that readability of the XML file format trumps performance. It also means that multiple players are fundamental to the nature of the engine, which is why the demo games shipped with the distribution are hardcoded to 2 players currently. Making single player games will be possible, however. Thirdly, there is an appalling lack of documentation shipped with the source distribution, which I will correct. My plan was to move straight from where we are to adding a graphical renderer to the engine. I can now see, however, that enhancing the current textual renderer and beefing up documenation is more important, so I will spend a few hours on that first. Thanks to everyone who has taken the time to try out the engine.
