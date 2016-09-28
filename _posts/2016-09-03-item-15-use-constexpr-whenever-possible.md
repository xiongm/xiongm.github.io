---
layout: post
title: 'Item 15: Use constexpr whenever possible.'
date: 2016-09-03 03:21:17.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26433735877'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

constexpr objects are const and are initialized with values known during compilation.

{% highlight cpp %}
int sz;
constexpr int size = sz; // error, sz not known at compile time
array<int, size> data; // error, size not known
constexpr int size2 = 10; //fine, known at compile time
array<int, size2> data2; // fine
{% endhighlight %}

constexpr functions can produce compile-time results when called with arguments whose values are known during compilation, but can also be used to produce run-time results when arguments are not known during compilation.

{% highlight cpp %}
constexpr int pow(int num, int exp) noexcept
{
return exp? num * pow(num, exp - 1) : 1;
}
constexpr auto exp = 3;
array<int, pow(3, exp)> results; // compile time pow
int pow = readPow(); // runtime retrieve 
int exp = readExp(); // runtime retrieve
int result  = pow(pow, exp); // run time pow
{% endhighlight %}
