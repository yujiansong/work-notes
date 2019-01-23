#!/usr/local/bin/lua
--[[
--function 可以以匿名函数（anonymous function）的方式通过参数传递:
--]]
function anonymous(tab, fun)
	for k, v in pairs(tab) do
		print(fun(k, v))
	end
end
tab1 = {name = 'wanglaoer', from = 'huludao', age = 30}
anonymous(tab1, function(key, val)
	return key .. ' = ' .. val
end
	)

