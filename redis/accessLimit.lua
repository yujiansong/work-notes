--lua+redis 实现访问频率限制: 
--实现访问者 $ip 在一定的时间 $time 内只能访问 $limit 次

local key = "rate.limit:" .. KEYS[1]
local limit = tonumber(ARGV[1])
local expire_time = ARGV[2]

local existance = redis.call("EXISTS", key)
if(existance == 1) then
	if redis.call("INCR", key) > limit then
		return 0
	else
		return 1
	end
else
	redis.call("SET", key, 1)
	redis.call("EXPIRE", key, expire_time)
	return 1
end

--[[
C:\Users\yujia>redis-cli --eval D:\practise\accessLimit.lua 192.168.1.1 , 6 120
(integer) 1
...同一个ip,120s内执行6次，之后在执行则返回0
C:\Users\yujia>redis-cli --eval D:\practise\accessLimit.lua 192.168.1.1 , 6 120
(integer) 0
--]]