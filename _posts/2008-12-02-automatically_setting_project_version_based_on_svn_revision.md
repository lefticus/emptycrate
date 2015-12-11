---
layout: blog_post
title: Automatically Setting Project Version Based on SVN Revision
published: true
date: '2008-12-02 09:18:20'
redirect_from:
- content/automatically-setting-project-version-based-svn-revision/
- node/4320/
- import_node/345/
tags:
- autoconf
- subversion
---

While working on a project at work I decided that the most accurate way of monitoring deployed versions of my software would be to make the version number set to the SVN repository revision. After a couple of days trying to get it to work on my own, I came across the following post: http://www.mail-archive.com/autoconf@gnu.org/msg16718.html Which contains the snippet: ` AC_INIT(my-fine-package, m4_esyscmd([./version.sh | tr -d '\n']))`
This line (at the time that autoconf is run) sets the autoconf version string to the result from the command "./version.sh | tr -d '\\n'" This is more complicated than we needed, so I simplified it to: ` AC_INIT(my-fine-package, m4_esyscmd([svnversion -n]))`
The method has some caveats. First of all, it's possible to run an `svn udpate` after running autoconf, which would make the value incorrect. Secondly, svnversion calculates the currently checked out repository version. Since different files may be from different checkouts or not updated recently you may get a result like "683:691M" (an example right in front of me at the moment) which means the checkout contains files from revisions 683 to 691 and the most recent checkout is modified (M). However, this is perfect for us because it means that we are able to know if some cobbled together version was released. Our build scripts do a autoreconf each time an official version is built, so the possibly incorrect version number (mentioned as the first caveat) should not be a problem for us.
