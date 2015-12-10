---
layout: blog_post
title: 'Nobody Understands C++: Intro'
published: true
date: '2007-07-19 19:53:08'
redirect_from:
- content/nobody-understands-c-intro
- node/4268
- import_node/268
tags:
- Programming
- Nobody Understands
- C++
- Articles
---

This is going to be the first post of several, though I'm not sure how many just yet. The title of the post should be self explanatory, but I will elaborate. It is my strongly held belief that C++ is generally poorly understood and gets a bad rap because of this. It is also my belief that this is NOT the fault of C++, but rather the fault of old-school C++ developers who learned the language before the language was ratified in 1998. A fellow Slashdot poster has unknowingly made my point for me quite well, and it is what I will use to start this intro. The [comment in question](http://ask.slashdot.org/comments.pl?sid=250311&cid=19863937) begins "My take on C++ is that the best programs only use a fraction of the features." The commenter further states that he is weary of operator overloading and templates. In my experience, people who make comments like the above tend to be people who think they are C++ experts but who are actually only novices. I do not know the commenter personally, so I'm not trying to say anything about him specifically. Also, I'm not claiming to be a C++ expert. I only have 4 years of experience with C++, and as we know, it takes [10 years](http://norvig.com/21-days.html) to become an expert in anything. Lets take two very simple examples. One using a rudimentary understanding of c++ and one using boost, which uses templates behind the scenes for us, and pulling out the big guns. Here is the scenario: you have a callback handler you want to implement in an OOP-ish way where members of your class get called when a certain event happens. In our first example, we only know how to use C style function pointers to implement our code, so we end up with something like the following:

    class CallbackHandler
    {
    private:
      struct CallbackFunction
      {
        CallbackFunction(void (*cbf)(), void *d)
          : cb(cbf), d(data) {}

        void (*cb)();
        void *data;
      }

      vector callbacks;

    public:
      void register(void (cb*)(), void *data)
      {
         callbacks
           .push_back(CallbackFunction(cb, data));
      }

      void doCallbacks()
      {
        for (vector::const_iterator
               itr = callbacks.begin();
             itr != callbacks.end();
             itr++)
        {
          itr->cb(itr->data);
        }
      }
    };

    class ClassWithCallbacks
    {
    public:
      static void callback1(void *obj)
      {
        reinterpret_cast(obj)
          ->callback1Impl();
      }

      static void callback2(void *obj)
      {
        reinterpret_cast(obj)
          ->callback2Impl();
      }

      void registerSelf(CallbackHandler &cbh)
      {
        cbh.register(&ClassWithCallbacks::callback1,
                     this);
        cbh.register(&ClassWithCallbacks::callback2,
                     this);
      }
    private:
      void callback1Impl() { /* dosomething */ }
      void callback2Impl() { /* dosomething */ }
    };

Now, for our second example, we have become a more advanced user. We have learned boost and have put to use the features of C++ that are "too confusing" as some may say.

    class CallbackHandler
    {
      vector< boost::function0 > callbacks;

    public:
      void register(boost::function0 &f)
      {
         callbacks.push_back(f);
      }

      void doCallbacks()
      {
        BOOST_FOREACH(boost::function0 f, 
                      callbacks)
        {
          f();
        }
      }
    };

    class ClassWithCallbacks
    {
    public:
      void registerSelf(CallbackHandler &cbh)
      {
        cbh.register(
          boost::bind(&ClassWithCallbacks::callback1,
                     this));
        cbh.register(
          boost::bind(&ClassWithCallbacks::callback2,
                     this));
      }

    private:
      void callback1Impl() { /* dosomething */ }
      void callback2Impl() { /* dosomething */ }
    };

Now, I challenge anyone to argue that the first example is cleaner or easier to understand. You may not understand the details of the second example, but surely learning them must be beneficial? I have LITERALLY seen cases where a rudimentary understanding of templates, or even the boost library would cut out AT LEAST 25% of the code written. That much of a savings must equate to more maintainable easier to read code. More to come on this topic...
