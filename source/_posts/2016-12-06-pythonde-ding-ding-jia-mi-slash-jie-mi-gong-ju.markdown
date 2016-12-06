---
layout: post
title: "Python的钉钉加密/解密工具"
date: 2016-12-06 23:15:54 +0800
comments: true
categories: 技术
---

又是很久没有写技术博客了，盖因最近都在学习知识，也没有总结出什么值得分享的内容，所以一直停笔至今。最近的工作和钉钉的开发打上了交到，官方并没有提供任何Python的SDK，于是只能全部自己写。现在我将其中实现起来相对费时间的“加密/解密/签名”部分分享出来，希望能帮助到一些人。

加密/解密的具体机制，可以参考[官方文档]( https://open-doc.dingtalk.com/doc2/detail.htm?treeId=175&articleId=104945&docType=1#s14)。

在你的项目中安装这个扩展，可以使用: `pip install dingtalk_crypto` 安装。

使用方法，可以参考下面的测试代码：

``` python
# -*- coding: utf-8 -*-

import json
from dingtalk_crypto import DingTalkCrypto

# 这个是钉钉官方给的测试数据
# @see https://open-doc.dingtalk.com/doc2/detail.htm?treeId=175&articleId=104945&docType=1#s14
encrypt_text = '1a3NBxmCFwkCJvfoQ7WhJHB+iX3qHPsc9JbaDznE1i03peOk1LaOQoRz3+nlyGNhwmwJ3vDMG' \
               '+OzrHMeiZI7gTRWVdUBmfxjZ8Ej23JVYa9VrYeJ5as7XM/ZpulX8NEQis44w53h1qAgnC3PRzM7Zc' \
               '/D6Ibr0rgUathB6zRHP8PYrfgnNOS9PhSBdHlegK+AGGanfwjXuQ9+0pZcy0w9lQ=='

crypto = DingTalkCrypto(
    '4g5j64qlyl3zvetqxz5jiocdr586fn2zvjpa8zls3ij',
    '123456',
    'suite4xxxxxxxxxxxxxxx'
)

signature = '5a65ceeef9aab2d149439f82dc191dd6c5cbe2c0'
timestamp = '1445827045067'
nonce = 'nEXhMP4r'


class TestCrypto:
    def test_decrypt(self):
        randstr, length, msg, suite_key = crypto.decrypt(encrypt_text)
        msg = json.loads(msg)

        assert msg['EventType'] == 'check_create_suite_url'
        assert msg['Random'] == 'LPIdSnlF'
        assert suite_key == 'suite4xxxxxxxxxxxxxxx'

    def test_encode(self):
        encrypt_msg = crypto.encrypt('hello world')
        randstr, length, msg, suite_key = crypto.decrypt(encrypt_msg)
        assert msg == 'hello world'

    def test_check_signature(self):
        assert crypto.check_signature(encrypt_text, timestamp, nonce, signature)

    def test_sign(self):
        msg = crypto.encrypt('hello world')
        actual_sig, actual_time, actual_nonce = crypto.sign(msg)
        assert True
```

最后，贴出项目的[源码地址](https://github.com/zgs225/dingtalk_crypto)，希望能一些交流。
