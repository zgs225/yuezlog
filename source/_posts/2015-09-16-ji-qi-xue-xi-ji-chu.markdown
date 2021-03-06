---
layout: post
title: "机器学习基础"
date: 2015-09-16 10:03:25 +0800
comments: true
categories: 技术
---
现今，机器学习已应用于多个领域，远超出大多数人的想象，下面就是假想的一日，其中很
多场景都会碰到机器学习：假设你想起今天是某位朋友的生日，打算通过邮局给她邮寄一张
生日贺卡你打开浏览器搜索趣味卡片，搜索引擎显示了10个最相关的链接你认为第二个链接
最符合你的要求，点击了这个链接，搜索引擎将记录这次点击，并从中学习以优化下次搜索
结果然后，你检查电子邮件系统，此时垃圾邮件过滤器已经在后台自动过滤垃圾广告邮件，
并将其放在垃圾箱内接着你去商店购买这张生日卡片，并给你朋友的孩子挑选了一些尿布结
账时，收银员给了你一张1美元的优惠券，可以用于购买6罐装的啤酒之所以你会得到这张优
惠券，是因为款台收费软件基于以前的统计知识，认为买尿布的人往往也会买啤酒然后你去
邮局邮寄这张贺卡，手写识别软件识别出邮寄地址，并将贺卡发送给正确的邮车当天你还去
了贷款申请机构，查看自己是否能够申请贷款，办事员并不是直接给出结果，而是将你最近
的金融活动信息输入计算机，由软件来判定你是否合格最后，你还去了赌场想找些乐子，当
你步入前门时，尾随你进来的一个家伙被突然出现的保安给拦了下来“对不起，索普先生，
我们不得不请您离开赌场我们不欢迎老千”。

## 什么是机器学习？

简单地说，**机器学习就是把无序的数据转换成有用的信息**。

机器学习横跨计算机科学、工程技术和统计学等多个学科，需要多学科的专业知识。

## 关键术语

+ 专家系统。
+ 特征，也称作属性。
+ 实例。
+ 分类。
+ 训练集。
+ 训练样本。
+ 目标变量。
+ 测试数据。
+ 知识表示。

## 机器学习的主要任务

+ 分类
+ 回归
+ 监督学习
+ 非监督学习
+ 密度估计
+ 聚类

## 选择合适算法

监督学习的用处：
  + K近邻算法: 线性回归
  + 朴素贝叶斯算法: 局部加权线性回归
  + 支持向量机: Ridge回归
  + 决策树: Lasso最小回归系数估计

非监督学习的用处
  + K-均值 - 最大期望值算法
  + DBSCAN - Parzen窗设计

## 开发机器学习应用步骤

1. 收集数据
2. 准备输入数据
3. 分析输入数据
4. 训练算法
5. 测试算法
6. 使用算法
