---
layout: blog_post
title: Windows XP Netbook Backup Options
published: true
date: '2009-03-31 05:00:00'
redirect_from:
- content/windows-xp-netbook-backup-options/
- node/4356/
- import_node/387/
tags:
- Recovery
- Netbook
- Acer Aspire One
---

After a recent problem with my master boot record on my [netbook](http://www.amazon.com/gp/product/B001EYV9TM?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=B001EYV9TM)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=B001EYV9TM), I decided it was time to make sure I had a backup and recovery option. Generally speaking, I'm not too worried about backups. All of the files I'm concerned about either exist on my network drive or on the internet. However, in the case of a catastrophic failure where I am not concerned about getting the data missing but and more concerned about actually getting the notebook booting again, a netbook offers few options. Netbooks do not come with CD/DVD burners. External ones may not be readily accessible. Even if you did have a CD drive available, your netbook probably did not ship with a factory restore CD. The option that I have settled on is [SelfImage](http://selfimage.excelcia.org/). SelfImage allows you to take a partition snapshot of a currently running Windows system. In my case, I used SelfImage to backup my main windows partition to the network storage I have at home. If you were playing along [yesterday](/import_node/386) you already have the tools needed to restore the image in the case of a catastrophic loss of data. The [UBCD4Windows](http://www.ubcd4win.com/) USB stick that we created contains SelfImage installed in the boot environment. Now, if something goes wrong, I should be able to boot my USB drive, connect to the house network, mount the share drive, and restore the image. Of course, this is all theory right now because I'm not willing to risk my system to restore the image I just created. I should probably try this with a smaller partition as a test. Also, it appears that the image created is a raw image and should also be testable as a loopback mount on Linux, to verify its contents. I have not tried that either, yet. Please share your successes of failures if you try this out.
