---
layout: blog_post
title: 'When to use #include "" verses #include <>'
published: true
date: '2009-03-25 05:00:00'
redirect_from:
- content/when-use-include-verses-include/
- node/4352/
- import_node/379/
tags:
- Programming
- C++
- Best Practices
---

Different compilers treat the two types of includes: 

`#include "filename"` and `#include <filename>`

Differently in the details, but if you are programming for portability there is a simple rule of thumb to keep in mind: *use the `<>` version to reference installed files, not local files*. We will illustrate the reasoning for using the `#include ""` format in your library's header files below.

> myproject
>
> > src
> >
> > > project.cpp
> >
> > include
> >
> > > myproject
> > >
> > > > project.hpp project_core.hpp

project.cpp source: 

```cpp
//project.cpp  
//We need to include our local project.hpp file, which is not yet installed 
//the compiler will use a command line similar to the following: 
//gcc src/project.cpp -I include/  

#include "myproject/project.hpp"  
// do stuff`
```


project.hpp source: 

```cpp
#ifndef __PROJECT_HPP__ 
#define __PROJECT_HPP__  
//project.hpp  
//We need to include project_base.hpp, and we have 3 options: 
// #include <project_base.hpp> 
// This version would require that include/myproject be in the compiler's include path 
// this is a bit annoying because it would require the user of your installed package to find 
// the exact path the includes were installed in  
// #include <myproject/project_base.hpp> 
// This version requires that the project includes *always* be installed in a folder 
// named "myproject" 
// This requirement may make testing and test-installs harder.  
// #include "project_base.hpp" 
// This is the version we will choose because (at least on some compilers) 
// the "" version of the include uses relative path lookups.  
// this means that we can install our project's .hpp files anywhere we like and the 
// project.hpp file will always be able to find its include for project_base.hpp 
// _as long as they are installed in the same folder_  #include "project_base.hpp"  
//do stuff  #endif`

project_base.hpp source: 

```cpp
#ifndef __PROJECT_BASE_HPP__ 
#define __PROJECT_BASE_HPP__  
//project_base.hpp  
//Not much to see here 
//do stuff  
#endif
```

When you go to actually use your installed library you will want to use the \<\> format: testmyproject.cpp source:

    #include <myproject/project.hpp>

    //Use the library

If we define the project as shown above and install in a standard location, compiling our testmyproject.cpp file is simple: ` gcc -I/usr/local testmyproject.cpp`

If, however, we use a different method of including project_base.hpp from project.hpp, our compilation is complicated: The additional include directory is necessary if we fail to follow the suggestions above because we have to help the compiler find all of the include paths we used. `gcc -I/usr/local -I/usr/local/myproject testmyproject.cpp`
