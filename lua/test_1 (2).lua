#!/usr/local/bin/lua
--[[
--for 循环
--]]

tab1 = {stu1 = '王老二', stu2 = '老郑', stu3 = '欧阳老二', 2019}
for k, v in pairs(tab1) do
	print(k..'_'..v)
end

