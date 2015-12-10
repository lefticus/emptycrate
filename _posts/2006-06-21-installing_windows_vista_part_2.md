---
layout: blog_post
title: 'Installing Windows Vista: Part 2'
published: true
date: '2006-06-21 08:24:15'
redirect_from:
- content/installing-windows-vista-part-2
- node/4238
- import_node/228
---

Yesterday after making my last blog posting I decided these were the steps I was going to take when I got home:

-   Backup HD to external USB HD
-   Delete all partitions on internal HD
-   Install Windows
-   Restore linux backup

The "Install Windows" step is where thing fell apart... again. I created a 20G partition for Windows, told it to use it, it agreed, then aborted with an error saying "could not find enough free space to extract temporary files" or something. Remember, 20G is 2.8G MORE than windows said it needed for installation. I decided to let windows have the entire drive, thinking, "no big deal, I'll just resize the ntfs when it's done." So, I let windows do its thing, telling it to take the whole drive, it installed smoothly and came up looking very nice. Pretty, different... and hiccuping about every 5 seconds for some perceivable amount of time. Making the system just about unusable. The Task Manager showed no unusual CPU usage. I upgraded the NVIDIA drivers and turned down the display effects. Both of these things seemed to make it better. I continued to install Pirates! (75% of the reason behind this project) and the hiccups returned about 1 minute into game play. I decided I was done playing with this and it was time to restore my Linux backup. I rebooted into the Gentoo install CD and attempted resizentfs. Which said I had not done a clean shutdown of Windows. I rebooted into Windows, shutdown, rebooted back into Linux. Same error. GRRR. I then wiped the partition table... AGAIN. Recreated a partition table with partitions 2,3,4 being used by Linux and a nice, clean, happy, unused 25G block at the front of the drive. Why 25G? well, that's the size of my last attempt (20G) + the approximate size of the install DVD. I restored Linux, rebooted into the Windows Vista Beta 2 install DVD, told it to use the unpartitioned space... and... IT'S INSTALLING! When I get home from work today I should know if it actually worked. Assuming it did, and the hiccups are still there, I will delete that partition again and this time try the 32bit version (I had been using the 64bit version this whole time). Some point soon I need to reinstall my Linux bootloader (grub) because Windows keeps wiping it out.
