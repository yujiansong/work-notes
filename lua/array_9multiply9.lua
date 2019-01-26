#!/usr/local/bin/lua
---[[
--9*9乘法表
--]]
array = {}
for i = 1, 9 do
	array[i] = {}
	for j = 1, 9 do
		array[i][j] = i * j
	end
end

for i = 1 ,9 do
	for j = 1, i do
		io.write(j..' * '..i..' = '..array[i][j]..' ')
	end
	print()
end

