---
layout: blog_post
title: Covariant Return Types
published: true
date: '2006-07-14 22:24:25'
redirect_from:
- content/covariant-return-types/
- node/4240/
- import_node/230/
- node/230/
tags:
- Programming
---

I came across this concept recently and wanted to share it here. In C++, you can change the return type of a virtual function if and only if that return type is derived class of the parent return type. Note: you can always change the return type of a overloaded method in a derived class. The following example compiles with no errors. Notice that the virtual `getThis()` is overridded with a new return type that is derived from the return type of the parent's `getThis()` function. Also notice how the non-virtual `getInt()` has its return type changed.

    class Base {
      public:
        virtual Base * getThis() { return this; }
        Base & getThisRef() { return *this; }

        int getInt() { return 1; }
    };

    class Derived : public Base {
      public:
        virtual Derived * getThis() { return this; }
        Derived & getThisRef() { return *this; }

        long getInt() { return 1; }
    };

Now notice the next example. This example will not compile because you can only change the return type of a virtual function with a derived type.

    class Base {
      public:
        virtual int getInt() { return 1; }
    };

    class Derived : public Base {
      public:
        virtual long getInt() { return 1; }
    };
