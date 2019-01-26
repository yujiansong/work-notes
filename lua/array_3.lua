#!/usr/local/bin/lua
---[[
--三维数组
--]]
array = {}
for i = 1, 9 do
	array[i] = {}
	for j = 1, 9 do
		array[i][j] = i * j
	end
end

for i = 1 ,9 do
	for j = 1, 9 do
		print(i..' * '..j..' = '..array[i][j])
	end
end

