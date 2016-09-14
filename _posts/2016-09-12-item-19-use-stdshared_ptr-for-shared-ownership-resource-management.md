---
layout: post
title: 'Item 19: Use std::shared_ptr for shared-ownership resource management.'
date: 2016-09-12 01:12:28.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26729398833'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---
shared_ptr is C++'s way of garbage collector. All shared_ptr holders collectively own the underlying object and when the last holder exits, the object will be destroyed, automatically.

shared_ptr increment ref count in constructor, copy constructor, and copy assignment operator (copy assignment operator also decrement ref count of the object originally pointed to, so copy assignment operator does both). Note that move constructor DOES NOT increment ref counts.

shared_ptr has performance implications because it needs to keep book information of the ref count, thus having twice the size of raw pointer. And to be thread safe, it needs to increment and decrement its ref count in atomic operation, which is usually slower than non atomic operation.

shared_ptr typically has two pointers, one pointing to the object, and another pointing to a control block dynamically allocated shared by all shared_ptrs. The control block should be set up  when first shared_ptr to an object is created. Per C++ 11, control block will be created when

* make_shared is called
* unique_ptr is converted to shared_ptr
* when shared_ptr constructor is called with pointer

The last approach is probably the most common way of creating a shared_ptr. In reality thou, it is possible that creating two shared_ptrs from the same raw pointer can result in two control blocks being created, thus causing duplicate ref counting, which is bad! See below
{% highlight cpp %}
auto p = new MyObject();
shared_ptr<MyObject> a(p); //
shared_ptr<MyObject> b(p);
{% endhighlight %}
The lesson here is to either use make_shared, or use new directly inside shared_ptr constructor.
Another way to introduce this kind of duplicate-control-block issue has to do with using this pointer. Sometimes, we have to create shared_ptr out of this pointer after the object has been created, so we can not use the methods mentioned above to avoid passing raw pointer directly to shared_ptr.
{% highlight cpp %}
vector<shared_ptr<MyObject>> objects;
// bad! what if there are other shared_ptrs already
// pointing to the object? meaning that at least one control block
// has been created, but passing raw pointer to shared_ptr constructor will surely
// create a control block, resulting in duplicate control blocks
objects.emplace_back(this);
{% endhighlight %}
This is exactly why we need to use enable_shared_from_this(), in case you have been using this for a while but never ask yourself why
{% highlight cpp %}
class MyObjects : public std::enable_shared_from_this<MyObjects>
{
...
};
vector<shared_ptr<MyObject>> objects
...
objects.emplace_back(shared_from_this());
{% endhighlight %}
