---
layout: post
title: item 11 Prefer deleted functions to private undefined ones
date: 2016-09-01 20:10:31.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26388428337'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

delete key word specify functions that are not defined, thus not meant to be used by clients.

C++ 98
{% highlight cpp %}
template <class charT, class traits = char_traits<charT>>
class basic_ios : public ios_base {
public:
 
private:
  basic_ios(const basic_ios &); // not defined
  basic_ios & operator=(const basic_ios &); // not defined
};
};
{% endhighlight %}
C++ 11
{% highlight cpp %}
template <class charT, class traits = char_traits<charT>>
class basic_ios : public ios_base {
public:
 
  basic_ios(const basic_ios &) = delete;
  basic_ios & operator=(const basic_ios &) = delete;
 
};
{% endhighlight %}

delete can be used with any function, not just member function, to eliminate the possibilities of usage by client

&nbsp;
