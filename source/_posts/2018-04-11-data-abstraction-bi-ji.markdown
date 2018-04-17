---
layout: mathjax
title: "Data Abstraction 笔记"
date: 2018-04-11 06:53:08 +0800
comments: true
hidden: true
categories: draft
---

_Data type abstraction_ includes _interface_ and _implementation_. _interface_ describe what the data of the type represents, what the operations on the data are and what properties these operations may be relied on to have. _implementation_ provides a specific representation of the data and code for the operations that make use of that data representation.

_Representation-independent_ means the client manipulates the values of the data type only through the procedures in the interface.

We use the notation $\lceil\nu\rceil$ for "the representation of data $\nu$".
