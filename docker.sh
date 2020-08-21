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
echo -e "${GREEN} 【1】部署pcr_box网站前台${RES}"
echo -e "${GREEN} 【2】部署pcr_box网站后台到docker并启动${RES}"
echo -e "${GREEN} 请输入序号----------- ${RES}"
read code
case "$code" in
1)
    echo -e "${YELLOW}->>开始执行 部署pcr_box网站前台 命令${RES}"
    {
        ./vue-pcr/vue-pcr.sh
    }
;;
3)
    echo -e "${YELLOW}->>开始执行 部署pcr_box网站后台到docker并启动 命令${RES}"
    {
        ./vue-pcr-server/vue-pcr-server.sh
    }
;;
*)
echo -e "${GREEN}退出脚本${RES}"
;;
esac