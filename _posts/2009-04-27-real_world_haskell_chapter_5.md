---
layout: blog_post
title: 'Real World Haskell: Chapter 5'
published: true
date: '2009-04-27 05:00:00'
redirect_from:
- content/real-world-haskell-chapter-5/
- node/4373/
- import_node/405/
tags:
- Programming
- Haskell
- Book Reviews
---

Chapter 5 of [Real World Haskell](http://www.amazon.com/gp/product/0596514980?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596514980)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=0596514980) covers the creation of our first Haskell module. The chapter seems to come prematurely from my perspective. I am not yet concerned about making a module while I'm still trying to understand the language. One thing that did catch my attention is the `Prelude.undefined` special value which allows for easy creation of stub code: ` -- This compiles but causes a runtime error if you try to execute it text :: String -> Doc text str = undefined`
**Bitwise Functions** We also learn in Chapter 5 that the bitwise manipulations we have come to take for granted in C, C++ and similar languages is now a library module. This is the first point at which I can see an obvious point where C++ would make more succinct and readable code than Haskell. 

```haskell
import Data.Bits 0x10000 `shiftR` 4 :: Int 7 .&. 2 :: Int
```


```cpp
int i = 0x10000 >> 4; int j = 7 & 2;
```

It seems clear to me that if your code consists of mainly bit manipulations, C++ or C might be the logical choice.
