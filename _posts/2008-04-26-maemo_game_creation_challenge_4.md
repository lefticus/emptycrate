---
layout: blog_post
title: Maemo Game Creation Challenge 4
published: true
date: '2008-04-26 21:55:25'
redirect_from:
- content/maemo-game-creation-challenge-4
- node/4292
- import_node/300
tags:
- Programming
- Maemo
- Game
- Ex Astris
- Changelog
---

The [results](http://code.google.com/p/exastris/downloads/list) of the 7 hour challenge have been posted the [google code project page](http://exastris.googlecode.com). Currently the code should compile on any gtkmm supported platform. A set of galaxies and planets are randomly generated and a map of where you currently are along with a circle showing where you are capable of moving to is displayed. The location where you start and the set of galaxies are currently the same with each launch of the game. This is intentional as the seed value for creating the game is hard coded into the engine currently. If you launch the application from a shell window you will notice that the "button down" event is fired and logged whenever the mouse button is pressed. This will soon lead to code for warping between planets. I did not quite manage to make my goal of having something playable, but I was very close.
