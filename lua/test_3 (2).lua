#!/usr/local/bin/lua
print(type(true))
print(type(false))
print(type(nil))

if type(false) or type(nil) then
	print("false and nil are false!")
else
	print("other is true")
end
