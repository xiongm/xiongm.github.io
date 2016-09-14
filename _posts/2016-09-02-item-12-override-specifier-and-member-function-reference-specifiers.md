---
layout: post
title: item 12 override specifier and member function reference specifiers
date: 2016-09-02 02:22:17.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26397067692'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

Declare overriding virtual functions override, so if it doesn't override anything, compiler will let you know.

&nbsp;

member function reference specifiers can limit use of member function to lvalues or rvalues only. This can be useful when you want lvalue to return lvalue and rvalue to return rvalue.

Consider the following code
{% highlight cpp %}
class Widget
{
public:
using DataType = std::vector<int>;
DataType & data()
{
  return data_;
}
private:
DataType data_;
}
....
Widget w;
auto data = w.data(); // copy constructed, b/c w.data() is lvalue
....
Widget create_widget();
auto data = create_widget().data(); // copy constructed as well, but doesn't have to be
{% endhighlight %}
Now by introducing reference specifiers for data(), we can improve this.
{% highlight cpp %}
class Widget
{
public:
using DataType = std::vector<int>;
DataType data() &; // used only when (*this) is lvalue
{
 return data_;
}
DataType data() &&; // used only when (*this) is rvalue
{
  return std::move(data_); // because (*this) is a temp object!
}
private:
DataType data_;
}
...
Widget w;
auto data = w.data(); // calls data() & copy constructed
...
Widget create_widget();
auto data = create_widget().data(); // calls data() && creates a rvalue, so move constructed
{% endhighlight %}
