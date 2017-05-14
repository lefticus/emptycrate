


# C++ Class Offerings

Jason is a C++ programmer, speaker, and trainer with over 15 years of professional experience. He has won awards for his conference sessions, published 5-star reviewed video training series with O'Reilly Media, and is a Microsoft MVP for his contribution to the C++ community.

Jason co-hosts [CppCast](http://cppcast.com), the podcast for C++ developers, and hosts [C++ Weekly](https://www.youtube.com/c/JasonTurner-lefticus), a YouTube channel for C++ developers.


## The Advantages to Jason's Training

Jason's style of highly interactive teaching in a small group environment ensures that each attendee has the opportunity to participate and ask questions.

His training focuses on teaching how to write code that:

 * Takes less time to develop
 * Costs less to develop
 * Is more maintainable
 * Performs well


------------------------------------------------------------------------------------------------------------------


# Suggested Curricula

Offering a variety of classes, Jason is able to tune a curriculum to the specific needs of your organization. 

Below are a few suggested curriculae for various types of organizations.

## Exploring C++ - For the organization that wants to know why C++ should be a consideration

 * [Why C++?](#why-c)

## Moving to C++ - For the organization that is interested in moving to C++ from C or another language

2 day class:

 * Day 1: [Why C++?](#why-c) & [Moving to C++](#moving-to-c)
 * Day 2: [Best Practices](#best-practices)

3 day class:

 * Day 1: [Why C++?](#why-c) & [Moving to C++](#moving-to-c)
 * Day 2: [Understanding Object Lifetime](#understanding-object-lifetime)
 * Day 3: [Best Practices](#best-practices)

4 day class:

 * Day 1: [Why C++?](#why-c) & [Moving to C++](#moving-to-c)
 * Day 2: [Understanding Object Lifetime](#understanding-object-lifetime)
 * Day 3: [Inheritance and Polymorphism](#inheritance-and-polymorphism)
 * Day 4: [Best Practices](#best-practices)
  
 
## Updating to C++11 and beyond - For the organization that is already using C++ but is interested in updating to the latest standards and cleaning up their code in the process

2 day class:

 * Day 1: [Demystifying C++11 and Beyond](#demystifying-c11-and-beyond) & [Moving to C++ 11 and Beyond](#moving-to-c11-and-beyond)
 * Day 2: [Best Practices](#best-practices) & [Best Practices for C++17](#best-practices-for-c17)

3 day class:

 * Day 1: [Demystifying C++11 and Beyond](#demystifying-c11-and-beyond) & [Moving to C++ 11 and Beyond](#moving-to-c11-and-beyond)
 * Day 2: [Understanding Object Lifetime](#understanding-object-lifetime)
 * Day 3: [Best Practices](#best-practices) & [Best Practices for C++17](#best-practices-for-c17)

4 day class:

 * Day 1: [Demystifying C++11 and Beyond](#demystifying-c11-and-beyond) & [Moving to C++ 11 and Beyond](#moving-to-c11-and-beyond)
 * Day 2: [Understanding Object Lifetime](#understanding-object-lifetime)
 * Day 3: [Inheritance and Polymorphism](#inheritance-and-polymorphism)
 * Day 4: [Best Practices](#best-practices) & [Best Practices for C++17](#best-practices-for-c17)


## Honing skills and increasing code quality - For the organization that is already using C++11 and is intersted in improving their overall code quality while increasing performance

2 day class:

 * Day 1: [Best Practices](#best-practices)
 * Day 2: [Best Practices for C++17](#best-practices-for-c17) & [Best Practices for the Library Author](#best-practices-for-the-library-author)

3 day class:

 * Day 1: [Understanding Object Lifetime](#understanding-object-lifetime)
 * Day 2: [Demystifying C++11 and Beyond](#demystifying-c11-and-beyond) & [Best Practices](#best-practices)
 * Day 3: [Best Practices for C++17](#best-practices-for-c17) & [Best Practices for the Library Author](#best-practices-for-the-library-author)

4 day class:

 * Day 1: [Understanding Object Lifetime](#understanding-object-lifetime)
 * Day 2: [Zero Cost C++](#zero-cost-c)
 * Day 3: [Demystifying C++11 and Beyond](#demystifying-c11-and-beyond) & [Best Practices](#best-practices)
 * Day 4: [Best Practices for C++17](#best-practices-for-c17) & [Best Practices for the Library Author](#best-practices-for-the-library-author)

------------------------------------------------------------------------------------------------------------------

# Class Descriptions

## Best Practices

Based on the Best Practices that Jason has been developing since 2014 with his cppbestpractices.com website and 
"Learning C++ Best Practices" video series published with O'Reilly, this series teaches the student how to write code that is more 
maintainable, simpler, and faster. This course is designed for users that already have a basic working knowledge of C++.

 * *Time*: 8 hrs
 * *Prerequisites*: A basic working knowledge of C++.

*Goal*:

After this class the student will be able to recognize that code such as this:

```cpp
size_t count_a(void *buf) {
  size_t count;
  char *typed_buf;
  count = 0;
  typed_buf = (char *)buf;
  for (int i = 0; i < typed_buf[i] != '\0'; ++i) {
    if (typed_buf[i] == 'a') {
      ++count;
    }
  }
  return count;
}
```

Can be transformed into code like this:

```cpp
size_t count_a(const std::vector<char> &t_vec)
{
  return std::count(std::begin(t_vec), std::end(t_vec), 'a');
}
```

We will cover:

 * The proper use of smart pointers
 * Avoiding common runtime performance pitfalls
 * Taking into account cross-platform considerations
 * Using the standard library
 * Using the wide range of tools available 
 * Basic object lifecycle
 * High level threading constructs
 * The impact of `decltype(auto)` on coding standards

## Best Practices For the Library Author

Library developers write code that affects the entire organization. It is particularly important that their 
code be efficient at both compile time and run time. It is equally important that the code be proven and maintainable.

 * *Time*: 4 hours
 * *Prerequisites*: The "Best Practices" class or equivalent knowledge

*Goal*

The student will understand details such as why variadic recursive template instantiations should be avoided and what the alternatives are.

We will cover:

 * Minimizing the impact of templates
   1. Compile time impact
   2. Runtime impact
 * Testing tools available
 * Properly using `constexpr`, `final` and `noexcept`
 * Properly testing `constexpr`
 * Using variable template aliases for compile time savings
 * Considering `auto` return types


## Best Practices for C++17

C++17 is coming soon and compilers already have significant support for it. There are several features of C++17 that will affect the
way we use C++. 

 * *Time*: 4 hours
 * *Prerequisites*: The "Best Practices" class or equivalent knowledge
 
We will cover

 * Using `if constexpr`
 * Designing your classes for class template type deduction
 * When and how to support structured bindings
 * Using `std::scoped_lock`



## Moving to C++11 and Beyond

In this module we will bring the already experienced C++ developer up to date with “modern” C++ with concrete examples for how C++11 can make code better and safer.

 * *Time*: 2 hours
 * *Prerequisites*: An understanding of C++98

We will introduce

 * Lambdas
 * `auto`
 * Return type deduction
 * Variadic templates
 * Standard library changes
 * Move semantics
 * `if constexpr` (C++17)
 * structured bindings (C++17)


## Why C++?

C++ is sometimes thought to be an overly complex language that carries with it the baggage of decades of backwards compatibility with itself and with C. So why do we use it? What advantages does C++ offer that makes it so compelling?

In this seminar we will discuss why C++ should be considered for the next project you are working on.

 * *Time*: 1-4 hrs
 * *Prerequisites*: Knowledge of an existing programming language

*Goal*

The attendee will gain and understanding of what makes C++ unique.

## Moving to C++

In this course we will help the programmer experienced in other languages develop a basic working understanding of C++

 * *Time*: 4 hours
 * *Prerequisites*: A strong knowledge of programming in a non-C++ language
 
 *Goal*
 
 The student who completes this class will be able to read and maintain an existing C++ code base and get started on new C++ projects.
 
We will cover
 
 * Looping constructs
 * Control blocks
 * Object lifetime
 * Basic data structures and standard library features
 * Where to go for help
 

## Demystifying C++11 And Beyond

C++11, 14 and 17 have added new constucts to the language that may make the experienced C++ programmer question how much overhead is added when utilizing these features and how trustworthy they are.

 * *Time*: 4 Hours
 * *Prerequisites*: An understanding of C++98
 
We will explain:

 * How lambdas (regular, generic and variadic) are implemented
 * How algorithms work and what overhead (if any) they add
 * How to implement your own algorithms
 * The difference between C-style arrays and C++11's `std::array`

## Inheritance and Polymorphism

Gain new control of your code through a clear understanding of inheritance and polymorphism in C++. You will learn the basics, the gotchas, the implementation and optimization of polymorphism and inheritance.

 * *Time*: 4-8 Hours
 * *Prerequisites*: A basic understanding of C++ and its syntax

We will:

 * Discover the differences between runtime and compile time polymorphism and how to combine them to create powerful constructs
 * Understand class hierarchies in C++
 * Learn to control aspects of a class using access specifiers
 * Explore covariant return types, multiple and virtual inheritance, private constructors, destructors, mixins, CRTP, and other advanced topics
 * Review the cost and optimization methods of polymorphism, as well as the trade-offs considered when designing libraries
 * Gain the ability to implement the std::any and std::function

## Understanding Object Lifetime

C++ has something very few other languages have: a well defined object life cycle. Understanding this key aspect of C++ is critical to writing clean, maintainable, and efficient C++.

 * *Time*: 8 Hours
 * *Prerequisites*": Beginner to advanced knowledge of C++
 
We will cover:

 * Understanding RAII
 * What does the standard say?
 * Member variable lifecycle
 * How and why to limit variable scope
 * The as-if rule
 * std::move and std::forward
 * Passing values
 * Returning values
 * Lifecycle of lambda captures
 * How the C++ memory model and object lifetime relate
 * Gotchas
 * A note about runtime polymorphism
 * What changes in C++17


## Zero Cost C++

C++ has an over arching design goal of providing abstractions that have zero or negative overhead compared to hand-rolled abstractions. In this class we will examine the zero cost abstractions that C++ provides and how to leverage them for high level and high performance code.

 * *Time*: 8 Hours
 * *Prerequisites*: An intermediate knowledge of C++

*Goal*

In this class the attendee will learn to trust the abstractions that C++ provides and how to utilize them.
 
We will cover:

 * Objects
 * Methods
 * (Delegating) Constructors / Destructors
 * Lambdas with/without captures
 * Structured bindings (aka destructuring)
 * Function calls that have been inlined (and how to 'force' inlining)
 * If-init
 * Templates (variadic, recursive)
 * Standard algorithms

