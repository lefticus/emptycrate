---
layout: blog_post
title: C++ Multiple Dispatch?
published: true
date: '2008-04-10 07:54:47'
redirect_from:
- content/c-multiple-dispatch/
- node/4281/
- import_node/287/
tags:
- Programming
- C++
---

I clearly must be missing something. I just noticed [this](http://www.oreillynet.com/onlamp/blog/2008/04/multiple_dispatch_now_please.html) article on the O'Reilly ONLamp blog, discussing multiple dispatch in Perl. The example code given:

    class Thing             {}
    class Rock     is Thing {}
    class Paper    is Thing {}
    class Scissors is Thing {}

    multi sub defeats(Thing    $t1, Thing    $t2) { 0 };
    multi sub defeats(Paper    $t1, Rock     $t2) { 1 };
    multi sub defeats(Rock     $t1, Scissors $t2) { 1 };
    multi sub defeats(Scissors $t1, Paper    $t2) { 1 };

    my $paper = Paper.new;
    my $rock  = Rock.new;

    say defeats($paper, $rock);
    say defeats($rock, $paper);

Absolutely, positively translates directly into C++:

    #include <iostream>

    class Thing{};
    class Rock  : public Thing {};
    class Paper : public Thing {};
    class Scissors : public Thing {};

    bool defeats(const Thing &, const Thing &) { return false; }
    bool defeats(const Paper &, const Rock &) { return true; }
    bool defeats(const Rock  &, const Scissors &) { return true; }
    bool defeats(const Scissors &, const Paper &) { return true; }

    Paper paper;
    Rock rock;

    int main(int, char **)
    {
      std::cout << std::boolalpha;
      std::cout << defeats(paper, rock) << std::endl;
      std::cout << defeats(rock, paper) << std::endl;
    }

Is multiple dispatch nothing more than just function overloading?
