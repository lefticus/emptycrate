---
layout: blog_post
title: Simple C++ String Conversions
published: true
date: '2009-03-17 14:13:56'
redirect_from:
- content/simple-c-string-conversions/
- node/4347/
- import_node/372/
tags:
- Programming
- C++
- Templates
---

The `boost::lexical_cast<>` utility is a handy way of converting objects to and from strings, providing a mechanism that many scripting languages have built in. lexical_cast works with any C++ type that has ostream and istream operators defined for it, that is, any object that `cout << object;` or `cin >> object;` would work with. This boost facility also does intelligent things such as throwing a bad_cast exception if the operation causes an error flag on the stream to be set. I use `boost::lexical_cast<>` throughout my code at work for things like serialization of objects for human readable communications. It is also sprinkled liberally throughout my code for handling things like quick debug logging: 

```cpp
myLogger.log("Error occurred: " + boost::lexical_cast(getErrorNo()));
```

However, it doesn't really make sense to pull boost into your project if you only need a handy tool for doing conversions to strings. It is simple to create your own version with a template: 

```cpp
template<typename T> 
std::string to_string(const T &t) {   
  std::stringstream ss;   
  ss << t;   
  return ss.str(); 
}
```

Example usage: 

```cpp
myLogger.log("Error occurred: " + to_string(getErrorNo()));
```

Not very many C++ programmers work like this, but I personally prefer to only use temporary variables if I really need to, and I want to make sure they are initialized on construction if at all possible. If you were to use the above technique with some legacy C code that was expecting a c-style string, you could perfectly legally do this:

```cpp
logfunc( ("Error occurred: " + to_string(getErrorNo())).c_str() );
```

This is perfectly legal because the result of a string + operator is a new string object created on the stack and that object will persist until after the moment that the function call returns.
