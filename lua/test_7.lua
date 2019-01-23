#!/usr/local/bin/lua
--[[
--函数式
--]]
function factorial1(n)
	if n == 0 then
		return 1
	else
		return n * factorial1(n-1)
	end
end
print(factorial1(5))
factorial2 = factorial1
--函数可以存在变量里
print(factorial2(6))
