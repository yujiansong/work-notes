#!/usr/local/bin/lua
--[[
--找出最大值及索引
--]]

function maximum(a)
	local mi = 1 --最大值索引
	local m = a[mi] --最大值
	for i,val in ipairs(a) do
		if val > a[mi]  then
			mi = i
			m = val
		end
	end
	return mi, m
end

print(maximum({23,45,24,12,37,34,66,88,21,90, 28, 29}))


