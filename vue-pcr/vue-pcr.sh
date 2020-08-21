#!/bin/bash
clear
# 定义颜色变量
RED='\e[1;31m' # 红
GREEN='\e[1;32m' # 绿
YELLOW='\e[1;33m' # 黄
BLUE='\e[1;34m' # 蓝
PINK='\e[1;35m' # 粉红
RES='\e[0m' # 清除颜色
# 开始脚本
echo -e "${YELLOW}->>开始执行 部署pcr_box网站前台脚本${RES}"
{
        chown www-data:www-data /etc/caddy/www
        mkdir -p /etc/caddy/www/vuepcr
        cd /etc/caddy/www/vuepcr 
        wget -c https://github.com/CJowo/pcr-guild-vue/releases/download/0.2.1/dist.zip
        unzip dist.zip
        rm dist.zip
        cp ~/docker_sh/vue-pcr/caddy_vue_pcr_box /etc/caddy/sites
        service caddy reload
}
echo -e "${GREEN}->>部署完毕${RES}"