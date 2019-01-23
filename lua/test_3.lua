#!/usr/local/bin/lua
--[
--当变量个数和值的个数不一致时，Lua会一直以变量个数为基础采取以下策略：
--a. 变量个数 > 值的个数             按变量个数补足nil
--b. 变量个数 < 值的个数             多余的值会被忽略
--]]

a, b, c = 0, 1
print(a,b,c) -- 0   1   nil

a, b = a+1, b+1, b+2
print(a,b) -- 1 2

a, b, c = 0
print(a, b, c) -- 0 nil nil
-- 如果要对多个变量赋值必须依次对每个变量赋值。
a, b, c = 0, 0, 0
print(a, b, c)
