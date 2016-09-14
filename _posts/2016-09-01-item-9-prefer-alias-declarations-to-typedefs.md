---
layout: post
title: 'Item 9: Prefer alias declarations to typedefs'
date: 2016-09-01 19:22:48.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26387074040'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

alias is easier to swallow than typedef in some situations

{% highlight cpp %}
typedef void (*FP) (int i, string s); // bad
using FP = void (*)(int i, string s); // good!
{% endhighlight %}

typedefs don t support templatization directly, but alias declarations do.

{% highlight cpp %}
template <typename T, typename Comp>
using MyPQ = priority_queue<T, vector<T>, Comp>; // good!
auto comp = [](int lhs, int rhs) {
return lhs < rhs;
};
MyPQ<int, decltype(comp)> pq(comp);
template <typename T, typename Comp>
struct MyPQ
{
typedef priority_queue<T, vector<T>, Comp>::type; // works, but not as good
};
MyPQ<T, decltype(comp)>::type pq(comp);
{% endhighlight %}
