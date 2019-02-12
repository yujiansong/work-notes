-- redis+lua集合去重
local key=KEYS[1]
local args=ARGV
local result={}
for m, n in ipairs(args) do
	local existence = redis.call("sismember", key, n)
	if(existence==1) then
		table.insert(result, 1, n)
	end
end
return result
--[[
127.0.0.1:6379> smembers players
1) "zhengbowen"
2) "yujiansong"
3) "liuyijie"
4) "wanglaoer"
5) "ouyanger"
C:\Users\yujia>redis-cli --eval D:\practise\190212-3.lua players , wanglaoer laozheng abc
1) "wanglaoer"
--]]