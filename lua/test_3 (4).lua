#!/usr/local/bin/lua
age = 30
if age > 40 and gender == 'Male' then
	print('the man is 40 years old, but like a flower.')
elseif age > 60 and gender ~= 'Female' then
	print('you are a old man')
elseif age < 20 then
	io.write('hello, boy!')
else
	local age = io.read()
	print('your age is '.. age)
end

	
