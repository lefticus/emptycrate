---
layout: blog_post
title: Copying a File in C++, The Easy Way
published: true
date: '2007-06-05 11:42:45'
redirect_from:
- content/copying-file-c-easy-way/
- node/4258/
- import_node/264/
tags:
- Programming
- C++
---

Just a few days ago I spent way too long looking at the [boost](http://www.boost.org) libraries to see if there was a way of adapting a std::fstream to an iterator type. I didn't find what I was looking for and did what I wanted a completely different way. This morning while reading Stroustrup (The C++ Programming Language) I learned that what I was looking for was already built in to the standard library! Well, after an hour or so of work I eliminated about 40 lines of code, made my code more maintainable and more readable. As a test case, I put together this little example. The below code is a complete program, it will compile and run and copy "input.txt" to "output.txt". It works with any file, binary or not (which is why the noskipws is needed). No, it is NOT the most efficient way of doing things, but it shows just how expressive the C++ standard library is.

    #include <istream>
    #include <iostream>
    #include <fstream>
    #include <iterator>

    using namespace std;

    int main()
    {
      fstream f("input.txt", fstream::in|fstream::binary);
      f << noskipws;
      istream_iterator begin(f);
      istream_iterator end;

      fstream f2("output.txt",
        fstream::out|fstream::trunc|fstream::binary);
      ostream_iterator begin2(f2);

      copy(begin, end, begin2);
    }
