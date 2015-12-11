---
layout: blog_post
title: 'Real World Haskell: Chapter 3'
published: true
date: '2009-01-26 11:23:57'
redirect_from:
- content/real-world-haskell-chapter-3/
- node/4333/
- import_node/358/
tags:
- Programming
- Haskell
- C++
- Book Reviews
---

Chapter 3 of [Real World Haskell](http://www.amazon.com/gp/product/0596514980?ie=UTF8&tag=empcra-20&linkCode=as2&camp=1789&creative=390957&creativeASIN=0596514980)![](http://www.assoc-amazon.com/e/ir?t=empcra-20&l=as2&o=1&a=0596514980) is "Defining Types, Streamlining Functions." At first glance Haskell seems to get stuck in it's own terseness, creating datastructures with no real structure, if you will. Haskell example: ` data BookInfo = Book Int String [String]                 deriving (Show)`

We see that a BookInfo is made up of int, string, array of string, but what does that *mean*? In an object orientated language like C++, we would have just enough verbosity to be able to apply some context to these data elements: ` struct BookInfo {   int id;   std::string title;   std::vector authors; };`

In fact, the next part makes my point via an example for type aliases, which are designed to make your code more descriptive: ` type CustomerID = Int type ReviewBody = String  data BetterReview = BetterReview BookInfo CustomerID ReviewBody`

Haskell "type" statements appear to be the same as a C++ typedef because they are not creating a new type, the alias and the original type are still equivalent. **Algebraic Types** Algebraic types are amazing. There have been times in C++ where I wish I could do something like this, but there has never really been a good way to, not even with boost::variant or boost::any. ` type CustomerID = Int type CustomerPhoneNumber = String  data CustomerLookupID = CustomerName String String | ID CustomerID | Phone CustomerPhoneNumber        deriving (Show)`

That is, a CustomerLookupID, can be a CustomerName, an ID or a Phone number. **Pattern Matching** I won't go too much into pattern matching here, but it is indeed similar to partial specialization of function templates in C++. The gist of it is that you can define the same function several different ways and the one that matches will be the one that is called at runtime. This makes sense and is very similar to the technique used for a template implementation of [Euclid's](/import_node/279) or the [Fibonacci sequence](/import_node/271). I was left with a bit of a question of about efficiency choices. For example, the book provides this summation example: ` sumList (x:xs) = x + sumList xs sumList []     = 0`

The first version of sumList matches a list, and splits out the head and the tail for you, at matching time. The second version matches and empty list and returns 0, to stop the recursion. How does that compare with this alternate implementation I came up with: ` sumList2 []     = 0 sumList2 (xs)   = head xs + sumList2 (tail xs)`

In my version, the empty list must be first, otherwise it will match an empty list and fail to "head" and "tail" it. But functionally, they are the same. **Record Syntax** Record syntax addresses the concerns I had previously about the simple "data" declaration, which does not provide context for the fields in the data type. ` type BookID = Int data Book = Book {        bookID :: BookID,        title :: String,        authors :: [String]        } deriving (Show)  book1 = Book { bookID = 52, title = "C++ In A Nutshell", Authors=["Ray Lischner"] }  --Print the ID of this book bookID book1`

All wrapped up in one handy place is a data record with built in accessor functions that are based on name, not position in the struct. **Where Clause** Haskell functions allow you to declare a where clause at the end of the function. Example: ` add100 value = value + toadd   where toadd = 100`

The where clause introduces new bindings. So, in this case, a new name "toadd" is created and the value 100 is assigned to it. As far as the flow of the code goes, this occurs *after* "toadd" is used. The authors indicate that this actually makes the code easier to read in many cases, and that one will miss it in languages that do not support it. I find this very difficult to accept. As I read the code above I think, "Wait, what is toadd? Where did it come from? What is its value?" And then as I read the next line I have further questions (as a part time SQL developer) and think "oh, this function only executes 'where toadd is 100.'" **Meaningful White Space and Explicit Structuring** Whitespace is meaningful in Haskell, which is not something I am used to. The rules come across as complicated, but seem to actually be quite simple: if the next line is indented relative to the preceding line it is part of that new code block. If it's at the same indentation of the preceding line, then it is not. Haskell does support the use of braces to indicate code blocks, but the author says that that is hardly ever used. Unfortunate. **Guards** Haskell guards are elegant and very helpful to making clean pattern matching code, and truly a feature that C++ templates could use. Although, I believe C++ template "concepts" will be similar. The example as provided by the author: ` niceDrop n xs | n <= 0 = xs niceDrop _ []          = [] niceDrop n (_:xs)      = niceDrop (n - 1) xs`

After only a few days of reading Haskell, this makes sense to me, and is clean at first glance.

1.  If n \<= 0 then drop nothing and return the list as it is
2.  Else, if the list is empty, nothing can be dropped, return the empty list
3.  Else, drop the first item, decrement n and recurse

