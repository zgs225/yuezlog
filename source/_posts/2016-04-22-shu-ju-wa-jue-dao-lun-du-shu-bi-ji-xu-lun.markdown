---
layout: post
title: "数据挖掘导论读书笔记-绪论"
date: 2016-04-22 07:20:44 +0800
comments: true
categories: 数据挖掘
---

## 数据挖掘的起源

提取有用的信息已经称为一项巨大的挑战，来自不同学科的研究者汇集到一起，开发可以处
理不同数据类型的更有效的、可伸缩的工具。特别地，数据挖掘利用了来自如下领域思想：

+ 来自统计学的抽样、估计和假设检验
+ 人工智能、模式识别和机器学习的搜索算法、建模技术和学习理论
+ 最优化、进化计算、信息论、信号处理、可视化和信息检索
+ 提供有效存储、索引和查询处理支持的数据库系统
+ 源于高性能（并行）计算的技术

## 什么是数据挖掘？

数据挖掘是一种将传统的数据分析与处理大量数据的复杂算法相结合的一种技术；是在大型
数据存储库中，自动地发现有用信息的过程。

## 数据挖掘要解决的问题

+ 可伸缩
+ 高维性
+ 异种数据和复杂数据
+ 数据的所有权与分布
+ 非传统的分析

## 数据挖掘的任务

+ **预测任务**：根据说明变量（自变量）预测目标变量（因变量）的值
+ **描述任务**：导出概括数据中潜在联系的模式
+ **预测建模**：为目标变量提供两类的预测建模任务：分类和回归
+ **关联分析**：用来发现数据中强关联特征的模式
+ **聚类分析**：旨在发现紧密相关的观测值组群，使得与不同簇的观测值相比，属于同一
  簇的观测值相互之间尽可能接近
+ **异常检测**：识别其特征显著不同于其他数据的观测值
