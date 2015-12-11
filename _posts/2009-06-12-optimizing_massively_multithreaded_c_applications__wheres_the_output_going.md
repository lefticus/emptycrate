---
layout: blog_post
title: Optimizing Massively Multithreaded C++ Applications - Where's the Output Going?
published: true
date: '2009-06-12 05:00:00'
redirect_from:
- content/optimizing-massively-multithreaded-c-applications-wheres-output-going/
- node/4389/
- import_node/437/
tags:
- Threads
- Programming
- Optimization
- MySQL
- C++
---

If you have dozens or hundreds of threads doing work they are probably producing some sort of output. I'm not referring to logger output, but to permanent storage, perhaps in a database. If you cannot store the data as quickly as you produce it, you will eventually run into problems. If you are just barely able to keep up with data storage then your scalability will be limited. In the system I am working on poor database performance caused a cascade of errors, making the root cause very difficult to track down. The queue used to store database inserts was growing so large that it was causing out of memory errors which resulted in `new`s returning null. The library calling `new` did not check the return value, which then caused a segmentation fault when the library attempted to use the pointer. For months I was convinced I had an intermittent memory related bug in my third party library. This was only partially true. To solve this problem I had to increase the performance of my MySQL database inserts by about 100 fold, from about 100 inserts per second to over 10,000 inserts per second possible. The exact solution I found is the topic for another article. Storage performance was a major source of problems for us and a very real bottleneck. Ultimately, as the performance issues got out of hand, the system's effectiveness dropped by about 80%. While the insert speed has been solved for now, it is something that we are actively monitoring.
