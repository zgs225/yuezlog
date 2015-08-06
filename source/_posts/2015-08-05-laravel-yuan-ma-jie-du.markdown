---
layout: post
title: "Laravel 源码解读"
date: 2015-08-05 11:22:20 +0800
comments: true
categories: 技术
---
> 为WEB艺术家创造的框架

由SitePoint发起的2015年最流行WEB框架的调查中，Laravel已巨大的优势获得了商用使用
数量、个人项目使用数量的第一名。当之无愧是目前最好的WEB框架之一。那么就让我们来
一步一步探究这样优秀的框架究竟是如何实现的吧。

{% lazy_img lazy no-shadow /photos/php-frameworks-votes.png 640 200 最流行框架投票 %}

## 目录

+ [入口文件 index.php](#laravel-section-1)
  + [Illuminate\Foundation\Application 类](#laravel-section-1-1)
  + [注入所有基础 Service Provider](#laravel-section-1-2)

<i id="laravel-section-1"></i>
## 入口文件 index.php

一个基于Laravel的应用，当WEB服务器接受到来自外部的请求后，会将这个这个请求解析到
应用根目录的 `public/index.php` 中。

{% include_code Laravel源码解读-index.php lang:php laravel_index.php %}

第二十一行代码

``` php
require __DIR__.'/../bootstrap/autoload.php';
```

为Laravel应用引入了由`Composer`提供的类加载器，这样Laravel应用便无需再手动加载任
何的类。其加载原理不是此次探究的目标，所以仅仅这样使用就好了。接下的代码，便是重
点。

<i id="laravel-section-1-1"></i>
### Illuminate\Foundation\Application 类

该类的继承结构如下：

{% lazy_img lazy no-shadow /photos/application-uml.png 640 200 类继承结构 %}

第三十五行代码

``` php
$app = require_once __DIR__.'/../bootstrap/app.php';
```

它将我的视线引入到了另外一个文件中，去看看到底发生了什么吧。

{% include_code Laravel源码解读-app.php lang:php laravel_app.php %}

看第十四行，原来`$app`是一个 `Illuminate\Foundation\Application` 对象，那么在创
建这个对象的时候又发生了什么呢？

从它的构造方法看起：

``` php Illuminate\Foundation\Application 构造方法
/**
 * Create a new Illuminate application instance.
 *
 * @param  string|null  $basePath
 * @return void
 */
public function __construct($basePath = null)
{
    $this->registerBaseBindings();

    $this->registerBaseServiceProviders();

    $this->registerCoreContainerAliases();

    if ($basePath) {
        $this->setBasePath($basePath);
    }
}
```

顺着函数调用，往下看。在这个构造函数中，首先调用了`registerBaseBindings`方法。

``` php Illuminate\Foundation\Application#registerBaseBindings
/**
  * Register the basic bindings into the container.
  *
  * @return void
  */
protected function registerBaseBindings()
{
    static::setInstance($this);

    $this->instance('app', $this);

    $this->instance('Illuminate\Container\Container', $this);
}
```

这段代码，是将实例对象注入到容器中。那么，这个容器是什么呢？答案还是要从这段调用
中去寻找。

`static::setInstance($this)` 所做的就是将 `$this` 赋值给自身的 `instance` 静态变
量。重点看 `$this->instance('app', $this)`。

`instance` 函数的作用是绑定一个已有对象到容器中，这个对象在容器中共享并且可以通
过键获取。

``` php Illuminate\Container\Container#instance
/**
  * Register an existing instance as shared in the container.
  *
  * @param  string  $abstract
  * @param  mixed   $instance
  * @return void
  */
public function instance($abstract, $instance)
{
    if (is_array($abstract)) {
        // $abstract 是这样的一个数组 ['actual key' => 'alias']
        list($abstract, $alias) = $this->extractAlias($abstract);

        // 实际上的行为是 $this->aliases[$alias] = $abstract;
        $this->alias($abstract, $alias);
    }

    unset($this->aliases[$abstract]);

    // 检查是否有这个键是否已经注册到容器中
    // $bound 是一个boolean值
    $bound = $this->bound($abstract);

    $this->instances[$abstract] = $instance;

    if ($bound) {
        $this->rebound($abstract);
    }
}
```

视线重新回到`Application`类中，接下来调用了这个方法 `$this->registerBaseServiceProviders()`，

``` php Illuminate\Foundation\Application#registerBaseServiceProviders
/**
  * Register all of the base service providers.
  *
  * @return void
  */
protected function registerBaseServiceProviders()
{
    $this->register(new EventServiceProvider($this));

    $this->register(new RoutingServiceProvider($this));
}

/**
  * Register a service provider with the application.
  *
  * @param  \Illuminate\Support\ServiceProvider|string  $provider
  * @param  array  $options
  * @param  bool   $force
  * @return \Illuminate\Support\ServiceProvider
  */
public function register($provider, $options = [], $force = false)
{
    if ($registered = $this->getProvider($provider) && !$force) {
        return $registered;
    }

    // If the given "provider" is a string, we will resolve it, passing in the
    // application instance automatically for the developer. This is simply
    // a more convenient way of specifying your service provider classes.
    if (is_string($provider)) {
        $provider = $this->resolveProviderClass($provider);
    }

    $provider->register();

    // Once we have registered the service we will iterate through the options
    // and set each of them on the application so they will be available on
    // the actual loading of the service objects and for developer usage.
    foreach ($options as $key => $value) {
        $this[$key] = $value;
    }

    $this->markAsRegistered($provider);

    // If the application has already booted, we will call this boot method on
    // the provider class so it has an opportunity to do its boot logic and
    // will be ready for any usage by the developer's application logics.
    if ($this->booted) {
        $this->bootProvider($provider);
    }

    return $provider;
}
```

其中，EventServiceProvider和RoutingServiceProvider分别是

+ `Illuminate\Events\EventServiceProvider`
+ `Illuminate\Routing\RoutingServiceProvider`

这些ServiceProvider是 `Illuminate\Support\ServiceProvider` 的子类，它接受一个
`Application` 对象作为构造函数参数，存储在实例变量 `$app` 中。

<i id="laravel-section-1-2"></i>
### 注入所有基础 Service Provider

在 `register` 方法中，每个ServiceProvider被调用了自身的 `register` 方法。首先看
看 `EventServiceProvider` 中的吧。

``` php Illuminate\Events\EventServiceProvider#register
public function register()
{
    $this->app->singleton('events', function ($app) {
        return (new Dispatcher($app))->setQueueResolver(function () use ($app) {
            return $app->make('Illuminate\Contracts\Queue\Factory');
        });
    });
}
```

上面方法体将一个 `Illuminate\Events\Dispatcher` 对象以键 `events` 绑定到了容器
中，它负责实现事件的调度。

再看看 `Illuminate\Routing\RoutingServiceProvider`:

``` php Illuminate\Routing\RoutingServiceProvider#register
public function register()
{
    $this->registerRouter();

    $this->registerUrlGenerator();

    $this->registerRedirector();

    $this->registerPsrRequest();

    $this->registerPsrResponse();

    $this->registerResponseFactory();
}
```

首页是在Laravel中接触的最多的 `route` 被注册，它是 `Illuminate\Routing\Router`
对象。
