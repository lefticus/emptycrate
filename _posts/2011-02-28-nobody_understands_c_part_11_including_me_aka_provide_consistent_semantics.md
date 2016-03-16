---
layout: blog_post
title: 'Nobody Understands C++: Part 11: Including Me (aka, Provide Consistent Semantics)'
published: true
date: '2011-02-28 20:11:10'
redirect_from:
- content/nobody-understands-c-part-11-including-me-aka-provide-consistent-semantics/
- node/4414/
- import_node/467/
- node/467/
tags:
- Nobody Understands C++
- C++
- Me
---


I just spent the better part of the day debugging an insidious little bug. It really shouldn't have taken that long... I even had unit tests in place that covered the code in question! Right!?

The fact is, C++ is a complex language and getting every detail right all the time can be hard. In this case I had a simple class with a boost::shared_ptr in it. In the copy constructor I wanted to clone the pointed to object, but needed to keep the pointer for other house keeping reasons.

```cpp
class MyClass
{
public:
  MyClass(const MyClass &t_other)
    : m_ptr(new MyClassImpl(*m_ptr)) // make a copy of the internal element
  {
  }
  bool operator==(const MyClass &t_rhs) const;

private:
  class MyClassImpl
  {
  };

  boost::shared_ptr<MyClassImpl> m_ptr;
};
```

*Bonus points to anyone who already sees the mistake I made. Go ahead, take a minute if you need it.*

My unit tests took the fact that I had implemented my own copy constructor into account.

```cpp
void TestCopy
{
  MyClass m1;
  MyClass m2(m1);
  ASSERT_TRUE(m1 == m2);
  
  m1.modifyObject();

  ASSERT_FALSE(m1 == m2);
}
```

Create an object, call the copy constructor, modify object and make sure they are actually different - that the data is not shared... Pass!

However, the actual use case in the production code was slightly different:

```cpp
MyClass m = getAMyClass();
```

It's an often not appreciated fact that the compiler may and will often convert the above into:

```cpp
MyClass m(getAMyClass());
```

This optimization is allowed by the standard and is taken in every case that I am aware of. (There's at least one discussion of it on [stack overflow](http://stackoverflow.com/questions/2462773/c-copy-construct-construct-and-assign-question).) Because I was aware of this optimization by the compiler, I was confident in my code and how it was being used.

None the less, I had a problem. The code was failing certain more complex test cases in g++ debug and release builds as well as MSVC++ release builds, but passing in Windows debug builds. I was flabbergasted. After several hours of debugging what "couldn't possibly be" a bug where data was shared between 2 MyClass objects, I finally added another unit test.

```cpp
void TestCopy
{
  MyClass m1;
  MyClass m2 = m1;
  ASSERT_TRUE(m1 == m2);
  
  m1.modifyObject();

  ASSERT_FALSE(m1 == m2);
}
```

This test also passed. I was correct - all current compilers took the optimization and applied a simple copy construction. But what was wrong with my code? Why did it still fail on most platforms in the more complex case? I had to resort to adding one more unit test:

```cpp
void TestCopy
{
  MyClass m1;
  MyClass m2;
  m2 = m1;
  ASSERT_TRUE(m1 == m2);
  
  m1.modifyObject();

  ASSERT_FALSE(m1 == m2);
}
```

Aha! Now I had the failing unit test I was looking for. I had failed to heed the warnings of #53 of C++ Coding Standards: "Explicitly enable or disable copying." Essentially, if you have the need need to implement the copy constructor, implement the assignment operator too. If you use the compiler generated version of one, use the compiler generated version of the other. If you explicitly disable one, disable the other too.

I don't know exactly which portion of the code had an explicit or somehow implicit assignment. I still don't know why it changed depending on build type either. There's possibly some optimization that the compiler is allowed to perform to convert one to the other that I'm not aware of?

Regardless, it's critical that you provide your users with consistent semantics for your code. Having assignment behave differently than copy construction is almost certainly not what the user is expecting.

The lessons learned are:

 1. Make your copy and assignment semantics consistent.
 2. Always use unit tests. They are invaluable. They save time in the long run and help prove to your client that you fixed the bug in question.
 
 







I just spent the better part of the day debugging an insidious little bug. It really shouldn't have taken that long... I even had unit tests in place that covered the code in question! Right!? The fact is, C++ is a complex language and getting every detail right all the time can be hard. In this case I had a simple class with a `boost::shared_ptr` in it. In the copy constructor I wanted to clone the pointed to object, but needed to keep the pointer for other house keeping reasons. ` class MyClass { public:   MyClass(const MyClass &t_other)     : m_ptr(new MyClassImpl(*m_ptr)) // make a copy of the internal element   {   }    bool operator==(const MyClass &t_rhs) const;  private:   class MyClassImpl   {   };    boost::shared_ptr m_ptr; };`

*Bonus points to anyone who already sees the mistake I made. Go ahead, take a minute if you need it.* My unit tests took the fact that I had implemented my own copy constructor into account. ` void TestCopy {   MyClass m1;   MyClass m2(m1);    ASSERT_TRUE(m1 == m2);      m1.modifyObject();    ASSERT_FALSE(m1 == m2); }`

Create an object, call the copy constructor, modify object and make sure they are actually different - that the data is not shared... Pass! However, the actual use case in the production code was slightly different: ` MyClass m = getAMyClass();`

It's an often not appreciated fact that the compiler may and will often convert the above into: ` MyClass m(getAMyClass());`

This optimization is allowed by the standard and is taken in every case that I am aware of. (There's at least one discussion of it on [stack overflow](http://stackoverflow.com/questions/2462773/c-copy-construct-construct-and-assign-question).) Because I was aware of this optimization by the compiler, I was confident in my code and how it was being used. None the less, I had a problem. The code was failing certain more complex test cases in g++ debug and release builds as well as MSVC++ release builds, but passing in Windows debug builds. I was flabbergasted. After several hours of debugging what "couldn't possibly be" a bug where data was shared between 2 MyClass objects, I finally added another unit test. ` void TestCopy {   MyClass m1;   MyClass m2 = m1;    ASSERT_TRUE(m1 == m2);      m1.modifyObject();    ASSERT_FALSE(m1 == m2); }`

This test also passed. I was correct - all current compilers took the optimization and applied a simple copy construction. But what was wrong with my code? Why did it still fail on most platforms in the more complex case? I had to resort to adding one more unit test: ` void TestCopy {   MyClass m1;   MyClass m2;   m2 = m1;    ASSERT_TRUE(m1 == m2);      m1.modifyObject();    ASSERT_FALSE(m1 == m2); }`

Aha! Now I had the failing unit test I was looking for. I had failed to heed the warnings of \#53 of C++ Coding Standards: "Explicitly enable or disable copying." Essentially, if you have the need need to implement the copy constructor, implement the assignment operator too. If you use the compiler generated version of one, use the compiler generated version of the other. If you explicitly disable one, disable the other too. I don't know exactly which portion of the code had an explicit or somehow implicit assignment. I still don't know why it changed depending on build type either. There's possibly some optimization that the compiler is allowed to perform to convert one to the other that I'm not aware of? Regardless, it's critical that you provide your users with consistent semantics for your code. Having assignment behave differently than copy construction is almost certainly not what the user is expecting. The lessons learned are:

1.  Make your copy and assignment semantics consistent.
2.  Always use unit tests. They are invaluable. They save time in the long run and help prove to your client that you fixed the bug in question.

