---
layout: blog_post
title: 'ChaiScript: Easy C++ Scripting'
published: true
date: '2009-07-13 19:33:15'
redirect_from:
- content/chaiscript-easy-c-scripting/
- node/4393/
- import_node/438/
- node/438/
tags:
- Programming
- ChaiScript
- C++
---

[Jon](http://www.jonathanturner.org/) and I released the first release of [ChaiScript](http://chaiscript.com) earlier today. ChaiScript is designed to make it trivially easy to use scripting in your C++ application and to expose your C++ to the scripting system. 

ChaiScript is a header only implementation. It requires no external libraries and is distributed under the BSD license, making it free and easy to distribute. So, how easy is easy, really? How does 3 lines of code sound for a classic hello world example? 

```cpp
#include <iostream>  
#include <chaiscript/chaiscript.hpp>    

int main(int argc, char *argv[])  {   
  chaiscript::ChaiScript_Engine chai;   
  chai.evaluate_string("print('Hello World');"); 
}
```

Of course, this example is quite limited in usefulness. But I want to keep this article short and not get into too much detail. So, I will provide on more example that shows how to expose a C++ function to ChaiScript. 

```cpp
#include <iostream>  
#include <chaiscript/chaiscript.hpp>  

std::string get_message() {   
  return "Hello World"; 
}    

int main(int argc, char *argv[])  {   
  chaiscript::ChaiScript_Engine chai;   
  dispatchkit::register_function(chai.get_eval_engine(), &get_message, "get_message");   
  chai.evaluate_string("print(get_message());"); 
}
```

ChaiScript never gets much more difficult than that. Stay tuned for more ideas, or check out the [The Book of ChaiScript](http://www.chaiscript.com/chaiscript_book) for more information.
