---
layout: blog_post
title: 'Nobody Understands C++: Part 6: Are You Still Using Pointers?'
published: true
date: '2009-01-02 00:50:25'
redirect_from:
- content/nobody-understands-c-part-6-are-you-still-using-pointers/
- node/4325/
- import_node/354/
tags:
- Nobody Understands
- C++
- Programming
- Pointers
- Articles
---

*2014-04-12 Note: the `boost::shared_ptr` comments apply to `std::shared_ptr` in c++11 as well* It is best to avoid using pointers in C++ as much as possible. The use of pointers can lead to confusion of ownership which can directly or indirectly lead to memory leaks. Even if object ownership is well managed simple (and difficult to find) bugs can also lead to memory leaks. *Security Risks* Also, by avoiding the use of pointers we can avoid and sometimes eliminate common security holes such as buffer overruns. See the last example for more information about this. *Examples* Common instances were pointer usage can be avoided: **Passing an Object to Be Edited** ` //Pointer way void SetSomeParam(SomeObject *o) {   o->someParam(0); }  //Reference way, avoiding pointers: void SetSomeParam(SomeObject &o) {   o.someParam(0); }`

**Complex Member Object Initialization** ` //Pointer way class MyClass {   private:     ComplexType *ct;    public:     MyClass(std::string param1, std::string param2, int param3)     {       ct = new ComplexType(param2, param2);     }     ~MyClass()     {       delete ct;     } };  // Member initialization list way class MyClass {   private:     ComplexType ct;    public:     MyClass(std::string param1, std::string param2, int param3)       : ct(param1, param2) // Call the ComplexType constructor with the params we want     {     }     ~MyClass()     {       // Nothing to do     } };  `

**Returning an Editable Member**

    //Pointer way
    //This is where I often think there is a confusion of ownership introduced
    class MyClass
    {
      private:
        int i;
      
      public:
        const int * getI() const //const version
        {
          return &i;
        }

        int * getI() //non-const version
        {
          return &i;
        }
    };

    //Reference way
    class MyClass
    {
      private:
        int i;
      
      public:
        const int & getI() const //const version
        {
          return i;
        }

        int & getI() //non-const version
        {
          return i;
        }
    };

**Simple Object Construction** With some object creation methods where the object type is known at compile time, we can avoid using pointers because the compiler can optimize away object copies and no performance is lost.

    struct Pixel
    {
      int x;
      int y;
      double r;
      double g;
      double b;

      Pixel(int t_x, int t_y, double t_r, double t_g, double t_b)
        : x(t_x), y(t_y), r(t_r), g(t_g), b(t_b)
      {
      }
    };

    //Pointer way
    Pixel *MakePixel(int t_x, int t_y)
    {
      //Oops, who owns the returned pixel again?
      // better not forget to delete it.
      return new Pixel(t_x, t_y, double(t_x)/double(t_y), double(t_y)/double(t_x), 0.0);
    }

    //Copy on return way
    Pixel MakePixel(int t_x, int t_y)
    {
      //Most compilers optimize away the copy, and no chance of a memory leak
      return Pixel(t_x, t_y, double(t_x)/double(t_y), double(t_y)/double(t_x), 0.0);
    }

**Factory Methods** There are times where you cannot avoid using "new" to construct an object, such as with factory methods. There are also times when you want to share data between objects and the only way to do that is with a pointer. In such cases you should use smart pointers and reference counted pointers that can automatically delete an object when it is no longer in use.

    //Naked pointer method
    //This can lead to memory leaks if we are not careful
    BaseClass *CreateObject(ObjectType type)
    {
      switch(type)
      {
        case Type1:
          return new DerivedType1;
        case Type2:
          return new DerivedType2;
      }
    }

    // boost::shared_ptr way, which is reference counted.
    // no chance for memory leaks
    boost::shared_ptr CreateObject(ObjectType type)
    {
      switch(type)
      {
        case Type1:
          return new boost::shared_ptr(DerivedType1);
        case Type2:
          return new boost::shared_ptr(DerivedType2);
      }
    }

**Dynamic Buffers and Legacy Code Interaction** What about the case where you need a dynamically allocated blob of bytes? Like, for instance, working with some legacy C code that expects dynamically allocated buffers. For these cases we can use std::vector to help us out. An std::vector's data is guaranteed to be allocated contiguously, so we can treat it like an array pointer when we need to.

    //Pointer way
    //Who owns the returned pointer again?
    char *ReadData(int size)
    {
      char *buf = new char[size];
      get_data(buf, size); // legacy C call that we don't control
      return buf;
    }

    //std::vector way
    //With this method there is no question of memory leaks, no question ownership
    //and a buffer overrun or other possible security risk is extremely unlikely
    //notice that we pass buf.size() into the get_data function? By doing this we guaranty
    //that the right size is passed to the legacy function even if there was not sufficient memory
    //to allocate the buffer we requested.
    std::vector ReadData(int size)
    {
      std::vector buf(size);
      get_data(&buf.front(), buf.size());
      return buf;
    }

**Conclusion** The advantages to not using pointers are clear: fewer bugs and fewer security concerns. For me, the best way that I learned to avoid using them was to ask myself the question, "how can I avoid using a pointer here?" each time I found myself wanting to use one. Hopefully these examples will give you some ideas.
