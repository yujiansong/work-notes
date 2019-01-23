#!/usr/local/bin/lua

--[[
--从1加到100的偶数和
--]]
sum = 0
for i = 100, 1, -2 do
	print('sum = ' ..sum.. '+' ..i)
	sum = sum + i
end
print('sum = ', sum)
