---
layout: blog_post
title: More Netbook Backup and Recovery Options
published: true
date: '2010-04-19 06:48:08'
redirect_from:
- content/more-netbook-backup-and-recovery-options/
- node/4408/
- import_node/460/
tags:
- Windows
- Recovery
- Linux
- Backup
- Acer Aspire One
---

We [previously](/content/booting-windows-recovery-console-usb-drive) [covered](/content/windows-xp-netbook-backup-options) options for backup and recovery on systems with no CDROM drive. I've since moved my netbook to Windows 7 and have come across a few more options. 

The first most thing brought to my attention is [this](http://arstechnica.com/open-source/guides/2010/03/a-fast-guide-to-system-rescue-using-open-tools.ars?utm_source=rss&utm_medium=rss&utm_campaign=rss) article from ars technica. The article promotes the idea of using [SystemRescueCD](http://www.sysresccd.org) to generate and restore hard disk images. The applicable bit for us is that SystemRescueCD is supported by [UNetbootin](http://unetbootin.sourceforge.net/). So, making a version that can boot/backup/restore from USB is quite easy. 

The second thing is a backup solution that a friend pointed out to me. [Areca Backup](http://www.areca-backup.org/) appears to be a relatively simple incremental backup solution. It has advanced [features](http://www.areca-backup.org/features.php) like compression and encryption, performing backup deltas and allows you to recover files based on given dates. I have not worked with it yet personally, but it seems to have some promise.

Finally, we come to the [Windows 7 Backup and Restore](http://www.microsoft.com/windows/windows-7/features/backup-and-restore.aspx) feature. I'm playing with this feature at the moment. If you have Windows 7 Professional or Ultimate, it allows you to backup to any location, network or local. If not, you are only allowed to back up to a local removable disk. The tool features explorer integration and the ability to browse/search for previous versions of a file and recover older versions. I'm currently getting an unexplained "permission denied" error while running my backup, but it still looks like a feature I will enable on all of my Windows 7 hosts.
