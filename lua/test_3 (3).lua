#!/usr/local/bin/lua

--[[
--数组
--]]

arr = {'wanglaoer', 100, 'laozheng', function () print('this is a closer function') end}

print(arr[4]())
