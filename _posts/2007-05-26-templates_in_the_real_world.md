---
layout: blog_post
title: Templates in the Real World
published: true
date: '2007-05-26 09:15:54'
redirect_from:
- content/templates-real-world/
- node/4260/
- import_node/261/
tags:
- Programming
- C++
- Templates
---

Let's say I'm doing some cryptography work. I've just received a signed message from another machine and I want to validate the signature. I have a few options:


1. Hard code the signature validator I want to use into the message object.

    ```cpp
    class Message
    {
      bool validate()
      {
         return validatemessage(myString,
             mySignature, myPublicKey);
      }
    }
    ```

    This forces the message class to know something about the encryption libraries being used, and provides no flexibility.

2. Use a boost function object

    A boost::function wraps up any function call into an object with a known signature. It's very flexible and allows you to do all kinds of things like reordering of function parameters.

    See boost::bind and boost::function for more info.

    ```cpp
    class Message
    {
      bool validate(boost::function<bool (string,
                signaturetype, keytype)> f)
      {
         return f(myString, mySignature, myPublicKey);
      }
    }
    ```

    boost::functions are excellent for when you need to store and pass around functions and bound member functions. However, they also add the overhead of a level of indirection and object copying.

    They do solve the problem of decoupling the encryption library being used from the message library.

3. A Function Template

    A function template provides all of the versatility of the above two methods while solving the overhead problem.

    ```cpp
    class Message
    {
      template<typename Functor>
      bool validate(Functor f)
      {
         return f(myString, mySignature, myPublicKey);
      }
    }
    ```

    This version can take any input which has a () operator, which can take the 3 types passed in. This includes a functor, boost::function (which is a functor), a static member function pointer or a regular function pointer. The object passed in is copied when it is passed in in the above version, but for a function pointer that is inconsequential.

    From an efficiency perspective, this is the ideal solution. It falls down when the Functor being called needs to be stored, which is where the boost::function method shines.

    It also fails to handle a member function pointer. However, since it can accept a boost::function with no loss of efficiency, you can always just used boost::bind to create a boost::function from a member function pointer.

    Oh, and this is the method that the standard algorithms use. 

