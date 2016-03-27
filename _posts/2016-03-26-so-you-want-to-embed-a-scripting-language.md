---
layout: blog_post
title: So You Want to Embed A Scripting Language in Your Application
published: true
tags:
- C++
- ChaiScript
redirect_from:
- node/4425
- node/4426
- node/4438
- content/languages-designed-embedding
- node/4450
- content/swig-overview
- node/4451
- content/so-you-want-embed-scripting-language-your-application
- import_node/96
- import_node/Embedding_a_Scripting_Language
---


*Note: this article was originally written in 2005. I'm importing some missed content into my new site and this is one of those articles. Much of the information in this article is out of date, but it still has some relevance. To see my personal take on the best way to embed scripting in C++, checkout [ChaiScript](http://chaiscript.com).*


So, you've been wondering what it would take to embed a scripting languge into your C or C++ application? This document will give you a simple overview of the various possibilities and the steps required to make it work. It will also provide a list of resources to give you the specifics that you need to bring it all together.

There are two major groups that an embeddable scripting language falls into. Those scripting languages which were initially standalone languages then hooks were added later for embedding them into other applications, and those scripting languages which were designed specifically for embedding in another application.

There are many languages that can be embedded as scripting languages and the concepts covered here should help you evaluate which ones you want to support and get you started in the process.

First we will cover <a href="http://swig.org">SWIG</a>, then move on to specific concerns about the two language types and conclude with a list of web resources.

# SWIG Overview

<a href="http://swig.org">SWIG</a> is your best friend when it comes to using your application's API from within a scripting language. SWIG stands for "Simplified Wrapper and Interface Generator." With SWIG, you can automatically generate wrapper code to allow you to use your C or C++ library from within a scripting language. The latest "stable" release of SWIG is 1.1p5 which was released in 1998, the latest "development" release is 1.3.27, released in June, 2005. 

The 1.3.27 release is known to have some backward compatibility issues and is blocked in Gentoo Linux. However, it is the release that we will be focusing on because it has a wider range of language support.

This release has varying levels of support for the following lanuages:

<ul>
<li>C#</li>
<li>Chicken</li>
<li>Guile</li>
<li>Java</li>
<li>Lua</li>
<li>Modula-3</li>
<li>MzScheme</li>
<li>Ocaml</li>
<li>Perl5</li>
<li>PHP4</li>
<li>Pike</li>
<li>Python</li>
<li>Ruby</li>
<li>Tcl</li>
</ul>


The general usage of SWIG is:

```
swig -<sourcelanguage> -<targetlanguage> <Interface file>
```

Specifically, in the case of generating Lua wrapper code for the Crate Game Engine, we would call:

```
swig -c++ -lua CrateGameEngine.i
```

Our case is very simple because we have made a point of designing the API to be SWIG friendly. Specifically, that means using datatypes that SWIG knows about. There are three main catagories of types that SWIG knows about.

<ol>
<li>Built In Types</li>
Built in types are POD types: char, int, long, bool, etc. Also, pointers to these types.
<li>STL Types</li>
STL types that are supported vary from widely from language to language. Currently, Python has very robust support with all major container classes and stream templates supported (e.g. std::vector, std::map, std::iostream, std::string, etc). Other languages, such as Lua, only support vector and string. Note, SWIG does not handle non-const pointers to strings very well. One reason given for this is that some scripting languages consider strings to be immutable.
<li>User Defined Types</li>
User defined types include classes, structs, enums and typedefs. Herein lies one of the main points of SWIG, to be able to generate language specific wrappers for user defined types. It is very well supported
</ol>

Therefore, to design with SWIG in mind, we have avoided using pointers to strings, and have limited public interfaces involving std classes to std::vector and std::string. Although std::map is supported by most languages in SWIG, it is mostly unusable for the case of:

```
std::map<string, string>
```

because the normal behavior of an STL container class is to return a reference to the object  that it contains. This allows the user of the container to perform an operation such as:

```
std::map<string, string> mymap
mymap["test"] = "test1";
mymap.front().second = "test2";
```

After that code has executed the key "test" is equal to "test2". Remember, SWIG cannot work with non-const pointers to strings very well, so a map that is set up to contain strings is very difficult to work with in the scripting language. Some of the other container classes, namely std::vector, consider std::string as a special case and work with it quite well, however.

That said, our input to SWIG is very simple, the file that we use follows:


```swig
%module(directors="1") CrateGameEngine

%include "LanguageSpecific.i"

%{
#include "CGE/PropertyBag.h"
#include "CGE/Renderer.h"
#include "CGE/Action.h"
#include "CGE/Object.h"
#include "CGE/Player.h"
#include "CGE/Conversation.h"
#include "CGE/Character.h"
#include "CGE/Map.h"
#include "CGE/RenderingEngine.h"
#include "CGE/ScriptingEngine.h"
#include "CGE/System.h"
#include "CGE/World.h"
#include "CGE/WorldLoader.h"
%}

%ignore logger(LogType logtype);

%include "../include/CGE/PropertyBag.h"
%include "../include/CGE/Renderer.h"
%include "../include/CGE/Action.h"
%include "../include/CGE/Object.h"
%include "../include/CGE/Player.h"
%include "../include/CGE/Conversation.h"
%include "../include/CGE/Character.h"
%include "../include/CGE/Map.h"
%include "../include/CGE/RenderingEngine.h"
%include "../include/CGE/ScriptingEngine.h"
%include "../include/CGE/System.h"
%include "../include/CGE/World.h"
%include "../include/CGE/WorldLoader.h"
```

Lines that are inside the `%{}` blocks are inserted verbatim into the resulting CPP which will be compliled to generate the language specific module.



# Languages Designed For Embedding

Lua and Javascript (specifically <a href="http://www.mozilla.org/js/spidermonkey/">spidermonkey</a>) are two languages which were specifically designed for embedding in a C or C++ application.

The general order of operations for using one of these languages is:

<ol>
<li>Initialize Scripting Language Context</li>
<li>Add Datatypes to Scripting Language Context</li>
<li>Add Variables to Scripting Language Context</li>
<li>Load Script into Context</li>
<li>Execute Script</li>
<li>Get Results from Context</li>
<li>Close Scripting Language Context</li>
</ol>

Lua is supported by SWIG, which saves you a lot of work. SWIG generates a method called SWIG_init which accomplishes step #2. It also generates methods SWIG_NewPointerObj and SWIG_ConvertPtr which help you with items #3 & #6 respectively.

In pratice, a simple implementation of this from the Crate Game Engine looks like:

```cpp
    lua_State *l = lua_open();
    
    luaL_reg lualibs[] = {
        {"base", luaopen_base},
        {"table", luaopen_table},
        /* {"io", luaopen_io}, */
        {"string", luaopen_string},
        {"math", luaopen_math},
        {"debug", luaopen_debug},
        /*{"loadlib", luaopen_loadlib}, */
        /* add your libraries here */
        {SWIG_name, SWIG_init},
        {NULL, NULL}
    };

    for(int i=0; lualibs[i].func != 0 ; i++) {
      lualibs[i].func(l);  /* open library */
      lua_settop(l, 0);  /* discard any results */
    }

    SWIG_NewPointerObj(l, mWorld, SWIGTYPE_p_CGE__World, false);
    lua_setglobal(l, "mWorld");
    SWIG_NewPointerObj(l, mSystem, SWIGTYPE_p_CGE__System, false);
    lua_setglobal(l, "mSystem");
    SWIG_NewPointerObj(l, useWithObject, SWIGTYPE_p_CGE__Object, false);
    lua_setglobal(l, "useWithObject");
    SWIG_NewPointerObj(l, parentObject, SWIGTYPE_p_CGE__Object, false);
    lua_setglobal(l, "parentObject");

    int result = luaL_loadbuffer(l, mScript.c_str(), mScript.length(), "script");

    if (result == 0) {
      if (lua_pcall(l, 0, 0, 0) != 0) {
        //Handle Error
      }

    } else if (result == LUA_ERRSYNTAX) {
      //Handle Error
    } else if (result == LUA_ERRMEM) {
      //Handle Error
    }

    lua_close(l);
```

Javascript is not supported by SWIG and would require much more code to accomplish the same work."


# Languages Designed as Standalone Languages

Languages such as PHP, Perl, Python and Ruby are primarily used as standalone languages, but have support for using C or C++ modules.

The first thing necessary is to generate a module for the target language, this is where SWIG again helps us. Please see the SWIG <a href="http://www.swig.org/Doc1.3/Sections.html#Sections">documentation</a> for examples on creating, testing and using a module.

The steps for using one of these languages inside your application is very similar to that of using one of the languages designed for embedding.

<ol>
<li>Initialize Scripting Language Context</li>
<li>Load Application API Module into Scripting Language Context</li>
<li>Add Variables to Scripting Language Context</li>
<li>Load Script into Context</li>
<li>Execute Script</li>
<li>Get Results from Context</li>
<li>Close Scripting Language Context</li>
</ol>

The main difference between these languages and the languages designed for embedding is the extra work to compile and distribute the language specific module which adds your applications API to the scripting language. SWIG provides the standard SWIG_init, SWIG_NewPointerObj and SWIG_ConvertPtr helper functions mentioned in the previous section to help with many of these steps.

These languages tend to each have a different prefered method of compiling a module and integrating these compilation methods into an existing project can be difficult.

Specific resources regarding compiling language modules is covered in the next section.





# Conclusions and Resources

"If your main goal is to integrate scripting capabilities quickly, with as few distribution dependancies as possible, using one of the languages that was designed for embedding is your best choice. <a href="http://lua.org">Lua</a> is currently popular and was chosen by blizzard to allow <a href="http://www.blizzard.com/support/wow/?id=aww01672p3">scripting</a> of thier user interface for World of Warcraft.

If, however, you are more interested in using a well supported language with a large community of support, choosing <a href="http://python.org">Python</a>, <a href="http://perl.org">Perl</a> or a similar language might be a better choice for you.

As always, carefully check the license and distribution requirements of the language you choose to make sure they are compatible with the license and distribution you are using for your application.

Much of the documentation and websites related to creating modules for languages and using scripting languages can be difficult to find. Many resources have been collected here, to help you get started.

<ul>
<li><a href="http://swig.org">SWIG</a> Resources</li>
<ul>
<li><a href="http://www.swig.org/Doc1.3/Sections.html#Sections">General Documentation</a>: The very well put together official documentation for SWIG.</li>
</ul>
<li><a href="http://perl.org">Perl</a> <a href="http://perl.com">Resources</a></li>
<ul>
<li>General <a href="http://perldoc.perl.org/index-internals.html">index</a> of documents related to extending Perl.</li>
<li>Guide to <a href="http://perldoc.perl.org/perlembed.html">embedding Perl</a>.</li>
</ul>
<li><a href="http://ruby-lang.org">Ruby</a> Resources</li>
<ul>
<li>Guide to <a href="http://www.rubycentral.com/book/ext_ruby.html">extending Ruby</a>.</li>
</ul>
<li><a href="http://php.net">PHP</a> Resources</li>
<ul>
<li>Guide to <a href="http://www.zend.com/php/internals/extension-writing1.php?article=extension-writing1&kind=internals&id=7788&open=1&anc=7042&view=1">extending PHP</a>.</li>
<li>PHP extension <a href="http://pecl.php.net">library and documentation</a>.</li>
</ul>
<li><a href="http://python.org">Python</a> Resources</strong></li>
<ul>
<li>Guide to <a href="http://docs.python.org/ext/building.html">building</a> Python extensions.</li> 
<li>Guide to <a href="http://docs.python.org/ext/embedding.html">embedding</a> Python in another application.</li>
<li>Blog <a href="http://stompstompstomp.com/weblog/entries/74/">posting</a> on distributing an application with embedded Python.</li>
</ul>
<li>Javascript Resources<li>
<ul>
<li>Guide to the Mozilla <a href="http://www.mozilla.org/js/spidermonkey/">spidermonkey</a> javascript engine</li>
</ul>
<li><a href="http://lua.org">Lua</a> Resources</li>
<ul>
<li><a href="http://www.lua.org/manual/5.0/">Lua Refernce Manual</a></li>
<li>Source code <a href="http://www.lua.org/source/5.0/">documentation</a>: lauxlib contains many useful, undocumented utilities.</li>
<li><a href="http://luabind.sourceforge.net/">Luabind</a>: A tool for binding classes and objects at runtime to Lua without using a code generator like SWIG.</li>
</ul>
</ul>"


