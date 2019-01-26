#!/usr/local/bin/lua
number = {}
for i = -2, 2 do
	number[i] = -2 * (i + 1)
end

for i = -2, 2 do
	print('number['..i..'] = '..number[i])
end
