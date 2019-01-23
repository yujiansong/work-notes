#!/usr/local/bin/lua
--[[
--lua table
--]]

wts = {name='wangtianshi', age=29, handsome=true}
--CURD
wts.website="http://www.wts.store"
local age = wts.age
wts.name='wanglaoer'
wts.handsome=false
print(wts.name)
print(wts.age)
print(wts.email)
print(wts.website)
print(wts.handsome)

