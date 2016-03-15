---
layout: blog_post
title: Trigraphs, Digraphs and Alternative Tokens
published: true
date: '2012-02-13 08:29:41'
redirect_from:
- content/trigraphs-digraphs-and-alternative-tokens/
- node/4419/
- import_node/472/
tags:
- C++
- Programming
---

Quick, which language is the following code written in?

    %:include 

    int main(int, char *argv<:??))
    <%
      int i = 0;
      int j = 0;

      for (; i < 10 and j < 11; ++i, ++j) ??< 
        std::cout << not (i bitand j) << std::endl;
      %>
    ??>

If you guessed standard C++, you'd be correct. C and C++ support a set of alternative tokens and character sequences to account for languages and keyboards that do not have easy access to characters that those of us with US keyboards consider to be normal. 

**Trigraph Sequences** 

The trigraph replacements are performed before any other part of the parsing process. 

 * `??=` becomes `#` 
 * `??(` becomes `[` 
 * `??<` becomes `{` 
 * `??/` becomes `\` 
 * `??)` becomes `]` 
 * `??>` becomes `}` 
 * `??’` becomes `ˆ` 
 * `??!` becomes `|` 
 * `??-` becomes `∼` 
  
**Bigraphs and Alternative Tokens** 

 * Alternative: `<%` primary: `{` 
 * Alternative: `%>` primary: `}` 
 * Alternative: `<:` primary: `[` 
 * Alternative: `:>` primary: `]` 
 * Alternative: `%:` primary: `#` 
 * Alternative: `%:%:` primary: `##` 
 * Alternative: `bitor` primary: `|` 
 * Alternative: `or_eq` primary: `|=` 
 * Alternative: `and` primary: `&&` 
 * Alternative: `and_eq` primary: `&=` 
 * Alternative: `or` primary: `||` 
 * Alternative: `xor_eq` primary: `ˆ=` 
 * Alternative: `xor` primary: `ˆ` 
 * Alternative: `not` primary: `!` 
 * Alternative: `compl` primary: `∼` 
 * Alternative: `not_eq` primary: `!=` 
 * Alternative: `bitand` primary: `&` 

**Translation of Example** 

Our example above now becomes:

    #include <iostream>

    int main(int, char *argv[]))
    {
      int i = 0;
      int j = 0;

      for (; i < 10 && j < 11; ++i, ++j) { 
        std::cout << ! (i & j) << std::endl;
      }
    }

What does this gain you? Nothing really. Even though trigraphs are a part of the standard most compilers require a switch to enable them! However, this information might help you work on your next [IOCCC](http://www.ioccc.org/) entry. Stackoverflow has more complete discussions on both [trigraphs](http://stackoverflow.com/questions/1234582/purpose-of-trigraph-sequences-in-c) and [digraphs](http://stackoverflow.com/questions/432443/why-are-there-digraphs-in-c-and-c).
