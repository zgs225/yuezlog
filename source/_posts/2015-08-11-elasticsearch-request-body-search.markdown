---
layout: post
title: "Elasticsearch request body search"
date: 2015-08-11 15:05:16 +0800
comments: true
categories: 技术
---

Elasticsearch 的搜索请求可以像一个领域专用语言(DSL)一样执行，它包含了一个专用的
[Query DSL](#elasticsearch-query-dsl)。

看一个例子：

``` json
curl -XGET "http://localhost:9200/twitter/tweet/_search" -d {
    "query" : {
        "term" : { "user" : "kimchy" }
    }
}

// 响应
{
  "_shards":{
    "total" : 5,
    "successful" : 5,
    "failed" : 0
  },
  "hits":{
    "total" : 1,
    "hits" : [
      {
        "_index" : "twitter",
        "_type" : "tweet",
        "_id" : "1",
        "_source" : {
          "user" : "kimchy",
          "postDate" : "2009-11-15T14:12:12",
          "message" : "trying out Elasticsearch"
        }
      }
    ]
  }
}
```

请求体中常用的参数如下：

参数         | 描述
-------------|---------------
timeout      | 搜索超时时间，默认没有超时时间
from         | 从第几个索引开始返回搜索结果，默认是0
size         | 返回多少搜索结果，模式是10
search\_type | 搜索行为表现类型，值类似：`dfs_query_then_fetch`, `dfs_query_and_fetch`, `query_then_fetch`, `query_and_fetch`。默认值是: `query_then_fetch`。[更多资料](https://www.elastic.co/guide/en/elasticsearch/reference/current/search-request-search-type.html)
query\_cache | 设置是否缓存搜索结果，值为 `true` 或者 `false`。[更多资料](https://www.elastic.co/guide/en/elasticsearch/reference/current/index-modules-shard-query-cache.html)

## 排序

Elasticsearch 允许指定一个或者多个字段进行排序。例如：

``` json
{
  "sort" : [
    { "post_date" : {"order" : "asc"}},
    "user",
    { "name" : "desc" },
    { "age" : "desc" },
    "_score"
  ],
  "query" : {
    "term" : { "user" : "kimchy" }
  }
}
```

指定用于排序的字段应当是搜索结果的一部分，排序的方向可以是 `asc` 或者 `desc`。

### 可选的排序模式

Elasticsearch 的排序支持数组或者多值字段，`mode` 选项就是控制根据数组值进行排序。

`mode` 选项可以是一下值：

值  | 描述
----|-------------
min | 选择最小的值
max | 选择最大的值
sum | 使用数组的总和
avg | 使用数组的平均值

``` json
curl -XPOST "localhost:9200/_search" -d {
   "query" : {
    ...
   },
   "sort" : [
      {"price" : {"order" : "asc", "mode" : "avg"}}
   ]
}
```

### 根据嵌套的对象排序

Elasticsearch 也支持使用一个或者多个对象内的字段进行排序。当使用对象内字段进行排
序的时候，支持使用下面参数：

+ `nested_path`：句号语法，例如 `production.price`。
+ `nested_filter`：如果符合条件则使用这个字段进行排序。默认该值为空。

看下面的例子，当 `offer.color` 为 `blue` 的时候，根据 `orffer.price` 进行排序：

``` json
curl -XPOST "localhost:9200/_search" -d {
   "query" : {
    ...
   },
   "sort" : [
       {
          "offer.price" : {
             "mode" :  "avg",
             "order" : "asc",
             "nested_filter" : {
                "term" : { "offer.color" : "blue" }
             }
          }
       }
    ]
}
```

### missing 参数

参数 `missing` 指定了当搜索结果中没有该字段时，程序如何处理。`missing` 的值可以
`_first`, `_last` 或者一个自定义值(当没有该字段的时候，假定该字段值为自定义值)。

``` json
{
  "sort" : [
    { "price" : {"missing" : "_last"} },
  ],
  "query" : {
    "term" : { "user" : "kimchy" }
  }
}
```

<i id="elasticsearch-query-dsl"></i>
## Query DSL

Elasticsearch 提供了一套基于JSON的查询语言。通常，查询都是基本的`term` 或者 `prefix`
，一些组合条件的 `bool` 查询
