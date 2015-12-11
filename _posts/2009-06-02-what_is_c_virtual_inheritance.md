---
layout: blog_post
title: What is C++ Virtual Inheritance?
published: true
date: '2009-06-02 05:00:00'
redirect_from:
- content/what-c-virtual-inheritance/
- node/4381/
- import_node/425/
tags:
- Virtual
- Programming
- Inheritance
- C++
---

From [C++ in a Nutshell](http://www.amazon.com/gp/product/059600298X?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=059600298X)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=059600298X):

> A base class can be declared with the virtual specifier, which is important when a class has multiple base classes. Ordinarily, each time a class is named in an inheritance graph, the most-derived class is organized so that an object has a distinct subobject for each occurrence of each base class. Virtual base classes, however, are combined into a single subobject. That is, each nonvirtual base class results in a distinct subobject, and each virtual base class gets a single subobject, no matter how many times that base class appears in the inheritance graph.

What does this mean? Let's start with an example: ` #include <iostream>  struct Object {   Object()     : m_id(-1)   {   }    Object(int t_id)     : m_id(t_id)   {   }    int m_id; };  struct Base1 : Object {   Base1()     : Object(1)   {   } };  struct Base2 : Object  {   Base2()     : Object(2)   {   } };  struct Derived : Base1, Base2 {   Derived()   {   } };  int main() {   Derived d;   //std::cout << d.m_id << std::endl; <-- Compiler error, ambiguous call   std::cout << d.Base1::m_id << std::endl; //Outputs 1, calling Base1's copy of Object    std::cout << d.Base2::m_id << std::endl; //Outputs 2, calling Base2's copy of Object }`

In the above we have the base class "Object" in the inheritance graph twice. Because we have *not* used the `virtual` keyword, the Object exists twice in memory and is initialized twice. To access any of Object's members we must explicitly choose whether or not we want the instance related to Base1 or Base2. However, if we declare Object to have virtual inheritance in Base1 and Base2, the multiple instances of Object are merged into one: ` #include <iostream>  struct Object {   Object()     : m_id(-1)   {   }    Object(int t_id)     : m_id(t_id)   {   }    int m_id; };  struct Base1 : virtual Object {   Base1()     : Object(1)   {   } };  struct Base2 : virtual Object  {   Base2()     : Object(2)   {   } };  struct Derived : Base1, Base2 {   Derived()   {   } };  int main() {   Derived d;   std::cout << d.m_id << std::endl; // -1 is output   d.m_id = 4;   std::cout << d.Base1::m_id << std::endl; // 4 is output   std::cout << d.Base2::m_id << std::endl; // 4 is output }`

Notice, first of all, that we are no longer required to specify Base1 or Base2 when accessing m_id because there is now only one instance of m_id. Also, notice that -1 is set initially. What happened here? When using virtual inheritance, the *most derived* class must initialize all virtual base classes. If this requirement were not in place, it would be impossible for the compiler to know which of the initializations it should honor. Because we did not explicitly initialize Object in Derived the default constructor for Object is called for us. If we want to make sure that Object is initialized how we would like we must modify the definition of Derived: ` struct Derived : Base1, Base2 {   Derived()     : Object(3)   {   } };`

Now, with our explicit initialization of the virtual base Object, m_id is set to 3 on construction: ` int main() {   Derived d;   std::cout << d.m_id << std::endl; // 3 is output }`

**When Should I Use Virtual Inheritance?** This depends entirely on the design of your system. There are three things you might consider:

1.  If your design allows for diamonds in the inheritance graph (like the above) you probably do want to merge all of the instances of your base class into one.
2.  If you have both virtual and non-virtual instances of the same class in your inheritance, you probably have made a programming mistake. There may be instances where this is a legitimate design decision.
3.  If you have diamonds in your inheritance graph, you probably want to strongly reconsider your design. Often, in modern C++ programming, complex inheritance based designs are dropped in favor of generic programming designs.

