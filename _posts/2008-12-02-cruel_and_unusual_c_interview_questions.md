---
layout: blog_post
title: Cruel and Unusual C++ Interview Questions
published: true
date: '2008-12-02 14:00:42'
redirect_from:
- content/cruel-and-unusual-c-interview-questions/
- node/4321/
- import_node/346/
- node/346/
tags:
- Interviewing
- C++
---

I do not, contrary to the opinions of some ([rather weepy](/content/c-inheritance-access-specifiers-previously-types-c-inheritance#comment-6266)) [individuals](/content/c-inheritance-access-specifiers-previously-types-c-inheritance#comment-6240), ask interview questions like, "name the types of C++ inheritance" then flog the interviewee for saying "virtual, non-virtual, single, multiple," because I was expecting "public, private, protected." Indeed, it's been more than two years since I last had the opportunity to interview, but when I did, I made sure of two things:

1.  I always knew I had fully researched the answer before asking the question.
2.  I avoided too many specific questions and instead tried to get the interviewee talking about past projects.

**What I Was Looking For** 

See, I am less interested in recommending someone for hire who has a bunch of facts memorized and more interested in hiring someone who took on self study learning. For instance, we were a Linux shop, so I would ask the person being interviewed about his or her favorite distro. If he didn't have a favorite Linux distribution, or at least hold a conversation about the various ones out there, that told me that he had not really spent any time playing and learning on his own. That is a specific example that came up a few times, but isn't necessarily fair in all cases. 

**Questions I Would Ask** 

I would probe the person being interviewed to see the depths of knowledge and skills. A favorite C++ question I asked in the last few interview I did was: *"Give me a generic C++ function that will return the max of any two values of the same type given to it."* I got exactly 0 people who mentioned the obvious (and broken) C macro: 

```cpp
#define MAX(i,j) (i>j?i:j)
```

Not a single person mentioned the typesafe C++ way of doing it with a template. Actually, not a single person even mentioned the WORD template during an entire interview. Well, maybe one candidate did. 

```cpp
template<typename T>  
const T& max(const T& left, const T& right) {   
  return left>right?left:right; 
}
```

I would have ended the interview and recommended a hire on the spot for any candidate who said: *"Well, you could just use `std::max<>`"* Maybe it was just the people we were bringing in for interviews, but it was the level of question I needed to ask. 

**Cruel and Unusual Questions** 

I did have one guy interview who put "C++ Guru" on his resume. I went digging for some harder questions to ask him. He actually did well, but we didn't hire him. I'm not sure I remember why now. These are the questions I wouldn't ask, they are probably generally unfair, as knowing specific little details is not a good measure of the growth the developer might have. *"What are the advantages and disadvantages of ADL ([Argument Dependant Lookup](http://en.wikipedia.org/wiki/Argument_dependent_name_lookup))?"* I would look for something like:

**Advantages**

Because of ADL code like: `std::cout << "hello world" << std::endl` can compile because the compiler can find `operator<<(ostream &, const char*)` in the namespace std automatically.

**Disadvantages**

ADL can cause unexpected results if the compiler finds a templated operator in a related namespace. (There are other criticisms on the wikipedia page I was not aware of.)

*"What is the use of virtual inheritance and when would you want it?"*

**What Is It?**

Virtual inheritance ensures that the same base class appearing two or more times in an inheritance graph has all of its instances merged.

**When would you want it?**

Probably anytime you have a diamond in your inheritance graph, but the details are up to the specific object model in question. It's possible you actually want separate instances of each base class. Better answer: "You should probably simplify your object model to eliminate diamonds and rely more on generic/functional programming."

*"What does `int i=0; printf("%i %i", ++i, i);` print?"*

Answer: The use of pre/post increment on the same statement as another use of the same variable is [undefined](/content/do-you-know-what-i-and-i-really-do), don't do it.

*"Describe for me the CRTP ([Curiously Recurring Template Pattern](http://en.wikipedia.org/wiki/Curiously_Recurring_Template_Pattern)) and give me an example of its usage."*

Answer: The CRTP is where a base class is given knowledge of a derived class via templates. Example: 

```cpp
//We can use the CRTP to allow the Base class to call a method of the derived class
//without incurring any virtual function call overhead
template<typename T>
class Base
{
  public:
    // Provide a <= operator to classes with < and ==
    bool operator<=(const T& right) const
    {
      const T &left = static_cast<const T &>(this);
      return left < right || left == right;
    }
};
class Derived : public Base<Derived>
{
  private:
    int m_val;

  public:
    Derived(int t_val)
        : m_val(t_val)  
    {                 
    }
    
    bool operator==(const Derived &t_right) const
    {
      return m_val == t_right.m_val;
    }

    bool operator<(const Derived &t_right) const
    {
      return m_val < t_right.m_val;
    }
};
```

**Maybe These are Reasonable Question Where You Work** 

If so, then by all means, but I had to verify a couple of the questions.
