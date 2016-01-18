---
layout: post
title: "Vim 技巧"
date: 2016-01-18 07:29:28 +0800
comments: true
categories: 技术
keywords:
  - vim tips
  - vim 技巧
  - vim 教程
  - 怎么使用vim
---

> 在Github上看到的一些挺有用的技巧，转载、汇总过来。文章最后会有来源。

### 行为一致的n和N

`n`和`N`在搜索中用来查找下一个或者上一个搜索结果。但是在使用`/`或者`?`搜索时，它
移动的方向不同，这个经常会混淆。所以，如果你希望`n`总是查找下一个搜索结果，`N`总
是查找上一个搜索结果的话，你可以这么做：

``` vim
nnoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
```

### 快速移动当前行

如果你想将当前行快速上移或者下移几行的话，你可以这么做：

``` vim
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
```

上面两个映射接受数字做为参数，例如：`2]e`表示将当前行下移两行。

### 快速宏编辑

这条非常有用！这个快捷键打开了一个命令历史窗口，你可以编辑，然后按`<cr>`键执行。

``` vim
nnoremap <leader>m  :<c-u><c-r>='let @'. v:register .' = '. string(getreg(v:register))<cr><c-f><left>
```

`<leader>m`使用这条技巧。

### 高亮光标所在当前行和当前列

``` vim
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn
```

### 显示多余的空白字符

``` vim
set list listchars=tab:»·,trail:·
```

### 在GUI中快速改变字体大小

测试在控制台的Vim中无效。

``` vim
command! Bigger  :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)+1', '')
command! Smaller :let &guifont = substitute(&guifont, '\d\+$', '\=submatch(0)-1', '')
```

### 参考

+ [mhinz/vim-galore](https://github.com/mhinz/vim-galore#tips-1)
