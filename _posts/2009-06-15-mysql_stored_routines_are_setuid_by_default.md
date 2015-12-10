---
layout: blog_post
title: MySQL Stored Routines are setuid By Default
published: true
date: '2009-06-15 05:00:00'
redirect_from:
- content/mysql-stored-routines-are-setuid-default
- node/4390
- import_node/431
tags:
- Security
- MySQL
---

By default, all views and stored routines in MySQL run with the privileges of the definer, not the invoker. This is equivalent to the [setuid bit](http://en.wikipedia.org/wiki/Setuid) in Unix. In the case where you need to provide execute permissions to stored routines (via EXECUTE) to a read-only user, it is possible to inadvertantly give your read-only user the ability to modify data. If the user has access to a stored routine that modifies data, then the user will be able to modify data. If you provide the optional attribute "SQL SECURITY INVOKER" when creating the view or routine, MySQL will honor the permissions of the caller, not the definer, and restore the expected security model.
