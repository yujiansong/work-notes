#!/usr/local/bin/lua
--[[
--返回俩个数的最大值
--]]

function max(num1, num2)
	if(num1 > num2) then
		result = num1
	else
		result = num2
	end
	return result
end

print('俩个数的最大值为 '..max(17,19))
print('俩个数的最大值为 '..max(17,9))
