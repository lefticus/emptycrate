---
layout: blog_post
title: Linux Thread Memory Usage
published: true
date: '2008-03-18 15:35:42'
redirect_from:
- content/linux-thread-memory-usage/
- node/4263/
- import_node/275/
tags:
- Threads
- Programming
- Linux
---

During the course of debugging a potential memory leak at work I noticed that Linux seems to allocate at least 8M of memory for each thread created. This very simple test program illustrates the memory allocations:

    void makeManyPThreads()
    {
        std::vector threads;

        for (int i = 0; i<10; i++)
        {
            threads.push_back(pthread_t(0));
            pthread_create(&threads.back(), 0, &doNothing2, 0);
        }

        std::vector::iterator itr = threads.begin();
        while (itr != threads.end())
        {
            pthread_join(*itr,0);
            ++itr;
        }

        sleep(11);

        threads.clear();
    }

    int main()
    {
        makeManyPThreads();
        sleep(10);
    }

The example is currently creating 10 threads then joining on all of them. During the time that all 10 threads exist the command "pmap -x " shows 10 x 8192K blocks allocated. If you do 1 thread, you see 1 block. If you create 2, you see 2. Etc. If you leave out the pthread_join() call you will notice that none of the blocks get deallocated before application exit. However, if you do leave in the pthread_join() you will notice that the OS leaves up to 4 blocks allocated, perhaps to reuse later? If you create and join 1 thread, 1 block remains until exit. 2 threads, 2 remain, 4 threads? 4 blocks remain. However, if you create 5 blocks, 1 is deallocated with a join and 4 still remain. I have run many tests and shown that this hold true for 100's of threads created. If you join them all, 4 blocks still remain in the end, and the number of blocks is always equal to the number of threads created and not yet joined. I thought this information might be useful to someone debugging why their multithreaded application is using gigabytes of RAM. However, I don't know anything about it outside of my experiments. Anyone know any more about this?
