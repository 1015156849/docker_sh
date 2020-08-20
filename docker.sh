#!/bin/bash
printf "\033c"
echo -e "\e[33m docker管理脚本"
echo "【1】启动nginx并挂载vue-pcr dist目录"
echo
echo
echo "【其他任意字符退出】"
echo "---------------------请输入序号------------------------"
read code

if [[ $code -eq 1 ]]
then
	echo "开始执行nginx部署命令。。。"
else
	echo "退出脚本"
fi
