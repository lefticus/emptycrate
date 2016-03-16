---
layout: blog_post
title: Don't Join on Yourself!
published: true
date: '2008-03-20 13:27:20'
redirect_from:
- content/dont-join-yourself/
- node/4266/
- import_node/276/
- node/276/
tags:
- Threads
- Programming
---

My apparent [memory leak](/content/linux-thread-memory-usage) from the other day did in fact turn out to be leaking thread resources. 

The key: Don't Join on Yourself! If a thread attempts to call pthread_join on itself it is likely to cause a deadlock in that thread that you may never know about. Particularly if you are using some sort of worker-thread model that creates and destroys threads often. A simple way to catch this problem would be to add an assertion in your destructor.

    class threaded_class
    {
        ~threaded_class()
        {
            // if somehow this thread tries to join on itself, perhaps by causing this
            // instance of threaded_class to get destroyed, cause an assertion failure
            // so we can investigate it
            assert(!pthread_equal(m_worker_thread, pthread_self()));
            pthread_join(m_worker_pthread);
        }

        pthread_t m_worker_thread;
    };
