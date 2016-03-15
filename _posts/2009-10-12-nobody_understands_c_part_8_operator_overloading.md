---
layout: blog_post
title: 'Nobody Understands C++: Part 8: Operator Overloading'
published: true
date: '2009-10-12 05:00:00'
redirect_from:
- content/nobody-understands-c-part-8-operator-overloading/
- node/4401/
- import_node/448/
tags:
- Programming
- Operator Overloading
- Nobody Understands C++
- C++
---

There has been much discussion over the years about the usefulness of operator overloading in C++ as well as the ability to get it right. 

In reality, it's hard to get it wrong as long as you follow the canonical forms of the operators and don't do unexpected things like overloade the `+` operator to perform a subtraction operation. Also, the types that your overloaded operators work with should be consistent. 

The canonical forms of the free function versions of the operators are as follows: 

```cpp
// Assignment operators:
Type &operator&=(Type &lhs, const Type &rhs); // Assign bitwise and
Type &operator^=(Type &lhs, const Type &rhs); // Assign exclusive or
Type &operator|=(Type &lhs, const Type &rhs); // Assign bitwise or
Type &operator-=(Type &lhs, const Type &rhs); // Assign difference
Type &operator<<=(Type &lhs, const Type &rhs); // Assign left shift
Type &operator*=(Type &lhs, const Type &rhs); // Assign product
Type &operator/=(Type &lhs, const Type &rhs); // Assign quotient
Type &operator%=(Type &lhs, const Type &rhs); // Assign remainder
Type &operator>>=(Type &lhs, const Type &rhs); // Assign right shift
Type &operator+=(Type &lhs, const Type &rhs); // Assign sum
//Other modification operators
Type &operator--(Type &lhs); // Prefix decrement - decrement and return new value
Type operator--(Type &lhs, int unused); // Postfix decrement - decrement and return copy of old value
Type &operator++(Type &lhs); // Prefix increment - increment and return new value
Type operator++(Type &lhs, int unused); // Postfix increment - increment and return copy of old value

//Comparison operators
bool operator==(const Type &lhs, const Type &rhs); // Equal
bool operator>(const Type &lhs, const Type &rhs); // Greater than
bool operator>=(const Type &lhs, const Type &rhs); // Greater than or equal
bool operator<(const Type &lhs, const Type &rhs); // less than
bool operator<=(const Type &lhs, const Type &rhs); // less than or equal
bool operator!(const Type &lhs); // logical complement
bool operator!=(const Type &lhs, const Type &rhs); // no equal

//Other operators
Type operator+(const Type &lhs, const Type &rhs); // Addition
Type operator+(const Type &lhs); // Unary plus
Type operator-(const Type &lhs, const Type &rhs) const; // Subtraction
Type operator-(const Type &lhs) const; // Unary minus
ContainedType* operator&(const Type &lhs); // Address of
Type operator&(const Type &lhs, const Type &rhs); // Bitwise and
Type operator~(const Type &lhs, const Type &rhs); // Bitwise complement
Type operator^(const Type &lhs, const Type &rhs); // Bitwise exclusive or
Type operator|(const Type &lhs, const Type &rhs); // Bitwise or
Type operator/(const Type &lhs, const Type &rhs); // Division
Type operator<<(const Type &lhs, const Type &rhs); // Left shift
Type operator*(const Type &lhs, const Type &rhs); // Multiplication
ContainedType &operator*(const Type &lhs); // Dereference
Type operator%(const Type &lhs, const Type &rhs); // Remainder
Type operator>>(const Type &lhs, const Type &rhs); // Right shift
```

Canonical forms of the member function versions of operator overloads: 

```cpp
class Type
{
  // Overloads which must be member functions
  ContainedType &operator[](const IndexType &index); // Array subscript
  Type &operator=(const Type &rhs); // Assignment
  ContainedType &operator->*(); // Member reference
  const ContainedType &operator->*() const; // Member reference
  ContainedType &operator->(); // Member reference
  const ContainedType &operator->() const; // Member reference
  // Assignment operators
  Type &operator&=(const Type &rhs); // Assign bitwise and
  Type &operator^=(const Type &rhs); // Assign exclusive or
  Type &operator|=(const Type &rhs); // Assign bitwise or
  Type &operator-=(const Type &rhs); // Assign difference
  Type &operator<<=(const Type &rhs); // Assign left shift
  Type &operator*=(const Type &rhs); // Assign product
  Type &operator/=(const Type &rhs); // Assign quotient
  Type &operator%=(const Type &rhs); // Assign remainder
  Type &operator>>=(const Type &rhs); // Assign right shift
  Type &operator+=(const Type &rhs); // Assign sum

  //Other modification operators
  Type &operator--(Type &lhs); // Prefix decrement - decrement and return new value
  Type operator--(Type &lhs, int unused); // Postfix decrement - decrement and return copy of old value
  Type &operator++(); // Prefix increment - increment and return new value
  Type operator++(int unused); // Postfix increment - increment and return copy of old value

  //Comparison operators
  bool operator==(const Type &rhs) const; // Equal
  bool operator>(const Type &rhs) const; // Greater than
  bool operator>=(const Type &rhs) const; // Greater than or equal  
  bool operator<(const Type &rhs) const; // Less than
  bool operator<=(const Type &rhs) const; // Less than or equal
  bool operator!=(const Type &rhs) const; // Not equal

  //Other operators
  Type operator+(const Type &rhs) const; // Addition
  Type operator+() const; // Unary plus
  Type operator-(const Type &rhs) const; // Subtraction
  Type operator-() const; // Unary minus
  ContainedType* operator&(); // Address of
  const ContainedType* operator&() const; // Address of
  Type operator&(const Type &rhs) const; // Bitwise and
  Type operator~(const Type &rhs) const; // Bitwise complement
  Type operator^(const Type &rhs) const; // Bitwise exclusive or
  Type operator|(const Type &rhs) const; // Bitwise or
  ContainedType &operator*(); // Dereference
  const ContainedType &operator*() const; // Dereference
  Type operator/(const Type &rhs) const; // Division
  Type operator<<(const Type &rhs) const; // Left shift
  bool operator!() const; // Logical complement
  Type operator*(const Type &rhs) const; // Multiplication
  Type operator%(const Type &rhs) const; // Remainder
  Type operator>>(const Type &rhs) const; // Right shift
};
```

*Note*: Assignment operations should always return a reference to the new value (typically, the code would be something like: `return *this;`). 

There are, of course, notable and somewhat reasonable exceptions to the canonical forms which are valid. 

For example, the "streaming" operator that the C++ standard library uses: 

```cpp
ostream &operator<<(ostream &os, const Type &out) {   
  return (os << out.to_string()); 
}
```

Or, for value types such as date types, it can make sense to not have the LHS, RHS or return types match for common operations: 

```cpp
Time_Duration operator-(const Date& lhs, const Date &rhs); 
Date operator-(const Date& lhs, const Time_Duration &rhs);
```

The following operators are explicitly left out of the above because they are either outside of the scope of this discussion, cannot be overloaded, or are dangerous / stupid to overload

  - `operator&&`
  - `operator||`
  - `operator,`
  - `.*`
  - `.`
  - `::`
  - `operator()`
  - `operator Type`
  - `operator new`
  - `operator delete`

  