---
layout: post
title: 'Item 22: When using the Pimpl Idiom, define special member functions in the
  implementation file'
date: 2016-09-12 02:06:47.000000000 -04:00
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
  _publicize_job_id: '26730538934'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---
> The Pimpl Idiom decreases build times by reducing compilation dependencies between class clients and class implementations.

> For std::unique_ptr pImpl pointers, declare special member functions in the class header, but implement them in the implementation file. Do this even if the default function implementations are acceptable.

