---
layout: post
title: Item 21 Prefer std::make_unique and std::make_shared to direct use of new.
date: 2016-09-12 02:04:56.000000000 -04:00
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

Compared to direct use of new, make functions eliminate source code duplication,provides cleaner, concise codes, improve exception safety, and, for std::make_shared and std::allocate_shared, generate code that s smaller and faster.


* exception safety - by merging two steps (object creation followed by shared_ptr creation) into one, eliminates potential memory leak

* faster code - by making one memory allocation requests to system

