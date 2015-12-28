---
layout: blog_post
title: XML Parsers
published: true
date: '2005-10-20 22:30:14'
redirect_from:
- content/xml-parsers/
- node/4194/
- import_node/42/
tags:
- XML
- Game Programming
---

The plan moving forward is to allow object trees and scripting to be loaded from XML files. Right now, I'm trying to pick an XML parser. There's several choices, and they're all difficult.

1.  Xerces - DOM Compliant - Fairly Big
2.  expat - Event based parser, but not SAX compliant, simple and small
3.  Sablotron - DOM wrapper for expat, naming convention is a little annoying IMO
4.  libxml2 - DOMish, but written in C
5.  arabica - DOM wrapper for expat

Right now I'm leaning towards xerces, but I'm really not sure, anyone have any ideas? Something that is easily portable, relatively small and validating would be great, xsl would be nice too.
