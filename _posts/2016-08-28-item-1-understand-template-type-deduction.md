---
layout: post
title: Item 1 Understand template type deduction
date: 2016-08-28 04:35:20.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- C++
- modernc++
meta:
  _publicize_job_id: '26222740079'
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---
Function template looks like the following
{% highlight cpp %}
template <typename T>
void f(ParamType param)
{% endhighlight %}
A call to the function looks like this
{% highlight cpp %}
f(expr)
{% endhighlight %}
During compilation, compiler use expr to deduce types for both T and ParamType and they are usually different. Following are some of the key knowledge points with examples. The quoted messages are from Modern Effective C++ by scott meyers

During template type deduction, arguments that are references are treated as non reference

{% highlight cpp %}
template <typename T>
void f(T & param)
int x = 10;
int & y = x;
const int z = 15
f(x) // T is int, param's type is int &
f(y) // T is int, param's type is int &.
// Note that y's reference-ness is ignored
f(z) // T is const int, param's type is const int &
{% endhighlight %}

When deducing types for universal reference parameters, lvalue arguments get special treatment.

{% highlight cpp %}
template <typename T>
void f(T && param)    // universal reference, yes it looks just like rvalue reference
int x = 10;
const int y = x;
// x is a lvalue, when deduced, T is translates to int &
// so is param's type
// the only situation in which a expr is deduced to a
// reference type
f(x)
f(y) // similarly, T is const int &, so is param's type
{% endhighlight %}

When deducing types for by-value parameters, const and/or volatile arguments
are treated as non-const and non-volatile.

{% highlight cpp %}
template <typename T>
void f(T param) // pass by value
int x = 10;
const int y = x;
f(x) // T is int, so is param's type
f(y) // T is int, so is param's type, notice how const is ignored
{% endhighlight %}
