---
layout: blog_post
title: Understanding the ChaiScript clone Function
published: true
date: '2009-09-29 20:06:18'
redirect_from:
- content/understanding-chaiscript-clone-function/
- node/4397/
- import_node/444/
tags:
- ChaiScript
- C++
---

In [ChaiScript](http://www.chaiscript.com) variable assignments create a copy of the object being assigned.

    var x = 5;
    var y = x; // Make a copy of x and assign it to y

It's an interesting study in how the ChaiScript language works to dissect this ability to clone an object dynamically. The basic premise is that the function creates and executes a dynamic function call to the object's copy constructor. The ChaiScript system translates the assignment operation into a clone to actually perform the copy.

    var y = clone(x);

"clone" is fully implemented as a ChaiScript function, which is part of the ChaiScript prelude:

    def clone(x) : function_exists(type_name(x)) && call_exists(eval(type_name(x)), x)  
    { 
      eval(type_name(x))(x); 
    } 

We can understand how the function works by breaking down the execution one step at a time. **First part of the function guard: `function_exists(type_name(x))`**

1.  Retrieve the typename of the object we want to clone: `type_name(x) /*"int" */`
2.  Check to see if a function exists that has the same name as the typename of the object we want to clone ("int"). `function_exists("int")`

**Second part of function guard: `call_exists(eval(type_name(x)), x)`**

1.  Again, retrieve the typename of the object: `type_name(x) /* "int" */`
2.  Eval the typename. We know that this is a safe operation because we confirmed in the first part of the "clone" function guard that the typename was a valid function name. This is the first "tricky" part of the function execution. The question is, what does `eval("int")` return? The answer is a function object, which are used often in ChaiScript. A function object is quite simply an object that represents a function.
3.  Check to see if a function call exists that matches our function object, with a single parameter of the value we want to clone. Thus, our code execution becomes: `call_exists(int, x)` This is equivalent to asking: Does a function called "int" exist that takes a single parameter of type int?

**Function body: `eval(type_name(x))(x)`** If we get past the function guards we know that there is a function called "int" that takes our value "x." At this point we assume that if there is a function with the same name as the type passed in, and that function takes exactly one argument that is of the type passed in, we have found our copy constructor. Taking what we have learned so far we now know that the function body can be reduced to: `return int(x);` **Consequence of the Implementation of Clone** The fallout of how we have implemented clone and the fact that it is called for every assignment operation is that you need to provide a clone ability for each new C++ type you add the the ChaiScript engine. That is, if you want your newly added type to support regular assignment and copying. Note that this is not a requirement, you can use the reference assignment (`:=`) operator instead. To make sure your type is fully supported, you need to add a type name for your type to the engine: ` ChaiScript chai; chai.add(user_type(), "MyType");`

Also, you need to add a copy constructor that has the same name as the type you just registered. There is a shorthand method for this built into the chaiscript::bootstrap helpers: ` chai.add(copy_constructor("MyType"));`

An additional shorthand exists for adding both a copy constructor and a default constructor at the same time: ` chai.add(basic_constructors("MyType"));`

It is worth taking the time to point out that "constructors" in ChaiScript are really not a special type of function, they are just functions that have "special" names. This can lead to interesting possibilities in more advanced examples.
