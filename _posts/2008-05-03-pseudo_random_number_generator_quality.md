---
layout: blog_post
title: Pseudo Random Number Generator Quality
published: true
date: '2008-05-03 10:45:06'
redirect_from:
- content/pseudo-random-number-generator-quality/
- node/4304/
- import_node/306/
- node/306/
tags:
- Programming
- Ex Astris
---

For those who do not know, most random number generation on a computer is accomplished via a [pseudo-random sequence generator](http://en.wikipedia.org/wiki/Pseudorandom_number_generator). 

A random number generator takes a seed value and generates a sequence of numbers from that value. If you provide the same seed, you get the same sequence. Often times the programmer will seed the random number generator with the current time of day, adding some variability to the output. 

For Ex Astris, however, we are taking advantage of this property of random number generators to generate a predictable sequence. That way we can generate and save the seed value and use the seed value to generate aspects of the universe on the fly, without having to generate and store 1000's (or millions, or whatever) of planets and their properties. 

I noticed that the Linux version of [rand_r](http://linux.die.net/man/3/rand_r) had some fairly noticeable and undesirable qualities where it was causing the planets to be formed in a sort a stripe pattern. But, it was not too bad and could possibly be over looked until a later time. Then my cousin compiled Ex Astris for MacOSX for me. [img_assist|nid=304|desc=Screen shot of Ex Astris for OSX|link=node|width=600|height=600] This was clearly not going to work! To be fair to OSX and Linux I'm doing some things that seems to break typical random number generators. For example, feeding a "random" output back in as a seed value. 

I was already familiar with the [Mersenne Twister](http://en.wikipedia.org/wiki/Mersenne_twister) algorithm because of the boost [random number generator](). The pseudo code for the algorithm on the Wikipedia page looked to be very straightforward so I went ahead and implemented it in a few minutes. The [result](http://code.google.com/p/exastris/source/browse/tags/snapshot-20080429/random_generator.hpp) is in the google code project. 

By implementing the Mersenne Twister we gained not only significantly better random number generation but almost more importantly we gained predictable random number generation across platforms. Below are screen shots of the updated MacOSX and Linux versions. Note that the Mac screen shot was stretched a little bit, but the relative placement and color of the planets are the same. [img_assist|nid=303|desc=Ex Astris for OSX w/Mersenne Twister|link=node|width=600|height=600] [img_assist|nid=305|desc=Ex Astris for Linux w/Mersenne Twister|link=node|width=600|height=600]
