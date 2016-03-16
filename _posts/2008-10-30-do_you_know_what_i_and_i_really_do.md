---
layout: blog_post
title: Do You Know What ++i And i++ Really Do?
published: true
date: '2008-10-30 21:44:52'
redirect_from:
- content/do-you-know-what-i-and-i-really-do/
- node/4313/
- import_node/329/
- node/329/
tags:
- Programming
- Articles
- C
- Perl
- Javascript
- Java
- PHP
---

An interviewer who thinks he is being clever might present you with a code sample like the following and ask you what the output would be:

```C
//C
#include <stdio.h>
void dosomething(int i, int j, int k, int l)
{
  printf("%d, %d, %d, %d\n", i,j,k,l);
}

int main(int argc, char **argv)
{
  int i =1;
  dosomething(i++, ++i, i++, ++i);

  i = 1;
  printf("%d\n", i++ + ++i + i++ + ++i);

  i = 1;
  printf("%d\n", (i++) + (++i) + (i++) + (++i));
}
```

You understand what the difference is between the pre and post incrementers, so you say:

> 1, increment, increment, 3, 3, increment, increment, 5

Then you say, "well, the next two should just be 1 + 3 + 3 + 5 = 12."

The answer seems to depend on which language you ask, ultimately.

The output from the above C program (with GCC on Linux) is:

> 4, 5, 2, 5
> 9
> 9

**It's Undefined**

The fact is, most languages specify that using a variable more than once in a statement with an increment or decrement operator has undefined results.

C and Perl show very unexpected output, while PHP, Javascript and Java all show the output that a human might come up with.

The bottom line is: don't do it, it's a Bad Idea.

Additional Language Outputs


```javascript
//Javascript
function dosomething( $i, $j, $k, $l ) {
         print($i, $j, $k, $l );
}
$i = 1;
dosomething( $i++, ++$i, $i++, ++$i );

$i = 1;
print($i++ + ++$i + $i++ + ++$i);

$i = 1;
print(($i++) + (++$i) + ($i++) + (++$i));
```

> 1 3 3 5
> 12
> 12


```java
//Java
class PrePostIncrement
{
  public static void doSomething(int i, int j, int k, int l)
  {
    System.out.println(i + ", " + j + ", " + k + ", " + l);
  }
  public static void main(String[] args)
  {
    int i = 1;
    doSomething(i++, ++i, i++, ++i);

    i = 1;
    System.out.println(i++ + ++i + i++ + ++i);

    i = 1;
    System.out.println((i++) + (++i) + (i++) + (++i));
  }
}
```

> 1, 3, 3, 5
> 12
> 12



```perl
#!/usr/bin/perl
use strict;
sub dosomething {
         print join( ', ', @_ ), "\n";
}

my $i = 1;
dosomething( $i++, ++$i, $i++, ++$i );

$i = 1;
print ($i++ + ++$i + $i++ + ++$i);
print "\n";

$i = 1;
print ($i++) + (++$i) + ($i++) + (++$i);
print "\n";
```

> 1, 5, 3, 5
> 12
> 1


```php
<?php
function dosomething( $i, $j, $k, $l ) {
         printf( "%d, %d, %d, %d\n", $i, $j, $k, $l );
}
$i = 1;
dosomething( $i++, ++$i, $i++, ++$i );

$i = 1;
printf("%d\n", $i++ + ++$i + $i++ + ++$i);

$i = 1;
printf("%d\n", ($i++) + (++$i) + ($i++) + (++$i));
?>
```

> 1, 3, 3, 5
> 12
> 12
