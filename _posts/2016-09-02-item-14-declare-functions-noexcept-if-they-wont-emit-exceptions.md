---
layout: post
title: 'Item 14: Declare functions noexcept if they won t emit exceptions'
date: 2016-09-02 20:41:23.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26425625187'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---
C++98 exception specification is not very worthwhile. A change to the spec will easily break client codes. During work on C++11, it is decided that a true exception spec should only care about whether a function should throw or not, that's how noexcept came out.

noexcept is part of function interface, by default it is false,i.e. the function may throw



compiler provides more optimization for noexcept function than non-noexcept function.

{% highlight cpp %}
void foo() throw();  // c++ 98 no throw style
void bar() noexcept; // c++ 11 no throw style
{% endhighlight %}
In the above code, if foo (i.e. C++ 98 style no throw) violates exception specification and throws, the call stack is unwounded to foo's caller, and terminated. This is guaranteed by spec. But if bar violates exception specification, there's no such guarantee,i.e. runtime will terminate without unwinding call stack to foo's caller.  This difference allows c++ 11's compiler optimizer to avoid having to maintain the call stack in a unwindable state. In contrast, C++ 98's optimizer doesn't have have this optimization flexibility, resulting in more optimized codes in C++11's noexcept function
{% highlight cpp %}
void foo() throw(); // less optimizable
void foo(); // default is may throw, thus less optimizable
void foo() noexcept; // most optimizable
{% endhighlight %}

noexcept is particularly valuable for some operations such as move and swap, since it is needed to guarantee exception safety for some operations that client depends on

&nbsp;

Most function are exception neutral, meaning that they won't emit exceptions themselves, but the function they invoke might. These functions are not noexcept

