---
layout: post
title: item 7 distinguish between parentheses () and braces {} when creating object
date: 2016-08-31 20:12:00.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26351197111'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

braced initialization prevents c++ most vexing parse problems

{% highlight cpp %}
vector<int> v(); // most vexing parse! it's not a vector variable, it declares a function named v that returns vector<int>
vector<int> v{}; // OK
vector<int> v(istream_iterator<int>(iss), istream_iterator<int>()); // most vexing parse!
vector<int> v{istream_iterator<int>(iss), istream_iterator<int>()}; // OK
vector<int> v((istream_iterator<int>(iss)), istream_iterator<int>()); // also OK
{% endhighlight %}

During constructor overload resolution, braced initializers are matched to std::initializer_list parameters if at all possible, even if other constructors offer seemingly better matches

{% highlight cpp %}
class my_vector
{
my_vector(); // dtor
   my_vector(int count, int value); // count copies of elements with value
   my_vector(std:initializer_list<int> li); // construct using initawlizer_list
}
my_vector v(10,0); // 10 elements of value 0
my_vector v1{10,0}; // a vector of 2 elements with value 10 and 0
my_vector v2(); // calls dtor
my_vector v3{}; // calls dtor
my_vector v4{{}}; // calls initializer constructor!
{% endhighlight %}

