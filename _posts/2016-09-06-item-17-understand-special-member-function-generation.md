---
layout: post
title: 'Item 17: Understand special member function generation.'
date: 2016-09-06 01:46:53.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags:
- modernc++
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26526456211'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---

The special member functions are those compilers may generate on their own:default constructor, destructor, copy operations  (C++98) and move operations (C++11). These functions are only generated when lacking of user-defined declaration but user code uses them.

&nbsp;

Move operations are generated only for classes lacking explicitly declared. move operations, copy operations, and a destructor. Move ctor and move assignment ctor are also dependent. Declaring either one of them will disable generation of the other,i.e. you have to define your own if you want to use it.

&nbsp;

The copy constructor is generated only for classes lacking an explicitly declared copy constructor, and it s deleted if a move operation is declared.The copy assignment operator is generated only for classes lacking an explicitly declared copy assignment operator, and it s deleted if a move operation is declared. Generation of the copy operations in classes with an explicitly declared destructor is still supported in C++11 but deprecated. Copy operations are independent, declaring either one but not the other will not prevent compiler from willing to generate the other.

&nbsp;

Member function templates never suppress generation of special member functions.

