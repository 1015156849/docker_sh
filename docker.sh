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
echo -e "${GREEN} 【1】安装nginx镜像并创建宿主机配置文件目录和配置文件【自动导入pcr-guild-vue】${RES}"
echo -e "${GREEN} 【2】重启nginx${RES}"
echo -e "${GREEN} 【3】启动pcr-guild 后台${RES}"
echo -e "${GREEN} 【0】退出 ${RES}"
echo -e "${GREEN} 请输入序号----------- ${RES}"
read code
case "$code" in
1)
    echo -e "${YELLOW}->>开始执行nginx部署命令。。。${RES}"
    {
        mkdir -p ~/data/nginx/{conf,conf.d,html,log}
        cp ~/docker_sh/nginx/nginx.conf ~/data/nginx/conf/
        cp ~/docker_sh/nginx/index.html ~/data/nginx/html
        cp ~/docker_sh/nginx/50x.html ~/data/nginx/html
        mkdir -p ~/data/nginx/html/vuepcr
        cd ~/data/nginx/html/vuepcr 
        wget -c https://github.com/CJowo/pcr-guild-vue/releases/download/0.2.1/dist.zip
        unzip dist.zip
        rm dist.zip
        docker run -d -p 8080:80 --name nginx -v ~/data/nginx/conf/nginx.conf:/etc/nginx/nginx.conf -v ~/data/nginx/log:/var/log/nginx -v ~/data/nginx/html:/usr/share/nginx/html nginx
    }
;;
2)
    echo -e "${YELLOW}->>开始重启nginx。。。${RES}"
    {
        cp ~/docker_sh/nginx/nginx.conf ~/data/nginx/conf/
        docker restart nginx
    }
    echo -e "${BLUE}重启nginx完成${RES}"
;;
3)
    echo -e "${YELLOW}->>开始执行pcr-guild 后台服务 命令。。。${RES}"
    clear
    echo -e "${YELLOW}启动pcr-guild 后台服务镜像${RES}"
    {
        docker run -itd -p 8081:80 --name vuepcr-server vuepcrserver:1.0 
    }
;;
5)
	echo -e "${YELLOW}->>开始执行nginx部署命令。。。${RES}"
    clear
    echo -e "${YELLOW}启动vue-pcr镜像${RES}"
    {
        docker run -itd --name vuepcr -v ~/data/nginx/html/vuepcr:/data/pcr-guild-vue/dist vuepcr:1.0 
    } 
    echo -e "${YELLOW}启动nginx镜像并挂在vuepcr${RES}"
;;
0)
	echo -e "${GREEN}退出脚本${RES}"
    exit;
;;
*)
;;
esac