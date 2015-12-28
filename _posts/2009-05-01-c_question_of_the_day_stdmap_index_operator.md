---
layout: blog_post
title: 'C++ Question of the Day: std::map index operator'
published: true
date: '2009-05-01 05:00:00'
redirect_from:
- content/c-question-day-stdmap-index-operator/
- node/4378/
- import_node/423/
tags:
- Question of the Day
- Programming
- C++
---

Jon asks:

> If I have a: `std::map<std::string, int> x` can I do: `x["bob"].push_back(2)`?

Yes, you can. The result of `x["bob"]` is an `std::vector &` If the particular key you are trying to access does not exist yet, it is created first. 

According to [C++ in a Nutshell](http://www.amazon.com/gp/product/059600298X?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=059600298X)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=059600298X) (pg 607) the definition of `map<>::operator[]` is: `(*((insert(std::make_pair(x, T(  )))).first)).second`. 

This means a few things. First of all, there is additional overhead with using `operator[]`. It must create a T with its default constructor and attempt to insert it. The `map<>::insert` method attempts the insert of the new object. If the key already exists, the existing object is returned. If not, the newly added object is returned. So, to use `map<>::operator[]` effectively, our contained type must have a default constructor and must be assignable. Also, because the index operator attempts an insert, there is no const version of the method. Therefor, you cannot use the index operator on a const map. 

It would have been possible to create a const version using a method like this: 

```cpp
const value_type &operator[](const key_type &t_key) const {   
  const_iterator itr = find(t_key);   
  if (itr == end()) {     
    throw std::out_of_range("Key does not exist");   
  } else {    
    return itr->second;   
  }
}
```

Alas, the creators of the standard library did not provide this method. My guess is that it is because of the different behavior (one may throw an exception, the other does not) and the different costs between the two methods.

**Note, C++11 adds a similar function called `std::map<>::at` now**
