---
layout: blog_post
title: 'C++ Inheritance Access Specifiers (previously: Types of C++ Inheritance)'
published: true
date: '2006-05-13 16:36:40'
redirect_from:
- content/c-inheritance-access-specifiers-previously-types-c-inheritance
- node/4343
- import_node/226
tags:
- Programming
- C++
---

*In an effort to reduce the number of nonconstructive comments posted by visitors who do not read the entire article or previous comments, I have decided to change the title of the article and the initial summary to something more accurate.* In C++ there are three inheritance access specifiers:

-   public
-   protected
-   private

Any of these three inheritance access specifiers can be modified with the `virtual` keyword. In my experience interviewing candidates for c++ positions, I've learned that the average programmer does not know how these are used, or even what they mean. So I thought I would go over them here. The three access modifiers `public`, `protected` and `private` are analogous to the access modifiers used for class members.

public  
When a base class is specified as `public` ie: `class c : public base {};` the base class can be seen by anyone who has access to the derived class. That is, any members inherited from `base` can be seen by code accessing `c`.

protected  
When a base class is specified as `protected` ie: `class c : protected base {};` the base class can only be seen by subclasses of `C`.

private  
When a base class is specified as `private` ie: `class c : private base {};` the base class can only be seen by the class `C` itself.

Examples of how this plays out:

    struct X {
    public:
      void A() {}
    };

    struct Y {
    public:
      void B() {}
    };

    struct Z {
    public:
      void C() {}
    };

    struct Q : public X, protected Y, private Z {
    public:
      void Test()
      {
        A(); // OK
        B(); // OK
        C(); // OK
      }
    };

    struct R : public Q {
    public:
      void Test2()
      {
        A(); // OK
        B(); // OK
        C(); // NOT OK

        Q t;
        Y *y = &t // OK
        Z *z = &t // NOT OK
      }
    };

    int main(int argc, char **argv) {
      Q t1;
      t1.A(); // OK
      t1.B(); // NOT OK
      t1.C(); // NOT OK

      R t2;
      t2.A(); // OK
      t2.B(); // NOT OK
      t2.C(); // NOT OK

      X *x = &t1; // OK
      Y *y = &t1; // NOT OK
      Z *z = &t1; // NOT OK

      x = &t2; // OK
      y = &t2; // NOT OK
      z = &t2; // NOT OK

    }

*What about Virtual?* Oh right. Virtual is only useful when multiple inheritance is involved and the same class appears in the inheritance graph more than once. If the inheritance is declared as `virtual` all instances of the class are merged into one sub object and that sub object is initialized once. If the class that appears multiple times in the inheritance graph is NOT declared `virtual` one sub object is created for EACH instance of the class and the class is initialized multiple times. Be careful! If the class is inherited sometimes as virtual and sometimes not, the virtual instances are merged and the non-virtual instances are not, giving you a mix of behavior. *Update* As stated in comments, these are not types of inheritance, but inheritance access specifiers. The concepts still hold. I personally use [C++ in a Nutshell](http://www.amazon.com/gp/product/059600298X?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=9325&creativeASIN=059600298X)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=059600298X) as my daily desk reference when programming. Access specifiers are noted on pages 313 and 314.
