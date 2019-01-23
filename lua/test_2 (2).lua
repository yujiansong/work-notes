#!/usr/local/bin/lua
--[[
--for循环
--]]
tab1 = {stu1 = '王老二', stu2 = 'laozheng', 12, 13, 'string', 2, 23}
for k, v in pairs(tab1) do
	print(k..'_'..v)
end
print('\n')
print('\n')
tab1.stu1 = nil
for k, v in pairs(tab1) do
	print(k..'_'..v)
end
