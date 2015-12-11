---
layout: blog_post
title: Why is ++i faster than i++ in C++?
published: true
date: '2008-10-31 22:15:59'
redirect_from:
- content/why-i-faster-i-c/
- node/4314/
- import_node/330/
tags:
- Programming
- C++
- Articles
---

I've heard this question come up a few times in C++ programming circles, "Why is ++i faster/better than i++?" The short answer is: i++ has to make a copy of the object and ++i does not. The long answer involves some code examples. ` int i = 1; int j = i++; // j is equal to 1, because i is incremented after the value is returned,                // which means a copy was made of the old value int k = ++i; // k is equal to 3, because i is incremented, then returned. No copy is needed`
Or a more robust example of the operator overloads: ` class integer { public:   integer(int t_value)     : m_value(t_value)   {   }    int get_value() { return m_value; }    integer &operator++() // pre increment operator   {     ++m_value;     return *this;   }    integer operator++(int) // post increment operator   {     integer old = *this; // a copy is made, it's cheap, but it's still a copy     ++m_value;     return old; // Return old copy   }  private:   int m_value;`
You might ask, "why cannot the C++ compiler optimize away the copy of you don't use it?" Really: ` int i=1; ++i; //why is this i++; //faster than this if I'm not using the copied returned value?`
It's possible that the compiler may optimize away the copy for you, but it's also possible that your post-increment operator overload has other side effects that the compiler cannot optimize for without changing the meaning of your code. On a side note, it's rare that you literally want to increment and return the old value, so `++i` is often more semantically correct than `i++`, besides being more efficient.
