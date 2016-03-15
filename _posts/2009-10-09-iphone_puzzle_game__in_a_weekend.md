---
layout: blog_post
title: iPhone Puzzle Game - In a Weekend
published: true
date: '2009-10-09 11:18:53'
redirect_from:
- content/iphone-puzzle-game-weekend/
- node/4398/
- import_node/447/
tags:
- Objective-C
- iPhone
- Development
---

A couple of weekends ago I decided to borrow a friend's Mac and learn how to do some iPhone development. The result of that weekend's work was a small puzzle game. 

The game is loosely based on a Palm puzzle game I made several years ago. One way you can support this website and my open source development work is to buy the application. 

[img_assist|nid=446|title=|desc=|link=url|url=http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=333262360&mt=8|align=right|width=57|height=57] It's $.99 and available on the [iPhone app store](http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=333262360&mt=8). 

The experience was my first exposure to Objective-C, which was interesting. In many ways the language feels kind of ugly compared to C++. It's certainly less rigid, and not really what I am use to. Also, it uses a message passing paradigm. In C++ you would call a method with the "dot" notation: `object.method(param)`. In Object-C this becomes: `[object method:param]`. The downside to this message passing is that method calls are weakly typed. The compiler can provide a warning at compile time, but in some cases you will have to rely on runtime errors. 

The upside is that mechanisms exist for asynchronous and delayed message calls. The messages are queued into the application's main run loop and occur at a later time. Because they occur in-band with the application you do not have to worry about threading concerns, but can easily queue up timers and such. The experience was fun, if I sell enough copies of this app I'll probably buy myself a Mac and give it another go.
