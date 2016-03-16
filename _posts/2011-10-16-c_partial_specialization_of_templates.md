---
layout: blog_post
title: C++ Partial Specialization of Templates
published: true
date: '2011-10-16 06:26:03'
redirect_from:
- content/c-partial-specialization-templates/
- node/4415/
- import_node/468/
- node/468/
tags:
- C++
- Programming
- Templates
---

In this article we are going to introduce the concept of C++ Template Partial Specialization. This is meant to be just a primer on the topic and not exhaustive. The examples here will be used and referenced in later articles. A series of discussions about C++11, now that the language has been [finalized](http://www.iso.org/iso/pressrelease.htm?refid=Ref1472), will be coming shortly. In C++ a template class such as this: 

```cpp
template<typename LHS, typeame RHS>
struct Add_With_Magic {   
  static int go(const LHS &t_lhs, const RHS &t_rhs)   {     
    return 2*t_lhs + t_rhs;   
  } 
};
```

can be "partially specialized." That is, we can define custom behavior for one or more specific types that the template may be instantiated with. 

```cpp
template<typename LHS, typeame RHS>
struct Add_With_Magic {   
  static int go(double t_lhs, const RHS &t_rhs)   {     
    return 3*t_lhs + t_rhs;   
  } 
};
```

This example is meant to be more illustrative than practical. However, we see that: 

```cpp
Add_With_Magic<float, int>::go(3.0,4); // returns 10 
Add_With_Magic<double, int>::go(3.0,4); // returns 13
```

Functions in C++ cannot be partially specialized. However, they can be overloaded, with the compiler choosing the most specifically defined version for us. Using function overloads the same behavior can be accomplished. 

```cpp
template<typename LHS, typename RHS>
int add_with_magic(const LHS &t_lhs, const RHS &t_rhs) {   
  return 2*t_lhs + t_rhs; 
}  

template<typename LHS, typename RHS>
int add_with_magic(double t_lhs, const RHS &t_rhs) {   
  return 3*t_lhs + t_rhs; 
}
```

We do not have to specify the function types when calling template functions because C++ performs automatic type resolution for us. This makes calling the template function versions of this code much more clean. 

```cpp
add_with_magic(3.0f, 4); // returns 10 
add_with_magic(3.0, 4); // Calls the double version, returns 13
```


