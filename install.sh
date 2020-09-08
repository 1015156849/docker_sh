#!/bin/bash
clear
# 定义颜色变量
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }
# 开始脚本
menuList=(
    docker
    docker管理网站
    caddy
    公主连结Box网站
    yobot会战机器人
    hoshinobot机器人

)

_load() {
	local _dir="/etc/ChaChaPRO/src/"
	. "${_dir}$@"
}

customInstall() {
    echo 
    while :; do
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menuList[*]}$none]"
            echo
            for ((i = 1; i <= ${#menuList[*]}; i++)); do
                Stream="${menuList[$i - 1]}"
                if [[ "$i" -le 9 ]]; then
                    # echo
                    echo -e "$yellow  $i. $none${Stream}"
                else
                    # echo
                    echo -e "$yellow $i. $none${Stream}"
                fi
            done
            echo
            read -p "$(echo -e "(请输入 ${cyan}序号$none)"):" menu
            [ -z "$menu" ] && menu=1
            case $menu in
            [1-9] | [1-2][0-9] | 3[0-2])
                echo
                echo
                echo -e "$yellow 功能 = $cyan${menuList[$menu - 1]}$none"
                echo "----------------------------------------------------------------"
                echo
                case $menu in
                1)
                    _load docker.sh
                break
                ;;
                2)
                break   
                ;;
                3)
                    _load caddy.sh
                break
                ;;
                4)
                    _load vue-pcrbox.sh
                break
                ;;
            *)
                error
                ;;
            esac
    done
}

installAll() {
    echo
    echo "installAll！"
    echo 
}

uninstallAll() {
    echo
    echo "uninstallAll！"
    echo 
}

installBase() {
    echo
    echo "installBase！"
    echo 
}

uninstallBase() {
    echo
    echo "uninstallBase！"
    echo 
}

clear
while :; do
	echo
	echo -e "$yellow ...........公主连结工具箱  一键安装脚本 & 管理脚本 by 茶茶PRO ..........$none"
	echo
	echo -e "$yellow 帮助说明: https://gitee.com/teatea-pro/pcrbox$none"
	echo
    echo -e "$yellow 默认安装 全部功能 需要一次性配置全部信息$none"
    echo
    echo -e "$yellow 安装基础环境 仅包含 docker caddy反向代理$none"
    echo
    echo -e "$yellow docker管理网站 pcrbox公会战网站 yobot会战机器人 hoshinobot机器人 需要每项单独安装配置！$none"
    echo 
    echo 
	echo -e "$yellow 1. 安装全部$none"
    echo 
	echo -e "$yellow 2. 卸载全部$none"
    echo
	echo -e "$yellow 3. 仅安装基础环境$none"
	echo
	echo -e "$yellow 4. 仅卸载基础环境$none"
	echo
    echo -e "$yellow 5. 单独安装具体功能$none"
	echo
	read -p "$(echo -e "请选择 [${magenta}1-5$none]:")" choose
	case $choose in
	1)
		installAll
		break
		;;
	2)
		uninstallAll
		break
		;;
    3)
        installBase
        break
        ;;
    4)
        uninstallBase
        break
        ;;
    5)
        customInstall
        break
        ;;        
	*)
		error
		;;
	esac
done