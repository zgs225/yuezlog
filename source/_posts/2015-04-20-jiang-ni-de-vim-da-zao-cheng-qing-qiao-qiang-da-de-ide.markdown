---
layout: post
title: "将你的Vim 打造成轻巧强大的IDE"
date: 2015-04-20 21:51:01 +0800
comments: true
categories: 技术
keywords: Vim插件,Vim技巧,如何使用Vim,Vim IDE
published: false
---
Vim和Emacs一个称为神之编辑器一个被称为编辑器之神，固然很是夸张，但也足以说明这两
款软件的优秀和在程序员界的地位。但是它们都已漫长的学习曲线让人望而生畏，阻止了大
多数人进入。作为一名几乎完全使用Vim写各种代码、文档的人，我想把我自己平时使用的
插件和配置整理下来，方便自己的总结和归纳，如果能有幸帮助到一些想学习Vim但是又不知
道如何入门的人来说，那就再荣幸不过了{% icon fa fa-heart  %}。

在下面的内容中，我会介绍我使用的插件、Vim的配置，最后如果你觉得这些配置手动太麻烦
的话，我推荐你看我的另一篇文章（[从零搭建和配置OSX开发环境](/cong-ling-da-jian-he-pei-zhi-osxkai-fa-huan-jing/)），
在那篇文章的末尾，我给出了一个**自动化配置和管理Vim的方法**。

先贴一张我的Vim的截图：

{% lazy_img lazy no-shadow /photos/vim-ide.png 600 240 vim as ide %}

## 你看的到的插件

从上面那种截图中肉眼能看到的截图说起，把整个界面按照左窗口、主窗口、右窗口和下窗
口命名，依次介绍出现在这个窗口中的主要插件。

#### 主窗口

作为一款主要用于书写代码的文本编辑器，一个足够舒服、靓丽的配色当然是首要考虑的。
我使用的配色主题是`molokai`（[官方地址](https://github.com/tomasr/molokai)），在
你安装好了这个插件之后，你需要下面几行配置应用它：

``` vim
" Switch syntax highlighting on, when the terminal has colors
if (t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Javascript syntax hightlight
syntax enable

" Set syntax highlighting for specific file types
autocmd BufRead,BufNewFile Appraisals set filetype=ruby
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd Syntax javascript set syntax=jquery

" Color scheme
colorscheme molokai
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0
```

另外一个推荐的vim主题是`solarized`([官方地址](https://github.com/altercation/vim-colors-solarized))。

在选定了一个适合自己的主题之后，就需要一些配置去解决排版的问题，比如字符编码和缩
进等问题。

``` vim
" Backspace deletes like most programs in insert mode
set backspace=2
" Show the cursor position all the time
set ruler
" Display incomplete commands
set showcmd
" Set fileencodings
set fileencodings=utf-8,bg18030,gbk,big5

filetype plugin indent on

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

set matchpairs+=<:>
set hlsearch
```

在第68行，水平和垂直方向分别有一条高亮条，这是用来表示我当 前光标所处于的行和列
用的。实现它，只需要几行简单的配置就可以了：

``` vim
" Highlight current line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn
```

##### 关于代码补全

有些人可能已经发现了，在我的主窗口中没有演示代码补全的功能，我需要对此做一个说明。
我本身不喜欢过于强大的代码的代码补全，所以默认的对于我来说已经完全足够了，如果你
需要使用更强大的代码补全，我推荐你使用`YouCompleteMe`（[官方地址](https://github.com/Valloric/YouCompleteMe)）。

{% lazy_img lazy no-shadow /photos/you-complete-me.gif 600 240 YouCompleteMe %}

#### 左窗口

左窗口是一个用于浏览目录结构的插件`nerdtree`（[官方地址](https://github.com/scrooloose/nerdtree)）。
同样一些简单的配置之后，它便能为你提供一个方便够用的功能。

``` vim
" NERD tree
let NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
" Automatically open a NERDTree if no files where specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Open a NERDTree
nmap <F5> :NERDTreeToggle<cr>
```

#### 右窗口

在我的截图中，右窗口陈列出了我当前打开的rb文件中申明的类、变量及方法等等。这是一
款名叫`tagbar`的插件，它为我们提供了一个简单的方式去浏览当前文件的结构，并且支持
在各个标签之间快捷的跳转。同理，安装之后，需要一些配置：

``` vim
" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
nmap <F6> :TagbarToggle<CR>
```

如果你发现默认的`Tagbar`不能支持你的语言，比如Css, Clojure, Markdown等等，你可以
参照[这篇文章](https://github.com/majutsushi/tagbar/wiki)为它提供额外的支持。

#### 下窗口

下窗口包含了两个部分：一个是用于全局搜索的窗口和一个状态条。
