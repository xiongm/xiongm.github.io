---
layout: post
title: 'Item 10: Prefer scoped enums to unscoped enums'
date: 2016-09-01 19:54:55.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26387976698'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

scoped enums, aka class enums, are visible only within the enum.

{% highlight cpp %}
enum Color {red, blue, yellow}; // c++98 style
auto red = false; // error, white has been declared
color c = red; // fine!
enum class Color {red, blue, yellow}; // c++ 11
auto red = true; // fine!
color c = red; // error, red doesn't exist in current scope
color c = Color::red; // fine
{% endhighlight %}

scoped enums can be forward declared, non-scoped enums can't

{% highlight cpp %}
enum Color; // doesn't work
enum Class Color; // fine
{% endhighlight %}

strongly typed, no implicit conversion like non-scoped enums

{% highlight cpp %}
enum class Color {red, blue, yellow};
Color c = Color::red;
bool is_less_than = c < 14.5 ? true: false; // error! no implicit conversion to double
bool is_less_than = static_cast<c> < 14.5? true : false; // fine
{% endhighlight %}
