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
echo -e "${YELLOW}->>开始执行部署Caddy配置并启动vuepcrserver服务 容器端口8081=>80${RES}"
{
        docker run -itd -p 8081:80 --name vuepcrserver vuepcrserver:1.0
        cp ~/docker_sh/vue-pcr-server/caddy_vue_pcr_box_server /etc/caddy/sites
        service caddy reload
}
echo -e "${GREEN}->>部署完毕${RES}"