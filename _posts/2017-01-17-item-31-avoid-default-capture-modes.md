---
layout: post
title: Item 31: Avoid default capture modes
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
  _publicize_job_id: '26730497786'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---


> lambda allow you to create a closure which will execute beyond the scope of its original creation
lambda has the two default capture modes

||notation || meaning ||
| [&] | capture by reference|
| [=] | capture by value |

Capturing a class instance variable is really capturing the this pointer of the class instance, not the variable itself. So do not assume default by value capture can solve the dangling pointer of default by reference capture



