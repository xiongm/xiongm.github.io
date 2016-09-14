---
layout: post
title: 'Item 2: Understand auto type deduction'
date: 2016-08-30 05:26:06.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _publicize_job_id: '26290293739'
  _rest_api_client_id: '-1'
  _rest_api_published: '1'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

auto type deduction IS template type deduction, for the most part

This is why we discuss template type deduction in Item1 before we start digging into auto type deduction. Recall in template type deduction, provided a function template
{% highlight cpp %}
template <typename T>
void f(ParamType param)
{% endhighlight %}
we use expr in
{% highlight cpp %}
f(expr)
{% endhighlight %}
to deduce type of T and ParamType.
Now for a auto type definition
{% highlight cpp %}
auto x = 10; // x is int
auto & y = x; // what is type of y?
{% endhighlight %}
If you think of auto as T, and the specifier for auto as ParamType, 10 as the expr, then deducing type of y for the above definition becomes deducing ParamType of the param given function template
{% highlight cpp %}
template <typename T>
f(T & param)
{% endhighlight %}
and the expr
{% highlight cpp %}
f(x)
{% endhighlight %}
We know x is int, so T is int, and param's type is int &, so y's type is int &.
