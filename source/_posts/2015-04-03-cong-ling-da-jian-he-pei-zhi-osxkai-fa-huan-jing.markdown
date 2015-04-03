---
layout: post
title: "从零搭建和配置OSX开发环境"
date: 2015-04-03 22:52:14 +0800
comments: true
categories: 技术
keywords: Mac开发环境搭建,OSX开发环境搭建,Ruby开发环境搭建,开发环境搭建
---
对于每一名开发者来说，更换系统或者更换电脑的时候，都免不了花上不短的时间去折腾开
发环境的问题。我本人也是三番两次，深知这个过程的繁琐。所有，根据我自己以往的经验，
以及参考一下他们的意见，整理一下关于在Mac下做各种开发的配置，包含Java, Ruby, Vim,
git, 数据库等等。欢迎补充与修正。

## {% icon fa fa-anchor %} Terminal篇

这篇文章包含配置控制台环境，包括包管理工具, zsh, Vim, git的安装配置。

#### Homebrew, 你不能错过的包管理工具

包管理工具已经成为现在操作系统中不可缺少的一个重要工具了，它能大大减轻软件安装的
负担，节约我们的时间。`Linux`中常用的有`yum`和`apt-get`工具，甚至`Windows`平台也
有`Chocolatey`这样优秀的工具，OSX平台自然有它独有的工具。

在OSX中，有两款大家常用的管理工具：`Homebrew`或者`MacPorts`。这两款工具都是为了解决同
样的问题——为OSX安装常用库和工具。`Homebrew`与`MacPorts`的主要区别是`Homebrew`不会破坏OSX
原生的环境，这也是我推荐`Homebrew`的主要原因。同时它安装的所有文件都是在用户独立空间内
的，这让你安装的所有软件对于该用户来说都是可以访问的，不需要使用`sudo`命令。

> 在安装`Homebrew`前，你需要前往AppStore下载并安装Xcode.

安装方式：

``` bash
# OSX系统基本上都自带Ruby1.9
# 所以无需先安装Ruby，但是之后我们需要管理Ruby
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

`Homebrew`常用命令：

``` bash
brew list                 # 查看已经安装的包
brew update               # 更新Homebrew自身
brew doctor               # 诊断关于Homebrew的问题(Homebrew 有问题时请用它)
brew cleanup              # 清理老版本软件包或者无用的文件
brew show ${formula}      # 查看包信息
brew search ${formula}    # 按名称搜索
brew upgrade ${formula}   # 升级软件包
brew install ${formula}   # 按名称安装
brew uninstall ${formula} # 按名称卸载
brew pin/unpin ${formula} # 锁定或者解锁软件包版本，防止误升级
```
+ [官方网站](http://brew.sh)
+ [FAQ](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/FAQ.md#faq)

#### zsh，好用的shell

Shell程序就是Linux/UNIX系统中的一层外壳，几乎所有的应用程序都可以运行在Shell环境
下，常用的有bash, csh, zcsh等。在`/etc/shells`文件中可以查看系统中的各种shell。

``` bash
cat /etc/shells

# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
```
而zsh是OSX系统原生的shell之一，其功能强大，语法相对于bash更加友好和强大，所以推荐
使用zsh作为默认的shell。

``` bash
# 切换zsh为默认shell
chsh -s $(which zsh)
```

如果你想使用最新的zsh，你可以使用Homebrew，此方法也会保留原生的zsh，防止你在某个
时刻需要它。

``` bash
# 查看最新zsh信息
brew info zsh

# 安装zsh
brew install --disable-etcdir zsh

# 添加shell路径至/etc/shells文件中
# 将 /usr/local/bin/zsh 添加到下面文件中
sudo vim /etc/shells

# 更换默认shell
chsh -s /usr/local/bin/zsh
```

下面贴上我的zsh配置以供参考

{% include_code 我的zsh配置 lang:bash zshrc %}
