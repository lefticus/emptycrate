---
layout: blog_post
title: 'Installing Windows Vista: Part 1'
published: true
date: '2006-06-20 07:45:58'
redirect_from:
- content/installing-windows-vista-part-1/
- node/4237/
- import_node/227/
---

I know, it's been a long time since I have posted a blog entry, and this one is going to be a bit of a rant. I hope you don't mind indulging me for a few minutes.

Last night I set out installing Windows Vista Beta 2 on an 80G harddrive with Gentoo Linux already installed. I had been planning to install Vista and had left a 16.9G partition open just for this purpose.

I inserted a freshly burned ISO of the Vista install DVD in the drive and rebooted. The installer came up pretty quickly, and it looks pretty. I then spent, oh, 5 minutes typing in the ungodly long key that Microsoft gave me when I downloaded Vista. After typing in the key I get to the partition editor that Vista has, choose my empty space and am given a warning "17.2G free is recommended for Windows Vista." followed by an error "No suitable device could be found for installation"

Crap. 300M. Crap.

The next 1.5 hours was spent trying to find a reasonable way to resize my reiserfs linux partition. Note: You cannot resize a partition while it is mounted. After messing with several things, I ended up booting the Gentoo install CD and using resize_reiserfs. It worked quite well, but required me to actually resize the partition itself by hand (delete and recreate); resize_reiserfs only resizes the filesystem.

Ok, reboot into Vista install DVD again... type in 25 character key again... choose new, larger blank space... create partition... choose partition... "No suitable device could be found for installation."

Crap.

The warning about the partition size is gone now but it still doesn't like my partition. At this point Windows is coming across like a whiney little kid that doesn't like the thing you are giving him even though it is exactly like the other choice.

Tonight my plan is to try and install Windows on an external USB drive. If that doesn't work... I'm not sure what I will do.