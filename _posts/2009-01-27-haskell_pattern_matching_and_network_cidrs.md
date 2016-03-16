---
layout: blog_post
title: Haskell Pattern Matching and Network CIDR's
published: true
date: '2009-01-27 09:27:41'
redirect_from:
- content/haskell-pattern-matching-and-network-cidrs/
- node/4332/
- import_node/361/
- node/361/
tags:
- Pattern Matching
- Haskell
- C++
---


I was recently faced with the following code which is simple but provided the perfect example to practice some Haskell.

I needed to calculate how many IPs there are in a subnet based just on the [CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) provided. The concept is simple, the CIDR indicates how many bits must match between a route and a destination to determine if a route should be taken.

A typical subnet in a home setup might be something like: 192.168.1.0/24 which means the first 24 bits must match, giving you a subnet range of 192.168.1.0->192.168.1.255, or 256 addresses. However, the network (first) and broadcast (last) addresses are generally unusable, which means the actual usable range is 192.168.1.1->192.168.1.254 or 254 addresses.

So, the answer should be simple: `numips = (32-cidr)^2 - 2`.

However, there are two special cases, a direct route (cidr of 32) which has one matching IP. and a point to point route (cidr of 31) which has 2 matching IP's. Our algorithm above would return -2 and 0 for these special cases, which is less than ideal.

The C++ implementation is certainly not difficult:

```cpp
int countips(int cidr)
{
  switch (cidr)
  {
    case 32:
      return 1;
    case 31:
      return 2;
    default:
      return (1<< (32-cidr)) -2; //Use a bitshift to simulate a power of 2 in C
  }
}
```

However, the point of this article is Haskell's pattern matching with guards, which does make this look a lot cleaner, in my opinion. Patterns match from top to bottom, and the first match is the one returned. The algorithmic nature of a functional programming language is perfect for something like this:

```haskell
ipcount cidr 
       | cidr == 32    = 1
       | cidr == 31    = 2
       | cidr > 0      = 2^(32-cidr) - 2
ipcount _              = 0
```

Each | symbol introduces a pattern guard, if the guard matches, that code branch is executed. It is very similar to our switch based implementation above. The second case with a _ for the parameter name indicates a wild card, so anything at all (including a string or whatever) that does not match the first version will match the wild card version and return 0.

I know this is a trivially simple example for people with a background in Haskell, so I would appreciate it if anyone with more experience wants to add to this example or clean up something I messed up.


