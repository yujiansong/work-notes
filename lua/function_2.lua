#!/usr/local/bin/lua
--[[
--Lua 中我们可以将函数作为参数传递给函数
--]]

myprint = function(param)
	print('这是打印函数: '..param)
end

function add(num1, num2, functionPrint)
	result = num1 + num2
	-- 调用传递的函数参数
	functionPrint(result)
end

myprint(10)
add(2, 4, myprint)
