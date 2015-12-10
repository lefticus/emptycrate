---
layout: blog_post
title: 'Multithreaded C++: Part 2: Boost Threads'
published: true
date: '2008-03-21 20:13:23'
redirect_from:
- content/multithreaded-c-part-2-boost-threads
- node/4267
- import_node/277
tags:
- Threads
- Programming
- C++
- Boost
- Articles
- Multithreaded C++ Series
---

If [pthreads](/import_node/270) represent the assembly language of multithreading programming, then boost::threads represent the C of multithreaded programming. Boost threads introduce some handy code saving features for the creation of threads, which is nice, but not as important as the [RAII](/import_node/274) techniques they put to use for mutex management. In this case an example is worth a thousand words. Here is the same code we wrote in for pthreads rewritten for boost::threads:

    class threaded_class
    {
    public:
        threaded_class()
            : m_stoprequested(false)
        {
        }

        ~threaded_class()
        {
        }

        // Create the thread and start work
        void go() 
        {
            assert(!m_thread);
            m_thread = boost::shared_ptr(new boost::thread(boost::bind(&threaded_class::do_work, this)));
        }

        void stop() // Note 1
        {
            assert(m_thread);
            m_stoprequested = true;
            m_thread->join();
        }

        int get_fibonacci_value(int which)
        {
            boost::mutex::scoped_lock l(m_mutex); //Note 2
            return m_fibonacci_values.get(which);
        }

    private:
        volatile bool m_stoprequested;
        boost::shared_ptr m_thread;
        boost::mutex m_mutex;
        
        std::vector m_fibonacci_values;

        int fibonacci_number(int num)
        {
            switch(num)
            {
                case 0:
                case 1:
                    return 1;
                default:
                    return fib(num-2) + fib(num-1);
            };
        }    

        // Compute and save fibonacci numbers as fast as possible
        void do_work()
        {
            int iteration = 0;
            while (!m_stoprequested)
            {
                int value = fibonacci_number(iteration);
                boost::mutex::scoped_lock l(m_mutex);
                m_fibonacci_values.push_back(value);
            }
        }                    
    };

From the [last](/import_node/270) pthreads example to this example our entire implementation, including comments and white space, decreased from 78 lines of code to 64. In this simple case, that was an 18% savings. Smaller, easier to read code is less error prone and easier to maintain (and therefore cheaper to write and maintain). We'll see in future articles that we can keep going with this, making the code even more succinct. Notes regarding this version:

Note 1  
In this version we still have the problem we had in the pthreads version. If we forget to call "stop" on this object we are going to at least leak thread resources and probably cause a crash.

Note 2  
The `boost::mutex::scoped_lock` class provides a handy [RAII](/import_node/274) way of managing mutex locks. In our [pthread only version](/import_node/270) we were very much at risk of forgetting to unlock a mutex we had locked, causing a difficult to debug deadlock. In this case, the length of the mutex is governed by the lifetime of the scoped_lock object. Because the scoped_lock will be destroyed as soon as it goes out of scope we know we are guaranteed to never forget to unlock the mutex.

[Part 1](/import_node/270)
