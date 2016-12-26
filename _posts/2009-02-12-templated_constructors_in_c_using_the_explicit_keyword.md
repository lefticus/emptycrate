---
layout: blog_post
title: 'Templated Constructors in C++: Using the "explicit" Keyword'
published: true
date: '2009-02-12 12:01:05'
redirect_from:
- content/templated-constructors-c-using-explicit-keyword/
- node/4341/
- import_node/367/
- node/367/
tags:
- Templates
- Programming
- C++
---

Sometimes, in the course of C++ template based programming it might be desirable to have a constructor that is templated, like the following contrived exampled: 

```cpp
#include <iostream>  

struct TestClass {   
  template<typename T>
  TestClass(const T &t) {       
    std::cout << "Constructed a TestClass " << t << std::endl;     
  } 
};
```

By creating a templated constructor, however, we have created an infinite number of automatic type conversions. That is, the following code does compile: 

```
void TakeATestClass(const TestClass &t) { }  

int main() {   
  TakeATestClass("Bob"); 
}
```


Is the above something that we really expected to compile? Probably not, but even if it is, the chance that we will lose track of it down the road and it will come back to bite us is pretty high. In fact, this takes principle \#40 from [C++ Coding Standards](http://www.amazon.com/gp/product/0321113586?ie=UTF8&tag=emptycrate-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0321113586)![](http://www.assoc-amazon.com/e/ir?t=emptycrate-20&l=as2&o=1&a=0321113586), "Avoid providing implicit conversions," and raises it to the Nth degree. 

The solution is simple. We can still retain the flexibility of the templated constructor while eliminating the accidental conversions by adding the "explicit" keyword to our constructor. 

```cpp
struct TestClass {   
  template<typename T>     
  explicit TestClass(const T &t) {       
    std::cout << "Constructed a TestClass " << t << std::endl;     
  } 
};
```

Our new version should eliminate all unintended constructions of our new class.
