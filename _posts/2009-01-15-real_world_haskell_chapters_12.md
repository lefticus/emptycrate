---
layout: blog_post
title: 'Real World Haskell: Chapters 1-2'
published: true
date: '2009-01-15 17:35:49'
redirect_from:
- content/real-world-haskell-chapters-1-2
- node/4329
- import_node/357
tags:
- Haskell
- C++
- Book Reviews
- Programming
---

Chapter 1 of [Real World Haskell](http://www.amazon.com/gp/product/0596514980?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596514980)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=0596514980) covers the most basic aspects of the language, such as common operators and operator precedence and gives some overviews of aspects of the language. Chapter 2 discusses the type system. What stands out to me the most is that many of the claims that are made about the advantages of statically and strongly typed languages also applies to C++. The following excerpt illustrates my point:

> Haskell's combination of strong and static typing makes it impossible for type errors to occur at runtime. While this means that we need to do a little more thinking “up front”, it also eliminates many simple errors that can otherwise be devilishly hard to find. It's a truism within the Haskell community that once code compiles, it's more likely to work correctly than in other languages. (Perhaps a more realistic way of putting this is that Haskell code often has fewer trivial bugs.) ... In Haskell, the compiler proves the absence of type errors for us: a Haskell program that compiles will not suffer from type errors when it runs. Refactoring is usually a matter of moving code around, then recompiling and tidying up a few times until the compiler gives us the “all clear”.

**Type Inference** However, Haskell says that it can infer types more often than not, making type declarations unnecessary. This reads as if every function call is equivalent to a C++ template. **Tuples** The Haskell notion of tuples seems to be very similar to that of boost::tuple, but cleaner as it is built into the language. C++ example: ` //Without the new "auto" type, coming in C++0x boost::tuple t = boost::make_tuple(5, "Hello", 2.3);  //The above is a bit cumbersome, and will be cleaned up with the auto tupe auto t = boost::make_tuple(5, "Hello", 2.3);`

Haskell, which is clearly cleaner: ` t = (5, "Hello", 2.3);`

**Parametric Polymorphism** Haskell's parametric polymorphism seems to be strongly related to C++ function templates, but we'll hopefully get into that more later.
