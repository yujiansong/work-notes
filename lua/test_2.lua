#!/usr/local/bin/lua
-- 给多个变量同是赋值
stu1, stu2 = 'wanglaoer', 'laozheng'
print('stu1 = '..stu1, 'stu2 = '..stu2)

--[[
--交换变量的值
--]]
stu1, stu2 = stu2, stu1
print('stu1 = '..stu1, 'stu2 = '..stu2)
