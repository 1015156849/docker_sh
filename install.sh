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

# Root
[[ $(id -u) != 0 ]] && echo -e " 请使用 ${red}root ${none}用户运行 ${yellow}${none}" && exit 1

cmd="apt-get"

sys_bit=$(uname -m)

_version="v1.0"

_gitbranch="master"

_dir="/etc/ChaChaPRO/pcrbox/src/"

_backup="/etc/ChaChaPRO/pcrbox/backup.conf"


case $sys_bit in
i[36]86)
	caddy_arch="386"
	;;
'amd64' | x86_64)
	caddy_arch="amd64"
	;;
*armv6*)
	caddy_arch="arm6"
	;;
*armv7*)
	caddy_arch="arm7"
	;;
*aarch64* | *armv8*)
	caddy_arch="arm64"
	;;
*)
	echo -e " 
	${red}本脚本${none} 不支持你的系统。 ${yellow}(-_-) ${none}
	备注: 仅支持 Ubuntu 16+ / Debian 8+ / CentOS 7+ 系统
	" && exit 1
	;;
esac

# 检测方法
if [[ $(command -v apt-get) || $(command -v yum) ]] && [[ $(command -v systemctl) ]]; then

	if [[ $(command -v yum) ]]; then

		cmd="yum"

	fi

else

	echo -e " 
	${red}本脚本${none} 不支持你的系统。 ${yellow}(-_-) ${none}
	备注: 仅支持 Ubuntu 16+ / Debian 8+ / CentOS 7+ 系统
	" && exit 1

fi


get_ip() {
	ip=$(curl -s https://ipinfo.io/ip)
	[[ -z $ip ]] && ip=$(curl -s https://api.ip.sb/ip)
	[[ -z $ip ]] && ip=$(curl -s https://api.ipify.org)
	[[ -z $ip ]] && ip=$(curl -s https://ip.seeip.org)
	[[ -z $ip ]] && ip=$(curl -s https://ifconfig.co/ip)
	[[ -z $ip ]] && ip=$(curl -s https://api.myip.com | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
	[[ -z $ip ]] && ip=$(curl -s icanhazip.com)
	[[ -z $ip ]] && ip=$(curl -s myip.ipip.net | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
	[[ -z $ip ]] && echo -e "\n$red 这垃圾小鸡扔了吧！$none\n" && exit
}


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
	local _dir="/etc/ChaChaPRO/pcrbox/src/"
	. "${_dir}$@"
}
update(){
    $cmd update -y
    if [[ $cmd == "apt-get" ]]; then
    $cmd install -y lrzsz git zip unzip curl wget qrencode libcap2-bin dbus
    else
    # $cmd install -y lrzsz git zip unzip curl wget qrencode libcap iptables-services
    $cmd install -y lrzsz git zip unzip curl wget qrencode libcap
    fi
    [ -d /etc/ChaChaPRO ] && rm -rf /etc/ChaChaPRO
    mkdir -p /etc/ChaChaPRO/pcrbox

    pushd /tmp
    git clone https://github.com/1015156849/docker_sh -b "$_gitbranch" /etc/ChaChaPRO/pcrbox --depth=1
    popd
    # mkdir -p /etc/ChaChaPRO/pcrbox
    # cp -rf $(pwd)/* /etc/ChaChaPRO/pcrbox

    if [[ ! -d /etc/ChaChaPRO/pcrbox ]]; then
        echo
        echo -e "$red 哎呀呀...克隆脚本仓库出错了...$none"
        echo
        echo -e " 温馨提示..... 请尝试自行安装 Git: ${green}$cmd install -y git $none 之后再安装此脚本"
        echo
        exit 1
    else
        echo "脚本更新完毕"
    fi
}
initInstall(){
    if [[ -d /etc/ChaChaPRO/pcrbox ]]; then
		echo
		echo " 已初始化该脚本"
		echo
	else
       update
	fi
    
}
customInstall() { 
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
            case $menu in
            1)
                _load docker.sh
                _menu_install_docker
                break
            ;;
            2)
                _load docker-manager.sh
                _menu_install_docker_manager
                break
            ;;
            3)
                _load caddy.sh
                _menu_install_caddy
                break
            ;;
            4)
                _load vue-pcr.sh
                _menu_install_pcr_box_vue
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
    echo -e "$yellow 6. 更新脚本$none"
	echo
	read -p "$(echo -e "请选择 [${magenta}1-6$none]:")" choose
	case $choose in
	1)
        initInstall
		installAll
		break
		;;
	2)
		uninstallAll
		break
		;;
    3)
        initInstall
        installBase
        break
        ;;
    4)
        initInstall
        uninstallBase
        break
        ;;
    5)
        initInstall
        customInstall
        break
        ;;
    6)
        update
        break
        ;;          
	*)
		error
		;;
	esac
    bash <(curl -s -L https://git.io/pcr_chachaPRO)
done

backup_config() {
	sed -i "18s/=1/=$v2ray_transport/; 21s/=2333/=$v2ray_port/; 24s/=$old_id/=$uuid/" $backup
	if [[ $v2ray_transport -ge 18 ]]; then
		sed -i "30s/=10000/=$v2ray_dynamic_port_start_input/; 33s/=20000/=$v2ray_dynamic_port_end_input/" $backup
	fi
	if [[ $shadowsocks ]]; then
		sed -i "42s/=/=true/; 45s/=6666/=$ssport/; 48s/=233blog.com/=$sspass/; 51s/=chacha20-ietf/=$ssciphers/" $backup
	fi
	[[ $v2ray_transport == [45] ]] && sed -i "36s/=233blog.com/=$domain/" $backup
	[[ $caddy ]] && sed -i "39s/=/=true/" $backup
	[[ $ban_ad ]] && sed -i "54s/=/=true/" $backup
	if [[ $is_path ]]; then
		sed -i "57s/=/=true/; 60s/=233blog/=$path/" $backup
		sed -i "63s#=https://liyafly.com#=$proxy_site#" $backup
	fi
}
