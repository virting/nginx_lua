# nginx lua 实现对ip限制 并增加白名单功能
增加白名单功能
#安装
请参考：https://openresty.org/en/installation.html
#配置
下载文件放到
/etc/nginx/conf.d/lua_conf/ 目录下
在nginx.conf中增加一下内容
lua_package_path "/usr/local/openresty/lualib/resty/?.lua;;/etc/nginx/conf.d/lua_conf/?.lua;;";
lua_package_cpath "/usr/local/openresty/lualib/resty/?.so;;";
init_by_lua_file "/etc/nginx/conf.d/lua_conf/check_ip.lua";
