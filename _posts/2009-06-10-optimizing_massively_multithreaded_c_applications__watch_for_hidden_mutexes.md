---
layout: blog_post
title: Optimizing Massively Multithreaded C++ Applications - Watch for Hidden Mutexes
published: true
date: '2009-06-10 05:00:00'
redirect_from:
- content/optimizing-massively-multithreaded-c-applications-watch-hidden-mutexes
- node/4387
- import_node/435
tags:
- Threads
- Programming
- Optimization
- C++
- Boost
---

If your application does not scale as your threads increase, you should check the code to make sure there are no hidden mutexes limiting your concurrency. **Logging System** How is your logging system implemented? Does writing a log message grab a mutex lock? Is the lock held for potentially a long time? If you provide a significant amount of logging from many different threads it is possible they are getting bound on the logger and limiting your concurrency. One possible fix is to implement a log message queue and have a separate thread that handles expensive logging operations such as transmitting the log message over the network or writing it to a file. **Global Objects** Do you have any global system objects? In the case of the application I was optimizing I needed to raise OS privilege level during certain operations. The system object that raised privileges had a mutex to prevent more than one thread from raising privileges at once. In this particular case, I spent more time in a raised level than not, and was effectively limiting my concurrency to... 1 (2 or 3 at best). The solution in this case was to just run the application as root, and bypass the issue. Alternatively, I could have used a non-exclusive lock and implemented a count of the number of threads needing privileges. Only when the count reached 0 would have I dropped back down to an unprivileged state. **Shared Data** Any data that is shared between threads must be protected with mutexes. If we don't protect it we risk serious problems with multiple threads trying to update a value at once or one thread trying to read a value while another one is updating it. Effectively managing shared data can be a real headache to get right. Worse, for the point of this discussion, shared data introduces points of contention between threads. Often, copying the data for per-thread usage may be your best bet. **Reader / Writer Mutexes** One can better manage data that must be shared by using reader / writer mutexes. While simultaneously reading and writing a variable more complex than a machine-sized integer is dangerous, almost any data type can be read from multiple readers simultaneously. The boost [shared_mutex](http://www.boost.org/doc/libs/1_39_0/doc/html/thread/synchronization.html#thread.synchronization.mutex_types.shared_mutex) is one such implementation of a reader / writer mutex. For any operation that must read the shared data, you acquire a shared_lock. For any operation that must update the data, you acquire an unique_lock. An unique_lock prevents any other lock from being acquired, but multiple threads can own shared_lock.
