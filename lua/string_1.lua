#!/usr/local/bin/lua
name = 'wanglaoER'
print(string.upper(name))
print(string.lower(name))
name2 = 'wangtianshihahaha'
print(string.gsub(name2, 'a', 'A', 3)) --替换
print(string.find(name2, 'shi', 1)) --查找字符所在的位置
print(string.reverse(name2)) --字符串反转
print(string.format('wanglaoer has money :%d$',200))
print(string.len(name2))
name3 = 'wangtianshi'
print(string.rep(name3, 10))
