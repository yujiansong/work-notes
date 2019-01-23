#!/usr/local/bin/lua

tab1 = {}
for i = 1,10 do
	tab1[i] = i
end
tab1['name'] = 'wanglaer'
tab1['from'] = [[liaoning]]
tab1['id'] = 10
--print(tab1['name'])
for k, v in pairs(tab1) do
	print(k..': '..v)
end
