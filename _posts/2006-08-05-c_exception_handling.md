---
layout: blog_post
title: C++ Exception Handling
published: true
date: '2006-08-05 09:52:20'
redirect_from:
- content/c-exception-handling/
- node/4242/
- import_node/240/
tags:
- Programming
---

I ran across a question the other day that I didn't know the answer to, so I thought I would look it up. Namely: what happens to objects on the stack as a c++ exception is handled. Continue reading to find out.

    class YourClass {
    public:
      YourClass() {
        cout << "YourClass() Called" << endl;
      }
      ~YourClass() {
        cout << "~YourClass() Called" << endl;
      }
    };

    void DoStuff() {
      cout << "DoStuff entered" << endl;;
      MyClass m;

      try {
        YourClass y;
        cout << "Throwing int exception" << endl;
        throw (15);
        cout << "Exception thrown" << endl;
      } catch (int i) {
        cout << "int Exception caught " << i << endl;
      } catch (...) {
        cout << "unknown exception caught" << endl;
      }

      try {
        MyClass m2;
        cout << "Throwing MyClass exception" << endl;
        throw (&m2);
      } catch (MyClass *m) {
        //BZZT invalid pointer m!
        //(see the debug output destructor already called
        cout << "MyClass exception caught" << endl;
      } catch (...) {
        cout << "unkown exception caught" << endl;
      }

      cout << "DoStuff exiting" << endl;
    }

    int main(int, char *[])
    {
      cout << "main entered" << endl;

      DoStuff();

      cout << "main exiting" << endl;
    }

When main executes, the following is printed out:

    main entered
    DoStuff entered
    MyClass() Called
    YourClass() Called
    Throwing int exception
    ~YourClass() Called
    int Exception caught 15
    MyClass() Called
    Throwing MyClass exception
    ~MyClass() Called
    MyClass exception caught
    DoStuff exiting
    ~MyClass() Called
    main exiting

Notice that anything created on the stack inside the `try {}` block is popped off BEFORE `catch{}` gets called.
