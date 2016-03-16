---
layout: blog_post
title: 'Multithreaded C++: Part 3: RAII And Threads'
published: true
date: '2008-03-31 22:21:27'
redirect_from:
- content/multithreaded-c-part-3-raii-and-threads/
- node/4273/
- import_node/282/
- node/282/
tags:
- Boost
- Articles
- C++
- Threads
- Programming
- RAII
- Multithreaded C++ Series
---

If [boost::threads](/import_node/277) represent the C of multithreaded programming, then RAII and automatically managed threads represent the C++ of multithreaded programming. In the last article we promised that using more [RAII](/import_node/274) would allow us to get this code even smaller and better to manage. Here is the result of that:

    class threaded_class
    {
    public:
        threaded_class()
            : m_stoprequested(false),  
              m_thread(boost::bind(&threaded_class::do_work, this)) //Note 2
        {
        }

        ~threaded_class()
        {
            m_stoprequested = true;
            m_thread.join(); //Note 2
        }

        int get_fibonacci_value(int which)
        {
            boost::mutex::scoped_lock l(m_mutex);
            return m_fibonacci_values.get(which);
        }

    private:
        volatile bool m_stoprequested;
        std::vector m_fibonacci_values;
        boost::mutex m_mutex;
        boost::thread m_thread;
        
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

By using RAII techniques we were able to cut our last example of boost::threads down from 64 lines of code to 52; a 20% savings in code size. Overall we are down by 35% from the original [pthreads](/import_node/270) version. Notes regarding this version:

Note 1  
In this version we initialize the thread during the constructor of the "threaded_class" object. It is critical that the `m_thread` object is the last object created. We ensure this by declaring it last. Why is this critical? The thread needs to use other objects in the class. By creating it last we make sure that all dependent objects are already created and ready to go by the time the thread is running.

Note 2  
During the destructor we join on the thread. We know the thread is the last thing to be created so it is the first thing to be destroyed. By joining on it here we ensure that the thread is stopped running before any dependent object is destroyed. In proper RAII fashion this class creates and manages all of its own resources, including its thread.

In the next article we will look at making this method of RAII managed threads generic so that we can reuse this technique. [Other articles in this series.](/tags/multithreaded-c-series)
