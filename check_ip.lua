require "config"
--获取ip地址
function client()
	local ip = ngx.req.get_headers()["X_real_ip"]
	if ip == nil then
		ip = ngx.req.get_headers()["X_Forwarded_For"]
	end
	if ip == nil then
		ip = ngx.var.remote_addr
	end
	if ip == nil then
		ip = "unknown"
	end
	return ip
end

--整合ip、uri、args
--function check_bind_uri()
--	local ip = client()
--	if bind_uri == 'on' and bind_url_args == 'on' then
--		if bind_url_args then
--			ip = ip..ngx.var.uri.."?"..nginx.var.args
--		else
--			ip = ip..ngx.var.uri
--		end
--	end
--	if bind_uri == 'on' and bind_url_args == 'off' then
--		ip = ip..ngx.var.uri
--	end
--	return ip
--end

function whiteip()
	if white_list == 'on' then
		local ip = client()
		local white_conf = white_config_dir
		local io = require 'io'
		local ip_list = io.open(white_conf,'r')
		if ip_list ~= "" then
			for white_ip in ip_list:lines() do
				if white_ip == ip then
					return true
				end
			end	
		end
	end
end	
			
