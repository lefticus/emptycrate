---
layout: blog_post
title: 'C++ Templates: Euclid''s Algorithm'
published: true
date: '2008-03-24 21:57:20'
redirect_from:
- content/c-templates-euclids-algorithm/
- node/4271/
- import_node/279/
- node/279/
- node/279/
tags:
- Templates
- Programming
- C++
---

A while back I was going though the first chapters of Knuth's The Art of Computer Programming and came across Euclid's algorithm for finding the greatest common denominator. I decided to implement the algorithm as a C++ template. Here's the complete example.



```cpp
#include <iostream>

template <int M, int N>
struct Euclids
{
  enum { value = Euclids<N, M%N>::value };
};

template <int N>
struct Euclids<N, 0>
{
  enum { value = N };
};

int main(int, char *[])
{
  std::cout << "GCD: 5,4: " << Euclids<5,4>::value << '\n';
  std::cout << "GCD: 10, 5: " << Euclids<10, 5>::value << '\n';
  std::cout << "GCD: 18, 8: " << Euclids<18, 8>::value << '\n';
  std::cout << "GCD: 894744, 2312: " << Euclids<894744, 2312>::value << '\n';
  std::cout << "GCD: 100, 10000: " << Euclids<100, 10000>::value << '\n';
  std::cout << "GCD: 40, 50: " << Euclids<40,50>::value << '\n';
}
```


