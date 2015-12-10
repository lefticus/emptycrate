---
layout: blog_post
title: OpenSolaris 2008.11 Mini Review
published: true
date: '2008-12-14 22:27:27'
redirect_from:
- content/opensolaris-200811-mini-review
- node/4324
- import_node/351
tags:
- OpenSolaris
- Review
---

I just installed OpenSolaris 2008.11 on VirtualBox 2.0.6. My initial impression is that it is a bit better than using the commercial Solaris, but it's still no Linux. For some background, I currently develop software in C++ for multiple platforms. Currently my work code base will compile on Linux, Solaris 10 and Windows. I do my primary development on Linux and periodically update for any differences on Solaris and Windows. More often than not Solaris actually poses MORE of a porting effort than Windows. This is probably due to assumptions that I make. I know that Unix system calls will not work on Windows, so I know to avoid them. However, with Solaris, I expect it to be similar to Linux and am not as prepared to make concessions. My experiences with Solaris to this point have given me a bad taste for it. My impressions are also affected by the fact that my company uses a SAN for all primary storage on our Solaris systems, which leads to pretty bad compilation time performance. Also, commercial Solaris has the Sun versions of standard Unix tools, which are severely limited in features compared to their GNU equivalents. Fortunately, OpenSolaris does correct this problem and uses the GNU versions of Unix tools. I was hoping that OpenSolaris would be a better user experience than Solaris 10, and so far it is somewhat better. Here are my nitpicky complains:

The default fonts are not very impressive. For instance, on this page that I am currently editing, the major title fonts are not anti-aliased, and some of the smaller fonts are anti-aliased too much, blurring the details.

Packages for GNU projects all start with SUNW. I know this is something that commercial Solaris does too, and it seems a bit... vain on the part of Sun. It also makes it hard to find the package you want. For instance, SUNWgcc installs gcc and g++.

G++ is only version 3.4.3, which is now more than 3 years old

Application switching and loading is painfully slow. This is probably a result of running it in VirtualBox. However, Ubuntu on the same system, also in VirtualBox, is much more usable.

I just found another problem while writing this article: the Middle Click emulation is not set up by default on this install of X. That's pretty useful for pasting selected text.

Plusses:

1.  Standard set of applications looks good, including Firefox, which I am using to write this article.
2.  VirtualBox additions for Solaris was easy to install, but that is more a feature of VirtualBox than of OpenSolaris. (Hint: pkgadd -d /media/VBOXADDITIONS_2.0.6_39755/VBoxAdditionsSolaris.pkg in my case)
3.  I haven't used it yet, but the Time Slider application looks like it will be handy.
4.  GNU versions of Unix tools.

