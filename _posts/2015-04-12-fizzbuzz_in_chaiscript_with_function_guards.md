---
layout: blog_post
title: FizzBuzz in ChaiScript with Function Guards
published: true
date: '2015-04-12 07:21:05'
redirect_from:
- content/fizzbuzz-chaiscript-function-guards
- node/4603
tags:
- ChaiScript
- Programming
---

I was recently reminded of the old FizzBuzz programming test and thought I would share a version of it for ChaiScript. ChaiScript has a possibly little used feature that allows you to execute a 'guard' or test before the function is executed, to see if it matches certain criteria. We can take advantage of this to generate rather readable version of FizzBuzz.


    def Fizz(int i) : i % 3 == 0 { "Fizz" }
    def Fizz(int i) { "" }
    def Buzz(int i) : i % 5 == 0 { "Buzz" }
    def Buzz(int i) { "" }

    def FizzBuzz(int i)
    {
      i.to_string() + " " + Fizz(i) + Buzz(i)
    }

    for (auto i=1; i <= 100; ++i)
    {
      print(FizzBuzz(i));
    }


Is it the shortest version ever? No. But it is interesting in that it doesn't have a single explicit branch statement.
