#!/bin/bash
clear
# 定义颜色变量
RED='\e[1;31m' # 红
GREEN='\e[1;32m' # 绿
YELLOW='\e[1;33m' # 黄
BLUE='\e[1;34m' # 蓝
PINK='\e[1;35m' # 粉红
RES='\e[0m' # 清除颜色

echo -e "${GREEN} docker管理脚本 ${GREEN}"
echo -e "${GREEN} 【1】启动nginx并挂载vue-pcr dist目录 ${GREEN}"
echo
echo
echo -e "${GREEN}【其他任意字符退出】${GREEN}"
echo -e "${GREEN}---------------------请输入序号------------------------${GREEN}"
read code

if [[ $code -eq 1 ]]
then
	echo -e "${GREEN}开始执行nginx部署命令。。。${GREEN}"
else
	echo -e "${GREEN}退出脚本${GREEN}"
fi
echo -e "${RES}${RES}"
