---
layout: post
title: item 5 prefer auto to explicit type declaration
date: 2016-08-31 02:12:20.000000000 -04:00
type: post
published: true
status: publish
categories: []
tags: []
meta:
  _rest_api_published: '1'
  _rest_api_client_id: '-1'
  _publicize_job_id: '26323353429'
author:
  login: cowboybebop98
  email: xiongm@gmail.com
  display_name: cowboybebop98
  first_name: ''
  last_name: ''
---
Benefits of auto

auto variables have their type deduced from initializers, so auto must have an initializer, practically eliminating the uninitialized variable problems introduced by explicit type declaration
auto is immune to mismatch (because compiler is doing the job, rather than human) preventing possible implicit conversion due to subtle type mismatch.
ease the job of refactoring. once written, no need to change.

