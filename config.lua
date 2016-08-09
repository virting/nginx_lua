
--  nginx限制单ip单url访问次数配置文件

--封禁IP时间
ip_bind_time = 86400

--指定ip访问频率时间段
ip_time_out = 86400    

--指定ip访问频率计数最大值
connect_count = 50

-- 是否开启限制uri on为开启 其他为关闭
bind_uri = 'on'

-- 是否开启限制带url参数 on为开启 其他为关闭
bind_url_args = 'on'

--设置白名单
white_list = 'on'

white_config_dir = '/etc/nginx/conf.d/lua_conf/white_list.rule'