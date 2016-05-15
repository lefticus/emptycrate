---
layout: blog_post
title: Folds (ish) In C++11
tags:
- C++
- Templates
---

It is possible to perform some form of the variadic folds that are coming in C++17 with the C++11 and C++14 compilers that we have available today by using just a little bit of creativity.


*I've done a small series of YouTube videos around these topics*

 * [Intro To Variadic Templates](/2016/04/11/intro_to_variadic_templates.html)
 * [Variadic Template Refactor](/2016/03/28/variadic_template_refactor.html)
 * [Variadic Expansion Wrap-Up](/2016/05/09/variadic_expansion_wrap_up.html)


# Background


There are two parts of the standard that explain why this code is correct.

These quotes are from n3337, which is ([according to wikipedia](https://en.wikipedia.org/wiki/C%2B%2B11)) the draft standard closest to what the final published C++11 standard says.

> 5.18 Comma operator [expr.comma]
> The comma operator groups left-to-right.
>
> ```
>    expression:
>         assignment-expression
>         expression , assignment-expression
> ```
>
>  A pair of expressions separated by a comma is evaluated left-to-right; the left expression is a discarded- value expression (Clause 5). 83 Every value computation and side effect associated with the left expression is sequenced before every value computation and side effect associated with the right expression. The type and value of the result are the type and value of the right operand; the result is of the same value category as its right operand, and is a bit-field if its right operand is a glvalue and a bit-field.

What this is telling us is that a sequence of statements separated by commas is evaluated left-to-right, and furthermore, the results of the first statement are fully evaluated before the next statement is executed.

This means that:

```cpp
int i = 0;
int j = (++i, ++i, ++i); 
```

Is valid and has well-defined behavior. That is, `j` is equal to `3` (the result of the right-most expression in the list of comma separated statements) on every compliant compiler (which should be all of them at this point).

The most excellent http://gcc.godblot.org can show us this [simply](https://godbolt.org/g/7Ofdp6).

Note that the compiler does not generate any warnings at all.

The second part of the standard we need to understand is this:



> [dcl.init.list 8.5.4.4] Within the initializer-list of a braced-init-list, the initializer-clauses, including any that result from pack expansions (14.5.3), are evaluated in the order in which they appear. That is, every value computation and side effect associated with a given initializer-clause is sequenced before every value computation and side effect associated with any initializer-clause that follows it in the comma-separated list of the initializer-list.  [Note: This evaluation ordering holds regardless of the semantics of the initialization; for example, it applies when the elements of the initializer-list are interpreted as arguments of a constructor call, even though ordinarily there are no sequencing constraints on the arguments of a call. —end note ]

So, this tells us something similar: braced initializer lists have the same sequenced guarantees that the comma operator gives us. So, again, something like:

```cpp
int i = 0;
std::array<int, 3> a {++i, ++i, ++i};
```

Is allowed. And again, we can confirm with gcc.godbolt.org that [everthing works as expected](https://godbolt.org/g/xkDI93).

(Note: The wording in the above quoted text is very strong about the fact that any `{}` list should be sequenced, however at the time of the writing of this article there are [outstanding bugs in gcc and msvc](http://stackoverflow.com/questions/36852367/are-there-sequence-points-in-braced-initializer-lists-when-they-apply-to-constru) when it comes to calling constructors)


So, what part of the standard does it say that the order of operations is left undefined? Only for function calls and paranthesized initialization of constructors!

That means that:

```cpp
int get_value_1() {
  std::cout << "get_value_1\n";
  return 1;
}

int get_value_2() {
  std::cout << "get_value_2\n";
  return 2;
}

void print_values(const int v1, const int v2) {
  std::cout << "v1: " << v1 << "v2: " << v2 << '\n';
}

int main()
{
  print_values(get_value_1(), get_value_2());
  int i = 0;
  print_values(++i, ++i);
}
```

This code can/will/may print different things on different compilers. This is because we have no guarantee as to what order the function arguments will be evaluated.

And indeed, both [gcc](https://godbolt.org/g/WbCigC) and [clang](https://godbolt.org/g/DHAzms) will warn on this code.


# The Bad Old Days of Variadic Expansions

When "we" (the C++ world) started using C++11's variadics we thought we had to do things like recursive template instantiations to get the predictable results we wanted.

This led to difficult to understand, difficult to read code that resulted in long compile times and large binaries because of many symbols being created.

```cpp
#include <iostream>

// have to deal with the 0th case here
void print()
{
}

template<typename T1, typename ... T>
  void print(const T1& t1, const T& ... t)
{
  std::cout << t1 << '\n';
  print(t...);
}

int main()
{
  print(1, 2, 3.4, "Hello World");
}
```

This code [does what we want](http://coliru.stacked-crooked.com/a/fe94c5199e25e787), and indeed this is a very simple case.  More complex cases can be much harder to reason about.


# The Abuse of Variadic Expansion Rules And `std::initializer_list`

Someone (not me) figured out that we can abuse the `std::initializer_list` type to let us guarantee the order of execution of some statements while not having to recursively instantiate templates. For this to work we need to create some temporary object to let us use the braced initializer syntax and hold some result values for us. 

Only problem is, our `print` function doesn't return a result value. So what do we do? Give it a dummy return value!

```cpp
#include <iostream>

template<typename T>
void print(const T &t)
{
  std::cout << t << '\n';
}

template<typename ... T>
  void print(const T& ... t)
{
  std::initializer_list<int>{ (print(t), 0)... };
}

int main()
{
  print(1, 2, 3.4, "Hello World");
}
```

The statement `(print(t), 0)...` takes advantage of the comma operator to say "execute the first thing then return the second thing." Even though `print(t)` returns void, we are giving a `0` to be pushed into the `std::initializer_list<int>` and the compiler just magically compiles that away. This code ends up being no less efficient than the previous version at runtime and much more efficient at compile time. It's also often much easier to reason about for the human reading it. It's a win-win-win.

And we [still get the same results](http://coliru.stacked-crooked.com/a/be8437dbba28027b).

# But Wait, What Else Can We Do With That Comma Operator?

A lot, it seems. We know that the compiler guarantees that the code inside of the `( , )` list that's expanded for the variadic template will be executed in-order, with sequence points. So maybe we can get rid of that extra `print()` function?

Certainly:

```cpp
#include <iostream>

template<typename ... T>
  void print(const T& ... t)
{
  std::initializer_list<int>{ (std::cout << t << '\n', 0)... };
}

int main()
{
  print(1, 2, 3.4, "Hello World");
}
```

And again, [things continue to work](http://coliru.stacked-crooked.com/a/26bb7b77fbe7a0bf).



# No Reason To Quit Now

How about generating a comma separted list of elements all in one statement? Sure!

```cpp
#include <string>
#include <sstream>
#include <iostream>

template<typename ... T> 
std::string to_string(T&&... t) { 
  std::stringstream ss; 
  bool noComma = true;
  (void)std::initializer_list<bool>{ (ss << (noComma ? "" : ", ") << t, noComma = false)... }; 
  return ss.str();
}

int main()
{
  std::cout << to_string(1, 3.5, 98, 12.0f, "bob");
}
```

No problem! Compiler is [happy to expand this code](http://coliru.stacked-crooked.com/a/5d2c5068ff1cfe4a).

This essentially becomes:

```cpp
#include <string>
#include <sstream>
#include <iostream>

std::string to_string(int i, double d, int j, float f, const char *s) { 
  std::stringstream ss; 
  bool noComma = true;
  ss << (noComma ? "" : ", ") << i; noComma = false;
  ss << (noComma ? "" : ", ") << d; noComma = false;
  ss << (noComma ? "" : ", ") << j; noComma = false;
  ss << (noComma ? "" : ", ") << f; noComma = false;
  ss << (noComma ? "" : ", ") << s; noComma = false;
  return ss.str();
}

int main()
{
  std::cout << to_string(1, 3.5, 98, 12.0f, "bob");
}
```

Which is, after optimizations:

```cpp
#include <string>
#include <sstream>
#include <iostream>

std::string to_string(int i, double d, int j, float f, const char *s) { 
  std::stringstream ss; 
  ss << "" << i;
  ss << ", " << d;
  ss << ", " << j;
  ss << ", " << f;
  ss << ", " << s;
  return ss.str();
}

int main()
{
  std::cout << to_string(1, 3.5, 98, 12.0f, "bob");
}
```


# You Said Something About Fold Expressions?

## Folding with `&&`

Sure, let's keep going! Want to `&&` a bunch of things-convertable-to-bool together?

```cpp
#include <cstdint>
#include <algorithm>
#include <utility>

template<typename ... V>
auto and_all(const V &... v) {
  bool result = true;
  (void)std::initializer_list<int>{ (result = result && v, 0)... };
  return result;
}

int main(int, const char *argv[])
{
  return and_all(argv[0], argv[1], argv[2]);
}
```

[The compiler](https://godbolt.org/g/wHpBVs) has no problem with this.


## Folding with `+`

Why not?

```cpp
#include <algorithm>
#include <utility>
#include <type_traits>
#include <iostream>

template<typename ... V>
auto sum_all(const V &... v) -> typename std::common_type<V...>::type {
  typename std::common_type<V...>::type result = {};
  (void)std::initializer_list<int>{ (result += v, 0)... };
  return result;
}

int main()
{
  std::cout << sum_all(1,2,3.4,8.9) << '\n';
}
```

(note, this article is trying to make a point about C++11, but this code is cleaner in C++14)

```cpp
// C++14 version

#include <algorithm>
#include <utility>
#include <type_traits>
#include <iostream>

template<typename ... V>
auto sum_all(const V &... v) {
  std::common_type_t<V...> result = {};
  (void)std::initializer_list<int>{ (result += v, 0)... };
  return result;
}

int main()
{
  std::cout << sum_all(1,2,3.4,8.9) << '\n';
}
```

[Does the expected thing](http://coliru.stacked-crooked.com/a/c46e38d7a410e70b)



## Folded `<`

```cpp
#include <functional>
#include <utility>
#include <type_traits>
#include <iostream>

template<typename U, typename ... V>
auto min(const U &u, const V &... v) -> typename std::common_type<U, V...>::type {
  using rettype = typename std::common_type<U, V...>::type;
  rettype result = static_cast<rettype>(u);
  (void)std::initializer_list<int>{ ( (v < result)?(result = static_cast<rettype>(v), 0):0 )... };
  return result;
}


int main()
{
  std::cout << min(1, 2, 3.4, -1.2, 8.9) << '\n';
}
```

[Run it](http://coliru.stacked-crooked.com/a/047b9665035d34d7).



## What About Short Circuiting And Performance?

Taking this version, which doesn't get compiled away to nothing with optimizations:

```cpp
#include <cstdint>
#include <algorithm>
#include <utility>

template<typename ... V>
  auto test(const V &... v) {
  bool result = true;
  (void)std::initializer_list<int>{ (result = result && static_cast<bool>(v), 0)... };
  return result;
}

int main(int, const char *argv[])
{
  return test(argv[0],argv[1],argv[2]);
}
```

And compare it to the 'hand rolled' version:

```cpp
#include <cstdint>
#include <algorithm>
#include <utility>

bool test(bool b1, bool b2, bool b3) {
  return b1 && b2 && b3;
}

int main(int, const char *argv[])
{
  return test(argv[0],argv[1],argv[2]);
}
```

Well... that's hard to tell. Clang seems to be able to better optimize (fewer jumps) the first version, while g++ seems to better optimize the second version...

Play with [version1](https://godbolt.org/g/VAOFLP) and [version2](https://godbolt.org/g/nRcBDJ) and see what you think.





## It Can Even Work With `constexpr` in C++14

We can even use this to do things with constexpr in C++14 (note that this almost certainly has more compile time overhead than the version of folding that is coming from C++17).

```cpp
#include <utility>
#include <type_traits>

template<typename ... V>
constexpr auto and_all(const V &... v) {
  bool result = true;
  (void)std::initializer_list<int>{ (result = result && v, 0)... };
  return result;
}


template<typename ... T>
auto my_func(T ... t) -> std::enable_if_t<and_all(std::is_integral<T>::value...)>
{
  // version for all integral params
};

int main(int, const char *argv[])
{
  my_func(1,2,3);
}
```

[Try changing the param types and see what happens.](https://godbolt.org/g/r4GHCS)


## Plus Some Other Fun Stuff

```cpp
#include <cstdint>
#include <algorithm>
#include <utility>

template<std::size_t ... I>
  auto test(std::index_sequence<I...>) {
  std::size_t acc = 0;
  (void)std::initializer_list<decltype(acc)>{ (acc += I)... };
  return acc;
}

int main()
{
  return test(std::make_index_sequence<101>());
}
```

A [compile-time](https://godbolt.org/g/6RHvBd) adding of 0-100 in a fairly short bit of code.


# Conclusion

This stuff if just ripe for abuse. Play with it. Share the fun things you've come up with. I'm [@lefticus](https://twitter.com/lefticus) on twitter.

# Thanks

Special thanks to [@Loghorn](https://twitter.com/Loghorn) for helping see just how far this can be taken.



