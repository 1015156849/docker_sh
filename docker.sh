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
echo -e "${GREEN} docker管理脚本--------------- ${RES}"
echo -e "${GREEN} 【1】注册dockerManager${RES}"
echo -e "${GREEN} 【2】部署pcr_box网站前台${RES}"
echo -e "${GREEN} 【3】部署pcr_box网站后台到docker并启动${RES}"
echo -e "${GREEN} 【4】部署pcr_box caddy ${RES}"
echo -e "${GREEN} 请输入序号----------- ${RES}"
read code
case "$code" in
1)
    echo -e "${YELLOW}->>开始执行 注册dockerManager 命令${RES}"
    {
        cp ~/docker_sh/caddy_docker /etc/caddy/sites
        service caddy reload
    }
    echo -e "${GREEN}->>执行完毕${RES}"
;;
2)
    echo -e "${YELLOW}->>开始执行 部署pcr_box网站前台 命令${RES}"
    {
        chmod +x ./vue-pcr/vue-pcr.sh
        ./vue-pcr/vue-pcr.sh
        chmod -x ./vue-pcr/vue-pcr.sh
    }
;;
3)
    echo -e "${YELLOW}->>开始执行 部署pcr_box网站后台到docker并启动 命令${RES}"
    {
       chmod +x ./vue-pcr-server/vue-pcr-server.sh
       ./vue-pcr-server/vue-pcr-server.sh
       chmod -x ./vue-pcr-server/vue-pcr-server.sh
    }
;;
4)
    echo -e "${YELLOW}->>开始执行 部署pcr_box caddy 命令${RES}"
    {
        cp ~/docker_sh/vue-pcr-server/caddy_vue_pcr_box_server /etc/caddy/sites
        service caddy reload
    }
;;
*)
echo -e "${GREEN}退出脚本${RES}"
;;
esac
chmod -x ./docker.sh