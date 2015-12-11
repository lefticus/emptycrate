---
layout: blog_post
title: 'Nobody Understands C++: Part 2: RAII'
published: true
date: '2008-03-18 20:22:18'
redirect_from:
- content/nobody-understands-c-part-2-raii/
- node/4264/
- import_node/274/
tags:
- RAII
- Programming
- C++
- Articles
- Nobody Understands
---

Understanding [RAII](http://en.wikipedia.org/wiki/Resource_Acquisition_Is_Initialization) is critical to understanding good C++ design. RAII stands for "Resource Acquisition Is Initialization." The basic idea is that an object fully manages all of its own resources. Understanding object lifetime is critical to understanding RAII. For the purposes of this article we will only be discussing objects created on the stack, not on the heap. That is, objects not created with "new." There are just a couple of simple rules to understanding lifetime:

1.  Objects are destroyed in the opposite order they are created
2.  Objects are destroyed when they go out of scope

The following code example illustrates object lifetime:

    void do_something()
    {
        std::string s("Hello World");    // s created
        std::vector some_strings(5);  // some_strings created with an initial size of 5

        if (s == "Hello World")
        {
            int i = 5;    // i created
            for (int j = i; j < 10; ++j) // j created
            {
                float f = 5.5; // f created;
                cout << f * j << endl;
                // f destroyed at end of each loop iteration scope is exited
            } // j destroyed when loop scope is exited.
        } // i destroyed on "if" scope exit

    }  // some_strings destroyed on do_something scope exit
        // s destroyed

How does RAII enforce good design and keep us out of trouble? Let's say we want to update a timestamp (with our hypothetical "time" class) every time a particular function exits. Without RAII this becomes very cumbersome.

    time t;

    void timed_function()
    {
        int i = random();

        if (i < 10)
        {
            t.update();
            return;
        }

        try {
            // do some work
        } catch (...) {
            t.update();
            throw();
        }
    }

Notice how we have to track every possible way that the function might exit and call `t.update`? What happens if `random()` can throw an exception and we did not know it? The RAII way is much cleaner. Let's create for ourselves a class, time_stamp, that does the work of updating a time for us.

    class time_stamp
    {
    public:
        time_stamp(time &t_time)
            : m_time(t_time)
        {}

        ~time_stamp()
        {
            m_time.update(); // as soon as I'm destroyed, update the time
        }
    private:
        time &m_time;
    };

We now have a reusable time_stamp class we can use wherever we need it. Our example above of needing to track when a function was last completed becomes much more simple:

    time t;

    void timed_function()
    {
        time_stamp ts(t);
        int i = random();

        if (i < 10)
        {
            return;
        }
        // do some work
    }

It is now literally impossible for us to forget to update the time of last exit, the compiler does it for us! But wait, what's the downside? First of all, there is overhead in creating and destroying our `time_stamp` object. In extreme cases this may be relevant, but it is more than likely worth the small hit to performance to gain code correctness. Secondly, it is possible if you misunderstand object scope and object lifetime, to create a situation where a crash would occur. For this example, let's say that our `time_stamp` class uses two-phase construction.


    void timed_function()
    {
        time_stamp ts;
        time t;
        ts.register(t);
        int i = random();

        if (i < 10)
        {
            return;
        }
        // do some work
    } // Oops, crash

The crash occurs because `t` is destroyed before `ts`. When `ts` is destroyed it tries to update `t`, causing a crash. We will now gloss over the other aspect of RAII, which is resource management. The idea is simple and is hopefully obvious by now. For an RAII object to be a good citizen it must destroy any resources it creates. If a class allocates memory in its constructor or any other point during its lifetime, it must deallocate that memory in its destructor. Following these simple concepts virtually eliminates the possibility of leaked resources in C++, which is a huge step forward from our C roots. More to come on RAII in the next threading article.
