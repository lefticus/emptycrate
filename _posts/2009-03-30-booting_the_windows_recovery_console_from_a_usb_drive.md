---
layout: blog_post
title: Booting the Windows Recovery Console From a USB Drive
published: true
date: '2009-03-30 05:00:00'
redirect_from:
- content/booting-windows-recovery-console-usb-drive/
- node/4355/
- import_node/386/
tags:
- Windows
- Recovery
---

*This process only worked with Windows XP at the time this article was written. Use these instructions at your own risk.* 

Last night I messed up my GRUB boot loader and spent the better part of 4 hours trying to get the [Windows Recovery Console](http://support.microsoft.com/kb/314058) booting off of a USB drive on my Acer Aspire One. The goal was the use the Recovery Console to run the tools fixmbr and fixboot to get Windows booting again. I couldn't find a single simple resource on how to do it, but it is really very simple: 

First off, you need the Windows XP installation files, preferably from a Windows install CD that you own. On my Acer, I was able to use the installation files that are installed on the harddrive in the i386 folder. I suggest copying these files to a new folder, for instance: c:\\winxpcd\\i386. 

Next, download the [Ultimate Boot CD for Windows](http://www.ubcd4win.com/) and install it. Before you continue with the process, determine if the Windows version that you have installation files is at least XP SP 1a (and preferably SP2+). If it is not you need to first "slipstream" the installation directory that you have. Slipstreaming is a fancy word for installing the SP from Microsoft into the installation folder that you have. UBCD4Win has [instructions](http://www.ubcd4win.com/slipstream.htm) on how to slipstream. Some people say you should never use an automated slipstreaming tool. Presumably this is because an automated slipstreaming tool would be able to inject a virus or rootkit into your installation. 

Next, run the UBCD4Win executable. You can choose to automatically search for your installation files if you want to, but it's much faster to just choose the folder that you have already located. The whole process of using UBCD4Win is very slow, so be patient. Leave the output default as BartPE, set Media output to "None" (we will not be using or needing an ISO file). Click "Build." The default options are sufficient. If the build process completes successfully close the window and click on the "Plugins" button. Now, select "!Critical: ubcd4winToUSB V-1.00" option. Now click the button "Config," select your USB device and hit "Start." *Warning, this process WILL erase everything on your USB drive.* If you have any problems with the process of writing the software to the USB drive you can download the latest version of the USB tool from the [forums](http://ubcd4win.com/forum/index.php?showtopic=11375). The author seems to be very concerned about making sure the software stays up to date. 

After the process is complete you should be able to reboot into your USB drive and launch the Windows Recovery Console. Keep in mind that any process you launch from the Recovery Console is going to use the boot device as default, which is your USB stick. You will need to specify which partition/drive you want operations to act on. The focus of this article has been the goal of the Recovery Console. However, the device you build really has far more than that. It includes FreeDOS, which is useful for running BIOS updates, and a run-from-USB Windows environment, which can be very helpful for creating/restoring backups, connecting to network devices, etc. 

Create one of these USB boot devices *before* you need it.
