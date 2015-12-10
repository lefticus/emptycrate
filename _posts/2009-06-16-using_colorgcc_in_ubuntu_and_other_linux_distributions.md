---
layout: blog_post
title: Using colorgcc in Ubuntu (and other Linux distributions)
published: true
date: '2009-06-16 05:00:00'
redirect_from:
- content/using-colorgcc-ubuntu-and-other-linux-distributions
- node/4391
- import_node/429
tags:
- Ubuntu
- Programming
- colorgcc
- C++
---

[colorgcc](http://schlueters.de/colorgcc.html) is an awesome little tool for colorizing the output of gcc and g++, making compiler errors and warnings much easier to spot. It hasn't been updated since 1999, but it hardly seems to matter. It's written in perl and available on most (if not all) Linux distributions. In [gentoo](http://packages.gentoo.org/package/dev-util/colorgcc) colorgcc is installed as a compiler front-end. This makes it trivially easy to use. Ubuntu has an official package for the project, but [no real official support](https://bugs.launchpad.net/ubuntu/+source/colorgcc/+bug/30734) for it (yet). It's really very easy to set it up: First of all, `/usr/local/bin` should already be in your $PATH variable, by default. Not only is it in the $PATH, it's the second item in the path, meaning it is searched very early on when looking for an executable. So, to automatically use colorgcc, all we have to do is add a symbolic link from `/usr/local/bin` to `/usr/bin/colorgcc` ` cd /usr/local/bin sudo ln -s /usr/bin/colorgcc gcc sudo ln -s /usr/bin/colorgcc g++ sudo ln -s /usr/bin/colorgcc cc sudo ln -s /usr/bin/colorgcc c++`
And there, you should be up and running with nice colorful output.
