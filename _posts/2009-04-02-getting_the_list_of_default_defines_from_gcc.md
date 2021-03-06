---
layout: blog_post
title: 'Getting the List of Default #define''s From GCC'
published: true
date: '2009-04-02 05:00:00'
redirect_from:
- content/getting-list-default-defines-gcc/
- node/4357/
- import_node/390/
- node/390/
tags:
- Programming
- GCC
- C++
- C
---

Most of the postings I make to this website are for my own personal reference. They are things that I want to make sure I don't forget, or at least have easy access to. Today is no exception. For some reason, I can never remember the following command and have to track it down every time I'm interested. 

```
echo "" | cpp -dD
```

This prints out all of the `#define`'s that GCC is providing for you. In some ways it's a fascinating little look inside the compiler. On mingw-gcc 3.4.5 you get the following: 

```cpp
# 1 "" 
# 1 "" 
#define __STDC_HOSTED__ 1 
#define __GNUC__ 3 
#define __GNUC_MINOR__ 4 
#define __GNUC_PATCHLEVEL__ 5 
#define __SIZE_TYPE__ unsigned int 
#define __PTRDIFF_TYPE__ int 
#define __WCHAR_TYPE__ short unsigned int 
#define __WINT_TYPE__ short unsigned int 
#define __GXX_ABI_VERSION 1002 
#define __USING_SJLJ_EXCEPTIONS__ 1 
#define __SCHAR_MAX__ 127 
#define __SHRT_MAX__ 32767 
#define __INT_MAX__ 2147483647 
#define __LONG_MAX__ 2147483647L 
#define __LONG_LONG_MAX__ 9223372036854775807LL 
#define __WCHAR_MAX__ 65535U 
#define __CHAR_BIT__ 8 
#define __FLT_EVAL_METHOD__ 2 
#define __FLT_RADIX__ 2 
#define __FLT_MANT_DIG__ 24 
#define __FLT_DIG__ 6 
#define __FLT_MIN_EXP__ (-125) 
#define __FLT_MIN_10_EXP__ (-37) 
#define __FLT_MAX_EXP__ 128 
#define __FLT_MAX_10_EXP__ 38 
#define __FLT_MAX__ 3.40282347e+38F 
#define __FLT_MIN__ 1.17549435e-38F 
#define __FLT_EPSILON__ 1.19209290e-7F 
#define __FLT_DENORM_MIN__ 1.40129846e-45F 
#define __FLT_HAS_INFINITY__ 1 
#define __FLT_HAS_QUIET_NAN__ 1 
#define __DBL_MANT_DIG__ 53 
#define __DBL_DIG__ 15 
#define __DBL_MIN_EXP__ (-1021) 
#define __DBL_MIN_10_EXP__ (-307) 
#define __DBL_MAX_EXP__ 1024 
#define __DBL_MAX_10_EXP__ 308 
#define __DBL_MAX__ 1.7976931348623157e+308 
#define __DBL_MIN__ 2.2250738585072014e-308 
#define __DBL_EPSILON__ 2.2204460492503131e-16 
#define __DBL_DENORM_MIN__ 4.9406564584124654e-324 
#define __DBL_HAS_INFINITY__ 1 
#define __DBL_HAS_QUIET_NAN__ 1 
#define __LDBL_MANT_DIG__ 64 
#define __LDBL_DIG__ 18 
#define __LDBL_MIN_EXP__ (-16381) 
#define __LDBL_MIN_10_EXP__ (-4931) 
#define __LDBL_MAX_EXP__ 16384 
#define __LDBL_MAX_10_EXP__ 4932 
#define __DECIMAL_DIG__ 21 
#define __LDBL_MAX__ 1.18973149535723176502e+4932L 
#define __LDBL_MIN__ 3.36210314311209350626e-4932L 
#define __LDBL_EPSILON__ 1.08420217248550443401e-19L 
#define __LDBL_DENORM_MIN__ 3.64519953188247460253e-4951L 
#define __LDBL_HAS_INFINITY__ 1 
#define __LDBL_HAS_QUIET_NAN__ 1 
#define __REGISTER_PREFIX__  
#define __USER_LABEL_PREFIX__ _ 
#define __VERSION__ "3.4.5 (mingw-vista special r3)" 
#define __NO_INLINE__ 1 
#define __FINITE_MATH_ONLY__ 0   
#define __i386 1 
#define __i386__ 1 
#define i386 1 
#define __tune_i686__ 1 
#define __tune_pentiumpro__ 1 
#define _X86_ 1  
#define __stdcall __attribute__((__stdcall__)) 
#define __fastcall __attribute__((__fastcall__)) 
#define __cdecl __attribute__((__cdecl__)) 
#define __declspec(x) __attribute__((x)) 
#define _stdcall __attribute__((__stdcall__)) 
#define _fastcall __attribute__((__fastcall__)) 
#define _cdecl __attribute__((__cdecl__)) 
#define __MSVCRT__ 1 #define __MINGW32__ 1 
#define _WIN32 1 
#define __WIN32 1 
#define __WIN32__ 1 
#define WIN32 1 
#define __WINNT 1 
#define __WINNT__ 1 
#define WINNT 1 
# 1 "" 
# 1 ""`
```

I honestly have very little idea what most of these would be useful for, but it's interesting to note that you can determine the exact version of GCC used to compile your code during compilation, if you desire. 

GCC 4.3.2 on Linux provides this interesting tidbit: 

```cpp
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 1 
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 1 
#define __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 1`
```

For those of you concerned about non locking synchronous operations.
