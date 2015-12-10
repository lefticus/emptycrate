---
layout: blog_post
title: How Do You Know If You Have a Hash Collision?
published: true
date: '2009-03-26 05:00:00'
redirect_from:
- content/how-do-you-know-if-you-have-hash-collision
- node/4353
- import_node/380
tags:
- Programming
---

Suppose the following situation: You have two devices, one collecting data and one inserting that data into a database. The two devices are separated over a network connection with individual data messages kept short. Each unit of data that is collected must necessarily have a unique key to bind its pieces together. While it would be possible for the data collector to query the data inserter for a unique key, is it worth the additional complexity? The collector would have to request the key and wait for a time out. If the key is received it is good to go, if not then a retry must occur. The situation is also complicated from the standpoint of the database inserter because it needs to have some way to generate unique keys and deal with keys whose data is never populated. A less complex, and perhaps better, way is for the data collector to have a method of autogenerating its own unique key in a reproduceable way. A one-way hashing algorithm which is a hash of some unique piece of data would work nicely for this. We end up with a series of messages: `            `

With our method of datacollection and data passing we are able to receive messages out of order or intermixed with other messages. We may even be able to drop messages. However, we have created a new problem, "What do we do in the case of a hash collision?" The rare possibilities exist:

1.  Our hashed data is not as unique as we thought it was.
2.  A legitimate [hash collision](http://en.wikipedia.org/wiki/Hash_collision) occurs (there's no such thing as a perfect hashing algorithm).
3.  Something akin to a [hash-exploit](http://en.wikipedia.org/wiki/MD5#Security) occurs.

Is there any way to detect, correct or mitigate against any of these possibilities? I don't have an answer to this problem. Maybe it's so unlikely to occur that we don't worry about it? That's the answer I'm currently going with.
