---
layout: post
title: 'Item 18: Use std::unique_ptr for exclusive-ownership resource management'
date: 2016-09-11 22:12:48.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26725681239'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---
unique_ptr is a move-only type, because unique_ptr embodies a exclusive ownership semantics, meaning that you can not have two unique_ptr point to the same underlying object. As a result, unique_ptr cannot be copied, i.e. copy constructor/copy assignment constructor are not defined for unique_ptr.
{% highlight cpp %}
using namespace std;
unique_ptr a(new MyObject());
unique_ptr b(a); // error! can not be copy constructed
unique_ptr c = move(a); // OK, but now a can not be used any more
{% endhighlight %}
unique_ptr by default is the same size as raw pointer, thus using unique_ptr incur no difference than using a raw pointer.
A good use of unique_ptr is simple factory function that initializes and returns unique_ptr. The caller will manage the lifecycle of the object.
{% highlight cpp %}
class Piece {
 ...
};
class Knight : public Piece {
 ...
};
class Bishop: public Piece {
 ...
};
// variadic template, C++ 11's new feature to support arbitrary number
// of template arguments with arbitrary type
typename <typename... Arguments>
unique_ptr<Piece>
create_piece(const string & name, Arguments&&... args)
{
    unique_ptr<Piece> piece;
    if (name == "Knight")
    {
       piece.reset(new Knight(forward<Arguments>(args)...));
    } else if (name == "Bishop")
    {
       piece.reset(new Bishop(forward<Arguments>(args)...));
    } else
    {
       throw std::runtime_error("unknown type");
    }
    return piece;
}
{% endhighlight %}

It is easy to convert unique_ptr to shared_ptr, thus making unique_ptr ideal for factory function since you have two options(unique_ptr or shared_ptr)

Notes:
Q: Why auto_ptr can't be used with STL but unique_ptr can?
A: elements in STL container need to be copy constructible and copy assignable, but copying auto_ptr from a STL container will set it to null, thus invalidating this guarantee. unique_ptr implements move semantics, it will use move instead of copy.
&nbsp;
