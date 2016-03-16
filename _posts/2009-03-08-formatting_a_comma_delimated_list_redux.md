---
layout: blog_post
title: Formatting a Comma Delimated List Redux
published: true
date: '2009-03-08 14:14:41'
redirect_from:
- content/formatting-comma-delimated-list-redux/
- node/4345/
- import_node/370/
- node/370/
tags:
- Programming
- Puzzle
---

A few weeks back, I posited the question, "[What is the best way to format a comma delimited list?](/import_node/369)" After seeing all of the succinct ways to accomplish this in other languages, I got a little jealous and decided to write this C++ algorithm which acts about the same. I feel like there must be a c++ standard library way of doing this that I'm some how overlooking. 

```cpp
template<typename InItr>  
std::string join(InItr begin, InItr end, const std::string &joiner) {   
  std::string ret;    
  while (begin != end) {     
    std::stringstream ss;     
    ss << *begin;     
    ret += ss.str();     
    ++begin;         
    if (begin != end) { 
      ret += joiner;     
    }   
  }    
  return ret; 
  
}
```

Usage: 

```cpp
//With an array: 
int vals[] = {1,17,9}; 
std::cout << join(&vals[0], &vals[sizeof(vals)/sizeof(int)], ", ") << std::endl;  
//With a vector: 
std::vector vec; 
vec.push_back(1); 
vec.push_back(17); 
vec.push_back(9); 
std::cout << join(vec.begin(), vec.end(), ",") << std::endl;
```

