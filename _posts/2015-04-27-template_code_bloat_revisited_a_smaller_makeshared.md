---
layout: blog_post
title: 'Template Code Bloat Revisited: A Smaller make_shared'
published: true
date: '2015-04-27 06:56:51'
tags:
- Templates
- C++
redirect_from:
- content/template-code-bloat-revisited-smaller-makeshared/
- node/4604/
- content/template-code-bloat-revisited/
---


Back in 2008 I wrote an article on [template code bloat](/content/nobody-understands-c-part-5-template-code-bloat). In that article I concluded that the use of templates does not necessarily cause your binary code to bloat and may actually result in smaller code! This ended up becoming one of my more significant articles and has been referenced on wikipedia.

*Note 2015-05-01 - fixed typos in first example* *Note 2015-05-04 - fixed typos in second example*

However, after spending the last few months optimizing and evaluating [ChaiScript](http://chaiscript.com) I've learned that the *misuse* of templates, particularly when inheritance is involved, can have a huge impact on code size.

Take the case of type-erasure, where you want to wrap an unknown type inside of a known type to provide a common interface. (For examples of type erasure, the end results of it are objects like `std::function<>` and `boost::any`)

```cpp
class Interface
{
  public:
    Interface() {}
    virtual ~Interface() = default;
    virtual std::string get_name() const = 0;
};

template<typename T>
struct Interface_Impl : Interface
{
  public:
    Interface_Impl() : m_name(typeid(T).name()) {}
    virtual std::string get_name() const {
      return m_name;
    };
  private:
    std::string m_name
};
```

Versus:

```cpp
class Interface
{
  public:
    Interface(std::string t_name) : m_name(std::move(t_name)) { }
    std::string get_name() const { return m_name; }

  private:
    std::string m_name;
};

template<typename T>
struct Interface_Impl : Interface
{
  public:
    Interface_Impl() : Interface(typeid(T).name()) {}
};
```

The first option is one that you might happen upon if being a bit too "object oriented" in your approach. It is, however:

- Potentially slower: Virtual function dispatch on `get_name`
- Larger: Each `Interface_Impl<>` that is instantiated must have its own `m_name` object defined. This adds extra symbols and code to the binaries
- Longer compile time: Instantiating more symbols means more compile time for the compiler.
- Did I mention slower?: A larger binary with more code paths also reduces cache friendliness.

The second option is pretty much better in every way, avoiding the pitfalls of the first.

make_shared
============

So what does this have to do with `make_shared`? An `std::shared_ptr` is a relatively complex beast that has to do atomic reference counting and efficient destruction dispatching and things like that. As such, a relatively large amount of code is instantiated for each `std::shared_ptr<>` type.

Taking one of our examples above: say we want to reason about an `Interface` object and pass it around.

```cpp
std::shared_ptr<Interface> p = std::make_shared<Interface_Impl<int>>(); 
```

`make_shared` offers us several advantages. It does one dynamic allocation vs two compared to `std::shared_ptr<Interface_Impl<int>>(new Interface_Impl<int>());`, is less code, and provides exception guarantees if something goes wrong during construction or allocation.

But it also presents a problem. We have now an instantiation of `std::shared_ptr<Interface_Impl>` when all we really cared about was `std::shared_ptr<Interface>`. If you have dozens of types, which is certainly not unreasonable in a large code base, the amount of code generate by the compiler can get out-of-hand.

You can avoid the extra instantiations if you force the compiler's hand, doing something like:


```cpp
std::shared_ptr<Interface> p(std::static_cast<Interface*>(new Interface_Impl<int>()));
```

Pros
----

- Significantly reduced compile time and compile size in large projects

Cons
----

- Ugly
- Must do virtual destructor calls from `~Interface` through to `~Interface_Impl`

Performance
-----------

This is supposed to be slower, right? It does two dynamic allocations instead of one. It is making a virtual destructor call. The counted reference value and held value are not adjacent to each other in RAM. These should all make it slower. However, in real tests with [ChaiScript](http://chaiscript.com), the smaller code is at least as fast as the theoretically faster code.

A "smaller" make_shared
========================

I'm proposing a version of `make_shared` that takes 2 template parameters. The type to create and the type to return.

A prototype version of this is:

```cpp
template<typename B, typename D, typename ...Arg>
inline std::shared_ptr<B> make_shared(Arg && ... arg)
{
  return std::shared_ptr<B>(static_cast<B*>(new D(std::forward<Arg>(arg)...)));
}
```

It has all of the problems mentioned above. I believe these could be sorted out, except for perhaps the virtual destructor call of the contained object.

The full tested example is this:


```cpp
#include <memory>
#include <vector>

struct Base
{
  virtual ~Base() = default;
};

template<int T>
struct Derived : Base
{
  Derived(int) {}
};

template<typename B, typename D, typename ...Arg>
inline std::shared_ptr<B> make_shared(Arg && ... arg)
{
#ifdef USE_STD
  return std::make_shared<D>(std::forward<Arg>(arg)...);
#else
  return std::shared_ptr<B>(static_cast<B*>(new D(std::forward<Arg>(arg)...)));
#endif
}

int main()
{
  std::vector<std::shared_ptr<Base>> objs;

  objs.push_back(make_shared<Base, Derived<1>>(1));
  objs.push_back(make_shared<Base, Derived<2>>(2));
  objs.push_back(make_shared<Base, Derived<3>>(3));
  // ... snip
  objs.push_back(make_shared<Base, Derived<57>>(57));
  objs.push_back(make_shared<Base, Derived<58>>(58));
  objs.push_back(make_shared<Base, Derived<59>>(59));
}
```


Using the `std::make_shared` version:


    jason@jason-VirtualBox:~$ /usr/bin/time g++ smaller_make_shared.cpp -std=c++11  -O3 -DUSE_STD && ls -al a.out
    3.95user 0.20system 0:04.16elapsed 99%CPU (0avgtext+0avgdata 255584maxresident)k
    0inputs+2384outputs (0major+74828minor)pagefaults 0swaps
    -rwxrwxr-x 1 jason jason 137580 Apr 25 20:48 a.out


My version:


    jason@jason-VirtualBox:~$ /usr/bin/time g++ smaller_make_shared.cpp -std=c++11  -O3  && ls -al a.out
    0.91user 0.04system 0:00.97elapsed 99%CPU (0avgtext+0avgdata 61828maxresident)k
    0inputs+736outputs (0major+23009minor)pagefaults 0swaps
    -rwxrwxr-x 1 jason jason 48361 Apr 25 21:02 a.out


The `std::make_shared` version is ~4.2x slower to compile, uses 4.1x more RAM and produces binaries which are 2.8x bigger.

For ChaiScript, which instantiates very many templates, this translates into 14% faster builds, 34% less RAM while compiling, 23% smaller builds, 2.8% faster runtimes and 13% less RAM usage at runtime.

This is all tested on g++4.8 on Ubuntu 14.04. I'm sure that other compilers and std library implementations will have different results. (MSVC 2015 CTP 4 shows about a 10% reduction in build sizes).

Is there something I'm missing here? Some either caveat or problem that has gone unnoticed? A real implementation would have to be slightly more complex with its allocations and exception handling, but should still significantly avoid the overhead of a full `shared_ptr` instantiation.
