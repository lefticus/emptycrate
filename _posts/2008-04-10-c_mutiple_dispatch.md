---
layout: blog_post
title: C++ Mutiple Dispatch!
published: true
date: '2008-04-10 11:21:20'
redirect_from:
- content/c-mutiple-dispatch
- node/4279
- import_node/288
tags:
- Templates
- Programming
- C++
- Boost
---

In my [last posting](/import_node/287) about C++ Multiple Dispatch I wondered if it was really any different than function overloading. I now appreciate that it is something that needs to occur at runtime, not compile time. With a little help from the Boost libraries, I threw together this example of how one could do Multiple Dispatch in C++. Note that in this version the first matching function is called, which means the generic "Thing, Thing" version must be registered last to get the appropriate behavior. Also, note that this template version is reusable and could actually be put to use for something. It is, however, limited to only 2 parameters, but it would be fairly trivial to increase/decrease the number. Most of this code is reusable, I put a comment where the user bits begin.

    #include <iostream>
    #include <stdexcept>
    #include <vector>

    #include <boost/function.hpp>
    #include <boost/shared_ptr.hpp>


    template
    class Dispatcher
    {
      public:
        struct UnhandledDispatch : std::runtime_error
        {
          UnhandledDispatch()
            : std::runtime_error("Uknown dispatch for given arguments")
          {
          }
        };

        template
        void addHandler(const boost::function &h)
        {
          myHandlers.push_back(boost::shared_ptr(new HandlerImpl(h)));
        }

        template
        void addHandler(ReturnType (*fp)(const I1&, const I2&))
        {
          myHandlers.push_back(
              boost::shared_ptr(
                new HandlerImpl(boost::function(fp))));
        }



        ReturnType operator()(const T1 &t1, const T2 &t2)
        {
          for (typename std::vector >::iterator itr = myHandlers.begin();
              itr != myHandlers.end();
              ++itr)
          {
            try {
              return (*itr)->go(t1, t2);
            } catch (std::bad_cast &) {
              //The current function did not match!
              //keep truckin and try the next one
            }
          }

          throw UnhandledDispatch();
        }

      private:
        struct Handler
        {
          virtual ReturnType go(const T1 &, const T2 &) = 0;
        };

        template
          struct HandlerImpl : Handler
        {
          HandlerImpl(const boost::function &f)
            : myFunction(f)
          {
          }

          virtual ReturnType go(const T1 &t1, const T2 &t2)
          {
            // this only succeeds if the dynamic_cast succeeds. Otherwise bad_cast is thrown
            // and caught by Dispatcher::operator()
            return myFunction(dynamic_cast(t1), dynamic_cast(t2));
          }

          private:
            boost::function myFunction;
        };

        std::vector > myHandlers;
    };

    // Everything above this line is implementation details, everything below is what the user
    // of the dispatcher needs to know.

    struct Thing {
      virtual ~Thing()
      {
      }
    };

    struct Rock : Thing {};
    struct Paper : Thing {};
    struct Scissors : Thing {};


    bool defeats(const Thing &, const Thing &) { return false; }
    bool defeats(const Paper &, const Rock &) { return true; }
    bool defeats(const Rock &, const Scissors &) { return true; }
    bool defeats(const Scissors &, const Paper &) { return true; }

    int main(int, char **)
    {
      Dispatcher myDispatcher; // the dispatcher returns a bool and takes two "Thing" classes
      myDispatcher.addHandler(&defeats); //Add paper, rock version
      myDispatcher.addHandler(&defeats); // add rock, scissors version
      myDispatcher.addHandler(&defeats); // add scissors, paper version
      myDispatcher.addHandler(&defeats); // add generic version

      Paper paper;
      Rock rock;

      Thing &thing1(paper);
      Thing &thing2(rock);

      std::cout << std::boolalpha;
      std::cout << myDispatcher(thing1, thing2) << std::endl; // decide (at runtime) which version to call
      std::cout << myDispatcher(rock, paper) << std::endl;
    }
