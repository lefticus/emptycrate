---
layout: blog_post
title: Prefer .at() to [ ] When Accessing C++ Vectors
published: true
date: '2009-02-12 08:40:23'
redirect_from:
- content/prefer-when-accessing-c-vectors/
- node/4340/
- import_node/366/
- node/366/
tags:
- C++
- Programming
---

I'm sure I will get some dissenting views posted in comments regarding this, but I just came to this conclusion while trying to track down a memory bug in the past few days. First of all, what's the difference? Take the follow code to set up our scenario: 

```cpp
std::vector myVec; 
myVec.push_back(1); 
myVec.push_back(2);
```

If we use the array access operator (`[]`) we might do something like this: ` myVec[5] = 10;`

We have clearly accessed an element which is past the end of the array, but what happens? Worst case, nothing. In the worst case scenario it appears to work and we never know that we have caused a problem until months down the road when we are wondering why some random memory location now contains "10." Best case, the application crashes on the spot and we know exactly what we did wrong. Alternatively, we could use the `.at()` accessor: 

```cpp
myVec.at(5) = 10;
```

In this case an `std::out_of_range` exception is thrown and we know immediately that we have a problem with our code. I've spent a fair amount of my time on this website and on other websites extolling the virtues of C++ and the fact that it is quite memory safe when used properly. However, I have been using the `[]` accessors in situations where I did not first check the array bounds and verify that I would not ever be causing memory corruption problems. Using `.at()` adds overhead, as each access must be range checked first, so it should not be used in tight loops, particularly when the range is known ahead of time. 

```cpp
for (int i = 0; i < myVec.size(); ++i) {    
  myVec[i]; // do something 
}  

//Or better yet, let's keep our algorithms generic in case 
//we decide to swap the vector out with a list later on because 
//we learn we are inserting things into the middle more then  
//is healthy for a vector 

doSomethingOverRange(myVec.begin(), myVec.end());  
```

