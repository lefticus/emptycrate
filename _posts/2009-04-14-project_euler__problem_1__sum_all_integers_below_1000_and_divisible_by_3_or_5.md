---
layout: blog_post
title: Project Euler - Problem 1 - Sum All Integers Below 1000 and Divisible By 3
  or 5
published: true
date: '2009-04-14 05:00:00'
redirect_from:
- content/project-euler-problem-1-sum-all-integers-below-1000-and-divisible-3-or-5/
- node/4365/
- import_node/396/
tags:
- Templates
- Puzzle
- Programming
- C++
---

The [first](http://projecteuler.net/index.php?section=problems&id=1) [Project Euler](http://projecteuler.net) problem is to calculate the sum of all integers below 1000 which are divisible by either 3 or 5. My solution is implemented entirely in C++ templates. The value is recursively calculated at compile time. The template specialization `struct Problem1<0>` stops the recursion and returns 0. To compile this code with gcc you must expand the maximum allowed template recursion depth to at least 1000. ` g++ EulerProblem1.cpp -ftemplate-depth-1000`

```cpp
//EulerProblem1.cpp 
#include <iostream>  

template struct Problem1 {   
  static const int value = (((count % 3) == 0 || (count % 5) == 0)?count:0) + Problem1::value; 
};   

template<> 
struct Problem1<0> {   
  static const int value = 0; 
};   

int main() {   
  std::cout << Problem1<999>::value << std::endl; 
}
```


