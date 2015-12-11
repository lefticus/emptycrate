---
layout: blog_post
title: Site Updates
published: true
date: '2008-03-06 20:26:45'
redirect_from:
- content/site-updates/
- node/4255/
- import_node/269/
---

I just updated the site with a new version of [Drupal](http://drupal.org/) and am still working out some problems. Currently the image module doesn't work correctly, so images will be missing. I'll be tracking the updates to the modules and will get things back up as I can. In the meantime all the content is available. Also, a new [Crate Game Engine](http://crategameengine.googlecode.com/) is in the works. I'm currently rewriting the [old one](http://sourceforge.net/projects/emptycrate) from scratch. The new one is based on a [Model-View-Controller](http://en.wikipedia.org/wiki/Model-view-controller) pattern, which I have implemented in C++ using a template design. Each component of the pattern is loaded dynamically at run time, so all 3 components are swappable. All state information is tightly controlled in the Model portion of the design and all changes occur via message passing between components and each component processes its in coming messages with a dedicated thread. With this design we get some of the performance advantage of a multithreaded application with none of the headache, since each object is only accessed via one thread. This is kind of a take on the [active object](http://en.wikipedia.org/wiki/Active_Object) design.
