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
customInstall(){
    clear
    echo 
    while :; do
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menu_main[*]}$none]"
            echo
            for ((i = 1; i <= ${#menu_main[*]}; i++)); do
                Stream="${menu_main[$i - 1]}"
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
                echo -e "$yellow 功能 = $cyan${menu_main[$menu - 1]}$none"
                echo "----------------------------------------------------------------"
                echo
                # case $menu in
                # 1)
                #     _load docker.sh
                # ;;
                # 2)
                #     selectMenu_caddy
                # ;;
                # 3)
                #     selectMenu_pcrbox
                # ;;
                break
                ;;
            *)
                error
                ;;
            esac
    done
    
}
installAll(){
    echo
    echo "installAll！"
    echo 
}
uninstallAll(){
    echo
    echo "uninstallAll！"
    echo 
}
installBase(){
    echo
    echo "installBase！"
    echo 
}
uninstallBase(){
    echo
    echo "uninstallBase！"
    echo 
}

clear
while :; do
	echo
	echo "...........公主连结工具箱  一键安装脚本 & 管理脚本 by 茶茶PRO .........."
	echo
	echo "帮助说明: https://gitee.com/teatea-pro/pcrbox"
	echo
    echo "默认安装 全部功能 需要一次性配置全部信息"
    echo
    echo "安装基础环境 仅包含 docker caddy反向代理"
    echo
    echo "docker管理网站 pcrbox公会战网站 yobot会战机器人 hoshinobot机器人 需要每项单独安装配置！"
    echo 
    echo 
	echo " 1. 安装全部"
    echo 
	echo " 2. 卸载全部"
    echo
	echo " 3. 仅安装基础环境"
	echo
	echo " 4. 仅卸载基础环境"
	echo
    echo " 5. 单独安装具体功能"
	echo
	read -p "$(echo -e "请选择 [${magenta}1-2$none]:")" choose
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
chmod -x ./install.sh