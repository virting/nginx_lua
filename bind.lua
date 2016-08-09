require "config"
require "check_ip"
local redis = require "resty.redis"
local red = redis:new()
red:set_timeout(1000) -- 1 sec

local ok, err = red:connect("127.0.0.1", 6379)
if not ok then
    ngx.say("redis connect faild")
end

local ip = client()
local is_bind, err = red:get("bind:"..ip)
if is_bind == '1' then
    ngx.exit(403)
end
local allowip = whiteip()
if not allowip then
	start_time, err = red:get("time:"..ip)
	ip_count, err = red:get("count:"..ip)
    if start_time == ngx.null or os.time() - start_time > ip_time_out then
		res, err = red:set("time:"..ip , os.time())
		res, err = red:expire("time:"..ip , ip_bind_time)
		res, err = red:set("count:"..ip , 1)
		res, err = red:expire("count:"..ip , ip_bind_time)
    else
		ip_count = ip_count + 1
		res, err = red:incr("count:"..ip)
		if ip_count >= connect_count then
			res, err = red:set("bind:"..ip, 1)
			res, err = red:expire("bind:"..ip, ip_bind_time)
		end
	end
end
local ok, err = red:close()