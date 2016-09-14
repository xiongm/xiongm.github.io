---
layout: post
title: 'Item 20: Use std::weak_ptr for std::shared_ptr like pointers that can dangle'
date: 2016-09-12 02:00:12.000000000 -04:00
type: post
published: true
status: publish
categories:
- C++
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26730392213'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---
weak_ptr is a smart pointer that acts like shared_ptr, but doesn't contribute to ref counting. It can tell if a object it points to has been destroyed or not (by using expire()) weak_ptr CANNOT be dereferenced. You have to convert it to shared_ptr to be able to use it. Thus weak_ptr isn't a standalone smart pointer, it is a augmentation to shared_ptr.

The property that weak_ptr isn't a standalone smart pointer can be reflected by how it's constructed, usually weak_ptr is constructed from a shared_ptr.

{% highlight cpp %}
auto sp = make_shared<MyObject>();
weak_ptr<MyObject> wp(sp); // doesn't increment p's ref count
...
sp = nullptr; // sp is gone. remember copy assignment operator both increment and decrement
if (wp.expired()) // test if the underlying object dangles, in this case true
{
}
{% endhighlight %}
To be able to check if an object dangles and if not, returns a shared_ptr, here's what you do
{% highlight cpp %}
auto sp = make_shared<MyObject>();
weak_ptr<MyObject> wp(sp);
...
shared_ptr<MyObject> sp1 = wp.lock(); // returns a shared_ptr if not expired(), otherwise returns null
if (sp1)
{
 ...
}
{% endhighlight %}

Potential use cases for std::weak_ptr include factory method caching, observer lists, and the prevention of std::shared_ptr cycles,i.e. shared_ptr A points to shared_ptr B and B points to A as well.

