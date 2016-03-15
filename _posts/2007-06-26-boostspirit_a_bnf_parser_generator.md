---
layout: blog_post
title: 'Boost::Spirit: A BNF Parser Generator'
published: true
date: '2007-06-26 20:57:19'
redirect_from:
- content/boostspirit-bnf-parser-generator/
- node/4286/
- import_node/266/
tags:
- Programming
- C++
- Boost
---

The boost spirit library allows for direct translation of a BNF grammar into C++ code which generates a parser at compile time. The following example, from http://spirit.sourceforge.net/distrib/spirit_1_8_3/libs/spirit/doc/introduction.html truly does this concept more justice than I could: BNF Example:

    group      ::= '(' expression ')'
    factor     ::= integer | group
    term       ::= factor (('*' factor) | ('/' factor))*
    expression ::= term (('+' term) | ('-' term))*

Translation to boost::spirit:

    group      = '(' >> expression >> ')';
    factor     = integer | group;
    term       = factor >> *(('*' >> factor) | ('/' >> factor));
    expression = term >> *(('+' >> term) | ('-' >> term));

A very simple (and complete) example that I have written shows you how to parse a simple dotted name value pair.

    #include <boost/spirit.hpp>
    #include <boost/spirit/actor/clear_actor.hpp>
    #include <string>
    #include <vector>
    #include <iostream>
    #include <boost/function.hpp>
    #include <boost/bind.hpp>

    using namespace std;
    using namespace boost::spirit;

    void myaction(vector &v, int &lastlen, 
      const char *begin, const char * end)
    {
      string str(begin,end);
      if (!str.empty()) {
        v.clear();
        v.push_back(str);
        lastlen = 0;
      } else {
        v.resize(lastlen);
      }
    }

    bool parse_entries(char const* str, 
      vector& v, string &value)
    {
      static int lastlen = 0;
      if (lastlen == 0) {
        lastlen = v.size();
      }
      return parse(str,

      //  Begin grammar
      (
        (!(+alpha_p))[boost::bind(&myaction, boost::ref(v), boost::ref(lastlen), _1, _2)] 
          >> *('.' >> (+alpha_p)[push_back_a(v)]) 
          >> !('=' >> (+(~ch_p('\n')))[assign_a(value)])
      )
      ,
      //  End grammar
      space_p).full;
    }

    int main()
    {
      vector input;
      input.push_back("black.abba.baab.bob");
      input.push_back(".cat = 52 woot woot");
      input.push_back(".dog= 23");
      input.push_back("chicken = 42");

      vector v;

      for (vector::const_iterator itr2 
             = input.begin();
           itr2!=input.end();
           itr2++) 
      {
        string value;
        parse_entries(itr2->c_str(), v, value);

        for (vector::const_iterator itr 
               = v.begin();
             itr != v.end();
             itr++)
        {
          cout << *itr << endl;
        }

        cout << value << endl << endl;
      }
    }

In this example if the input begins with a '.' the context for the key name is maintained from the last entry. Go ahead and give it a go.
