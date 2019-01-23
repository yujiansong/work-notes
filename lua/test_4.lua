#!/usr/local/bin/lua
--[[
--对 table 的索引使用方括号 []。Lua 也提供了 . 操作。
--t[i]
--t.i    当索引为字符串类型时的一种简化写法
--gettable_event(t,i) 采用索引访问本质上是一个类似这样的函数调用
--]]
site = {}
site['key'] = 'www.jianlibao.com.cn'
print('site["key"] = '..site['key'])
print('site.key = '..site.key)
