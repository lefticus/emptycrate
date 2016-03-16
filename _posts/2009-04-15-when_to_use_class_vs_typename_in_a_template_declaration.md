---
layout: blog_post
title: When to use class vs. typename in a Template Declaration
published: true
date: '2009-04-15 05:00:00'
redirect_from:
- content/when-use-class-vs-typename-template-declaration/
- node/4366/
- import_node/397/
- node/397/
tags:
- Templates
- Programming
- C++
- Best Practices
---

When declaring a template you can choose either "class" or "typename" for a template parameter. Example: 

```cpp
template<typename T> 
class vector {   
  // ... 
};
```

or 


```cpp
template<typename class>
class vector {   
  // ... 
};
```

So, which should you use, when? According to [C++ in a Nutshell](http://www.amazon.com/gp/product/059600298X?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=059600298X)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=059600298X) (pg 322) it doesn't matter. The two are interchangeable in template declarations. 

I have read that you should consider using "typename" when you want to document that your template is meant to work with any type and "class" when you want to document that it is designed to work with more complex data structures.
