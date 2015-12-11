---
layout: blog_post
title: Creating Bad Code That's Still Great
published: true
date: '2009-03-19 15:10:20'
redirect_from:
- content/creating-bad-code-thats-still-great/
- node/4349/
- import_node/375/
tags:
- Programming
- Articles
---

There are plenty of opinions out there about how to write great code ranging from styles and techniques to code formatting and programming languages. Inevitably when discussing great code someone will say, "But what if you need code **right now**, and you are willing to sacrifice quality in order to get work done faster?" Which raises the question, "How do I write Bad Code... that's still great?" I believe this question also comes up when you are first investigating a new problem domain that you have no experience with. In this situation you will almost certainly write Bad Code the first time through, there is no way around it. I say the answer to these problems is simple: *Insulate yourself from your bad code.* If you are getting ready to write some Bad Code, write code that has no interactions at all with the rest of the system. Totally avoid using:

-   Global Data
-   Module Level Data
-   Shared data of any kind

Insist that all inputs you use are passed to you and that you do not provide any shared data yourself. Either provide a single return value from your function or a set of accessors to your new Bad class. It's a single rule: Put your Bad Code in complete isolation from the rest of your code. By following this rule you create a function/module/class that can be completely swapped out if it's ever determined that it is causing problems. This begs the question, "Why not always write isolated code with no side effects?" Which is a great question; if we always program as if we are writing Bad Code we create code that is testable, modular, replaceable, aggregratable and all the good -ables. *This is the single greatest contribution of functional programming languages to Computer Science.* In a language such as Haskell it is impossible to create side effects, even going so far as to require you to warn the compiler if you are going to access something external to the application itself. If you ever come across an article talking about how LISP saved the day and allowed the developers to create a huge application in 1/10 the time that another language would allow, what you are really reading is: *LISP allowed me to write Bad Code until the cows came home... without hurting my team member's productivity.*
