---
layout: blog_post
title: How To Build a wxMozilla Based App in Cygwin/MinGW
published: true
date: '2005-11-02 08:15:46'
redirect_from:
- content/how-build-wxmozilla-based-app-cygwinmingw/
- node/4203/
- import_node/57/
tags:
- wxWidgets
- C++
- wxMozilla 
---

What follows is a posting that I made to the wxMozilla-devel mailing list. I promised viewers of this site that I would post info on how to build biblestudy under Cygwin/MinGW, so here it is, please post comments if you have any questions. 

Update 11/11/2005: I have posted a precompiled binary of the wxMozilla/MinGW SDK to [sourceforge](http://sf.net/projects/wxmozilla). 

Yes, I had to compile Mozilla under Cygwin/MinGW. The specific Mozilla packages that I have uses are the 1.0.\* FireFox downloads. I actually did manage to get the Mozilla crosscompiled under Linux/MinGW, but was unable to get the build to actually work. I think that with my new knowledge I might be able to get the crosscompile working. 

For the most part, I followed this guys instructions at [gemal.dk](http://gemal.dk/mozilla/build.html). I varied from his instructions some because he suggests this hacked together Cygwin with some specific MinGW compiler, which I found completely unnecessary. I also made sure, to keep things simple, to make a pure FireFox distribution, I did not try removing/adding any options. Oh, I had absolutely no luck trying to get glib compiled with Cygwin/MinGW, and found it very necessary to use the wintools that the previous link points to. 

After building Firefox and verifying that the winEmbed.exe test program worked, I compiled wxWidgets, making sure to set CXX="g++ -mno-cygwin" and set --target=mingw. I must say at this point, wxWidgets has always been a pleasure to compile/crosscompile. Their configure script works amazingly well. 

I next compiled wxMozilla, which was an adventure. I had to hand tweak the configure script to remove the checks for wxGTK (I was most interested in getting it to work, not in getting it fixed for others, tho I may do that). I also needed to make sure that CXX was set correctly as above. Once I convinced configure that it was OK to compile the app it went fairly smoothly. However, wxMozilla.exe test application would not link. I went back to the Mozilla winEmbed.exe test to see which files needed to be linked in, which ended up being: `-L$mozilla_libs -L$mozilla_libs/components -L$mozilla_libs/../lib -lunicharutil_s -lucvutil_s -ljsj3250 -lgfxshared_s -lembed_base_s -lprofdirserviceprovider_s -lgkgfx -lxpcom -lnspr4 -lplc4 -lplds4` 

In retrospect, I could have sent those requirements on the LD_FLAGS variable, probably. 

Once I had the wxMozilla test app working, I knew that I could continue on to BibleStudy. BibleStudy now requires the [ReadingPlanner library](http://sourceforge.net/projects/readingplanner) which ended up requiring an update to autoconf & automake. I got that built and installed. 

The next issue was Sword from crosswire.org. Every version after 1.5.7a requires installmgr support, which needs networking support. This was enough of a problem to me (and I just wanted to see my applicatoin work) that I ended up just back porting biblestudy to 1.5.7a. Oh, sword is another one that it is important you set the `--target=mingw`. 

I then compiled biblestudy, which required I had the include and lib paths set to the places that each of the previous libraries were installed. I also had to modify the something about the way I chose which libwxmozilla to link in, but at this point I just didn't care. :) I got it linked and went to start the app but realized that I crash if there are 0 sword modules installed and had to install some in the local path of the application. 

Oh, it's important to note that I wanted as little pain as possible during this process, so as each test app / .dll was built I copied it into the mozilla/dist/bin folder so that it could find all of the required mozilla bits. 

The "distribution" that I posted yesterday on [freshmeat](http://freshmeat.net/projects/biblestudy/) is me taking the working mozilla/dist/bin folder, deleting everything unnecessary, striping the rest, then running UPX on it all. I'm pleased because the actually binaries for the whole thing are down to about 10M now, the rest of the .zip is sample modules.
