#!/usr/local/bin/lua
--[
--对于全局变量和 table，
--nil 还有一个"删除"作用，
--给全局变量或者 table 表里的变量赋一个 nil 值，
--等同于把它们删除
--]]

student = {stua = 'wanglaoer', stub = 'laozheng', stuc = 'yujiansong',  1324}
for k, v in pairs(student) do
	print(k .. '-' .. v)
end

