#!/usr/local/bin/lua
--[[
--函数的返回值
--]]

function getUserInfo(id)
	print(id)
	return 'wanglaoer', 28, 'wts@163.com', 'https://www.wts.store.com', id
end

name, age, email, website, id = getUserInfo(2)
print('name:'..name..'\n'..'age:'..age..'\n'..'email:'..email..'\n'..'website:'..website..'\n'..'id:'..id)
