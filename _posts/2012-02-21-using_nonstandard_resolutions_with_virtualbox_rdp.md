---
layout: blog_post
title: Using Non-Standard Resolutions with VirtualBox RDP
published: true
date: '2012-02-21 12:52:51'
redirect_from:
- content/using-non-standard-resolutions-virtualbox-rdp/
- node/4420/
- import_node/473/
tags:
- VirtualBox
- Windows
- RDP
---

I like to connect to Virtual Box guest operating systems remotely over RDP connections. This generally works well except if I connect from my 1280x720 laptop to a Windows guest. In this case the Windows guest will tend to resize to a "standard" resolution that fits inside of the 1280x720, which is 800x600. This can be rather obnoxious. I tend to RDP directly into the Windows guest OS itself, but in some cases this isn't possible and I have to use the RDP mechanism built into VirtualBox. After 2 years, I finally found a way to get the Windows guest to resize to any resolution I happen to connect from. *Note:* The VirtualBox guest additions must be installed for this to work. From your host's command prompt type this: `VBoxManage setextradata global GUI/MaxGuestResolution any` This essentially tells VirtualBox to allow any guest to use any resolution it wants to. I haven't seen any downside yet to setting this mode. Presumably there must be some... The related VirtualBox documentation is [here](http://www.virtualbox.org/manual/ch09.html#idp57638704).
