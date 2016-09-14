---
layout: post
title: item 4 know how to view deduced types
date: 2016-08-31 01:20:44.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26322250542'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

use compiler diagnostics

{% highlight cpp %}
template <typename T>
class TD;
const int n = 0;
auto x = n;
auto y = &n;
TD<decltype(x)> xTD; //error, implicit instantiation of undefined template 'TD<int>'
TD<decltype(y)> yTD; // error,implicit instantiation of undefined template 'TD<const int *>'
{% endhighlight %}
