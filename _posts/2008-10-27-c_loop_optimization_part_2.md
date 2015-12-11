---
layout: blog_post
title: 'C++ Loop Optimization: Part 2'
published: true
date: '2008-10-27 19:57:33'
redirect_from:
- content/c-loop-optimization-part-2/
- node/4309/
- import_node/325/
tags:
- Programming
- Optimization
- C++
- Articles
---

After the [first article](/content/c-loop-optimization) on loop optimization my cousin pointed out to me that in some cases, tail recursion can actually be [faster](http://ygingras.net/b/2008/4/tail-call-elimination-is-good-in-c-too) then loops in C with the help of tail recursion elimination. It took several tries to come up with a version that the compiler was able to optimize. I knew I got the version correct when the application stopped segfaulting (I believe it was running out of stack space). My experimentation shows that some optimized cases are faster (unoptimized versions will not complete execution) then loops. If anyone has any more experience with this, please attach a better optimized version and I'll give it a run on my machine. ` struct Increment {   int m_value;    Increment(int i)     : m_value(i)   {    }    int operator()()   {     return m_value++;   } };  template uint64_t sum(InItr begin, const InItr &end, uint64_t sumsofar) {   if (begin == end)    {     return sumsofar;   } else {     ++begin;     return sum(begin, end, sumsofar + *begin);   } }  int main() {   std::vector vec;    std::generate_n(back_inserter(vec), 10000000, Increment(0));    for (int i = 0; i < 1000; ++i)   {     std::cout << sum(vec.begin(), vec.end(), 0) << std::endl;   } }`
**Tail Recursion Timings**
|-------|--------|
| *-O2* | 44.113 |
| *-O3* | 48.278 |

**Functional Timings** (From previous article, timings reran)
|-------|--------|
| *-O2* | 42.146 |
| *-O3* | 45.087 |

**Pre-increment Optimization Timings** (From previous article, timings reran)
|-------|--------|
| *-O2* | 44.936 |
| *-O3* | 45.434 |

The tail recursion version is faster then the pre-increment optimized version for -02, but slower for -03. I don't know enough about the compiler optimization techniques to know why -03 would actually slow down all of the test cases. If nothing else this version is nice and small, pretty easy to read and performs quite well.
