#!/usr/local/bin/lua
--[[
--until loop
--]]
sum = 2
repeat
	sum = sum ^ 2
	print('sum = ' .. sum)
until sum > 1000
