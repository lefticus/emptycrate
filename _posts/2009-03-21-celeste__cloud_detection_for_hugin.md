---
layout: blog_post
title: Celeste - Cloud Detection for Hugin
published: true
date: '2009-03-21 23:18:27'
redirect_from:
- content/celeste-cloud-detection-hugin/
- node/4351/
- import_node/377/
tags:
- Hugin
---

I recently came across the new [Celeste](http://ultrawide.wordpress.com/2008/11/12/using-celeste/) code for the [Hugin](http://hugin.sourceforge.net/) panorama software. 

Hugin is an open source tool for automatically finding common points between images in a panorama and stitching the images together; it's very good at what it does. (We've covered it here [before](/tags/hugin)). 

Clouds present an interesting problem in automatic panorama stitching - they can look exactly the same between two images but actually not be correlating points for the image. That is: clouds move. From the standpoint of the software they contain shared points, but if you allow the software to join on them you introduce error in your stitching. The new Celeste code which was added during last year's [GSOC](http://code.google.com/soc/) automatically detects "cloud like" points and removes them from the list of matching points between images. 

I'm impressed. It looks like the technique has promise and it should be in the next release of Hugin.
