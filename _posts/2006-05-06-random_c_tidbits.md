---
layout: blog_post
title: Random C++ Tidbits
published: true
date: '2006-05-06 11:08:26'
redirect_from:
- content/random-c-tidbits/
- node/4235/
- import_node/224/
tags:
- Programming
---

Did you know that the following will generate a compiler error?

    class X {
    public:
      X() {}
      virtual ~X() {}

      virtual void A() {}
      void B() {}

    private:
      char data[4];
    };

    class Q {

    protected:
      char data[8];
    };

    class Y : public X, public Q {
    public:
      Y() {}
      virtual ~Y() {}

      virtual void A() { data[1] = '2'; }
      void B() {}

    };

The error generated is:

    test.cpp: In member function `virtual void Y::A()':
    test.cpp:26: error: reference to `data' is ambiguous
    test.cpp:18: error: candidates are: char Q::data[8]
    test.cpp:12: error:                 char X::data[4]
    test.cpp:26: error: `data' was not declared in this scope

At least with GCC 3.4.5. I find this annoying because `Y::A()` technically only has access to `Q::data`, not to `X::data`. Also, did you know that adding virtual methods to a class increases its size? Note:

    #include <iostream>

    struct X {
    public:
      virtual void A() {}
      void B() {}

    private:
      char data[4];
    };

    struct Y {
    public:
      void A() {}
      void B() {}

    private:
      char data[4];
    };


    int main(int argc, char **argv) {
      using namespace std;
      cout << "Sizeof X: " << sizeof(X) << " sizeof Y: " << sizeof(Y);
    }

gives the output:

    jason@localhost ~/Programming/sizeof $ ./a.out
    Sizeof X: 8 sizeof Y: 4



