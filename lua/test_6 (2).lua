#!/usr/local/bin/lua
--[[
--lua 装载和执行
--]]
local WangerModel = {}
local function getname()
	return 'wang tian shi'
end

function WangerModel.Greeting()
	print('hello, my name is '..getname())
end

return WangerModel

	
