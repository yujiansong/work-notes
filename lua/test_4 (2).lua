#!/usr/local/bin/lua

a = {}
a["key"] = "value"
key = 10
a[key] = 22
a[key] = 22 + 11
for k, v in pairs(a) do
	print(k..':'..v)
end
