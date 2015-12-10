---
layout: blog_post
title: Thread Safety Locking Strategies
published: true
date: '2008-04-16 08:32:24'
redirect_from:
- content/thread-safety-locking-strategies
- node/4282
- import_node/289
tags:
- Threads
- Programming
- C++
---

I'm going to cover a thread safety strategy I have been thinking about lately. Let's look at an example for a typical "lock the variables as you use them" approach:

    class Stuff
    {
      public:
        void doSomething()
        {
          setString();
          checkString();
        }

      private:
        string myString;
        boost::mutex myMutex;

        void setString()
        {
          boost::mutex::scoped_lock l(myMutex); // Lock before touching local vars
          myString = "hello world";
        }

        void checkString()
        {
          boost::mutex::scoped_lock l(myMutex); // Lock before touching local vars
          assert(myString == "hello world");
        }
    };

I am proposing the following changes to the typical approach:

1.  Prefer to not use member data in private methods. This rule could be enforced by making all private methods static, if desired.
2.  Place general locks on all public facing methods. This assures that only one thread can be accessing your class at a time

Pros to this method:

-   Not using object level data in a private method enhances composability of the private methods and makes them more able to be used with the standard algorithms.
-   Coarser grained locks are easier to debug.
-   In sufficiently large classes object level data can start to look like global variables, this avoids that problem
-   Using future methods, such as transactional objects, will become a more natural change, one can just "check out" the object at the beginning of the public method

Cons:

-   Coarser grained locks are less parallelizable, we may be wasting CPU time with this method

This is the result of those changes. Compared it to the above example, it's a bit more concise. I think I would like to call this "Level 1 Thread Safety." By building your classes that need to be thread safe like this you can get thread safety quickly and cheaply, and have the capability to move into more efficient methods in the future if you need to.

    class Stuff
    {
      public:
        void doSomething()
        {
          boost::mutex::scoped_lock l(myMutex);
          setString(myString);
          checkString(myString);
        }

      private:
        string myString;
        boost::mutex myMutex;

        void setString(string &s)
        {
          s = "hello world";
        }

        void checkString(const string &s)
        {
          assert(s == "hello world");
        }
    };
