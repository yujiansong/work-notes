#!/usr/local/bin/lua
--[[
--从1加到100的奇数和
--]]
sum = 0
for i = 1, 100, 2 do
	sum = sum + i
end
print('sum =', sum)
