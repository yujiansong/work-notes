-- redis+lua 找到hash中age小于指定值的所有数据
local result={}
local myperson=KEYS[1]
local nums=ARGV[1]

local myresult=redis.call("hkeys", myperson)

for i, v in ipairs(myresult) do
	local hval = redis.call("hget", myperson, v)
	redis.log(redis.LOG_WARNING,hval)
	if(tonumber(hval) < tonumber(nums)) then
		table.insert(result, 1, v)
	end
end

return result

--[[
127.0.0.1:6379> hgetall ages
 1) "laozheng"
 2) "29"
 3) "wanglaoer"
 4) "38"
 5) "yujiansong"
 6) "28"
 7) "ouyanglaoer"
 8) "49"
 9) "liuyijie"
10) "34"
11) "huangzhen"
12) "59"
13) "xiaoming"
14) "18"
15) "chenzhi"
16) "27"

C:\Users\yujia>redis-cli --eval D:\practise\190212-4.lua ages , 28
1) "xiaoming"
2) "chenzhi"
--]]