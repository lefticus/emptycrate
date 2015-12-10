---
layout: blog_post
title: Make Sure You Provide Virtual Destructors
published: true
date: '2014-09-06 14:38:59'
redirect_from:
- content/make-sure-you-provide-virtual-destructors
- node/4600
tags:
- C++
- Programming
---

If you make use of inheritance, it's likely that you need to provide a virtual destructor for your classes. Modern compilers will warn if you do not, but this is a pretty recent development.

The problem is best illustrated with an example:

    #include <iostream>

    struct Base1 { 
      ~Base1() { 
        std::cout << "~Base1" << std::endl; 
      } 
    };

    struct Derived1 : Base1 { 
      ~Derived1() { 
        std::cout << "~Derived1" << std::endl;
      } 
    };

    struct Base2 { 
      virtual ~Base2() { 
        std::cout << "~Base2" << std::endl;
      } 
    };

    struct Derived2 : Base2 { 
      ~Derived2() { 
        std::cout << "~Derived2" << std::endl;
      } 
    };

    struct Base3 { 
      virtual ~Base3() { 
        std::cout << "~Base3" << std::endl;
      } 
    };

    struct Derived3 : Base3 { 
      virtual ~Derived3() { 
        std::cout << "~Derived3" << std::endl; 
      } 
    };

    struct Base4 { 
      ~Base4() { 
        std::cout << "~Base4" << std::endl; 
      } 
    };

    struct Derived4 : Base4 { 
      virtual ~Derived4() { 
        std::cout << "~Derived4" << std::endl;
      } 
    };

    int main() { 
      Base1 *b1 = new Derived1(); delete b1; // '~Derived1() is never called

      Base2 *b2 = new Derived2(); delete b2;

      Base3 *b3 = new Derived3(); delete b3;

      Base4 *b4 = new Derived4(); delete b4; // '~Derived4()' is never called 
    }

Notice the example above that we consistently follow the pattern of accessing a derived class via a pointer to the base class. This is often (but not always) the use case for inheritance, to provide a common interface. If you do not provide a virtual destructor for your base classes, the derived destructors are never called.

This can lead to extremely difficult to debug memory errors down the road.

For gcc, to help catch this kind of error you can enable the compiler flag `-Wnon-virtual-dtor`
